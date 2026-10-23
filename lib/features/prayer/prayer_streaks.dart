import 'prayer_service.dart';

/// Recorded outcome of a prayer. A prayer with no record is "not recorded"
/// and is represented by absence from the map, never by [missed].
enum PrayerStatus { onTime, late, missed }

/// Per-day records: `day (yyyy-MM-dd) -> prayer -> status`.
typedef PrayerLog = Map<String, Map<PrayerName, PrayerStatus>>;

String dayKey(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

/// How streaks are calculated
/// -------------------------
/// A day is *complete* when all five prayers are recorded as completed
/// (`onTime` or `late`; with [strict] only `onTime`). Any `missed` or
/// unrecorded prayer makes the day incomplete.
///
/// The current streak is the number of consecutive complete days ending
/// today. If today is not complete yet, the streak ends yesterday instead,
/// so an in-progress day never resets it. Unrecorded prayers are never
/// counted as missed; they just do not extend the streak.
bool isDayComplete(Map<PrayerName, PrayerStatus>? day, {bool strict = false}) {
  if (day == null) return false;
  for (final p in PrayerName.values) {
    final s = day[p];
    if (s == null || s == PrayerStatus.missed) return false;
    if (strict && s != PrayerStatus.onTime) return false;
  }
  return true;
}

int currentStreak(PrayerLog log, DateTime today, {bool strict = false}) {
  var cursor = DateTime(today.year, today.month, today.day);
  if (!isDayComplete(log[dayKey(cursor)], strict: strict)) {
    cursor = DateTime(cursor.year, cursor.month, cursor.day - 1);
  }
  var count = 0;
  while (isDayComplete(log[dayKey(cursor)], strict: strict)) {
    count++;
    cursor = DateTime(cursor.year, cursor.month, cursor.day - 1);
  }
  return count;
}

int longestStreak(PrayerLog log, {bool strict = false}) {
  final days = log.keys.where((k) => isDayComplete(log[k], strict: strict)).toList()
    ..sort();
  var best = 0;
  var run = 0;
  DateTime? prev;
  for (final k in days) {
    final d = DateTime.parse(k);
    // Calendar-day difference, safe across DST changes.
    final consecutive = prev != null &&
        DateTime(prev.year, prev.month, prev.day + 1) == d;
    run = consecutive ? run + 1 : 1;
    if (run > best) best = run;
    prev = d;
  }
  return best;
}

/// Counts of recorded outcomes over [days] ending at [end] (inclusive).
({int completed, int missed, int unrecorded}) summarize(
    PrayerLog log, DateTime end, int days) {
  var completed = 0, missed = 0, recorded = 0;
  for (var i = 0; i < days; i++) {
    final d = DateTime(end.year, end.month, end.day - i);
    final entry = log[dayKey(d)] ?? const {};
    for (final s in entry.values) {
      recorded++;
      if (s == PrayerStatus.missed) {
        missed++;
      } else {
        completed++;
      }
    }
  }
  return (
    completed: completed,
    missed: missed,
    unrecorded: days * PrayerName.values.length - recorded,
  );
}
