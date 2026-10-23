import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/features/fitness/hydration.dart';
import 'package:nuvora/features/fitness/workout_library.dart';

void main() {
  group('workout library', () {
    test('every workout is well formed', () {
      expect(workouts.map((w) => w.id).toSet(), hasLength(workouts.length));
      for (final w in workouts) {
        expect(w.exercises, isNotEmpty, reason: w.name);
        for (final e in w.exercises) {
          expect(e.instructions.trim(), isNotEmpty, reason: e.name);
          expect(e.modification.trim(), isNotEmpty, reason: e.name);
          expect(e.isTimed ? e.seconds! > 0 : e.reps! > 0, isTrue);
        }
        expect(w.estimatedMinutes, inInclusiveRange(2, 30), reason: w.name);
      }
    });

    test('all categories are covered', () {
      expect(workouts.map((w) => w.category).toSet(),
          WorkoutCategory.values.toSet());
    });

    test('steps alternate work and rest with no trailing rest', () {
      final w = workoutById('full_starter')!;
      final steps = buildSteps(w);
      expect(steps, hasLength(w.exercises.length * 2 - 1));
      expect(steps.first.isRest, isFalse);
      expect(steps.last.isRest, isFalse);
      for (var i = 0; i < steps.length; i++) {
        expect(steps[i].isRest, i.isOdd);
      }
      expect(steps[1].durationSeconds, w.restSeconds);
      // Repetition based exercises have no timer.
      expect(steps[2].exercise!.name, 'Bodyweight squat');
      expect(steps[2].durationSeconds, isNull);
      // A rest step points at the exercise that follows.
      expect(steps[1].exerciseIndex, 1);
    });

    test('estimated duration counts work and rest', () {
      final w = workoutById('busy_day')!;
      // 30s + 10 reps*3 + 8 reps*3 + 20s = 104s work, 3 rests * 15s.
      expect(w.estimatedSeconds, 104 + 45);
      expect(w.estimatedMinutes, 3);
    });

    test('unknown id returns null', () {
      expect(workoutById('nope'), isNull);
    });
  });

  group('hydration', () {
    test('totals ignore invalid amounts', () {
      expect(totalMl([250, 500, -100, 0]), 750);
      expect(totalMl(const []), 0);
    });

    test('goal fraction is clamped and safe for a zero goal', () {
      expect(goalFraction(500, 2000), 0.25);
      expect(goalFraction(3000, 2000), 1);
      expect(goalFraction(100, 0), 0);
    });
  });

  group('fasting', () {
    final start = DateTime(2024, 3, 11, 4, 0);

    test('elapsed and remaining follow the clock', () {
      final f = Fast(startedAt: start, plannedSeconds: 14 * 3600);
      final now = start.add(const Duration(hours: 5));
      expect(f.elapsed(now), const Duration(hours: 5));
      expect(f.remaining(now), const Duration(hours: 9));
      expect(f.reachedGoal(now), isFalse);
    });

    test('remaining is zero once the plan is reached', () {
      final f = Fast(startedAt: start, plannedSeconds: 3600);
      final now = start.add(const Duration(hours: 2));
      expect(f.remaining(now), Duration.zero);
      expect(f.reachedGoal(now), isTrue);
    });

    test('an open-ended fast has no remaining time', () {
      final f = Fast(startedAt: start);
      expect(f.remaining(start.add(const Duration(hours: 1))), isNull);
      expect(f.reachedGoal(start.add(const Duration(days: 1))), isFalse);
    });

    test('a finished fast stops counting', () {
      final f = Fast(
          startedAt: start, endedAt: start.add(const Duration(hours: 10)));
      expect(f.isActive, isFalse);
      expect(f.elapsed(start.add(const Duration(days: 3))),
          const Duration(hours: 10));
    });

    test('elapsed across a daylight-saving jump uses real elapsed time', () {
      // Durations come from instants, so a clock change cannot add or
      // remove time. Built with UTC instants to be independent of the
      // machine's time zone.
      final s = DateTime.utc(2024, 3, 10, 5, 0);
      final f = Fast(startedAt: s);
      expect(f.elapsed(DateTime.utc(2024, 3, 10, 17, 0)),
          const Duration(hours: 12));
    });
  });
}
