import 'planner.dart';

class ExamInfo {
  const ExamInfo(this.name, this.daysLeft);
  final String name;
  final int daysLeft;
}

class TopicInfo {
  const TopicInfo(this.title, this.priority, {this.dueInDays});
  final String title;

  /// 1 = high, 2 = medium, 3 = low.
  final int priority;
  final int? dueInDays;
}

/// Everything the generator needs, gathered from stored data by the caller.
/// Titles for generic activities are supplied already localized.
class PlanInputs {
  const PlanInputs({
    required this.day,
    required this.now,
    required this.prayerTimes,
    required this.dueCards,
    required this.exams,
    required this.topics,
    required this.workoutMinutes,
    required this.reviewTitle,
    required this.workoutTitle,
    this.kept = const [],
    this.windowStartHour = 6,
    this.windowEndHour = 22,
    this.prayerMinutes = 20,
  });

  final DateTime day;
  final DateTime now;

  /// Localized prayer name -> calculated time. Empty when no location is set.
  final Map<String, DateTime> prayerTimes;
  final int dueCards;
  final List<ExamInfo> exams;
  final List<TopicInfo> topics;
  final int workoutMinutes;
  final String reviewTitle;
  final String workoutTitle;

  /// Existing pinned, completed or skipped activities. They are treated as
  /// fixed so a new plan is built around them.
  final List<FixedBlock> kept;
  final int windowStartHour;
  final int windowEndHour;
  final int prayerMinutes;
}

/// Builds suggestions from stored data using only local rules.
///
/// * Each exam within 14 days gets a study block (90 min when 3 days or
///   fewer remain, otherwise 60), priority 1. At most two exams.
/// * Due flashcards get a review block of 10 to 30 minutes.
/// * Up to two unfinished topics get 45-minute blocks, ordered by priority
///   then nearest due date.
/// * A workout of the user's preferred length is placed from 16:00 onward,
///   so it does not crowd the morning study time.
PlanResult generatePlan(PlanInputs i) {
  final d = i.day;
  DateTime at(int h) => DateTime(d.year, d.month, d.day, h);

  final fixed = <FixedBlock>[
    for (final e in i.prayerTimes.entries)
      FixedBlock(
          e.key, e.value, e.value.add(Duration(minutes: i.prayerMinutes))),
    ...i.kept,
  ];

  final tasks = <PlanTask>[];

  final exams = [...i.exams.where((e) => e.daysLeft >= 0 && e.daysLeft <= 14)]
    ..sort((a, b) => a.daysLeft.compareTo(b.daysLeft));
  for (final e in exams.take(2)) {
    tasks.add(PlanTask(
      id: 'exam:${e.name}',
      kind: PlanKind.study,
      title: e.name,
      minutes: e.daysLeft <= 3 ? 90 : 60,
      minMinutes: 30,
      priority: 1,
      reason: 'exam_soon',
    ));
  }

  if (i.dueCards > 0) {
    tasks.add(PlanTask(
      id: 'cards',
      kind: PlanKind.review,
      title: i.reviewTitle,
      minutes: i.dueCards.clamp(10, 30),
      minMinutes: 10,
      priority: 2,
      reason: 'cards_due',
    ));
  }

  final topics = [...i.topics]..sort((a, b) {
      final p = a.priority.compareTo(b.priority);
      if (p != 0) return p;
      return (a.dueInDays ?? 9999).compareTo(b.dueInDays ?? 9999);
    });
  for (final t in topics.take(2)) {
    tasks.add(PlanTask(
      id: 'topic:${t.title}',
      kind: PlanKind.study,
      title: t.title,
      minutes: 45,
      minMinutes: 20,
      priority: t.priority == 1 ? 2 : 3,
      reason: 'topic_pending',
    ));
  }

  if (i.workoutMinutes > 0) {
    tasks.add(PlanTask(
      id: 'workout',
      kind: PlanKind.workout,
      title: i.workoutTitle,
      minutes: i.workoutMinutes,
      minMinutes: 10,
      priority: 2,
      earliest: at(16),
      reason: 'workout_goal',
    ));
  }

  final isToday = i.now.year == d.year &&
      i.now.month == d.month &&
      i.now.day == d.day;
  return Planner.build(
    windowStart: at(i.windowStartHour),
    windowEnd: at(i.windowEndHour),
    fixed: fixed,
    tasks: tasks,
    now: isToday ? i.now : null,
  );
}
