import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/data/database.dart';
import 'package:nuvora/features/auth/profile_repository.dart';
import 'package:nuvora/features/notifications/notification_service.dart';
import 'package:nuvora/features/prayer/prayer_repository.dart';
import 'package:nuvora/features/study/study_repository.dart';

class FakeScheduler implements NotificationScheduler {
  bool permission = true;
  int cancelAllCalls = 0;
  List<ScheduledReminder> scheduled = [];
  int permissionRequests = 0;

  @override
  Future<bool> hasPermission() async => permission;

  @override
  Future<bool> requestPermission() async {
    permissionRequests++;
    return permission;
  }

  @override
  Future<void> replaceAll(List<ScheduledReminder> reminders) async {
    scheduled = reminders;
  }

  @override
  Future<void> cancelAll() async {
    cancelAllCalls++;
    scheduled = [];
  }
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late AppDatabase db;
  late String a;
  late FakeScheduler scheduler;
  late NotificationService service;
  final now = DateTime(2024, 5, 10, 6, 0);

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    a = await ProfileRepository(db).createProfile(const NewProfile(displayName: 'A'));
    scheduler = FakeScheduler();
    service = NotificationService(db, scheduler, clock: () => now);
  });
  tearDown(() => db.close());

  test('defaults: nothing enabled, nothing scheduled, no permission prompt',
      () async {
    final r = await service.reschedule(a);
    expect(r.outcome, RescheduleOutcome.nothingEnabled);
    expect(scheduler.scheduled, isEmpty);
    expect(scheduler.permissionRequests, 0);
  });

  test('a denied permission schedules nothing and clears old reminders',
      () async {
    await service.update(a, study: true);
    scheduler.permission = false;
    final r = await service.reschedule(a);
    expect(r.outcome, RescheduleOutcome.permissionDenied);
    expect(scheduler.scheduled, isEmpty);
    expect(scheduler.cancelAllCalls, 1);
    expect(scheduler.permissionRequests, 0,
        reason: 'rescheduling must never prompt; only an explicit action does');
  });

  test('enabled categories are scheduled with generic, private text by default',
      () async {
    await service.update(a, study: true, reflection: true);
    final r = await service.reschedule(a);
    expect(r.outcome, RescheduleOutcome.scheduled);
    expect(scheduler.scheduled, isNotEmpty);
    for (final s in scheduler.scheduled) {
      expect(s.title, 'Nuvora');
      expect(s.body, 'You have a reminder.');
      expect(s.at.isAfter(now), isTrue);
    }
  });

  test('details are shown only when the user opts in', () async {
    await service.update(a, study: true, showDetails: true);
    await service.reschedule(a);
    expect(scheduler.scheduled.first.body, 'Time for a focus session.');
  });

  test('prayer reminders need a location and use the saved method', () async {
    await service.update(a, prayer: true);
    var r = await service.reschedule(a);
    expect(r.count, 0, reason: 'no location yet: nothing invented');

    await PrayerRepository(db).saveSettings(a,
        method: 'karachi',
        asrMethod: 'shafi',
        latitude: 24.8607,
        longitude: 67.0011,
        locationLabel: 'Karachi');
    await service.update(a, prayerMask: 0x1 | 0x10, showDetails: true);
    r = await service.reschedule(a);
    expect(r.count, greaterThan(0));
    final bodies = scheduler.scheduled.map((s) => s.body).toSet();
    expect(bodies, {"It's time for Fajr.", "It's time for Isha."});
    expect(scheduler.scheduled.every((s) => s.channel == 'prayer'), isTrue);
  });

  test('changing a setting reschedules without duplicates', () async {
    await service.update(a, study: true);
    await service.reschedule(a);
    final firstIds = scheduler.scheduled.map((s) => s.id).toList();
    await service.reschedule(a);
    expect(scheduler.scheduled.map((s) => s.id).toList(), firstIds);

    await service.update(a, study: false);
    final r = await service.reschedule(a);
    expect(r.outcome, RescheduleOutcome.nothingEnabled);
    expect(scheduler.scheduled, isEmpty);
  });

  test('quiet hours and language are applied', () async {
    await service.update(a,
        study: true,
        studyMinute: 22 * 60 + 30,
        reflection: true,
        quietStartMinute: 22 * 60,
        quietEndMinute: 7 * 60,
        showDetails: true);
    await service.reschedule(a);
    expect(scheduler.scheduled.where((s) => s.channel == 'study'), isEmpty);
    expect(scheduler.scheduled.where((s) => s.channel == 'reflection'), isNotEmpty);

    await service.reschedule(a, languageCode: 'ur');
    expect(scheduler.scheduled.first.body, contains('غور'));
  });

  test('flashcard reminders appear only when cards are due', () async {
    await service.update(a, flashcards: true);
    await service.reschedule(a);
    expect(scheduler.scheduled, isEmpty);
    await StudyRepository(db, clock: () => now).addCard(a, 'Q', 'A');
    await service.reschedule(a);
    expect(scheduler.scheduled, hasLength(1));
  });

  test('preferences are per profile and round-trip', () async {
    final b = await ProfileRepository(db).createProfile(const NewProfile(displayName: 'B'));
    await service.update(a,
        hydration: true,
        hydrationIntervalMinutes: 180,
        weeklyReport: true,
        weeklyReportDay: DateTime.friday,
        quietStartMinute: 1320,
        quietEndMinute: 420);
    final pa = await service.watchPrefs(a).first;
    final pb = await service.watchPrefs(b).first;
    expect((pa.hydration, pa.hydrationIntervalMinutes, pa.weeklyReport, pa.weeklyReportDay),
        (true, 180, true, DateTime.friday));
    expect((pa.quietStartMinute, pa.quietEndMinute), (1320, 420));
    expect(anyReminderEnabled(pb), isFalse);

    await service.update(a, clearQuietHours: true);
    expect((await service.watchPrefs(a).first).quietStartMinute, isNull);
  });
}
