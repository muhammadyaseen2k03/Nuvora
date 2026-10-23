import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../data/database.dart';
import '../../data/table_specs.dart';

/// Thrown for any backup that cannot be read or safely restored.
class BackupException implements Exception {
  const BackupException(this.code, [this.detail]);

  /// Machine-readable reason: `too_large`, `not_json`, `wrong_format`,
  /// `newer_version`, `invalid_structure`, `invalid_row`, `unknown_table`,
  /// `restore_failed`.
  final String code;
  final String? detail;

  @override
  String toString() => 'BackupException($code${detail == null ? '' : ': $detail'})';
}

/// The result of validating a backup file before anything is written.
class BackupPreview {
  const BackupPreview(
      {required this.profileName,
      required this.createdAt,
      required this.rowCounts});

  final String profileName;
  final DateTime createdAt;

  /// Table name -> number of rows.
  final Map<String, int> rowCounts;

  int get totalRows => rowCounts.values.fold(0, (a, b) => a + b);
}

/// Versioned export and restore of one profile's data.
///
/// File format (version 1)
/// -----------------------
/// ```json
/// {
///   "format": "nuvora-backup",
///   "version": 1,
///   "createdAt": "2024-05-10T09:00:00.000Z",
///   "appSchema": 5,
///   "tables": { "<table_name>": [ { "<column>": <int|double|string|null> } ] }
/// }
/// ```
/// Secrets are never exported: the recovery question, its verifier hash and
/// salt, and the cloud user id are removed. Restoring never needs them.
///
/// Restore modes
/// -------------
/// * `restoreAsNewProfile` (the default, non-destructive): creates a new
///   profile; existing data is untouched. All ids are regenerated, so
///   restoring the same file twice cannot collide with itself.
/// * `restoreReplacingProfile`: destructive. Inside one transaction the
///   target profile's data is removed and the backup is imported in its
///   place. If anything fails, the transaction rolls back and the original
///   data remains.
class BackupService {
  BackupService(this._db, {DateTime Function()? clock})
      : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _now;
  static const _uuid = Uuid();

  static const formatName = 'nuvora-backup';
  static const currentVersion = 1;
  static const maxBytes = 20 * 1024 * 1024;

  /// Columns that must never leave the device in a backup.
  static const _secretColumns = {
    'profiles': {
      'recovery_question',
      'recovery_hash',
      'recovery_salt',
      'cloud_user_id',
    },
  };

  // --- Export ---------------------------------------------------------------

  Future<String> export(String profileId) async {
    final tables = <String, List<Map<String, Object?>>>{};
    for (final spec in tableSpecs) {
      final rows = await _rows(spec, profileId);
      final secret = _secretColumns[spec.name] ?? const <String>{};
      tables[spec.name] = [
        for (final r in rows)
          {
            for (final e in r.entries)
              if (!secret.contains(e.key)) e.key: e.value,
          },
      ];
    }
    return jsonEncode({
      'format': formatName,
      'version': currentVersion,
      'createdAt': _now().toUtc().toIso8601String(),
      'appSchema': _db.schemaVersion,
      'tables': tables,
    });
  }

  // --- Validation -----------------------------------------------------------

  /// Parses and validates [source]. Throws [BackupException] without
  /// touching the database.
  Future<BackupPreview> validate(String source) async {
    final parsed = await _parse(source);
    final profiles = parsed.tables['profiles']!;
    return BackupPreview(
      profileName: profiles.single['display_name'] as String,
      createdAt: parsed.createdAt,
      rowCounts: {
        for (final e in parsed.tables.entries)
          if (e.value.isNotEmpty) e.key: e.value.length,
      },
    );
  }

  // --- Restore ----------------------------------------------------------------

  /// Imports the backup as a brand-new profile and returns its id.
  Future<String> restoreAsNewProfile(String source) async {
    final parsed = await _parse(source);
    final newId = _uuid.v4();
    await _import(parsed, newProfileId: newId, replaceExisting: false);
    return newId;
  }

  /// Replaces [targetProfileId]'s data with the backup, atomically.
  Future<String> restoreReplacingProfile(
      String source, String targetProfileId) async {
    final parsed = await _parse(source);
    await _import(parsed,
        newProfileId: targetProfileId, replaceExisting: true);
    return targetProfileId;
  }

  // --- Internals --------------------------------------------------------------

