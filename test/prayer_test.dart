import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/data/database.dart';
import 'package:nuvora/features/auth/profile_repository.dart';
import 'package:nuvora/features/prayer/prayer_repository.dart';
import 'package:nuvora/features/prayer/prayer_service.dart';
import 'package:nuvora/features/prayer/prayer_streaks.dart';

PrayerLog _full(List<String> days,
    {PrayerStatus status = PrayerStatus.onTime}) {
  return {
    for (final d in days) d: {for (final p in PrayerName.values) p: status},
  };
}

void main() {
  group('PrayerService', () {
    // Reference case from the Adhan project test data: Raleigh, NC
    // (35.78056, -78.6389), 2015-07-12, North America (ISNA), Hanafi Asr.
    // Published in America/New_York (UTC-4): 4:42, 6:08, 1:21pm, 6:22pm,
    // 8:32pm, 9:57pm.
    test('matches published reference times within one minute', () {
      const service = PrayerService();
      final t = service.forDay(
        const PrayerConfig(
          method: 'northAmerica',
          asrMethod: 'hanafi',
          latitude: 35.78056,
          longitude: -78.6389,
        ),
        DateTime(2015, 7, 12),
      );
      DateTime utc(int d, int h, int m) => DateTime.utc(2015, 7, d, h, m);
      void near(DateTime actual, DateTime expected) {
        expect(actual.toUtc().difference(expected).inSeconds.abs(),
            lessThanOrEqualTo(60),
            reason: 'expected ~$expected got ${actual.toUtc()}');
      }

      near(t.times[PrayerName.fajr]!, utc(12, 8, 42));
      near(t.sunrise, utc(12, 10, 8));
      near(t.times[PrayerName.dhuhr]!, utc(12, 17, 21));
      near(t.times[PrayerName.asr]!, utc(12, 22, 22));
      near(t.times[PrayerName.maghrib]!, utc(13, 0, 32));
      near(t.times[PrayerName.isha]!, utc(13, 1, 57));
    });

    test('standard Asr matches an independent solar-geometry calculation', () {
      // Raleigh, 2015-07-12: declination ~21.9 deg gives a noon shadow of
      // ~0.2475 of the object height, so Asr (shadow = height + noon shadow)
      // occurs when the sun is ~38.7 deg high, ~3h49m after solar noon
      // (Dhuhr 17:21 UTC) => ~21:10 UTC. Hand-derived, not from the library.
      final t = const PrayerService().forDay(
        const PrayerConfig(
          method: 'northAmerica',
          asrMethod: 'shafi',
          latitude: 35.78056,
          longitude: -78.6389,
        ),
        DateTime(2015, 7, 12),
      );
      final expected = DateTime.utc(2015, 7, 12, 21, 10);
      expect(
          t.times[PrayerName.asr]!.toUtc().difference(expected).inMinutes.abs(),
          lessThanOrEqualTo(2));
    });

    test('Hanafi Asr is later than standard Asr', () {
      const service = PrayerService();
      PrayerConfig cfg(String asr) => PrayerConfig(
          method: 'karachi', asrMethod: asr, latitude: 24.86, longitude: 67.0);
      final day = DateTime(2024, 3, 1);
      final shafi = service.forDay(cfg('shafi'), day).times[PrayerName.asr]!;
      final hanafi = service.forDay(cfg('hanafi'), day).times[PrayerName.asr]!;
      expect(hanafi.isAfter(shafi), isTrue);
    });

    test('next prayer rolls over to tomorrow Fajr after Isha', () {
      const service = PrayerService();
      final t = service.forDay(
        const PrayerConfig(
            method: 'karachi',
            asrMethod: 'shafi',
            latitude: 24.86,
            longitude: 67.0),
        DateTime(2024, 3, 1),
      );
      final afterIsha = t.times[PrayerName.isha]!.add(const Duration(minutes: 1));
      final n = t.next(afterIsha);
      expect(n.prayer, isNull);
      expect(n.time, t.nextFajr);
      expect(t.nextFajr.isAfter(t.times[PrayerName.isha]!), isTrue);

      final beforeDawn = t.times[PrayerName.fajr]!.subtract(const Duration(minutes: 1));
      expect(t.next(beforeDawn).prayer, PrayerName.fajr);
      expect(t.current(beforeDawn), isNull);
      expect(t.current(t.times[PrayerName.asr]!), PrayerName.asr);
    });
  });

  group('streaks', () {
    final today = DateTime(2024, 5, 10);

    test('counts consecutive complete days ending today', () {
      final log = _full(['2024-05-08', '2024-05-09', '2024-05-10']);
      expect(currentStreak(log, today), 3);
    });

    test('an in-progress today does not reset the streak', () {
      final log = _full(['2024-05-08', '2024-05-09']);
      log['2024-05-10'] = {PrayerName.fajr: PrayerStatus.onTime};
      expect(currentStreak(log, today), 2);
    });

    test('unrecorded and missed prayers both end a streak, but differently '
        'recorded', () {
      final log = _full(['2024-05-07', '2024-05-09', '2024-05-10']);
      // 05-08 has no records at all: not complete, but also not "missed".
      expect(currentStreak(log, today), 2);
      expect(log.containsKey('2024-05-08'), isFalse);

      log['2024-05-08'] = {
        for (final p in PrayerName.values) p: PrayerStatus.onTime,
        PrayerName.isha: PrayerStatus.missed,
      };
      expect(currentStreak(log, today), 2);
    });

    test('strict mode requires on-time prayers', () {
      final log = _full(['2024-05-09', '2024-05-10'])
        ..['2024-05-09']![PrayerName.asr] = PrayerStatus.late;
      expect(currentStreak(log, today), 2);
      expect(currentStreak(log, today, strict: true), 1);
    });

    test('longest streak and month boundary', () {
      final log = _full([
        '2024-02-28', '2024-02-29', '2024-03-01', // leap-day boundary
        '2024-03-05',
      ]);
      expect(longestStreak(log), 3);
    });

    test('summary separates missed from unrecorded', () {
      final log = <String, Map<PrayerName, PrayerStatus>>{
        '2024-05-10': {
          PrayerName.fajr: PrayerStatus.onTime,
          PrayerName.dhuhr: PrayerStatus.late,
          PrayerName.asr: PrayerStatus.missed,
        },
      };
      final s = summarize(log, today, 1);
      expect((s.completed, s.missed, s.unrecorded), (2, 1, 2));
    });
  });

  group('PrayerRepository', () {
    late AppDatabase db;
    late PrayerRepository repo;
    late String profileId;
    late String otherId;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      repo = PrayerRepository(db);
      final profiles = ProfileRepository(db);
      profileId = await profiles.createProfile(const NewProfile(displayName: 'A'));
      otherId = await profiles.createProfile(const NewProfile(displayName: 'B'));
    });
    tearDown(() => db.close());

    test('set, change and clear a status', () async {
      final day = DateTime(2024, 5, 10);
      await repo.setStatus(profileId, day, PrayerName.fajr, PrayerStatus.onTime);
      await repo.setStatus(profileId, day, PrayerName.fajr, PrayerStatus.late);
      var log = await repo.watchLog(profileId, day, day).first;
      expect(log['2024-05-10']![PrayerName.fajr], PrayerStatus.late);
      expect(await db.select(db.prayerRecords).get(), hasLength(1));

      await repo.setStatus(profileId, day, PrayerName.fajr, null);
      log = await repo.watchLog(profileId, day, day).first;
      expect(log, isEmpty);
    });

    test('records are isolated per profile and removed with the profile',
        () async {
      final day = DateTime(2024, 5, 10);
      await repo.setStatus(profileId, day, PrayerName.asr, PrayerStatus.missed);
      expect(await repo.watchLog(otherId, day, day).first, isEmpty);

      await ProfileRepository(db).deleteProfile(profileId);
      expect(await db.select(db.prayerRecords).get(), isEmpty);
    });

    test('settings persist and keep location when not changed', () async {
      await repo.saveSettings(profileId,
          method: 'karachi',
          asrMethod: 'hanafi',
          latitude: 24.86,
          longitude: 67.0,
          locationLabel: 'Karachi');
      await repo.saveSettings(profileId,
          method: 'egyptian', asrMethod: 'shafi');
      final s = (await repo.watchSettings(profileId).first)!;
      expect(s.method, 'egyptian');
      expect(s.latitude, 24.86);
      expect(s.locationLabel, 'Karachi');
      expect(await repo.watchSettings(otherId).first, isNull);
    });
  });
}
