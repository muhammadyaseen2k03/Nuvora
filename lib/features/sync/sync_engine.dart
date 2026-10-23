import 'package:drift/drift.dart';

import '../../data/database.dart';
import '../../data/table_specs.dart';
import 'remote.dart';

class SyncResult {
  const SyncResult({
    this.pushed = 0,
    this.pulled = 0,
    this.deletesApplied = 0,
    this.keptLocal = 0,
    this.skipped = 0,
  });

  final int pushed;
  final int pulled;
  final int deletesApplied;

  /// Remote versions ignored because the local row was newer or equal.
  final int keptLocal;

  /// Remote records that were invalid or referenced a missing parent.
  final int skipped;
}

/// Offline-first, per-profile sync between the local database and a
/// [SyncRemote].
///
/// Conflict rules (documented per data type)
/// -----------------------------------------
/// * Mutable rows (settings, subjects, topics, cards, journal, plans, ...):
///   last writer wins by the row's own `updated_at`. On a tie the local row
///   is kept. The loser is not merged field by field.
/// * Append-only rows (water logs, review history, workout history, awards):
///   union. A row is inserted if its id is not present; it is never changed.
/// * Deletions: a delete beats any edit that is older than the delete. An
///   edit made after the delete resurrects the row, and the newer edit is
///   pushed back to the server.
/// * Pushes are idempotent (keyed by table and row id), so a retry after a
///   failure never creates duplicates, and the server ignores records older
///   than what it already has.
///
/// Not synced: profile identity and recovery data, notification and privacy
/// preferences (consent and delivery are per device).
class SyncEngine {
  SyncEngine(this._db, this._remote, {DateTime Function()? clock})
      : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final SyncRemote _remote;
  final DateTime Function() _now;

  static const profilePlaceholder = '@profile';
  static const _batch = 100;
  static const _pullLimit = 200;

  /// Runs one push-then-pull cycle. Throws [SyncException] on failure and
  /// leaves already-applied work in place; calling again continues safely.
  Future<SyncResult> sync(String profileId) async {
    final settings = await (_db.select(_db.syncSettings)
          ..where((s) => s.profileId.equals(profileId)))
        .getSingleOrNull();
    if (settings == null || !settings.enabled) {
      throw const SyncException('disabled');
    }
    final categories = {
      SyncCategory.core,
      if (settings.syncPrayer) SyncCategory.prayer,
      if (settings.syncStudy) SyncCategory.study,
      if (settings.syncFitness) SyncCategory.fitness,
      if (settings.syncJournal) SyncCategory.journal,
    };

    try {
      final pushed = await _push(profileId, categories);
      final pulled = await _pull(profileId, categories);
      await (_db.update(_db.syncSettings)
            ..where((s) => s.profileId.equals(profileId)))
          .write(SyncSettingsCompanion(
              lastSyncAt: Value(_now()), lastError: const Value(null)));
      return SyncResult(
        pushed: pushed,
        pulled: pulled.applied,
        deletesApplied: pulled.deletes,
        keptLocal: pulled.keptLocal,
        skipped: pulled.skipped,
      );
    } on SyncException catch (e) {
      await (_db.update(_db.syncSettings)
            ..where((s) => s.profileId.equals(profileId)))
          .write(SyncSettingsCompanion(lastError: Value(e.code)));
      rethrow;
    }
  }

  // --- Push -----------------------------------------------------------------

  Future<int> _push(String profileId, Set<SyncCategory> categories) async {
    var pushed = 0;
    for (final spec in tableSpecs) {
      if (!spec.isSynced || !categories.contains(spec.category)) continue;
      final cursorKey = 'push:${spec.name}';
      final since = int.tryParse(await _state(profileId, cursorKey) ?? '') ?? 0;
      // `>=` so rows changed within the same second as the last push are not
      // missed; re-pushing an unchanged row is harmless (idempotent).
      final rows = await _db.customSelect(
        'SELECT * FROM ${spec.name} WHERE profile_id = ? AND '
        '${spec.changeColumn} >= ? ORDER BY ${spec.changeColumn}',
        variables: [Variable<String>(profileId), Variable<int>(since)],
      ).get();
      final records = [for (final r in rows) _toRecord(spec, r.data)];
      var maxChange = since;
      for (var i = 0; i < records.length; i += _batch) {
        final chunk = records.sublist(i, (i + _batch).clamp(0, records.length));
        await _remote.push(chunk);
        pushed += chunk.length;
      }
      for (final r in rows) {
        final c = r.data[spec.changeColumn] as int? ?? 0;
        if (c > maxChange) maxChange = c;
      }
      if (records.isNotEmpty) {
        await _setState(profileId, cursorKey, '$maxChange');
      }
    }

    // Deletions.
    final tombs = await (_db.select(_db.syncTombstones)
          ..where((t) => t.profileId.equals(profileId)))
        .get();
    final live = tombs.where((t) {
      final spec = specFor(t.targetTable);
      return spec != null && spec.isSynced && categories.contains(spec.category);
    }).toList();
    for (var i = 0; i < live.length; i += _batch) {
      final chunk = live.sublist(i, (i + _batch).clamp(0, live.length));
      await _remote.push([
        for (final t in chunk)
          RemoteRecord(
              table: t.targetTable,
              rowId: t.rowId,
              updatedAt: t.deletedAt,
              data: null),
      ]);
      pushed += chunk.length;
      // Remove only what was acknowledged.
      for (final t in chunk) {
        await (_db.delete(_db.syncTombstones)
              ..where((x) =>
                  x.targetTable.equals(t.targetTable) &
                  x.rowId.equals(t.rowId) &
                  x.profileId.equals(profileId)))
            .go();
      }
    }
    return pushed;
  }

