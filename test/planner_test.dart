import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/features/planner/planner.dart';

DateTime at(int h, [int m = 0]) => DateTime(2024, 5, 10, h, m);

void expectNoOverlap(List<PlanBlock> blocks) {
  for (var i = 1; i < blocks.length; i++) {
    expect(!blocks[i].start.isBefore(blocks[i - 1].end), isTrue,
        reason: '${blocks[i - 1].title} overlaps ${blocks[i].title}');
  }
}

void main() {
  final prayers = [
    FixedBlock('Dhuhr', at(12, 30), at(12, 50)),
    FixedBlock('Asr', at(16, 0), at(16, 20)),
  ];

  test('places tasks without overlap, respecting fixed blocks and gaps', () {
    final result = Planner.build(
      windowStart: at(8),
      windowEnd: at(20),
      fixed: prayers,
      tasks: const [
        PlanTask(id: 'exam', kind: PlanKind.study, title: 'Exam prep',
            minutes: 90, priority: 1, reason: 'exam_soon'),
        PlanTask(id: 'cards', kind: PlanKind.review, title: 'Flashcards',
            minutes: 20),
        PlanTask(id: 'read', kind: PlanKind.study, title: 'Reading',
            minutes: 60, priority: 3),
      ],
    );
    expect(result.unscheduled, isEmpty);
    expectNoOverlap(result.blocks);
    expect(result.blocks.where((b) => b.isFixed), hasLength(2));
    // Highest priority takes the earliest slot.
    final exam = result.blocks.firstWhere((b) => b.taskId == 'exam');
    expect(exam.start, at(8));
    // At least 10 minutes between every pair of consecutive blocks.
    for (var i = 1; i < result.blocks.length; i++) {
      expect(
          result.blocks[i].start.difference(result.blocks[i - 1].end).inMinutes,
          greaterThanOrEqualTo(10));
    }
  });

  test('a preferred earliest time is honoured', () {
    final result = Planner.build(
      windowStart: at(8),
      windowEnd: at(20),
      fixed: prayers,
      tasks: [
        PlanTask(id: 'gym', kind: PlanKind.workout, title: 'Workout',
            minutes: 30, earliest: at(17)),
      ],
    );
    expect(result.blocks.firstWhere((b) => !b.isFixed).start, at(17));
  });

  test('tasks that do not fit are reported, never silently dropped', () {
    final result = Planner.build(
      windowStart: at(8),
      windowEnd: at(20),
      fixed: prayers,
      tasks: const [
        PlanTask(id: 'huge', kind: PlanKind.study, title: 'Marathon',
            minutes: 11 * 60),
      ],
    );
    expect(result.blocks.where((b) => !b.isFixed), isEmpty);
    expect(result.unscheduled.single.why, 'no_room');
  });

  test('a task can be shortened to its minimum when needed', () {
    // Free time between 12:50+gap and 16:00-gap is 3h; ask for 4h, min 2h.
    final result = Planner.build(
      windowStart: at(12, 50),
      windowEnd: at(16),
      fixed: [FixedBlock('Dhuhr', at(12, 30), at(12, 50))],
      tasks: const [
        PlanTask(id: 'long', kind: PlanKind.study, title: 'Long study',
            minutes: 240, minMinutes: 120),
      ],
    );
    expect(result.unscheduled, isEmpty);
    expect(result.blocks.firstWhere((b) => !b.isFixed).minutes, 120);
  });

  test('planning for today starts after now, on a 5-minute boundary', () {
    final result = Planner.build(
      windowStart: at(6),
      windowEnd: at(20),
      fixed: const [],
      now: at(9, 12),
      tasks: const [
        PlanTask(id: 'a', kind: PlanKind.study, title: 'A', minutes: 30),
      ],
    );
    expect(result.blocks.single.start, at(9, 15));
  });

  test('pinned (user-edited) blocks are kept and never overlapped', () {
    // The user moved Reading to 09:00-10:00 and pinned it; the re-plan must
    // keep it exactly and plan around it.
    final result = Planner.build(
      windowStart: at(8),
      windowEnd: at(20),
      fixed: [...prayers, FixedBlock('Reading', at(9), at(10))],
      tasks: const [
        PlanTask(id: 'exam', kind: PlanKind.study, title: 'Exam prep',
            minutes: 90, priority: 1),
      ],
    );
    final reading = result.blocks.firstWhere((b) => b.title == 'Reading');
    expect((reading.start, reading.end), (at(9), at(10)));
    expectNoOverlap(result.blocks);
    final exam = result.blocks.firstWhere((b) => b.taskId == 'exam');
    expect(exam.start.isBefore(at(10, 10)) && exam.end.isAfter(at(8, 50)), isFalse);
  });

  test('deterministic for the same input', () {
    List<String> run() => Planner.build(
          windowStart: at(8),
          windowEnd: at(20),
          fixed: prayers,
          tasks: const [
            PlanTask(id: 'b', kind: PlanKind.study, title: 'B', minutes: 30),
            PlanTask(id: 'a', kind: PlanKind.study, title: 'A', minutes: 30),
          ],
        ).blocks.map((b) => '${b.title}@${b.start}').toList();
    expect(run(), run());
  });

  test('earliest after the window is reported', () {
    final result = Planner.build(
      windowStart: at(8),
      windowEnd: at(20),
      fixed: const [],
      tasks: [
        PlanTask(id: 'late', kind: PlanKind.other, title: 'Late',
            minutes: 10, earliest: at(21)),
      ],
    );
    expect(result.unscheduled.single.why, 'after_window');
  });
}
