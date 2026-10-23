import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../data/database.dart';
import 'prayer_service.dart';
import 'prayer_streaks.dart';

class PrayerRepository {
  PrayerRepository(this._db, {DateTime Function()? clock})
      : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _now;
  static const _uuid = Uuid();

  Stream<PrayerSetting?> watchSettings(String profileId) =>
      (_db.select(_db.prayerSettings)
            ..where((s) => s.profileId.equals(profileId)))
          .watchSingleOrNull();

  /// Saves calculation preferences. Pass [latitude]/[longitude] to change the
  /// location; leave both null to keep the stored one.
  Future<void> saveSettings(
    String profileId, {
    required String method,
    required String asrMethod,
    double? latitude,
    double? longitude,
    String? locationLabel,
  }) async {
    final existing = await (_db.select(_db.prayerSettings)
          ..where((s) => s.profileId.equals(profileId)))
        .getSingleOrNull();
    final changeLocation = latitude != null && longitude != null;
    await _db.into(_db.prayerSettings).insertOnConflictUpdate(
          PrayerSettingsCompanion.insert(
            profileId: profileId,
            method: Value(method),
            asrMethod: Value(asrMethod),
            latitude: Value(changeLocation ? latitude : existing?.latitude),
            longitude: Value(changeLocation ? longitude : existing?.longitude),
            locationLabel: Value(
                changeLocation ? locationLabel : existing?.locationLabel),
            updatedAt: _now(),
          ),
        );
  }

  /// Records [status] for a prayer, or clears the record when null (which
  /// returns it to "not recorded").
  Future<void> setStatus(
    String profileId,
    DateTime day,
    PrayerName prayer,
    PrayerStatus? status,
  ) async {
    final key = dayKey(day);
    final match = _db.select(_db.prayerRecords)
      ..where((r) =>
          r.profileId.equals(profileId) &
          r.day.equals(key) &
          r.prayer.equals(prayer.name));
    if (status == null) {
      await (_db.delete(_db.prayerRecords)
            ..where((r) =>
                r.profileId.equals(profileId) &
                r.day.equals(key) &
                r.prayer.equals(prayer.name)))
          .go();
      return;
    }
    final now = _now();
    await _db.transaction(() async {
      final existing = await match.getSingleOrNull();
      if (existing == null) {
        await _db.into(_db.prayerRecords).insert(PrayerRecordsCompanion.insert(
              id: _uuid.v4(),
              profileId: profileId,
              day: key,
              prayer: prayer.name,
              status: status.name,
              createdAt: now,
              updatedAt: now,
            ));
      } else {
        await (_db.update(_db.prayerRecords)
              ..where((r) => r.id.equals(existing.id)))
            .write(PrayerRecordsCompanion(
          status: Value(status.name),
          updatedAt: Value(now),
        ));
      }
    });
  }

  /// All records for the profile between [from] and [to] (inclusive).
  Stream<PrayerLog> watchLog(String profileId, DateTime from, DateTime to) {
    final q = _db.select(_db.prayerRecords)
      ..where((r) =>
          r.profileId.equals(profileId) &
          r.day.isBetweenValues(dayKey(from), dayKey(to)));
    return q.watch().map((rows) {
      final log = <String, Map<PrayerName, PrayerStatus>>{};
      for (final r in rows) {
        final prayer = PrayerName.values.asNameMap()[r.prayer];
        final status = PrayerStatus.values.asNameMap()[r.status];
        if (prayer == null || status == null) continue;
        (log[r.day] ??= {})[prayer] = status;
      }
      return log;
    });
  }
}
