import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/data/database.dart';
import 'package:nuvora/features/auth/profile_repository.dart';
import 'package:nuvora/features/study/focus_timer.dart';
import 'package:nuvora/features/study/srs.dart';
import 'package:nuvora/features/study/study_repository.dart';

void main() {
  late AppDatabase db;
  late String a;
  late String b;
  var clock = DateTime(2024, 5, 10, 9, 0);
  late StudyRepository repo;

  setUp(() async {
    clock = DateTime(2024, 5, 10, 9, 0);
    db = AppDatabase(NativeDatabase.memory());
    repo = StudyRepository(db, clock: () => clock);
    final profiles = ProfileRepository(db);
    a = await profiles.createProfile(const NewProfile(displayName: 'A'));
    b = await profiles.createProfile(const NewProfile(displayName: 'B'));
  });
  tearDown(() => db.close());

  test('subject progress reflects saved topic statuses', () async {
    final math = await repo.addSubject(a, 'Math');
    final t1 = await repo.addTopic(a, math, 'Limits');
    await repo.addTopic(a, math, 'Derivatives', priority: 1);
    await repo.addSubject(a, 'Physics');
    await repo.setTopicStatus(a, t1, TopicStatus.completed);

    final progress = await repo.watchSubjectProgress(a).first;
    final m = progress.firstWhere((p) => p.subject.name == 'Math');
    expect((m.total, m.completed, m.fraction), (2, 1, 0.5));
    expect(progress.firstWhere((p) => p.subject.name == 'Physics').fraction, 0);

    final topics = await repo.watchTopics(a, math).first;
    expect(topics.first.title, 'Derivatives'); // higher priority first
  });

  test('data is isolated between profiles and cascades on subject delete',
      () async {
    final s = await repo.addSubject(a, 'Math');
    await repo.addTopic(a, s, 'T');
    expect(await repo.watchSubjects(b).first, isEmpty);
    // Wrong profile cannot delete it.
    await repo.deleteSubject(b, s);
    expect(await repo.watchSubjects(a).first, hasLength(1));
    await repo.deleteSubject(a, s);
    expect(await db.select(db.syllabusTopics).get(), isEmpty);
  });

  test('focus session: recover, pause, and complete at the true end time',
      () async {
    final id = await repo.startSession(a,
        kind: FocusKind.focus, plannedSeconds: 1500);
    var s = (await repo.watchActiveSession(a).first)!;
    expect(s.id, id);

    clock = clock.add(const Duration(minutes: 5));
    await repo.pauseSession(s);
    s = (await repo.watchActiveSession(a).first)!;
    clock = clock.add(const Duration(minutes: 10)); // paused 10 minutes
    await repo.resumeSession(s);
    s = (await repo.watchActiveSession(a).first)!;
    expect(s.accumulatedPausedMs, const Duration(minutes: 10).inMilliseconds);

    // App was closed; reopened long after the session should have ended.
    clock = DateTime(2024, 5, 10, 12, 0);
    await repo.completeIfDue(s);
    expect(await repo.watchActiveSession(a).first, isNull);
    final done = await repo.completedFocusOn(a, DateTime(2024, 5, 10));
    expect(done, hasLength(1));
    // 09:00 + 25 min focus + 10 min paused = 09:35, not 12:00.
    expect(done.single.endedAt, DateTime(2024, 5, 10, 9, 35));
  });

  test('starting a session cancels any unfinished one', () async {
    await repo.startSession(a, kind: FocusKind.focus, plannedSeconds: 1500);
    await repo.startSession(a, kind: FocusKind.shortBreak, plannedSeconds: 300);
    final all = await db.select(db.studySessions).get();
    expect(all.where((s) => s.endedAt == null), hasLength(1));
    expect(all.where((s) => s.cancelled), hasLength(1));
    expect(await repo.completedFocusOn(a, clock), isEmpty);
  });

  test('flashcard review updates schedule and stores history atomically',
      () async {
    final id = await repo.addCard(a, 'Q?', 'A.');
    var due = await repo.dueCards(a);
    expect(due.map((c) => c.id), [id]);

    final next = await repo.reviewCard(a, due.single, Rating.good);
    expect(next.intervalDays, 1);
    expect(await repo.dueCards(a), isEmpty);

    final card = (await repo.watchCards(a).first).single;
    expect((card.intervalDays, card.repetitions), (1, 1));
    expect(card.dueAt, DateTime(2024, 5, 11));

    final reviews = await repo.watchReviewsSince(a, DateTime(2024, 1, 1)).first;
    expect(reviews.single.rating, 'good');
    expect(reviews.single.intervalAfterDays, 1);

    // Next day it is due again; archived cards never are.
    clock = DateTime(2024, 5, 11, 8, 0);
    expect(await repo.dueCards(a), hasLength(1));
    await repo.setArchived(a, id, true);
    expect(await repo.dueCards(a), isEmpty);
  });

  test('cards and reviews are isolated per profile', () async {
    await repo.addCard(a, 'Q', 'A');
    expect(await repo.dueCards(b), isEmpty);
    final card = (await repo.dueCards(a)).single;
    await repo.deleteCard(b, card.id);
    expect(await repo.dueCards(a), hasLength(1));
  });

  test('upcoming exams exclude past ones and are sorted', () async {
    await repo.addExam(a, 'Past', DateTime(2024, 5, 1));
    await repo.addExam(a, 'Later', DateTime(2024, 6, 1));
    await repo.addExam(a, 'Soon', DateTime(2024, 5, 12));
    final exams = await repo.watchUpcomingExams(a).first;
    expect(exams.map((e) => e.name), ['Soon', 'Later']);
  });
}
