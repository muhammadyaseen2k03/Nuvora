import 'dart:async';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../data/database.dart';
import 'focus_timer.dart';
import 'srs.dart';

enum TopicStatus { notStarted, inProgress, completed }

class SubjectProgress {
  const SubjectProgress(this.subject, this.total, this.completed);
  final Subject subject;
  final int total;
  final int completed;
  double get fraction => total == 0 ? 0 : completed / total;
}

class StudyRepository {
  StudyRepository(this._db, {DateTime Function()? clock})
      : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _now;
  static const _uuid = Uuid();

  // --- Subjects & syllabus --------------------------------------------------

  Future<String> addSubject(String profileId, String name) async {
    final id = _uuid.v4();
    final now = _now();
    await _db.into(_db.subjects).insert(SubjectsCompanion.insert(
        id: id,
        profileId: profileId,
        name: name.trim(),
        createdAt: now,
        updatedAt: now));
    return id;
  }

  Future<void> deleteSubject(String profileId, String id) =>
      (_db.delete(_db.subjects)
            ..where((s) => s.id.equals(id) & s.profileId.equals(profileId)))
          .go();

  Stream<List<Subject>> watchSubjects(String profileId) =>
      (_db.select(_db.subjects)
            ..where((s) => s.profileId.equals(profileId))
            ..orderBy([(s) => OrderingTerm.asc(s.name)]))
          .watch();

  Stream<List<SubjectProgress>> watchSubjectProgress(String profileId) {
    final subjects = watchSubjects(profileId);
    final topics = (_db.select(_db.syllabusTopics)
          ..where((t) => t.profileId.equals(profileId)))
        .watch();
    return _combine(subjects, topics, (List<Subject> s, List<SyllabusTopic> t) {
      return [
        for (final sub in s)
          () {
            final mine = t.where((x) => x.subjectId == sub.id).toList();
            return SubjectProgress(sub, mine.length,
                mine.where((x) => x.status == 'completed').length);
          }(),
      ];
    });
  }

  Future<String> addTopic(
    String profileId,
    String subjectId,
    String title, {
    int priority = 2,
    int? estimateMinutes,
    String? description,
    DateTime? dueDate,
    String? notes,
  }) async {
    final id = _uuid.v4();
    final now = _now();
    await _db.into(_db.syllabusTopics).insert(SyllabusTopicsCompanion.insert(
          id: id,
          profileId: profileId,
          subjectId: subjectId,
          title: title.trim(),
          priority: Value(priority),
          estimateMinutes: Value(estimateMinutes),
          description: Value(description),
          dueDate: Value(dueDate),
          notes: Value(notes),
          createdAt: now,
          updatedAt: now,
        ));
    return id;
  }

  Future<void> setTopicStatus(
          String profileId, String topicId, TopicStatus status) =>
      (_db.update(_db.syllabusTopics)
            ..where((t) => t.id.equals(topicId) & t.profileId.equals(profileId)))
          .write(SyllabusTopicsCompanion(
              status: Value(status.name), updatedAt: Value(_now())));

  Future<void> deleteTopic(String profileId, String topicId) =>
      (_db.delete(_db.syllabusTopics)
            ..where((t) => t.id.equals(topicId) & t.profileId.equals(profileId)))
          .go();

  Stream<List<SyllabusTopic>> watchTopics(String profileId, String subjectId) =>
      (_db.select(_db.syllabusTopics)
            ..where((t) =>
                t.profileId.equals(profileId) & t.subjectId.equals(subjectId))
            ..orderBy([
              (t) => OrderingTerm.asc(t.priority),
              (t) => OrderingTerm.asc(t.createdAt),
            ]))
          .watch();

  // --- Exams ------------------------------------------------------------------

  Future<String> addExam(String profileId, String name, DateTime examAt,
      {String? subjectId, int priority = 2}) async {
    final id = _uuid.v4();
    final now = _now();
    await _db.into(_db.exams).insert(ExamsCompanion.insert(
          id: id,
          profileId: profileId,
          name: name.trim(),
          examAt: examAt,
          subjectId: Value(subjectId),
          priority: Value(priority),
          createdAt: now,
          updatedAt: now,
        ));
    return id;
  }

  Future<void> deleteExam(String profileId, String id) =>
      (_db.delete(_db.exams)
            ..where((e) => e.id.equals(id) & e.profileId.equals(profileId)))
          .go();

