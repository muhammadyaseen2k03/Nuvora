import '../home/daily_score.dart';

/// Calendar status for one day.
///
/// * [unrecorded]: nothing was recorded at all. Not the same as missed.
/// * [missed]: the user explicitly recorded misses and nothing completed.
/// * [partial]: something was completed, but not every tracked goal.
/// * [complete]: every tracked goal reached its target.
enum DayStatus { unrecorded, missed, partial, complete }

DayStatus classifyDay({
  required List<GoalProgress> goals,
  required bool anyRecord,
  required bool explicitMissOnly,
}) {
  if (!anyRecord) return DayStatus.unrecorded;
  final score = dailyScore(goals);
  if (score == null) return DayStatus.unrecorded;
  if (score >= 1 - 1e-9) return DayStatus.complete;
  if (score > 0) return DayStatus.partial;
  // Nothing completed: only an explicit "missed" record counts as missed.
  return explicitMissOnly ? DayStatus.missed : DayStatus.unrecorded;
}
