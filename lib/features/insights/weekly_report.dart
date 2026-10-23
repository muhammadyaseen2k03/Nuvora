import '../home/daily_score.dart';

/// One day's recorded numbers, supplied from stored data.
class DayStats {
  const DayStats({
    required this.day,
    this.prayersCompleted = 0,
    this.prayersMissed = 0,
    this.studyMinutes = 0,
    this.studyBySubject = const {},
    this.workouts = 0,
    this.waterMl = 0,
  });

  final DateTime day;
  final int prayersCompleted;
  final int prayersMissed;
  final int studyMinutes;
  final Map<String, int> studyBySubject;
  final int workouts;
  final int waterMl;
}

class WeeklyGoals {
  const WeeklyGoals({this.studyMinutesPerDay = 60, this.waterMlPerDay = 2000});
  final int studyMinutesPerDay;
  final int waterMlPerDay;
}

/// Which parts of the report the user wants included.
class ReportCategories {
  const ReportCategories(
      {this.prayer = true,
      this.study = true,
      this.fitness = true,
      this.hydration = true});
  final bool prayer, study, fitness, hydration;
}

class WeeklyReport {
  const WeeklyReport({
    required this.mostConsistentDay,
    required this.studyMinutesTotal,
    required this.studyBySubject,
    required this.workouts,
    required this.prayersCompleted,
    required this.prayersRecorded,
    required this.hydrationDaysMet,
    required this.suggestion,
  });

  /// Null when nothing at all was recorded this week.
  final DateTime? mostConsistentDay;
  final int studyMinutesTotal;

  /// Subject name -> minutes, largest first.
  final List<MapEntry<String, int>> studyBySubject;
  final int workouts;
  final int prayersCompleted;

  /// Prayers with any record. Unrecorded prayers are not counted as missed.
  final int prayersRecorded;
  final int hydrationDaysMet;

  /// A code for one practical suggestion: `water`, `study`, `workout`,
  /// `prayer_tracking` or `keep_going`.
  final String suggestion;
}

/// Builds a report from [days] (typically seven consecutive days).
/// Everything is derived from the supplied records; nothing is estimated.
WeeklyReport buildWeeklyReport(
  List<DayStats> days,
  WeeklyGoals goals, {
  ReportCategories include = const ReportCategories(),
}) {
  double dayScore(DayStats d) =>
      dailyScore([
        if (include.prayer)
          GoalProgress('prayers', fractionOf(d.prayersCompleted, 5)),
        if (include.study)
          GoalProgress('study', fractionOf(d.studyMinutes, goals.studyMinutesPerDay)),
        if (include.fitness) GoalProgress('workout', d.workouts > 0 ? 1 : 0),
        if (include.hydration)
          GoalProgress('water', fractionOf(d.waterMl, goals.waterMlPerDay)),
      ]) ??
      0;

  DateTime? best;
  var bestScore = 0.0;
  for (final d in days) {
    final s = dayScore(d);
    if (s > bestScore) {
      bestScore = s;
      best = d.day;
    }
  }

  final bySubject = <String, int>{};
  for (final d in days) {
    d.studyBySubject.forEach((k, v) => bySubject[k] = (bySubject[k] ?? 0) + v);
  }
  final subjects = bySubject.entries.toList()
    ..sort((a, b) {
      final c = b.value.compareTo(a.value);
      return c != 0 ? c : a.key.compareTo(b.key);
    });

  final completed = days.fold<int>(0, (s, d) => s + d.prayersCompleted);
  final missed = days.fold<int>(0, (s, d) => s + d.prayersMissed);
  final studyTotal = days.fold<int>(0, (s, d) => s + d.studyMinutes);
  final workouts = days.fold<int>(0, (s, d) => s + d.workouts);
  final waterMet = days.where((d) => d.waterMl >= goals.waterMlPerDay).length;

  // One suggestion: the included category with the lowest weekly completion.
  final n = days.isEmpty ? 1 : days.length;
  final candidates = <String, double>{
    if (include.hydration) 'water': waterMet / n,
    if (include.study)
      'study': fractionOf(studyTotal, goals.studyMinutesPerDay * n),
    if (include.fitness) 'workout': fractionOf(workouts, 3),
    // Encourage recording rather than judging: low recorded share suggests
    // tracking, not that prayers were missed.
    if (include.prayer) 'prayer_tracking': fractionOf(completed + missed, 5 * n),
  };
  var suggestion = 'keep_going';
  var lowest = 1.0;
  // Iterate in a fixed order for deterministic ties.
  for (final key in const ['water', 'study', 'workout', 'prayer_tracking']) {
    final v = candidates[key];
    if (v != null && v < lowest - 1e-9) {
      lowest = v;
      suggestion = key;
    }
  }

  return WeeklyReport(
    mostConsistentDay: best,
    studyMinutesTotal: studyTotal,
    studyBySubject: subjects,
    workouts: workouts,
    prayersCompleted: completed,
    prayersRecorded: completed + missed,
    hydrationDaysMet: waterMet,
    suggestion: suggestion,
  );
}