  Stream<List<Exam>> watchUpcomingExams(String profileId) =>
      (_db.select(_db.exams)
            ..where((e) =>
                e.profileId.equals(profileId) &
                e.examAt.isBiggerOrEqualValue(_now()))
            ..orderBy([(e) => OrderingTerm.asc(e.examAt)]))
          .watch();

  // --- Focus sessions ---------------------------------------------------------

  FocusTimer timerOf(StudySession s) => FocusTimer(
        kind: FocusKind.values.asNameMap()[s.kind] ?? FocusKind.focus,
        plannedSeconds: s.plannedSeconds,
        startedAt: s.startedAt,
        pausedAt: s.pausedAt,
        accumulatedPausedMs: s.accumulatedPausedMs,
        endedAt: s.endedAt,
        cancelled: s.cancelled,
      );

  /// The unfinished session, if any. Used to recover after a restart.
  Stream<StudySession?> watchActiveSession(String profileId) =>
      (_db.select(_db.studySessions)
            ..where((s) => s.profileId.equals(profileId) & s.endedAt.isNull())
            ..limit(1))
          .watchSingleOrNull();

  /// Starts a session. Any unfinished session is cancelled first so there is
  /// never more than one active session.
  Future<String> startSession(
    String profileId, {
    required FocusKind kind,
    required int plannedSeconds,
    String? subjectId,
  }) async {
    final id = _uuid.v4();
    final now = _now();
    await _db.transaction(() async {
      await (_db.update(_db.studySessions)
            ..where((s) => s.profileId.equals(profileId) & s.endedAt.isNull()))
          .write(StudySessionsCompanion(
              endedAt: Value(now),
              cancelled: const Value(true),
              updatedAt: Value(now)));
      await _db.into(_db.studySessions).insert(StudySessionsCompanion.insert(
            id: id,
            profileId: profileId,
            kind: kind.name,
            plannedSeconds: plannedSeconds,
            startedAt: now,
            subjectId: Value(subjectId),
            createdAt: now,
            updatedAt: now,
          ));
    });
    return id;
  }

  Future<void> _saveTimer(String id, FocusTimer t) =>
      (_db.update(_db.studySessions)..where((s) => s.id.equals(id))).write(
          StudySessionsCompanion(
        pausedAt: Value(t.pausedAt),
        accumulatedPausedMs: Value(t.accumulatedPausedMs),
        endedAt: Value(t.endedAt),
        cancelled: Value(t.cancelled),
        updatedAt: Value(_now()),
      ));

  Future<void> pauseSession(StudySession s) =>
      _saveTimer(s.id, timerOf(s).pause(_now()));

  Future<void> resumeSession(StudySession s) =>
      _saveTimer(s.id, timerOf(s).resume(_now()));

  Future<void> cancelSession(StudySession s) =>
      _saveTimer(s.id, timerOf(s).cancel(_now()));

  /// Finalizes a session whose time ran out. The end time is the moment the
  /// timer actually reached zero, not when the app noticed.
  Future<void> completeIfDue(StudySession s) async {
    final t = timerOf(s);
    final now = _now();
    if (t.endedAt != null || t.remaining(now) > Duration.zero) return;
    final trueEnd = t.startedAt.add(Duration(
        milliseconds: t.plannedSeconds * 1000 + t.accumulatedPausedMs));
    await _saveTimer(s.id, t.complete(trueEnd));
  }

  /// Completed (not cancelled) focus sessions that ended on [day].
  Future<List<StudySession>> completedFocusOn(
      String profileId, DateTime day) async {
    final start = DateTime(day.year, day.month, day.day);
    final end = DateTime(day.year, day.month, day.day + 1);
    return (_db.select(_db.studySessions)
          ..where((s) =>
              s.profileId.equals(profileId) &
              s.kind.equals(FocusKind.focus.name) &
              s.cancelled.equals(false) &
              s.endedAt.isBiggerOrEqualValue(start) &
              s.endedAt.isSmallerThanValue(end)))
        .get();
  }

  Stream<List<StudySession>> watchFinishedFocus(
      String profileId, DateTime from) =>
      (_db.select(_db.studySessions)
            ..where((s) =>
                s.profileId.equals(profileId) &
                s.kind.equals(FocusKind.focus.name) &
                s.endedAt.isNotNull() &
                s.startedAt.isBiggerOrEqualValue(from)))
          .watch();

  // --- Flashcards ---------------------------------------------------------------

