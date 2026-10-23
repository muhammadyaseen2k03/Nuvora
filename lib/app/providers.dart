import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/database.dart';
import '../features/auth/profile_repository.dart';
import '../features/ai/ai_client.dart';
import '../features/ai/ai_service.dart';
import '../features/auth/cloud_auth.dart';
import '../features/auth/secure_session_store.dart';
import '../features/backup/backup_service.dart';
import '../features/fitness/fitness_repository.dart';
import '../features/habits/journal_repository.dart';
import '../features/insights/history_repository.dart';
import '../features/notifications/local_notifications_scheduler.dart';
import '../features/notifications/notification_planner.dart';
import '../features/notifications/notification_service.dart';
import '../features/planner/planner_repository.dart';
import '../features/sync/cloud_account.dart';
import '../features/sync/cloud_config.dart';
import '../features/sync/remote.dart';
import '../features/sync/supabase_remote.dart';
import '../features/sync/sync_engine.dart';
import '../features/sync/sync_settings_repository.dart';
import '../features/prayer/prayer_repository.dart';
import '../features/prayer/prayer_streaks.dart';
import '../features/study/study_repository.dart';

final sharedPrefsProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase.persistent();
  ref.onDispose(db.close);
  return db;
});

final profileRepositoryProvider =
    Provider((ref) => ProfileRepository(ref.watch(databaseProvider)));

const _activeProfileKey = 'active_profile_id';

/// The profile whose data the UI may show. Null means onboarding is required.
class ActiveProfileId extends Notifier<String?> {
  @override
  String? build() => ref.watch(sharedPrefsProvider).getString(_activeProfileKey);

  Future<void> set(String? id) async {
    final prefs = ref.read(sharedPrefsProvider);
    if (id == null) {
      await prefs.remove(_activeProfileKey);
    } else {
      await prefs.setString(_activeProfileKey, id);
    }
    state = id;
  }
}

final activeProfileIdProvider =
    NotifierProvider<ActiveProfileId, String?>(ActiveProfileId.new);

final profilesProvider =
    StreamProvider((ref) => ref.watch(profileRepositoryProvider).watchProfiles());

final activeProfileProvider = FutureProvider<Profile?>((ref) async {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return null;
  // Re-read when the profile list changes (rename/delete).
  ref.watch(profilesProvider);
  return ref.watch(profileRepositoryProvider).getProfile(id);
});

final preferencesProvider = StreamProvider<UserPreference?>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(null);
  return ref.watch(profileRepositoryProvider).watchPreferences(id);
});

final themeModeProvider = Provider<ThemeMode>((ref) {
  switch (ref.watch(preferencesProvider).value?.themeMode) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
});

final localeProvider = Provider<Locale?>((ref) {
  final code = ref.watch(preferencesProvider).value?.languageCode;
  return code == null ? null : Locale(code);
});

// --- Prayer ---------------------------------------------------------------

final prayerRepositoryProvider =
    Provider((ref) => PrayerRepository(ref.watch(databaseProvider)));

final prayerSettingsProvider = StreamProvider<PrayerSetting?>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(null);
  return ref.watch(prayerRepositoryProvider).watchSettings(id);
});

// --- Planning, habits and progress -----------------------------------------

final journalRepositoryProvider =
    Provider((ref) => JournalRepository(ref.watch(databaseProvider)));
final plannerRepositoryProvider =
    Provider((ref) => PlannerRepository(ref.watch(databaseProvider)));
final historyRepositoryProvider =
    Provider((ref) => HistoryRepository(ref.watch(databaseProvider)));

/// Records for a date range, recomputed whenever any table changes.
Stream<List<DayRecord>> _watchRecords(
    Ref ref, DateTime Function() from, DateTime Function() to) async* {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) {
    yield const [];
    return;
  }
  final db = ref.watch(databaseProvider);
  final repo = ref.watch(historyRepositoryProvider);
  yield await repo.load(id, from(), to());
  await for (final _ in db.tableUpdates()) {
    yield await repo.load(id, from(), to());
  }
}

/// The last 60 days, used by the weekly report and achievements.
final historyProvider = StreamProvider.autoDispose<List<DayRecord>>((ref) {
  final n = DateTime.now();
  return _watchRecords(ref, () => DateTime(n.year, n.month, n.day - 60),
      () => DateTime(n.year, n.month, n.day));
});

/// All days of the month containing the given date.
final monthRecordsProvider =
    StreamProvider.autoDispose.family<List<DayRecord>, DateTime>((ref, month) {
  return _watchRecords(ref, () => DateTime(month.year, month.month, 1),
      () => DateTime(month.year, month.month + 1, 0));
});

final todayPlanProvider = StreamProvider.autoDispose<List<PlannedActivity>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const []);
  return ref
      .watch(plannerRepositoryProvider)
      .watchDay(id, DateTime.now());
});

final journalEntriesProvider = StreamProvider.autoDispose
    .family<List<JournalEntry>, String>((ref, query) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const []);
  return ref.watch(journalRepositoryProvider).watch(id, query: query);
});

final awardsProvider = StreamProvider.autoDispose<List<AchievementAward>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const []);
  return ref.watch(historyRepositoryProvider).watchAwards(id);
});

// --- Fitness --------------------------------------------------------------

