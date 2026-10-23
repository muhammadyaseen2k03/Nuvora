/// Milestone badges. An achievement is awarded only when its criterion is
/// met by real stored data; there is no way to grant one otherwise.
class AchievementStats {
  const AchievementStats({
    this.prayerStreak = 0,
    this.focusSessionsTotal = 0,
    this.studyMinutesThisMonth = 0,
    this.workoutsTotal = 0,
    this.hydrationGoalStreak = 0,
  });

  /// Current streak of days with all five prayers recorded as completed.
  final int prayerStreak;
  final int focusSessionsTotal;
  final int studyMinutesThisMonth;
  final int workoutsTotal;

  /// Consecutive days (ending today or yesterday) that met the water goal.
  final int hydrationGoalStreak;
}

class AchievementDef {
  const AchievementDef(this.id, this.target, this.valueOf);

  final String id;
  final int target;
  final int Function(AchievementStats) valueOf;

  int progress(AchievementStats s) => valueOf(s);
  bool isEarned(AchievementStats s) => valueOf(s) >= target;
}

final achievementDefs = <AchievementDef>[
  AchievementDef('prayer_streak_7', 7, (s) => s.prayerStreak),
  AchievementDef('focus_sessions_10', 10, (s) => s.focusSessionsTotal),
  AchievementDef('study_hours_20_month', 20 * 60, (s) => s.studyMinutesThisMonth),
  AchievementDef('workouts_10', 10, (s) => s.workoutsTotal),
  AchievementDef('hydration_week', 7, (s) => s.hydrationGoalStreak),
];

/// Ids of achievements whose criteria are met by [stats].
Set<String> earnedAchievements(AchievementStats stats) => {
      for (final d in achievementDefs)
        if (d.isEarned(stats)) d.id,
    };

/// Consecutive days meeting [goalMl], ending today, or yesterday when today
/// is still in progress. [totalsByDay] is keyed by yyyy-MM-dd.
int hydrationStreak(Map<String, int> totalsByDay, int goalMl, DateTime today) {
  String key(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  bool met(DateTime d) => goalMl > 0 && (totalsByDay[key(d)] ?? 0) >= goalMl;
  var cursor = DateTime(today.year, today.month, today.day);
  if (!met(cursor)) cursor = DateTime(cursor.year, cursor.month, cursor.day - 1);
  var n = 0;
  while (met(cursor)) {
    n++;
    cursor = DateTime(cursor.year, cursor.month, cursor.day - 1);
  }
  return n;
}

/// Experience points: a simple, transparent total. 10 per completed focus
/// session, 20 per workout, 5 per prayer recorded as completed. Levels are
/// every 200 XP.
int experiencePoints({
  required int focusSessions,
  required int workouts,
  required int prayersCompleted,
}) =>
    focusSessions * 10 + workouts * 20 + prayersCompleted * 5;

int levelFor(int xp) => xp ~/ 200 + 1;