  Future<String> addCard(String profileId, String front, String back,
      {String? subjectId, String? tags}) async {
    final id = _uuid.v4();
    final now = _now();
    final init = CardSchedule.initial(now);
    await _db.into(_db.flashcards).insert(FlashcardsCompanion.insert(
          id: id,
          profileId: profileId,
          front: front.trim(),
          back: back.trim(),
          subjectId: Value(subjectId),
          tags: Value(tags),
          ease: Value(init.ease),
          intervalDays: Value(init.intervalDays),
          repetitions: Value(init.repetitions),
          dueAt: init.due,
          createdAt: now,
          updatedAt: now,
        ));
    return id;
  }

  Future<void> updateCard(String profileId, String id,
          {String? front, String? back, String? tags}) =>
      (_db.update(_db.flashcards)
            ..where((c) => c.id.equals(id) & c.profileId.equals(profileId)))
          .write(FlashcardsCompanion(
        front: Value.absentIfNull(front?.trim()),
        back: Value.absentIfNull(back?.trim()),
        tags: Value.absentIfNull(tags),
        updatedAt: Value(_now()),
      ));

  Future<void> setArchived(String profileId, String id, bool archived) =>
      (_db.update(_db.flashcards)
            ..where((c) => c.id.equals(id) & c.profileId.equals(profileId)))
          .write(FlashcardsCompanion(
              archived: Value(archived), updatedAt: Value(_now())));

  Future<void> deleteCard(String profileId, String id) =>
      (_db.delete(_db.flashcards)
            ..where((c) => c.id.equals(id) & c.profileId.equals(profileId)))
          .go();

  Stream<List<Flashcard>> watchCards(String profileId,
          {bool archived = false}) =>
      (_db.select(_db.flashcards)
            ..where((c) =>
                c.profileId.equals(profileId) & c.archived.equals(archived))
            ..orderBy([(c) => OrderingTerm.asc(c.dueAt)]))
          .watch();

  /// Unarchived cards due now, oldest due first.
  Future<List<Flashcard>> dueCards(String profileId, {int limit = 50}) =>
      (_db.select(_db.flashcards)
            ..where((c) =>
                c.profileId.equals(profileId) &
                c.archived.equals(false) &
                c.dueAt.isSmallerOrEqualValue(_now()))
            ..orderBy([(c) => OrderingTerm.asc(c.dueAt)])
            ..limit(limit))
          .get();

  /// Applies [rating], updates the card's schedule and stores the review in
  /// one transaction so history and schedule can never disagree.
  Future<CardSchedule> reviewCard(
      String profileId, Flashcard card, Rating rating) async {
    final now = _now();
    final next = Srs.review(
      CardSchedule(
          ease: card.ease,
          intervalDays: card.intervalDays,
          repetitions: card.repetitions,
          due: card.dueAt),
      rating,
      now,
    );
    await _db.transaction(() async {
      await (_db.update(_db.flashcards)
            ..where((c) => c.id.equals(card.id) & c.profileId.equals(profileId)))
          .write(FlashcardsCompanion(
        ease: Value(next.ease),
        intervalDays: Value(next.intervalDays),
        repetitions: Value(next.repetitions),
        dueAt: Value(next.due),
        updatedAt: Value(now),
      ));
      await _db.into(_db.flashcardReviews).insert(FlashcardReviewsCompanion.insert(
            id: _uuid.v4(),
            profileId: profileId,
            cardId: card.id,
            rating: rating.name,
            reviewedAt: now,
            intervalAfterDays: next.intervalDays,
            easeAfter: next.ease,
          ));
    });
    return next;
  }

  Stream<List<FlashcardReview>> watchReviewsSince(
          String profileId, DateTime from) =>
      (_db.select(_db.flashcardReviews)
            ..where((r) =>
                r.profileId.equals(profileId) &
                r.reviewedAt.isBiggerOrEqualValue(from)))
          .watch();
}

/// Minimal two-stream combiner that avoids adding rxdart for one use.
Stream<R> _combine<A, B, R>(
    Stream<A> a, Stream<B> b, R Function(A, B) f) async* {
  A? la;
  B? lb;
  var hasA = false, hasB = false;
  final controller = StreamController<R>();
  void emit() {
    if (hasA && hasB) controller.add(f(la as A, lb as B));
  }

  final sa = a.listen((v) {
    la = v;
    hasA = true;
    emit();
  }, onError: controller.addError);
  final sb = b.listen((v) {
    lb = v;
    hasB = true;
    emit();
  }, onError: controller.addError);
  controller.onCancel = () async {
    await sa.cancel();
    await sb.cancel();
  };
  yield* controller.stream;
}