  Future<_Parsed> _parse(String source) async {
    if (source.length > maxBytes) throw const BackupException('too_large');
    final Object? decoded;
    try {
      decoded = jsonDecode(source);
    } on FormatException {
      throw const BackupException('not_json');
    }
    if (decoded is! Map<String, dynamic> || decoded['format'] != formatName) {
      throw const BackupException('wrong_format');
    }
    final version = decoded['version'];
    if (version is! int || version < 1) {
      throw const BackupException('invalid_structure', 'version');
    }
    if (version > currentVersion) throw const BackupException('newer_version');
    final createdRaw = decoded['createdAt'];
    final created = createdRaw is String ? DateTime.tryParse(createdRaw) : null;
    if (created == null) throw const BackupException('invalid_structure', 'createdAt');
    final tablesRaw = decoded['tables'];
    if (tablesRaw is! Map<String, dynamic>) {
      throw const BackupException('invalid_structure', 'tables');
    }
    for (final name in tablesRaw.keys) {
      if (specFor(name) == null) throw BackupException('unknown_table', name);
    }

    final tables = <String, List<Map<String, Object?>>>{};
    for (final spec in tableSpecs) {
      final raw = tablesRaw[spec.name];
      if (raw == null) {
        tables[spec.name] = const [];
        continue;
      }
      if (raw is! List) throw BackupException('invalid_structure', spec.name);
      final known = await _columns(spec.name);
      final rows = <Map<String, Object?>>[];
      for (final r in raw) {
        if (r is! Map<String, dynamic>) {
          throw BackupException('invalid_row', spec.name);
        }
        for (final e in r.entries) {
          final v = e.value;
          if (!known.contains(e.key) ||
              !(v == null || v is int || v is double || v is String)) {
            throw BackupException('invalid_row', '${spec.name}.${e.key}');
          }
        }
        for (final k in spec.pk) {
          if (spec.isProfilesTable ? false : r[k] == null) {
            throw BackupException('invalid_row', '${spec.name}.$k');
          }
        }
        rows.add(Map<String, Object?>.from(r));
      }
      tables[spec.name] = rows;
    }

    final profiles = tables['profiles']!;
    if (profiles.length != 1 || profiles.single['display_name'] is! String) {
      throw const BackupException('invalid_structure', 'profiles');
    }
    return _Parsed(created, tables);
  }

  Future<void> _import(_Parsed parsed,
      {required String newProfileId, required bool replaceExisting}) async {
    try {
      await _db.transaction(() async {
        // When replacing, keep the target's own secrets (recovery data and
        // cloud id): they are never part of a backup.
        Map<String, Object?>? keep;
        if (replaceExisting) {
          final existing = await _db.customSelect(
            'SELECT recovery_question, recovery_hash, recovery_salt, '
            'cloud_user_id, mode FROM profiles WHERE id = ?',
            variables: [Variable<String>(newProfileId)],
          ).getSingleOrNull();
          keep = existing == null
              ? null
              : Map<String, Object?>.from(existing.data);
          await _db.customStatement(
              'DELETE FROM profiles WHERE id = ?', [newProfileId]);
        }
        // old id -> new id, per table. Every row id is regenerated.
        final idMap = <String, Map<String, String>>{};
        for (final spec in tableSpecs) {
          final map = idMap[spec.name] = {};
          for (final row in parsed.tables[spec.name]!) {
            final out = Map<String, Object?>.from(row);
            if (spec.isProfilesTable) {
              out['id'] = newProfileId;
              // Restored profiles start local, with no recovery question.
              out['mode'] = 'local';
              if (keep != null) out.addAll(keep);
            } else {
              out['profile_id'] = newProfileId;
              if (spec.pk.length == 1 && spec.pk.first == 'id') {
                final fresh = _uuid.v4();
                map[row['id'] as String] = fresh;
                out['id'] = fresh;
              }
            }
            for (final fk in spec.fks.entries) {
              final v = row[fk.key];
              if (v == null) continue;
              final mapped = idMap[fk.value]?[v as String];
              if (mapped == null) {
                throw BackupException(
                    'invalid_row', '${spec.name}.${fk.key} -> ${fk.value}');
              }
              out[fk.key] = mapped;
            }
            await _insert(spec.name, out);
          }
        }
      });
    } on BackupException {
      rethrow;
    } catch (e) {
      throw BackupException('restore_failed', e.runtimeType.toString());
    }
  }

  Future<void> _insert(String table, Map<String, Object?> row) {
    final cols = row.keys.toList();
    final placeholders = List.filled(cols.length, '?').join(', ');
    return _db.customStatement(
      'INSERT INTO $table (${cols.join(', ')}) VALUES ($placeholders)',
      [for (final c in cols) row[c]],
    );
  }

  Future<Set<String>> _columns(String table) async {
    final rows = await _db.customSelect('PRAGMA table_info($table)').get();
    return {for (final r in rows) r.read<String>('name')};
  }

  Future<List<Map<String, Object?>>> _rows(
      TableSpec spec, String profileId) async {
    final result = await _db.customSelect(
      'SELECT * FROM ${spec.name} WHERE ${spec.profileColumn} = ? '
      'ORDER BY ${spec.pk.join(', ')}',
      variables: [Variable<String>(profileId)],
    ).get();
    return [for (final r in result) Map<String, Object?>.from(r.data)];
  }
}

class _Parsed {
  _Parsed(this.createdAt, this.tables);
  final DateTime createdAt;
  final Map<String, List<Map<String, Object?>>> tables;
}
