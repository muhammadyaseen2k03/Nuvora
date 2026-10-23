/// Daily completion score.
///
/// The score is a weighted average of per-goal progress, where each goal's
/// progress is a fraction from 0 to 1 (capped, so over-achieving one goal
/// cannot hide another). With the default equal weights, the four goals are:
///
/// * prayers: prayers recorded as completed today / 5
/// * study: focus minutes today / daily study goal
/// * workout: 1 if a workout was completed today, else 0
/// * water: millilitres logged today / daily water goal
///
/// A goal with weight 0 is excluded. If every weight is 0 there is no score.
/// The score describes today's activity only. It is not a measure of anyone's
/// worth or devotion.
class GoalProgress {
  const GoalProgress(this.id, this.fraction, {this.weight = 1});

  final String id;

  /// Progress toward the goal, clamped to 0..1 when scoring.
  final double fraction;
  final double weight;
}

/// Returns a value from 0 to 1, or null when no goal contributes.
double? dailyScore(List<GoalProgress> goals) {
  var total = 0.0;
  var weighted = 0.0;
  for (final g in goals) {
    if (g.weight <= 0) continue;
    final f = g.fraction.isNaN ? 0.0 : g.fraction.clamp(0.0, 1.0);
    total += g.weight;
    weighted += g.weight * f;
  }
  return total == 0 ? null : weighted / total;
}

double fractionOf(num done, num goal) {
  if (goal <= 0) return 0;
  final f = done / goal;
  return f < 0 ? 0 : (f > 1 ? 1 : f.toDouble());
}