  RemoteRecord _toRecord(TableSpec spec, Map<String, Object?> row) {
    final data = Map<String, Object?>.from(row);
    data['profile_id'] = profilePlaceholder;
    final single = spec.pk.length == 1 && spec.pk.first == 'id';
    final change = row[spec.changeColumn] as int? ?? 0;
    return RemoteRecord(
      table: spec.name,
      rowId: single ? row['id'] as String : profilePlaceholder,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(change * 1000, isUtc: true),
      data: data,
    );
  }

  // --- Pull -----------------------------------------------------------------

  Future<_PullTotals> _pull(
      String profileId, Set<SyncCategory> categories) async {
    final totals = _PullTotals();
    var cursor = int.tryParse(await _state(profileId, 'pull_seq') ?? '') ?? 0;
    while (true) {
      final page = await _remote.pull(cursor, limit: _pullLimit);
      if (page.records.isEmpty) break;
      await _db.transaction(() async {
        // Upserts parent-first, then deletes child-first.
        final order = {for (var i = 0; i < tableSpecs.length; i++) tableSpecs[i].name: i};
        final upserts = page.records.where((r) => !r.isDeleted).toList()
          ..sort((a, b) =>
              (order[a.table] ?? 999).compareTo(order[b.table] ?? 999));
        final deletes = page.records.where((r) => r.isDeleted).toList()
          ..sort((a, b) =>
              (order[b.table] ?? 999).compareTo(order[a.table] ?? 999));
        for (final r in upserts) {
          await _applyUpsert(profileId, categories, r, totals);
        }
        for (final r in deletes) {
          await _applyDelete(profileId, categories, r, totals);
        }
        await _setState(profileId, 'pull_seq', '${page.lastSeq}');
      });
      cursor = page.lastSeq;
      if (page.records.length < _pullLimit) break;
    }
    return totals;
  }

  TableSpec? _usable(Set<SyncCategory> categories, String table) {
    final spec = specFor(table);
    if (spec == null || !spec.isSynced || !categories.contains(spec.category)) {
      return null;
    }
    return spec;
  }

  Future<void> _applyUpsert(String profileId, Set<SyncCategory> categories,
      RemoteRecord r, _PullTotals totals) async {
    final spec = _usable(categories, r.table);
    final data = r.data;
    if (spec == null || data == null) {
      totals.skipped++;
      return;
    }
    final known = await _columns(spec.name);
    for (final e in data.entries) {
      final v = e.value;
      if (!known.contains(e.key) ||
          !(v == null || v is int || v is double || v is String)) {
        totals.skipped++;
        return;
      }
    }
    final row = Map<String, Object?>.from(data);
    row['profile_id'] = profileId;
    final single = spec.pk.length == 1 && spec.pk.first == 'id';
    final id = single ? r.rowId : profileId;
    if (single) row['id'] = id;
    if (single && id == profilePlaceholder) {
      totals.skipped++;
      return;
    }

    // A local deletion newer than this record wins.
    final tomb = await _tombstone(profileId, spec.name, single ? id : profilePlaceholder);
    if (tomb != null && !tomb.deletedAt.isBefore(r.updatedAt)) {
      totals.keptLocal++;
      return;
    }

    final keyCol = single ? 'id' : 'profile_id';
    final local = await _db.customSelect(
      'SELECT ${spec.changeColumn} AS c FROM ${spec.name} WHERE $keyCol = ?',
      variables: [Variable<String>(id)],
    ).getSingleOrNull();

    if (local != null) {
      if (!spec.mutable) return; // append-only: already have it
      final localChange = local.read<int>('c');
      final remoteChange = r.updatedAt.millisecondsSinceEpoch ~/ 1000;
      if (remoteChange <= localChange) {
        totals.keptLocal++;
        return;
      }
    }

    // Parents must exist locally.
    for (final fk in spec.fks.entries) {
      final v = row[fk.key];
      if (v == null) continue;
      final parent = await _db.customSelect(
        'SELECT 1 AS x FROM ${fk.value} WHERE id = ? AND profile_id = ?',
        variables: [Variable<String>(v as String), Variable<String>(profileId)],
      ).getSingleOrNull();
      if (parent == null) {
        totals.skipped++;
        return;
      }
    }

    try {
      await _upsert(spec, row);
    } catch (_) {
      // A row the schema rejects (for example a missing required column)
      // must not abort the whole sync.
      totals.skipped++;
      return;
    }
    totals.applied++;
    if (local == null && tomb != null) {
      await _clearTombstone(profileId, spec.name, single ? id : profilePlaceholder);
    }
  }

