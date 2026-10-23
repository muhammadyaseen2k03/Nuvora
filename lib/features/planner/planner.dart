/// Offline rule-based daily planner.
///
/// Inputs are the day's availability window, fixed blocks (prayer times,
/// commitments, and any block the user has pinned or edited) and a list of
/// tasks to place. The planner never moves or removes fixed blocks, so a
/// re-plan cannot discard the user's own changes.
///
/// Rules
/// -----
/// 1. Free time is the window minus every fixed block, each widened by
///    [gapMinutes] on both sides so there is always a transition period.
/// 2. Tasks are placed by priority (1 = most urgent), then longer first, then
///    id, into the earliest free interval that can hold them at or after the
///    task's `earliest` time (and after `now` when planning today).
/// 3. After each placed task, [gapMinutes] of free time is reserved.
/// 4. A task that does not fit is reported in `unscheduled` with a reason;
///    if it declares `minMinutes`, it is first retried at that shorter length.
///
/// The result is deterministic for the same inputs and has no overlaps.
enum PlanKind { study, review, workout, other }

class PlanTask {
  const PlanTask({
    required this.id,
    required this.kind,
    required this.title,
    required this.minutes,
    this.priority = 2,
    this.minMinutes,
    this.earliest,
    this.reason,
  });

  final String id;
  final PlanKind kind;
  final String title;
  final int minutes;

  /// 1 = urgent, 2 = normal, 3 = if time allows.
  final int priority;

  /// Shortest useful length, if the task may be shortened to fit.
  final int? minMinutes;

  /// Do not start before this time (for example, a preferred workout time).
  final DateTime? earliest;

  /// A short code the UI turns into an explanation ("exam_soon", ...).
  final String? reason;
}

class FixedBlock {
  const FixedBlock(this.label, this.start, this.end);
  final String label;
  final DateTime start;
  final DateTime end;
}

class PlanBlock {
  const PlanBlock({
    required this.title,
    required this.start,
    required this.end,
    required this.isFixed,
    this.taskId,
    this.kind,
    this.reason,
  });

  final String title;
  final DateTime start;
  final DateTime end;
  final bool isFixed;
  final String? taskId;
  final PlanKind? kind;
  final String? reason;

  int get minutes => end.difference(start).inMinutes;
}

class Unscheduled {
  const Unscheduled(this.task, this.why);
  final PlanTask task;

  /// `no_room` when nothing fits, `after_window` when `earliest` is past the
  /// end of the window.
  final String why;
}

class PlanResult {
  const PlanResult(this.blocks, this.unscheduled);
  final List<PlanBlock> blocks;
  final List<Unscheduled> unscheduled;
}

class _Interval {
  _Interval(this.start, this.end);
  DateTime start;
  DateTime end;
}

class Planner {
  const Planner();

  static PlanResult build({
    required DateTime windowStart,
    required DateTime windowEnd,
    required List<FixedBlock> fixed,
    required List<PlanTask> tasks,
    int gapMinutes = 10,
    DateTime? now,
  }) {
    final gap = Duration(minutes: gapMinutes);
    var start = windowStart;
    if (now != null && now.isAfter(start)) start = _ceilTo5(now);

    // Free intervals = window minus widened fixed blocks.
    var free = <_Interval>[_Interval(start, windowEnd)];
    final sortedFixed = [...fixed]..sort((a, b) => a.start.compareTo(b.start));
    for (final f in sortedFixed) {
      free = _subtract(free, f.start.subtract(gap), f.end.add(gap));
    }
    free.removeWhere((i) => !i.end.isAfter(i.start));

    final ordered = [...tasks]..sort((a, b) {
        final p = a.priority.compareTo(b.priority);
        if (p != 0) return p;
        final m = b.minutes.compareTo(a.minutes);
        return m != 0 ? m : a.id.compareTo(b.id);
      });

    final placed = <PlanBlock>[];
    final unscheduled = <Unscheduled>[];

    for (final task in ordered) {
      if (task.earliest != null && !task.earliest!.isBefore(windowEnd)) {
        unscheduled.add(Unscheduled(task, 'after_window'));
        continue;
      }
      final lengths = <int>[task.minutes];
      if (task.minMinutes != null && task.minMinutes! < task.minutes) {
        lengths.add(task.minMinutes!);
      }
      PlanBlock? block;
      for (final len in lengths) {
        final dur = Duration(minutes: len);
        for (final slot in free) {
          var s = slot.start;
          if (task.earliest != null && task.earliest!.isAfter(s)) {
            s = task.earliest!;
          }
          if (!s.add(dur).isAfter(slot.end)) {
            block = PlanBlock(
              title: task.title,
              start: s,
              end: s.add(dur),
              isFixed: false,
              taskId: task.id,
              kind: task.kind,
              reason: task.reason,
            );
            break;
          }
        }
        if (block != null) break;
      }
      if (block == null) {
        unscheduled.add(Unscheduled(task, 'no_room'));
        continue;
      }
      placed.add(block);
      free = _subtract(free, block.start, block.end.add(gap));
      free.removeWhere((i) => !i.end.isAfter(i.start));
    }

    final blocks = <PlanBlock>[
      for (final f in sortedFixed)
        PlanBlock(title: f.label, start: f.start, end: f.end, isFixed: true),
      ...placed,
    ]..sort((a, b) => a.start.compareTo(b.start));
    return PlanResult(blocks, unscheduled);
  }

  static DateTime _ceilTo5(DateTime t) {
    final extra = (5 - t.minute % 5) % 5;
    final base = DateTime(t.year, t.month, t.day, t.hour, t.minute);
    return base.add(Duration(minutes: extra));
  }

  /// Removes [from, to) from every interval.
  static List<_Interval> _subtract(
      List<_Interval> intervals, DateTime from, DateTime to) {
    final out = <_Interval>[];
    for (final i in intervals) {
      if (!to.isAfter(i.start) || !from.isBefore(i.end)) {
        out.add(i);
        continue;
      }
      if (from.isAfter(i.start)) out.add(_Interval(i.start, from));
      if (to.isBefore(i.end)) out.add(_Interval(to, i.end));
    }
    return out;
  }
}
