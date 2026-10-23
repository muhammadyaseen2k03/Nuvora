import 'package:drift/drift.dart';

import '../../data/database.dart';

/// Per-profile sync choices. Everything defaults to off.
class SyncSettingsRepository {
  SyncSettingsRepository(this._db);

  final AppDatabase _db;

  Stream<SyncSetting?> watch(String profileId) => (_db.select(_db.syncSettings)
        ..where((s) => s.profileId.equals(profileId)))
      .watchSingleOrNull();

  Future<void> _ensure(String profileId) => _db
      .into(_db.syncSettings)
      .insert(SyncSettingsCompanion.insert(profileId: profileId),
          mode: InsertMode.insertOrIgnore);

  Future<void> update(
    String profileId, {
    bool? enabled,
    bool? prayer,
    bool? study,
    bool? fitness,
    bool? journal,
  }) async {
    await _ensure(profileId);
    await (_db.update(_db.syncSettings)
          ..where((s) => s.profileId.equals(profileId)))
        .write(SyncSettingsCompanion(
      enabled: Value.absentIfNull(enabled),
      syncPrayer: Value.absentIfNull(prayer),
      syncStudy: Value.absentIfNull(study),
      syncFitness: Value.absentIfNull(fitness),
      syncJournal: Value.absentIfNull(journal),
    ));
  }

  /// Records which cloud account this profile is linked to. The local profile
  /// id is never used to authorize anything remotely; the server decides from
  /// the signed-in user's token.
  Future<void> linkCloudUser(String profileId, String? cloudUserId) =>
      (_db.update(_db.profiles)..where((p) => p.id.equals(profileId))).write(
        ProfilesCompanion(
          cloudUserId: Value(cloudUserId),
          mode: Value(cloudUserId == null ? 'local' : 'cloud'),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Stops syncing and forgets cursors and pending deletions. Local data is
  /// untouched.
  Future<void> disableAndReset(String profileId) async {
    await _ensure(profileId);
    await _db.transaction(() async {
      await (_db.update(_db.syncSettings)
            ..where((s) => s.profileId.equals(profileId)))
          .write(const SyncSettingsCompanion(
              enabled: Value(false), lastError: Value(null)));
      await (_db.delete(_db.syncState)
            ..where((s) => s.profileId.equals(profileId)))
          .go();
      await (_db.delete(_db.syncTombstones)
            ..where((t) => t.profileId.equals(profileId)))
          .go();
    });
  }

  /// Number of local deletions the server has not been told about yet.
  Stream<int> watchPendingDeletes(String profileId) {
    final count = _db.syncTombstones.rowId.count();
    return (_db.selectOnly(_db.syncTombstones)
          ..addColumns([count])
          ..where(_db.syncTombstones.profileId.equals(profileId)))
        .map((r) => r.read(count) ?? 0)
        .watchSingle();
  }
}
