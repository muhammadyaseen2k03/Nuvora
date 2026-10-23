import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/features/study/focus_timer.dart';
import 'package:nuvora/features/study/srs.dart';

void main() {
  group('Srs', () {
    final now = DateTime(2024, 5, 10, 14, 30);

    test('new card is due immediately', () {
      expect(CardSchedule.initial(now).isDue(now), isTrue);
    });

    test('good ratings grow the interval 1 -> 3 -> ease multiples', () {
      var s = CardSchedule.initial(now);
      s = Srs.review(s, Rating.good, now);
      expect((s.intervalDays, s.repetitions), (1, 1));
      expect(s.due, DateTime(2024, 5, 11));
      s = Srs.review(s, Rating.good, now);
      expect(s.intervalDays, 3);
      s = Srs.review(s, Rating.good, now);
      expect(s.intervalDays, 8); // round(3 * 2.5)
      expect(s.ease, 2.5);
    });

    test('again resets repetitions, lowers ease, never below the floor', () {
      var s = CardSchedule.initial(now);
      for (var i = 0; i < 3; i++) {
        s = Srs.review(s, Rating.good, now);
      }
      s = Srs.review(s, Rating.again, now);
      expect((s.repetitions, s.intervalDays), (0, 1));
      expect(s.ease, closeTo(2.3, 1e-9));
      for (var i = 0; i < 20; i++) {
        s = Srs.review(s, Rating.again, now);
      }
      expect(s.ease, Srs.minEase);
    });

    test('easy raises ease up to the cap and hard slows growth', () {
      var s = CardSchedule.initial(now);
      s = Srs.review(s, Rating.easy, now);
      expect(s.intervalDays, 3);
      for (var i = 0; i < 10; i++) {
        s = Srs.review(s, Rating.easy, now);
      }
      expect(s.ease, Srs.maxEase);

      final base = CardSchedule(
          ease: 2.5, intervalDays: 10, repetitions: 3, due: now);
      final hard = Srs.review(base, Rating.hard, now);
      final good = Srs.review(base, Rating.good, now);
      expect(hard.intervalDays, 12);
      expect(good.intervalDays, 25);
      expect(hard.ease, closeTo(2.35, 1e-9));
    });

    test('due date crosses month and year boundaries', () {
      final s = Srs.review(
          CardSchedule(ease: 2.5, intervalDays: 10, repetitions: 3, due: now),
          Rating.good,
          DateTime(2024, 12, 20, 23, 59));
      expect(s.due, DateTime(2025, 1, 14));
    });

    test('isDue is true from the start of the due day', () {
      final s = CardSchedule(
          ease: 2.5, intervalDays: 1, repetitions: 1, due: DateTime(2024, 5, 11));
      expect(s.isDue(DateTime(2024, 5, 10, 23, 59)), isFalse);
      expect(s.isDue(DateTime(2024, 5, 11, 0, 0)), isTrue);
    });
  });

  group('FocusTimer', () {
    final t0 = DateTime(2024, 5, 10, 9, 0);

    test('remaining time derives from timestamps', () {
      final t = FocusTimer.start(FocusKind.focus, 25 * 60, t0);
      expect(t.remaining(t0.add(const Duration(minutes: 10))),
          const Duration(minutes: 15));
      expect(t.status(t0.add(const Duration(minutes: 10))), FocusStatus.running);
    });

    test('pause stops the clock and resume continues from there', () {
      var t = FocusTimer.start(FocusKind.focus, 25 * 60, t0);
      t = t.pause(t0.add(const Duration(minutes: 5)));
      final later = t0.add(const Duration(hours: 2));
      expect(t.elapsed(later), const Duration(minutes: 5));
      expect(t.status(later), FocusStatus.paused);

      t = t.resume(t0.add(const Duration(minutes: 35))); // paused for 30 min
      expect(t.elapsed(t0.add(const Duration(minutes: 40))),
          const Duration(minutes: 10));
      expect(t.remaining(t0.add(const Duration(minutes: 40))),
          const Duration(minutes: 15));
    });

    test('recovery after restart: a rebuilt state gives the same answer', () {
      final original = FocusTimer.start(FocusKind.focus, 1500, t0)
          .pause(t0.add(const Duration(minutes: 3)))
          .resume(t0.add(const Duration(minutes: 8)));
      // Simulate persisting the fields and loading them in a new process.
      final restored = FocusTimer(
        kind: original.kind,
        plannedSeconds: original.plannedSeconds,
        startedAt: original.startedAt,
        pausedAt: original.pausedAt,
        accumulatedPausedMs: original.accumulatedPausedMs,
      );
      final now = t0.add(const Duration(minutes: 20));
      expect(restored.elapsed(now), original.elapsed(now));
      expect(restored.elapsed(now), const Duration(minutes: 15));
    });

    test('a timer that ran out while the app was closed reads as completed',
        () {
      final t = FocusTimer.start(FocusKind.focus, 1500, t0);
      final reopened = t0.add(const Duration(hours: 3));
      expect(t.status(reopened), FocusStatus.completed);
      expect(t.remaining(reopened), Duration.zero);
      // Elapsed is capped at the planned length, not "3 hours".
      expect(t.elapsed(reopened), const Duration(minutes: 25));
    });

    test('cancel records the actual time spent', () {
      var t = FocusTimer.start(FocusKind.focus, 1500, t0);
      t = t.cancel(t0.add(const Duration(minutes: 7)));
      expect(t.status(t0.add(const Duration(hours: 1))), FocusStatus.cancelled);
      expect(t.elapsed(t0.add(const Duration(hours: 1))),
          const Duration(minutes: 7));
    });

    test('pause/resume are no-ops in the wrong state', () {
      final t = FocusTimer.start(FocusKind.focus, 1500, t0);
      expect(identical(t.resume(t0), t), isTrue);
      final p = t.pause(t0.add(const Duration(minutes: 1)));
      expect(identical(p.pause(t0.add(const Duration(minutes: 2))), p), isTrue);
    });

    test('long break follows every Nth focus session', () {
      const p = PomodoroPreset.classic;
      expect(p.breakAfter(1), FocusKind.shortBreak);
      expect(p.breakAfter(3), FocusKind.shortBreak);
      expect(p.breakAfter(4), FocusKind.longBreak);
      expect(p.breakAfter(8), FocusKind.longBreak);
    });
  });
}
