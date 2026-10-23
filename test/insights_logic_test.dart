import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/features/habits/day_status.dart';
import 'package:nuvora/features/home/daily_score.dart';
import 'package:nuvora/features/insights/achievements.dart';
import 'package:nuvora/features/insights/weekly_report.dart';

void main() {
  group('achievements', () {
    test('nothing is earned from empty stats', () {
      expect(earnedAchievements(const AchievementStats()), isEmpty);
    });

    test('awarded only at the exact thresholds', () {
      expect(earnedAchievements(const AchievementStats(prayerStreak: 6)), isEmpty);
      expect(earnedAchievements(const AchievementStats(prayerStreak: 7)),
          {'prayer_streak_7'});
      expect(
          earnedAchievements(const AchievementStats(
              focusSessionsTotal: 10, workoutsTotal: 9)),
          {'focus_sessions_10'});
      expect(
          earnedAchievements(
              const AchievementStats(studyMinutesThisMonth: 20 * 60 - 1)),
          isEmpty);
      expect(
          earnedAchievements(
              const AchievementStats(studyMinutesThisMonth: 20 * 60)),
          {'study_hours_20_month'});
    });

    test('hydration streak ends yesterday when today is in progress', () {
      final totals = {
        '2024-05-07': 2000,
        '2024-05-08': 2500,
        '2024-05-09': 2000,
        '2024-05-10': 300, // today, not yet met
      };
      expect(hydrationStreak(totals, 2000, DateTime(2024, 5, 10)), 3);
      totals['2024-05-10'] = 2000;
      expect(hydrationStreak(totals, 2000, DateTime(2024, 5, 10)), 4);
      expect(hydrationStreak(totals, 0, DateTime(2024, 5, 10)), 0);
      // A gap breaks the streak.
      expect(hydrationStreak({'2024-05-10': 2000, '2024-05-08': 2000}, 2000,
          DateTime(2024, 5, 10)), 1);
    });

    test('xp and levels are simple and transparent', () {
      expect(experiencePoints(focusSessions: 2, workouts: 1, prayersCompleted: 4),
          20 + 20 + 20);
      expect(levelFor(0), 1);
      expect(levelFor(199), 1);
      expect(levelFor(200), 2);
    });
  });

  group('weekly report', () {
    final monday = DateTime(2024, 5, 6);
    DateTime d(int i) => DateTime(monday.year, monday.month, monday.day + i);

    test('uses stored numbers and finds the most consistent day', () {
      final days = [
        DayStats(day: d(0), studyMinutes: 30, studyBySubject: {'Math': 30}),
        DayStats(
            day: d(1),
            prayersCompleted: 5,
            studyMinutes: 60,
            studyBySubject: {'Math': 20, 'Physics': 40},
            workouts: 1,
            waterMl: 2000),
        DayStats(day: d(2), prayersCompleted: 2, prayersMissed: 1),
      ];
      final r = buildWeeklyReport(days, const WeeklyGoals());
      expect(r.mostConsistentDay, d(1));
      expect(r.studyMinutesTotal, 90);
      expect(r.studyBySubject.map((e) => '${e.key}:${e.value}'),
          ['Physics:40', 'Math:50'].reversed.toList());
      expect(r.workouts, 1);
      expect((r.prayersCompleted, r.prayersRecorded), (7, 8));
      expect(r.hydrationDaysMet, 1);
    });

    test('empty week has no most consistent day and keeps going', () {
      final r = buildWeeklyReport([for (var i = 0; i < 7; i++) DayStats(day: d(i))],
          const WeeklyGoals(),
          include: const ReportCategories(prayer: false, study: false, fitness: false, hydration: false));
      expect(r.mostConsistentDay, isNull);
      expect(r.suggestion, 'keep_going');
    });

    test('suggestion targets the weakest included category', () {
      final days = [
        for (var i = 0; i < 7; i++)
          DayStats(
              day: d(i),
              prayersCompleted: 5,
              studyMinutes: 60,
              workouts: i < 3 ? 1 : 0,
              waterMl: i < 2 ? 2000 : 500),
      ];
      expect(buildWeeklyReport(days, const WeeklyGoals()).suggestion, 'water');
      expect(
          buildWeeklyReport(days, const WeeklyGoals(),
                  include: const ReportCategories(hydration: false))
              .suggestion,
          'keep_going');
    });

    test('unrecorded prayers do not lower the completed count or count as missed',
        () {
      final r = buildWeeklyReport(
          [DayStats(day: d(0), prayersCompleted: 3)], const WeeklyGoals());
      expect((r.prayersCompleted, r.prayersRecorded), (3, 3));
    });
  });

  group('day status', () {
    const all = [GoalProgress('a', 1), GoalProgress('b', 1)];
    const some = [GoalProgress('a', 1), GoalProgress('b', 0)];
    const none = [GoalProgress('a', 0), GoalProgress('b', 0)];

    test('classification', () {
      expect(classifyDay(goals: all, anyRecord: true, explicitMissOnly: false),
          DayStatus.complete);
      expect(classifyDay(goals: some, anyRecord: true, explicitMissOnly: false),
          DayStatus.partial);
      expect(classifyDay(goals: none, anyRecord: true, explicitMissOnly: true),
          DayStatus.missed);
      expect(classifyDay(goals: none, anyRecord: false, explicitMissOnly: false),
          DayStatus.unrecorded);
      // Records exist but nothing completed and no explicit miss.
      expect(classifyDay(goals: none, anyRecord: true, explicitMissOnly: false),
          DayStatus.unrecorded);
      expect(classifyDay(goals: const [], anyRecord: true, explicitMissOnly: false),
          DayStatus.unrecorded);
    });
  });
}
