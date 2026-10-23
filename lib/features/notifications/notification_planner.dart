import '../prayer/prayer_service.dart';

/// Kinds of reminders. Each can be switched on or off independently.
enum ReminderKind { prayer, study, workout, hydration, reflection, flashcards, weeklyReport }

class NotificationPrefs {
  const NotificationPrefs({
    this.prayer = false,
    this.prayerMask = 31,
    this.prayerOffsetMinutes = 0,
    this.study = false,
    this.studyMinuteOfDay = 19 * 60,
    this.workout = false,
    this.workoutMinuteOfDay = 17 * 60,
    this.hydration = false,
    this.hydrationIntervalMinutes = 120,
    this.reflection = false,
    this.reflectionMinuteOfDay = 21 * 60,
    this.flashcards = false,
    this.flashcardsMinuteOfDay = 18 * 60,
    this.weeklyReport = false,
    this.weeklyReportDay = DateTime.sunday,
    this.quietStartMinute,
    this.quietEndMinute,
    this.showDetails = false,
  });

  final bool prayer;

  /// Bit i set = remind for PrayerName.values[i] (fajr..isha). 31 = all five.
  final int prayerMask;

  /// Minutes before the calculated time (0 = at the time).
  final int prayerOffsetMinutes;
  final bool study;
  final int studyMinuteOfDay;
  final bool workout;
  final int workoutMinuteOfDay;
  final bool hydration;
  final int hydrationIntervalMinutes;
  final bool reflection;
  final int reflectionMinuteOfDay;
  final bool flashcards;
  final int flashcardsMinuteOfDay;
  final bool weeklyReport;

  /// `DateTime.monday` (1) to `DateTime.sunday` (7).
  final int weeklyReportDay;

  /// Quiet hours in minutes after midnight; null disables them. A window may
  /// wrap past midnight (for example 22:00 to 07:00).
  final int? quietStartMinute;
  final int? quietEndMinute;

  /// When false (the default) notification text is generic and does not name
  /// the prayer, subject or other personal detail.
  final bool showDetails;

  bool prayerEnabledFor(PrayerName p) => (prayerMask >> p.index) & 1 == 1;
}

class PlannedNotification {
  const PlannedNotification({
    required this.id,
    required this.kind,
    required this.at,
    this.prayer,
  });

  /// Stable for the same reminder on the same day, so re-planning replaces
  /// rather than duplicates.
  final int id;
  final ReminderKind kind;
  final DateTime at;
  final PrayerName? prayer;
}

/// Decides which reminders to schedule. Pure and deterministic.
///
/// * Only the next [horizonDays] days are planned (Android limits pending
///   alarms); the app re-plans on launch, resume and any settings change.
///   The weekly report looks ahead 7 days so it is never missed.
/// * Times at or before `now` are skipped.
/// * Quiet hours suppress every reminder except prayer reminders, which the
///   user chose individually and are never silently dropped.
/// * Hydration is capped at 8 per day and never closer than 60 minutes apart.
/// * Flashcard reminders are planned only for today, and only when cards
///   are due, so there are no empty "review" nags.
class NotificationPlanner {
  const NotificationPlanner();

  static const horizonDays = 3;
  static const maxPerDay = 20;

  List<PlannedNotification> plan({
    required DateTime now,
    required NotificationPrefs prefs,
    required DayPrayerTimes? Function(DateTime day) prayerTimesFor,
    required int dueCards,
  }) {
    final out = <PlannedNotification>[];
    final earliest = now.add(const Duration(seconds: 10));
    final today = DateTime(now.year, now.month, now.day);

    void add(ReminderKind kind, DateTime at, int slot, {PrayerName? prayer}) {
      if (!at.isAfter(earliest)) return;
      if (kind != ReminderKind.prayer && _isQuiet(at, prefs)) return;
      out.add(PlannedNotification(
        id: _id(kind, at, slot),
        kind: kind,
        at: at,
        prayer: prayer,
      ));
    }

    for (var d = 0; d < 7; d++) {
      final day = DateTime(today.year, today.month, today.day + d);
      final inHorizon = d < horizonDays;

      if (inHorizon) {
        if (prefs.prayer) {
          final times = prayerTimesFor(day);
          if (times != null) {
            for (final p in PrayerName.values) {
              if (!prefs.prayerEnabledFor(p)) continue;
              final at = times.times[p]!
                  .subtract(Duration(minutes: prefs.prayerOffsetMinutes));
              add(ReminderKind.prayer, at, p.index, prayer: p);
            }
          }
        }
        if (prefs.study) {
          add(ReminderKind.study, _at(day, prefs.studyMinuteOfDay), 0);
        }
        if (prefs.workout) {
          add(ReminderKind.workout, _at(day, prefs.workoutMinuteOfDay), 0);
        }
        if (prefs.reflection) {
          add(ReminderKind.reflection, _at(day, prefs.reflectionMinuteOfDay), 0);
        }
        if (prefs.flashcards && d == 0 && dueCards > 0) {
          add(ReminderKind.flashcards, _at(day, prefs.flashcardsMinuteOfDay), 0);
        }
        if (prefs.hydration) {
          final interval = prefs.hydrationIntervalMinutes < 60
              ? 60
              : prefs.hydrationIntervalMinutes;
          var slot = 0;
          // 09:00 to 21:00, at most 8 per day.
          for (var m = 9 * 60; m <= 21 * 60 && slot < 8; m += interval) {
            add(ReminderKind.hydration, _at(day, m), slot);
            slot++;
          }
        }
      }
      if (prefs.weeklyReport && day.weekday == prefs.weeklyReportDay) {
        add(ReminderKind.weeklyReport, _at(day, 18 * 60), 0);
      }
    }

    out.sort((a, b) => a.at.compareTo(b.at));
    return out;
  }

  static DateTime _at(DateTime day, int minuteOfDay) => DateTime(
      day.year, day.month, day.day, minuteOfDay ~/ 60, minuteOfDay % 60);

  static bool _isQuiet(DateTime t, NotificationPrefs p) {
    final s = p.quietStartMinute;
    final e = p.quietEndMinute;
    if (s == null || e == null || s == e) return false;
    final m = t.hour * 60 + t.minute;
    return s < e ? (m >= s && m < e) : (m >= s || m < e);
  }

  /// Stable id: kind (1-9), day number and slot packed into 31 bits.
  static int _id(ReminderKind kind, DateTime at, int slot) {
    final dayNumber =
        DateTime.utc(at.year, at.month, at.day).millisecondsSinceEpoch ~/ 86400000;
    return (kind.index + 1) * 100000000 + (dayNumber % 1000000) * 100 + slot;
  }
}
