/// Timestamp-based focus timer state.
///
/// Nothing here depends on a running countdown. All values derive from
/// persisted timestamps, so after the app is backgrounded, killed or the
/// device restarts, the same state yields the correct remaining time.
enum FocusKind { focus, shortBreak, longBreak }

enum FocusStatus { running, paused, completed, cancelled }

class FocusTimer {
  const FocusTimer({
    required this.kind,
    required this.plannedSeconds,
    required this.startedAt,
    this.pausedAt,
    this.accumulatedPausedMs = 0,
    this.endedAt,
    this.cancelled = false,
  });

  factory FocusTimer.start(FocusKind kind, int plannedSeconds, DateTime now) =>
      FocusTimer(kind: kind, plannedSeconds: plannedSeconds, startedAt: now);

  final FocusKind kind;
  final int plannedSeconds;
  final DateTime startedAt;

  /// Set while paused.
  final DateTime? pausedAt;

  /// Total time spent paused in earlier pauses.
  final int accumulatedPausedMs;

  /// Set once the session is finished or cancelled.
  final DateTime? endedAt;
  final bool cancelled;

  /// Time actually spent in the session as of [now], excluding pauses.
  Duration elapsed(DateTime now) {
    final end = endedAt ?? pausedAt ?? now;
    final ms = end.difference(startedAt).inMilliseconds - accumulatedPausedMs;
    final clamped = ms < 0 ? 0 : ms;
    final planned = plannedSeconds * 1000;
    return Duration(milliseconds: clamped > planned ? planned : clamped);
  }

  Duration remaining(DateTime now) =>
      Duration(seconds: plannedSeconds) - elapsed(now);

  FocusStatus status(DateTime now) {
    if (cancelled) return FocusStatus.cancelled;
    if (endedAt != null) return FocusStatus.completed;
    if (remaining(now) <= Duration.zero) return FocusStatus.completed;
    return pausedAt != null ? FocusStatus.paused : FocusStatus.running;
  }

  FocusTimer pause(DateTime now) {
    if (pausedAt != null || endedAt != null) return this;
    return _copy(pausedAt: now);
  }

  FocusTimer resume(DateTime now) {
    final p = pausedAt;
    if (p == null || endedAt != null) return this;
    return FocusTimer(
      kind: kind,
      plannedSeconds: plannedSeconds,
      startedAt: startedAt,
      accumulatedPausedMs:
          accumulatedPausedMs + now.difference(p).inMilliseconds,
      endedAt: endedAt,
    );
  }

  FocusTimer cancel(DateTime now) {
    if (endedAt != null) return this;
    return _copy(endedAt: pausedAt ?? now, cancelled: true);
  }

  /// Marks a timer that has run out as completed at its true end time, so
  /// the recorded duration is the planned length rather than "when the user
  /// reopened the app".
  FocusTimer complete(DateTime now) {
    if (endedAt != null) return this;
    return _copy(endedAt: now);
  }

  FocusTimer _copy({DateTime? pausedAt, DateTime? endedAt, bool? cancelled}) =>
      FocusTimer(
        kind: kind,
        plannedSeconds: plannedSeconds,
        startedAt: startedAt,
        pausedAt: pausedAt ?? this.pausedAt,
        accumulatedPausedMs: accumulatedPausedMs,
        endedAt: endedAt ?? this.endedAt,
        cancelled: cancelled ?? this.cancelled,
      );
}

/// Pomodoro presets: focus / short break / long break (minutes), with a long
/// break after every [longBreakEvery] focus sessions.
class PomodoroPreset {
  const PomodoroPreset(this.focusMin, this.shortBreakMin, this.longBreakMin,
      {this.longBreakEvery = 4});
  final int focusMin;
  final int shortBreakMin;
  final int longBreakMin;
  final int longBreakEvery;

  static const classic = PomodoroPreset(25, 5, 15);
  static const deep = PomodoroPreset(50, 10, 20, longBreakEvery: 3);
  static const short = PomodoroPreset(15, 3, 10);
  static const all = [classic, deep, short];

  /// Which break follows the [completedFocusSessions]-th completed focus.
  FocusKind breakAfter(int completedFocusSessions) =>
      completedFocusSessions > 0 &&
              completedFocusSessions % longBreakEvery == 0
          ? FocusKind.longBreak
          : FocusKind.shortBreak;
}
