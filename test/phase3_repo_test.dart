import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/data/database.dart';
import 'package:nuvora/features/auth/profile_repository.dart';
import 'package:nuvora/features/fitness/fitness_repository.dart';
import 'package:nuvora/features/habits/journal_repository.dart';
import 'package:nuvora/features/insights/achievements.dart';
import 'package:nuvora/features/insights/history_repository.dart';
import 'package:nuvora/features/planner/plan_generator.dart';
import 'package:nuvora/features/planner/planner.dart';
import 'package:nuvora/features/planner/planner_repository.dart';
import 'package:nuvora/features/prayer/prayer_repository.dart';
import 'package:nuvora/features/prayer/prayer_service.dart';
import 'package:nuvora/features/prayer/prayer_streaks.dart';
import 'package:nuvora/features/study/focus_timer.dart';
import 'package:nuvora/features/study/study_repository.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late AppDatabase db;
  late String a;
  late String b;
  var clock = DateTime(2024, 5, 10, 9, 0);
  DateTime now() => clock;

  setUp(() async {
    clock = DateTime(2024, 5, 10, 9, 0);
    db = AppDatabase(NativeDatabase.memory());
    final profiles = ProfileRepository(db);
    a = await profiles.createProfile(const NewProfile(displayName: 'A'));
    b = await profiles.createProfile(const NewProfile(displayName: 'B'));
  });
  tearDown(() => db.close());

  group('journal', () {
    test('one entry per day, upsert, search, delete, isolation', () async {
      final repo = JournalRepository(db, clock: now);
      final day = DateTime(2024, 5, 10);
      await repo.save(a, day, wentWell: 'Finished my chapter', grateful: 'Family');
      await repo.save(a, day, wentWell: 'Finished my chapter', learned: 'Limits');
      await repo.save(a, DateTime(2024, 5, 9), grateful: 'Rain 100% good_day');
      await repo.save(b, day, wentWell: 'Private to B');

      var all = await repo.watch(a).first;
      expect(all.map((e) => e.day), ['2024-05-10', '2024-05-09']);
      expect(all.first.learned, 'Limits');
      expect(all.first.grateful, ''); // replaced by the second save

      expect((await repo.watch(a, query: 'CHAPTER').first), hasLength(1));
      // LIKE wildcards in the query are treated literally.
      expect((await repo.watch(a, query: '100%').first), hasLength(1));
      expect((await repo.watch(a, query: 'good_day').first), hasLength(1));
      expect((await repo.watch(a, query: '%').first), hasLength(1));
      expect((await repo.watch(a, query: 'private').first), isEmpty);

      // Saving all-empty answers removes the entry.
      await repo.save(a, DateTime(2024, 5, 9));
      all = await repo.watch(a).first;
      expect(all, hasLength(1));
      expect(await repo.forDay(a, day), isNotNull);
      await repo.delete(b, all.single.id); // wrong profile: no effect
      expect(await repo.watch(a).first, hasLength(1));
    });
  });

  group('planner repository', () {
    final day = DateTime(2024, 5, 10);
    DateTime at(int h, [int m = 0]) => DateTime(2024, 5, 10, h, m);

    PlanBlock block(String t, int h, int m) => PlanBlock(
        title: t,
        start: at(h, m),
        end: at(h, m + 30),
        isFixed: false,
        kind: PlanKind.study,
        taskId: t);

    test('regeneration keeps pinned, done and skipped items', () async {
      final repo = PlannerRepository(db, clock: now);
      await repo.replaceSuggestions(a, day,
          [block('One', 9, 0), block('Two', 10, 0), block('Three', 11, 0)]);
      var items = await repo.watchDay(a, day).first;
      expect(items.map((i) => i.title), ['One', 'Two', 'Three']);

      await repo.setPinned(a, items[0].id, true);
      await repo.setStatus(a, items[1].id, ActivityStatus.done);
      await repo.replaceSuggestions(a, day, [block('New', 13, 0)]);

      items = await repo.watchDay(a, day).first;
      expect(items.map((i) => i.title), ['One', 'Two', 'New']);
      expect(await repo.watchDay(b, day).first, isEmpty);
    });

    test('moving an item pins it; invalid ranges are rejected', () async {
      final repo = PlannerRepository(db, clock: now);
      await repo.replaceSuggestions(a, day, [block('One', 9, 0)]);
      final item = (await repo.watchDay(a, day).first).single;
      await repo.move(a, item.id, at(14), at(15));
      final moved = (await repo.watchDay(a, day).first).single;
      expect((moved.startAt, moved.pinned), (at(14), true));
      expect(() => repo.move(a, item.id, at(15), at(14)), throwsArgumentError);
      expect(
          () => repo.addManual(a, day,
              title: 'x', start: at(10), end: at(10)),
          throwsArgumentError);
    });
  });

  group('plan generator', () {
    test('builds a non-overlapping plan from stored-data inputs', () {
      final day = DateTime(2024, 5, 10);
      DateTime at(int h, [int m = 0]) => DateTime(2024, 5, 10, h, m);
      final result = generatePlan(PlanInputs(
        day: day,
        now: DateTime(2024, 5, 10, 7, 3),
        prayerTimes: {'Dhuhr': at(12, 30), 'Asr': at(16, 0), 'Maghrib': at(19, 10)},
        dueCards: 14,
        exams: const [ExamInfo('Calculus', 2), ExamInfo('Far away', 30)],
        topics: const [TopicInfo('Limits', 1), TopicInfo('Vectors', 2)],
        workoutMinutes: 25,
        reviewTitle: 'Review cards',
        workoutTitle: 'Workout',
      ));
      final b = result.blocks;
      for (var i = 1; i < b.length; i++) {
        expect(!b[i].start.isBefore(b[i - 1].end), isTrue,
            reason: '${b[i - 1].title} / ${b[i].title}');
      }
      expect(b.where((x) => x.title == 'Far away'), isEmpty); // beyond 14 days
      final calc = b.firstWhere((x) => x.title == 'Calculus');
      expect(calc.minutes, 90); // 2 days left
      expect(calc.reason, 'exam_soon');
      expect(calc.start.isAfter(DateTime(2024, 5, 10, 7, 2)), isTrue);
      expect(b.firstWhere((x) => x.title == 'Workout').start.hour,
          greaterThanOrEqualTo(16));
      expect(b.where((x) => x.isFixed), hasLength(3));
    });

    test('no data gives an empty plan, not invented activities', () {
      final result = generatePlan(PlanInputs(
        day: DateTime(2024, 5, 10),
        now: DateTime(2024, 5, 9),
        prayerTimes: const {},
        dueCards: 0,
        exams: const [],
        topics: const [],
        workoutMinutes: 0,
        reviewTitle: 'r',
        workoutTitle: 'w',
      ));
      expect(result.blocks, isEmpty);
    });
  });

  group('history and achievements', () {
    test('day records come from stored data; unrecorded is not missed',
        () async {
      final prayer = PrayerRepository(db, clock: now);
      final fitness = FitnessRepository(db, clock: now);
      final study = StudyRepository(db, clock: now);
      final day = DateTime(2024, 5, 10);

      await prayer.setStatus(a, day, PrayerName.fajr, PrayerStatus.onTime);
      await prayer.setStatus(a, day, PrayerName.dhuhr, PrayerStatus.missed);
      await prayer.setStatus(a, DateTime(2024, 5, 9), PrayerName.asr, PrayerStatus.missed);
      await fitness.addWater(a, 750);
      await fitness.saveWorkoutSession(a,
          workoutKey: 'k', workoutName: 'W',
          startedAt: DateTime(2024, 5, 10, 7), endedAt: DateTime(2024, 5, 10, 7, 20),
          exercisesCompleted: 3, exercisesTotal: 5);
      final math = await study.addSubject(a, 'Math');
      await study.startSession(a,
          kind: FocusKind.focus, plannedSeconds: 1500, subjectId: math);
      clock = DateTime(2024, 5, 10, 11, 0);
      final s = (await study.watchActiveSession(a).first)!;
      await study.completeIfDue(s);
      await fitness.addWater(b, 9999 > 5000 ? 5000 : 1);

      final records = await HistoryRepository(db, clock: now)
          .load(a, DateTime(2024, 5, 8), DateTime(2024, 5, 10));
      expect(records.map((r) => r.stats.day.day), [8, 9, 10]);
      final r8 = records[0], r9 = records[1], r10 = records[2];
      expect(r8.anyRecord, isFalse); // nothing recorded: unrecorded
      expect(r9.explicitMissOnly, isTrue);
      expect(r10.stats.prayersCompleted, 1);
      expect(r10.stats.prayersMissed, 1);
      expect(r10.stats.waterMl, 750);
      expect(r10.stats.workouts, 1);
      expect(r10.stats.studyMinutes, 25);
      expect(r10.stats.studyBySubject, {'Math': 25});
    });

    test('achievements are awarded once, only when criteria are met',
        () async {
      final history = HistoryRepository(db, clock: now);
      final fitness = FitnessRepository(db, clock: now);
      for (var i = 0; i < 9; i++) {
        await fitness.saveWorkoutSession(a,
            workoutKey: 'k', workoutName: 'W',
            startedAt: DateTime(2024, 5, 1 + i), endedAt: DateTime(2024, 5, 1 + i, 1),
            exercisesCompleted: 1, exercisesTotal: 1);
      }
      var stats = await history.achievementStats(a, 2000);
      expect(earnedAchievements(stats), isEmpty);
      expect(await history.syncAwards(a, earnedAchievements(stats)), isEmpty);

      await fitness.saveWorkoutSession(a,
          workoutKey: 'k', workoutName: 'W',
          startedAt: DateTime(2024, 5, 10), endedAt: DateTime(2024, 5, 10, 1),
          exercisesCompleted: 1, exercisesTotal: 1);
      stats = await history.achievementStats(a, 2000);
      expect(stats.workoutsTotal, 10);
      expect(await history.syncAwards(a, earnedAchievements(stats)),
          ['workouts_10']);
      // Second sync does not duplicate.
      expect(await history.syncAwards(a, earnedAchievements(stats)), isEmpty);
      expect(await history.watchAwards(a).first, hasLength(1));
      expect(await history.watchAwards(b).first, isEmpty);
    });

    test('prayer streak feeds the 7-day achievement', () async {
      final prayer = PrayerRepository(db, clock: now);
      for (var d = 0; d < 7; d++) {
        for (final p in PrayerName.values) {
          await prayer.setStatus(
              a, DateTime(2024, 5, 4 + d), p, PrayerStatus.onTime);
        }
      }
      final stats = await HistoryRepository(db, clock: now)
          .achievementStats(a, 2000);
      expect(stats.prayerStreak, 7);
      expect(earnedAchievements(stats), contains('prayer_streak_7'));
    });
  });
}