  Future<void> _applyDelete(String profileId, Set<SyncCategory> categories,
      RemoteRecord r, _PullTotals totals) async {
    final spec = _usable(categories, r.table);
    if (spec == null) {
      totals.skipped++;
      return;
    }
    final single = spec.pk.length == 1 && spec.pk.first == 'id';
    final keyCol = single ? 'id' : 'profile_id';
    final id = single ? r.rowId : profileId;
    final local = await _db.customSelect(
      'SELECT ${spec.changeColumn} AS c FROM ${spec.name} WHERE $keyCol = ?',
      variables: [Variable<String>(id)],
    ).getSingleOrNull();
    if (local == null) return;
    final localChange = local.read<int>('c');
    final deletedAt = r.updatedAt.millisecondsSinceEpoch ~/ 1000;
    if (localChange > deletedAt) {
      totals.keptLocal++; // edited after the delete: resurrect (pushed later)
      return;
    }
    await _db.customStatement(
        'DELETE FROM ${spec.name} WHERE $keyCol = ?', [id]);
    // The delete trigger recorded a tombstone; this deletion came from the
    // server, so do not send it back.
    await _clearTombstone(profileId, spec.name, single ? id : profilePlaceholder);
    totals.deletes++;
  }

  // --- Helpers ----------------------------------------------------------------

  Future<void> _upsert(TableSpec spec, Map<String, Object?> row) {
    final cols = row.keys.toList();
    final pk = spec.pk.join(', ');
    final updates = [
      for (final c in cols)
        if (!spec.pk.contains(c)) '$c = excluded.$c',
    ].join(', ');
    // ON CONFLICT DO UPDATE (not INSERT OR REPLACE) so that foreign-key
    // cascades never delete child rows during an update.
    final sql = 'INSERT INTO ${spec.name} (${cols.join(', ')}) '
        'VALUES (${List.filled(cols.length, '?').join(', ')}) '
        '${updates.isEmpty ? 'ON CONFLICT($pk) DO NOTHING' : 'ON CONFLICT($pk) DO UPDATE SET $updates'}';
    return _db.customStatement(sql, [for (final c in cols) row[c]]);
  }

  final Map<String, Set<String>> _columnCache = {};

  Future<Set<String>> _columns(String table) async {
    final cached = _columnCache[table];
    if (cached != null) return cached;
    final rows = await _db.customSelect('PRAGMA table_info($table)').get();
    return _columnCache[table] = {for (final r in rows) r.read<String>('name')};
  }

  Future<SyncTombstone?> _tombstone(
          String profileId, String table, String rowId) =>
      (_db.select(_db.syncTombstones)
            ..where((t) =>
                t.profileId.equals(profileId) &
                t.targetTable.equals(table) &
                t.rowId.equals(rowId)))
          .getSingleOrNull();

  Future<void> _clearTombstone(
          String profileId, String table, String rowId) =>
      (_db.delete(_db.syncTombstones)
            ..where((t) =>
                t.profileId.equals(profileId) &
                t.targetTable.equals(table) &
                t.rowId.equals(rowId)))
          .go();

  Future<String?> _state(String profileId, String key) async {
    final row = await (_db.select(_db.syncState)
          ..where((s) => s.profileId.equals(profileId) & s.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> _setState(String profileId, String key, String value) =>
      _db.into(_db.syncState).insertOnConflictUpdate(SyncStateCompanion.insert(
          profileId: profileId, key: key, value: value));
}

class _PullTotals {
  int applied = 0;
  int deletes = 0;
  int keptLocal = 0;
  int skipped = 0;
}
