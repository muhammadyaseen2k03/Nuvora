import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/data/database.dart';
import 'package:nuvora/features/auth/profile_repository.dart';
import 'package:nuvora/features/fitness/fitness_repository.dart';
import 'package:sqlite3/sqlite3.dart' as sql;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late AppDatabase db;
  late FitnessRepository repo;
  late String a;
  late String b;
  var clock = DateTime(2024, 5, 10, 9, 0);

  setUp(() async {
    clock = DateTime(2024, 5, 10, 9, 0);
    db = AppDatabase(NativeDatabase.memory());
    repo = FitnessRepository(db, clock: () => clock);
    final profiles = ProfileRepository(db);
    a = await profiles.createProfile(const NewProfile(displayName: 'A'));
    b = await profiles.createProfile(const NewProfile(displayName: 'B'));
  });
  tearDown(() => db.close());

  group('water', () {
    test('totals per day are correct and isolated per profile', () async {
      await repo.addWater(a, 250);
      await repo.addWater(a, 500, at: DateTime(2024, 5, 10, 13, 0));
      await repo.addWater(a, 300, at: DateTime(2024, 5, 9, 22, 0));
      await repo.addWater(b, 999);

      final logs = await repo.watchWaterSince(a, DateTime(2024, 5, 8)).first;
      final totals = FitnessRepository.dailyTotals(logs, DateTime(2024, 5, 10), 3);
      expect(totals.map((t) => t.ml), [0, 300, 750]);
      expect(await repo.watchWaterSince(b, DateTime(2024, 5, 8)).first,
          hasLength(1));
    });

    test('rejects invalid amounts and goals', () async {
      expect(() => repo.addWater(a, 0), throwsArgumentError);
      expect(() => repo.addWater(a, 6000), throwsArgumentError);
      expect(() => repo.setWaterGoal(a, 10), throwsArgumentError);
    });

    test('undo removes only the latest log; goal persists per profile',
        () async {
      await repo.addWater(a, 250, at: DateTime(2024, 5, 10, 8));
      await repo.addWater(a, 500, at: DateTime(2024, 5, 10, 12));
      await repo.undoLastWater(a);
      final logs = await repo.watchWaterSince(a, DateTime(2024, 5, 10)).first;
      expect(logs.map((l) => l.amountMl), [250]);

      await repo.setWaterGoal(a, 3000);
      final prefs = await (db.select(db.userPreferences)
            ..where((p) => p.profileId.equals(a)))
          .getSingle();
      expect(prefs.waterGoalMl, 3000);
      final other = await (db.select(db.userPreferences)
            ..where((p) => p.profileId.equals(b)))
          .getSingle();
      expect(other.waterGoalMl, 2000);
    });
  });

  group('fasting', () {
    test('start, recover after restart, end, history', () async {
      final id = await repo.startFast(a, plannedSeconds: 14 * 3600);
      final active = (await repo.watchActiveFast(a).first)!;
      expect(active.id, id);
      expect(active.startedAt, clock);

      clock = clock.add(const Duration(hours: 15));
      await repo.endFast(a, id, notes: 'felt fine');
      expect(await repo.watchActiveFast(a).first, isNull);
      final hist = await repo.watchFastHistory(a).first;
      expect(hist.single.endedAt!.difference(hist.single.startedAt),
          const Duration(hours: 15));
      expect(hist.single.notes, 'felt fine');
      expect(await repo.watchFastHistory(b).first, isEmpty);
    });

    test('starting a new fast closes the open one', () async {
      await repo.startFast(a);
      clock = clock.add(const Duration(hours: 1));
      await repo.startFast(a, plannedSeconds: 3600);
      final all = await db.select(db.fastingSessions).get();
      expect(all.where((f) => f.endedAt == null), hasLength(1));
    });
  });

  test('workout history is stored and newest first', () async {
    Future<void> save(String name, DateTime t) => repo.saveWorkoutSession(a,
        workoutKey: 'k',
        workoutName: name,
        startedAt: t,
        endedAt: t.add(const Duration(minutes: 10)),
        exercisesCompleted: 4,
        exercisesTotal: 5);
    await save('First', DateTime(2024, 5, 8, 7));
    await save('Second', DateTime(2024, 5, 9, 7));
    final hist = await repo.watchWorkoutHistory(a).first;
    expect(hist.map((w) => w.workoutName), ['Second', 'First']);
    expect(await repo.watchWorkoutHistory(b).first, isEmpty);
  });

  group('migration', () {
    test('upgrading from schema v1 keeps profiles and adds new tables',
        () async {
      // Build a version-1 database by hand.
      final raw = sql.sqlite3.openInMemory();
      raw.execute('''
        CREATE TABLE profiles (
          id TEXT NOT NULL PRIMARY KEY, display_name TEXT NOT NULL,
          mode TEXT NOT NULL DEFAULT 'local', cloud_user_id TEXT,
          recovery_question TEXT, recovery_hash TEXT, recovery_salt TEXT,
          created_at INTEGER NOT NULL, updated_at INTEGER NOT NULL,
          deleted_at INTEGER);
        CREATE TABLE user_preferences (
          profile_id TEXT NOT NULL PRIMARY KEY,
          theme_mode TEXT NOT NULL DEFAULT 'system',
          language_code TEXT NOT NULL DEFAULT 'en',
          fitness_level TEXT NOT NULL DEFAULT 'beginner',
          workout_minutes INTEGER NOT NULL DEFAULT 20,
          study_goal_minutes INTEGER NOT NULL DEFAULT 60,
          updated_at INTEGER NOT NULL);
        INSERT INTO profiles (id, display_name, created_at, updated_at)
          VALUES ('p1', 'Old User', 1700000000, 1700000000);
        INSERT INTO user_preferences (profile_id, updated_at)
          VALUES ('p1', 1700000000);
        PRAGMA user_version = 1;
      ''');
      final upgraded = AppDatabase(NativeDatabase.opened(raw));
      addTearDown(upgraded.close);

      final profiles = await upgraded.select(upgraded.profiles).get();
      expect(profiles.single.displayName, 'Old User');
      final prefs = await upgraded.select(upgraded.userPreferences).getSingle();
      expect(prefs.waterGoalMl, 2000); // new column gets its default

      // New tables are usable.
      await FitnessRepository(upgraded).addWater('p1', 250);
      expect(await upgraded.select(upgraded.waterLogs).get(), hasLength(1));
      // Deletion-tracking triggers exist after the upgrade.
      final log = (await upgraded.select(upgraded.waterLogs).get()).single;
      await (upgraded.delete(upgraded.waterLogs)
            ..where((w) => w.id.equals(log.id)))
          .go();
      final tombs = await upgraded.select(upgraded.syncTombstones).get();
      expect((tombs.single.targetTable, tombs.single.rowId), ('water_logs', log.id));
      expect(await upgraded.select(upgraded.flashcards).get(), isEmpty);
      expect(await upgraded.select(upgraded.prayerRecords).get(), isEmpty);
    });
  });
}
