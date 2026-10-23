import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/features/home/daily_score.dart';

void main() {
  test('equal weights average the goals', () {
    final s = dailyScore(const [
      GoalProgress('prayers', 0.6),
      GoalProgress('study', 1),
      GoalProgress('workout', 0),
      GoalProgress('water', 0.4),
    ]);
    expect(s, closeTo(0.5, 1e-9));
  });

  test('progress is capped so one goal cannot hide another', () {
    final s = dailyScore(const [
      GoalProgress('study', 3.0),
      GoalProgress('water', 0),
    ]);
    expect(s, 0.5);
  });

  test('weights change the contribution; zero weight excludes a goal', () {
    final s = dailyScore(const [
      GoalProgress('prayers', 1, weight: 3),
      GoalProgress('study', 0, weight: 1),
      GoalProgress('workout', 0, weight: 0),
    ]);
    expect(s, 0.75);
  });

  test('no contributing goals gives no score', () {
    expect(dailyScore(const []), isNull);
    expect(dailyScore(const [GoalProgress('a', 1, weight: 0)]), isNull);
  });

  test('fractionOf is safe for zero goals and clamps', () {
    expect(fractionOf(10, 0), 0);
    expect(fractionOf(5, 10), 0.5);
    expect(fractionOf(30, 10), 1);
    expect(fractionOf(-1, 10), 0);
  });
}
