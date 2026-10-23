import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/features/notifications/notification_planner.dart';
import 'package:nuvora/features/prayer/prayer_service.dart';

DateTime at(int day, int h, [int m = 0]) => DateTime(2024, 5, day, h, m);

DayPrayerTimes timesFor(DateTime d) => DayPrayerTimes(
      times: {
        PrayerName.fajr: DateTime(d.year, d.month, d.day, 4, 30),
        PrayerName.dhuhr: DateTime(d.year, d.month, d.day, 12, 15),
        PrayerName.asr: DateTime(d.year, d.month, d.day, 15, 45),
        PrayerName.maghrib: DateTime(d.year, d.month, d.day, 19, 10),
        PrayerName.isha: DateTime(d.year, d.month, d.day, 20, 40),
      },
      sunrise: DateTime(d.year, d.month, d.day, 6),
      nextFajr: DateTime(d.year, d.month, d.day + 1, 4, 30),
    );

List<PlannedNotification> plan(NotificationPrefs prefs,
        {DateTime? now, int dueCards = 0, bool hasPrayer = true}) =>
    const NotificationPlanner().plan(
      now: now ?? at(10, 9),
      prefs: prefs,
      prayerTimesFor: (d) => hasPrayer ? timesFor(d) : null,
      dueCards: dueCards,
    );

void main() {
  test('everything is off by default: nothing is planned', () {
    expect(plan(const NotificationPrefs()), isEmpty);
  });

  test('categories are independent', () {
    final study = plan(const NotificationPrefs(study: true));
    expect(study.map((n) => n.kind).toSet(), {ReminderKind.study});
    final both = plan(const NotificationPrefs(study: true, reflection: true));
    expect(both.map((n) => n.kind).toSet(),
        {ReminderKind.study, ReminderKind.reflection});
  });

  test('only future times are planned and the horizon is three days', () {
    final n = plan(const NotificationPrefs(study: true),
        now: at(10, 20)); // 19:00 today already passed
    expect(n.map((x) => x.at.day), [11, 12]);
    expect(n.every((x) => x.at.isAfter(at(10, 20))), isTrue);
    final all = plan(const NotificationPrefs(study: true), now: at(10, 6));
    expect(all.map((x) => x.at.day), [10, 11, 12]);
  });

  test('prayer reminders honour per-prayer choice and the offset', () {
    final n = plan(const NotificationPrefs(
        prayer: true,
        prayerMask: 0x1 | 0x4, // fajr and asr only
        prayerOffsetMinutes: 10),
        now: at(10, 0));
    final today = n.where((x) => x.at.day == 10).toList();
    expect(today.map((x) => x.prayer), [PrayerName.fajr, PrayerName.asr]);
    expect(today.first.at, at(10, 4, 20));
    expect(today.last.at, at(10, 15, 35));
  });

  test('prayer reminders need a calculated location', () {
    expect(plan(const NotificationPrefs(prayer: true), hasPrayer: false),
        isEmpty);
  });

  test('quiet hours suppress other reminders but never prayer reminders', () {
    const prefs = NotificationPrefs(
      prayer: true,
      study: true,
      studyMinuteOfDay: 22 * 60 + 30,
      reflection: true,
      reflectionMinuteOfDay: 21 * 60,
      quietStartMinute: 22 * 60,
      quietEndMinute: 7 * 60, // wraps past midnight
    );
    final n = plan(prefs, now: at(10, 0));
    expect(n.where((x) => x.kind == ReminderKind.study), isEmpty);
    expect(n.where((x) => x.kind == ReminderKind.reflection), isNotEmpty);
    // Fajr at 04:30 is inside quiet hours but is still scheduled.
    expect(
        n.where((x) => x.kind == ReminderKind.prayer && x.prayer == PrayerName.fajr),
        hasLength(3));
  });

  test('ids are unique, stable, and fit in 31 bits', () {
    const prefs = NotificationPrefs(
        prayer: true, study: true, workout: true, hydration: true,
        reflection: true, weeklyReport: true, weeklyReportDay: DateTime.saturday);
    final a = plan(prefs, now: at(10, 0));
    final b = plan(prefs, now: at(10, 0));
    expect(a.map((x) => x.id).toList(), b.map((x) => x.id).toList());
    expect(a.map((x) => x.id).toSet(), hasLength(a.length));
    expect(a.every((x) => x.id > 0 && x.id < 2147483647), isTrue);
  });

  test('re-planning later keeps ids for the same reminders (no duplicates)',
      () {
    const prefs = NotificationPrefs(study: true);
    final early = plan(prefs, now: at(10, 6));
    final later = plan(prefs, now: at(10, 8));
    expect(later.map((x) => x.id), early.map((x) => x.id));
  });

  test('hydration is capped, spaced at least an hour, and skips quiet hours',
      () {
    final n = plan(const NotificationPrefs(hydration: true, hydrationIntervalMinutes: 10),
        now: at(10, 0));
    final today = n.where((x) => x.at.day == 10).toList();
    expect(today.length, lessThanOrEqualTo(8));
    for (var i = 1; i < today.length; i++) {
      expect(today[i].at.difference(today[i - 1].at).inMinutes,
          greaterThanOrEqualTo(60));
    }
    final quiet = plan(
        const NotificationPrefs(
            hydration: true,
            hydrationIntervalMinutes: 120,
            quietStartMinute: 12 * 60,
            quietEndMinute: 15 * 60),
        now: at(10, 0));
    expect(
        quiet.where((x) => x.at.hour >= 12 && x.at.hour < 15), isEmpty);
  });

  test('flashcard reminders only when cards are due, and only today', () {
    const prefs = NotificationPrefs(flashcards: true);
    expect(plan(prefs, now: at(10, 9), dueCards: 0), isEmpty);
    final n = plan(prefs, now: at(10, 9), dueCards: 5);
    expect(n, hasLength(1));
    expect(n.single.at, at(10, 18));
  });

  test('weekly report is planned on the chosen weekday within 7 days', () {
    // 2024-05-10 is a Friday; Sunday is 12 May.
    final n = plan(const NotificationPrefs(weeklyReport: true), now: at(10, 9));
    expect(n.single.kind, ReminderKind.weeklyReport);
    expect(n.single.at, at(12, 18));
    final mon = plan(
        const NotificationPrefs(weeklyReport: true, weeklyReportDay: DateTime.thursday),
        now: at(10, 9));
    expect(mon.single.at.day, 16);
  });

  test('daily volume stays reasonable even with everything on', () {
    final n = plan(const NotificationPrefs(
        prayer: true, study: true, workout: true, hydration: true,
        reflection: true, flashcards: true, weeklyReport: true),
        now: at(10, 0), dueCards: 3);
    for (final d in [10, 11, 12]) {
      expect(n.where((x) => x.at.day == d).length,
          lessThanOrEqualTo(NotificationPlanner.maxPerDay));
    }
  });
}
