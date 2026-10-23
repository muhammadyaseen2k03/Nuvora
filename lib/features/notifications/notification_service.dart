import 'dart:ui' show Locale;

import 'package:drift/drift.dart';

import '../../data/database.dart';
import '../../l10n/gen/app_localizations.dart';
import '../prayer/prayer_service.dart';
import '../study/study_repository.dart';
import 'notification_planner.dart';

/// One reminder ready to hand to the platform.
class ScheduledReminder {
  const ScheduledReminder({
    required this.id,
    required this.at,
    required this.title,
    required this.body,
    required this.channel,
  });

  final int id;
  final DateTime at;
  final String title;
  final String body;

  /// `prayer`, `study`, `health` or `reflection`.
  final String channel;
}

/// The platform side (Android local notifications). Replaceable in tests.
abstract class NotificationScheduler {
  /// Whether the user has allowed notifications. Never prompts.
  Future<bool> hasPermission();

  /// Shows the system permission prompt. Call only after explaining why.
  Future<bool> requestPermission();

  /// Cancels everything previously scheduled and schedules [reminders].
  Future<void> replaceAll(List<ScheduledReminder> reminders);

  Future<void> cancelAll();
}

enum RescheduleOutcome { scheduled, nothingEnabled, permissionDenied }

class RescheduleResult {
  const RescheduleResult(this.outcome, [this.count = 0]);
  final RescheduleOutcome outcome;
  final int count;
}

NotificationPrefs prefsFromRow(NotificationPreference r) => NotificationPrefs(
      prayer: r.prayer,
      prayerMask: r.prayerMask,
      prayerOffsetMinutes: r.prayerOffsetMinutes,
      study: r.study,
      studyMinuteOfDay: r.studyMinute,
      workout: r.workout,
      workoutMinuteOfDay: r.workoutMinute,
      hydration: r.hydration,
      hydrationIntervalMinutes: r.hydrationIntervalMinutes,
      reflection: r.reflection,
      reflectionMinuteOfDay: r.reflectionMinute,
      flashcards: r.flashcards,
      flashcardsMinuteOfDay: r.flashcardsMinute,
      weeklyReport: r.weeklyReport,
      weeklyReportDay: r.weeklyReportDay,
      quietStartMinute: r.quietStartMinute,
      quietEndMinute: r.quietEndMinute,
      showDetails: r.showDetails,
    );

bool anyReminderEnabled(NotificationPrefs p) =>
    p.prayer ||
    p.study ||
    p.workout ||
    p.hydration ||
    p.reflection ||
    p.flashcards ||
    p.weeklyReport;

/// Reads preferences and stored data, plans reminders and hands them to the
/// platform scheduler. Everything is derived from local data, so reminders
/// work offline. Call [reschedule] on launch, on resume and after any
/// relevant setting changes (preferences, prayer location or method, time
/// zone, language).
class NotificationService {
  NotificationService(this._db, this._scheduler,
      {DateTime Function()? clock})
      : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final NotificationScheduler _scheduler;
  final DateTime Function() _now;

  Stream<NotificationPrefs> watchPrefs(String profileId) =>
      (_db.select(_db.notificationPreferences)
            ..where((p) => p.profileId.equals(profileId)))
          .watchSingleOrNull()
          .map((r) => r == null ? const NotificationPrefs() : prefsFromRow(r));

  Future<void> update(
    String profileId, {
    bool? prayer,
    int? prayerMask,
    int? prayerOffsetMinutes,
    bool? study,
    int? studyMinute,
    bool? workout,
    int? workoutMinute,
    bool? hydration,
    int? hydrationIntervalMinutes,
    bool? reflection,
    int? reflectionMinute,
    bool? flashcards,
    int? flashcardsMinute,
    bool? weeklyReport,
    int? weeklyReportDay,
    bool? showDetails,
    int? quietStartMinute,
    int? quietEndMinute,
    bool clearQuietHours = false,
  }) =>
      (_db.update(_db.notificationPreferences)
            ..where((p) => p.profileId.equals(profileId)))
          .write(NotificationPreferencesCompanion(
        prayer: Value.absentIfNull(prayer),
        prayerMask: Value.absentIfNull(prayerMask),
        prayerOffsetMinutes: Value.absentIfNull(prayerOffsetMinutes),
        study: Value.absentIfNull(study),
        studyMinute: Value.absentIfNull(studyMinute),
        workout: Value.absentIfNull(workout),
        workoutMinute: Value.absentIfNull(workoutMinute),
        hydration: Value.absentIfNull(hydration),
        hydrationIntervalMinutes: Value.absentIfNull(hydrationIntervalMinutes),
        reflection: Value.absentIfNull(reflection),
        reflectionMinute: Value.absentIfNull(reflectionMinute),
        flashcards: Value.absentIfNull(flashcards),
        flashcardsMinute: Value.absentIfNull(flashcardsMinute),
        weeklyReport: Value.absentIfNull(weeklyReport),
        weeklyReportDay: Value.absentIfNull(weeklyReportDay),
        showDetails: Value.absentIfNull(showDetails),
        quietStartMinute: clearQuietHours
            ? const Value(null)
            : Value.absentIfNull(quietStartMinute),
        quietEndMinute: clearQuietHours
            ? const Value(null)
            : Value.absentIfNull(quietEndMinute),
        updatedAt: Value(_now()),
      ));

