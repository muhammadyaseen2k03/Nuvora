/// Spaced-repetition scheduling (SM-2 variant).
///
/// Each card keeps an ease factor, a repetition count and an interval in
/// whole days. After a review the self-assessed [Rating] updates them:
///
/// | rating | repetitions | next interval                          | ease    |
/// |--------|-------------|----------------------------------------|---------|
/// | again  | reset to 0  | 1 day                                  | -0.20   |
/// | hard   | +1          | max(1, round(previous * 1.2))          | -0.15   |
/// | good   | +1          | 1st: 1 day, 2nd: 3 days, then prev*ease | 0       |
/// | easy   | +1          | 1st: 3 days, then prev*ease*1.3        | +0.15   |
///
/// Ease is clamped to [minEase, 3.0]. The due date is the review's calendar
/// day plus the interval, so cards are due at the start of that local day.
enum Rating { again, hard, good, easy }

class CardSchedule {
  const CardSchedule({
    required this.ease,
    required this.intervalDays,
    required this.repetitions,
    required this.due,
  });

  /// A card that has never been reviewed; due immediately.
  factory CardSchedule.initial(DateTime now) => CardSchedule(
        ease: Srs.startEase,
        intervalDays: 0,
        repetitions: 0,
        due: DateTime(now.year, now.month, now.day),
      );

  final double ease;
  final int intervalDays;
  final int repetitions;
  final DateTime due;

  bool isDue(DateTime now) => !due.isAfter(now);
}

class Srs {
  static const startEase = 2.5;
  static const minEase = 1.3;
  static const maxEase = 3.0;

  static CardSchedule review(CardSchedule s, Rating rating, DateTime now) {
    var ease = s.ease;
    int interval;
    int reps;
    switch (rating) {
      case Rating.again:
        ease -= 0.20;
        reps = 0;
        interval = 1;
      case Rating.hard:
        ease -= 0.15;
        reps = s.repetitions + 1;
        interval = _atLeast1((s.intervalDays * 1.2).round());
      case Rating.good:
        reps = s.repetitions + 1;
        interval = switch (s.repetitions) {
          0 => 1,
          1 => 3,
          _ => _atLeast1((s.intervalDays * ease).round()),
        };
      case Rating.easy:
        ease += 0.15;
        reps = s.repetitions + 1;
        interval = s.repetitions == 0
            ? 3
            : _atLeast1((s.intervalDays * ease * 1.3).round());
    }
    ease = ease.clamp(minEase, maxEase).toDouble();
    return CardSchedule(
      ease: ease,
      intervalDays: interval,
      repetitions: reps,
      due: DateTime(now.year, now.month, now.day + interval),
    );
  }

  static int _atLeast1(int v) => v < 1 ? 1 : v;
}