final fitnessRepositoryProvider =
    Provider((ref) => FitnessRepository(ref.watch(databaseProvider)));

/// Water logs for the last 7 days (including today).
final waterLogsProvider = StreamProvider<List<WaterLog>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const []);
  final now = DateTime.now();
  return ref
      .watch(fitnessRepositoryProvider)
      .watchWaterSince(id, DateTime(now.year, now.month, now.day - 6));
});

final activeFastProvider = StreamProvider<FastingSession?>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(null);
  return ref.watch(fitnessRepositoryProvider).watchActiveFast(id);
});

final fastHistoryProvider = StreamProvider<List<FastingSession>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const []);
  return ref.watch(fitnessRepositoryProvider).watchFastHistory(id);
});

final workoutHistoryProvider = StreamProvider<List<WorkoutSession>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const []);
  return ref.watch(fitnessRepositoryProvider).watchWorkoutHistory(id);
});

// --- Study ----------------------------------------------------------------

final studyRepositoryProvider =
    Provider((ref) => StudyRepository(ref.watch(databaseProvider)));

final subjectsProvider = StreamProvider<List<Subject>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const []);
  return ref.watch(studyRepositoryProvider).watchSubjects(id);
});

final subjectProgressProvider = StreamProvider<List<SubjectProgress>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const []);
  return ref.watch(studyRepositoryProvider).watchSubjectProgress(id);
});

final upcomingExamsProvider = StreamProvider<List<Exam>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const []);
  return ref.watch(studyRepositoryProvider).watchUpcomingExams(id);
});

final activeSessionProvider = StreamProvider<StudySession?>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(null);
  return ref.watch(studyRepositoryProvider).watchActiveSession(id);
});

final cardsProvider = StreamProvider<List<Flashcard>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const []);
  return ref.watch(studyRepositoryProvider).watchCards(id);
});

final recentReviewsProvider = StreamProvider<List<FlashcardReview>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const []);
  final now = DateTime.now();
  return ref
      .watch(studyRepositoryProvider)
      .watchReviewsSince(id, DateTime(now.year, now.month, now.day - 30));
});

final todayFocusProvider = StreamProvider<List<StudySession>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const []);
  final now = DateTime.now();
  return ref
      .watch(studyRepositoryProvider)
      .watchFinishedFocus(id, DateTime(now.year, now.month, now.day));
});

/// Records for roughly the last 400 days, enough for streaks and summaries.
final prayerLogProvider = StreamProvider<PrayerLog>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const {});
  final now = DateTime.now();
  return ref.watch(prayerRepositoryProvider).watchLog(
        id,
        DateTime(now.year, now.month, now.day - 400),
        DateTime(now.year, now.month, now.day + 1),
      );
});

/// The current time. Overridden in tests so time-of-day logic is repeatable.
final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

// --- Backup and cloud ------------------------------------------------------

final backupServiceProvider =
    Provider((ref) => BackupService(ref.watch(databaseProvider)));

final cloudConfigProvider = Provider((ref) => CloudConfig.fromEnvironment());

final cloudAuthProvider = Provider((ref) =>
    CloudAuth(ref.watch(cloudConfigProvider), SecureSessionStore()));

final syncRemoteProvider = Provider<SyncRemote>((ref) => SupabaseRemote(
    ref.watch(cloudConfigProvider), ref.watch(cloudAuthProvider)));

final syncEngineProvider = Provider(
    (ref) => SyncEngine(ref.watch(databaseProvider), ref.watch(syncRemoteProvider)));

final cloudAccountServiceProvider = Provider((ref) => CloudAccountService(
    ref.watch(cloudConfigProvider), ref.watch(cloudAuthProvider)));

final syncSettingsRepositoryProvider = Provider(
    (ref) => SyncSettingsRepository(ref.watch(databaseProvider)));

final syncSettingsProvider = StreamProvider<SyncSetting?>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(null);
  return ref.watch(syncSettingsRepositoryProvider).watch(id);
});

final pendingDeletesProvider = StreamProvider<int>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(0);
  return ref.watch(syncSettingsRepositoryProvider).watchPendingDeletes(id);
});

// --- AI (optional) ---------------------------------------------------------

final aiClientProvider = Provider<AiClient>((ref) => SupabaseAiClient(
    ref.watch(cloudConfigProvider), ref.watch(cloudAuthProvider)));

final aiServiceProvider = Provider((ref) => AiService(
    ref.watch(databaseProvider),
    ref.watch(aiClientProvider),
    ref.watch(historyRepositoryProvider)));

final aiConsentProvider = StreamProvider<AiConsent>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const AiConsent());
  return ref.watch(aiServiceProvider).watchConsent(id);
});

final aiHistoryProvider = StreamProvider.autoDispose<List<AiMessage>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const []);
  return ref.watch(aiServiceProvider).watchHistory(id);
});

// --- Notifications ---------------------------------------------------------

final notificationSchedulerProvider =
    Provider<NotificationScheduler>((ref) => LocalNotificationsScheduler());

final notificationServiceProvider = Provider((ref) => NotificationService(
    ref.watch(databaseProvider), ref.watch(notificationSchedulerProvider)));

final notificationPrefsProvider = StreamProvider<NotificationPrefs>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return Stream.value(const NotificationPrefs());
  return ref.watch(notificationServiceProvider).watchPrefs(id);
});
