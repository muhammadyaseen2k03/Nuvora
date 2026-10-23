// Hydration and fasting helpers (pure functions, easy to test).

/// Sum of [amountsMl], ignoring non-positive values.
int totalMl(Iterable<int> amountsMl) =>
    amountsMl.where((a) => a > 0).fold(0, (a, b) => a + b);

/// Progress toward a goal, clamped to 0..1. A goal of zero or less yields 0.
double goalFraction(int totalMl, int goalMl) {
  if (goalMl <= 0) return 0;
  final f = totalMl / goalMl;
  return f < 0 ? 0 : (f > 1 ? 1 : f);
}

/// A fast. [plannedSeconds] is optional; a fast with no plan only counts up.
class Fast {
  const Fast({required this.startedAt, this.plannedSeconds, this.endedAt});

  final DateTime startedAt;
  final int? plannedSeconds;
  final DateTime? endedAt;

  bool get isActive => endedAt == null;

  Duration elapsed(DateTime now) {
    final end = endedAt ?? now;
    final d = end.difference(startedAt);
    return d.isNegative ? Duration.zero : d;
  }

  /// Time left in the plan, or null when there is no plan. Zero once the
  /// planned length has been reached.
  Duration? remaining(DateTime now) {
    final p = plannedSeconds;
    if (p == null) return null;
    final left = Duration(seconds: p) - elapsed(now);
    return left.isNegative ? Duration.zero : left;
  }

  bool reachedGoal(DateTime now) =>
      plannedSeconds != null && elapsed(now).inSeconds >= plannedSeconds!;
}