  Future<bool> hasPermission() => _scheduler.hasPermission();
  Future<bool> requestPermission() => _scheduler.requestPermission();

  Future<RescheduleResult> reschedule(String profileId,
      {String languageCode = 'en'}) async {
    final row = await (_db.select(_db.notificationPreferences)
          ..where((p) => p.profileId.equals(profileId)))
        .getSingleOrNull();
    final prefs = row == null ? const NotificationPrefs() : prefsFromRow(row);
    if (!anyReminderEnabled(prefs)) {
      await _scheduler.cancelAll();
      return const RescheduleResult(RescheduleOutcome.nothingEnabled);
    }
    if (!await _scheduler.hasPermission()) {
      await _scheduler.cancelAll();
      return const RescheduleResult(RescheduleOutcome.permissionDenied);
    }

    final prayerSettings = await (_db.select(_db.prayerSettings)
          ..where((s) => s.profileId.equals(profileId)))
        .getSingleOrNull();
    const prayerService = PrayerService();
    DayPrayerTimes? timesFor(DateTime day) {
      final s = prayerSettings;
      if (s?.latitude == null || s?.longitude == null) return null;
      return prayerService.forDay(
        PrayerConfig(
          method: s!.method,
          asrMethod: s.asrMethod,
          latitude: s.latitude!,
          longitude: s.longitude!,
        ),
        day,
      );
    }

    final dueCards = prefs.flashcards
        ? (await StudyRepository(_db, clock: _now).dueCards(profileId)).length
        : 0;

    final planned = const NotificationPlanner().plan(
      now: _now(),
      prefs: prefs,
      prayerTimesFor: timesFor,
      dueCards: dueCards,
    );

    final l = lookupAppLocalizations(Locale(languageCode));
    final reminders = [
      for (final n in planned) _toReminder(n, prefs.showDetails, l),
    ];
    await _scheduler.replaceAll(reminders);
    return RescheduleResult(RescheduleOutcome.scheduled, reminders.length);
  }

  ScheduledReminder _toReminder(
      PlannedNotification n, bool details, AppLocalizations l) {
    final channel = switch (n.kind) {
      ReminderKind.prayer => 'prayer',
      ReminderKind.study || ReminderKind.flashcards => 'study',
      ReminderKind.workout || ReminderKind.hydration => 'health',
      ReminderKind.reflection || ReminderKind.weeklyReport => 'reflection',
    };
    // Generic by default: notification text can be seen on a locked screen.
    if (!details) {
      return ScheduledReminder(
          id: n.id,
          at: n.at,
          title: l.appName,
          body: l.notifGenericBody,
          channel: channel);
    }
    final body = switch (n.kind) {
      ReminderKind.prayer => l.notifPrayerBody(_prayerName(l, n.prayer!)),
      ReminderKind.study => l.notifStudyBody,
      ReminderKind.workout => l.notifWorkoutBody,
      ReminderKind.hydration => l.notifHydrationBody,
      ReminderKind.reflection => l.notifReflectionBody,
      ReminderKind.flashcards => l.notifFlashcardsBody,
      ReminderKind.weeklyReport => l.notifWeeklyBody,
    };
    return ScheduledReminder(
        id: n.id, at: n.at, title: l.appName, body: body, channel: channel);
  }

  String _prayerName(AppLocalizations l, PrayerName p) => switch (p) {
        PrayerName.fajr => l.prayerFajr,
        PrayerName.dhuhr => l.prayerDhuhr,
        PrayerName.asr => l.prayerAsr,
        PrayerName.maghrib => l.prayerMaghrib,
        PrayerName.isha => l.prayerIsha,
      };
}
