import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'table_specs.dart';

part 'database.g.dart';

/// Local identity. [cloudUserId] is deliberately separate from [id]: the
/// local id is never used to authorize remote access.
class Profiles extends Table {
  TextColumn get id => text()();
  TextColumn get displayName => text().withLength(min: 1, max: 60)();
  TextColumn get mode => text().withDefault(const Constant('local'))();
  TextColumn get cloudUserId => text().nullable()();
  TextColumn get recoveryQuestion => text().nullable()();
  // PBKDF2 verifier of the recovery answer; the answer itself is never stored.
  TextColumn get recoveryHash => text().nullable()();
  TextColumn get recoverySalt => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class UserPreferences extends Table {
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();
  TextColumn get fitnessLevel =>
      text().withDefault(const Constant('beginner'))();
  IntColumn get workoutMinutes => integer().withDefault(const Constant(20))();
  IntColumn get studyGoalMinutes =>
      integer().withDefault(const Constant(60))();
  IntColumn get waterGoalMl => integer().withDefault(const Constant(2000))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {profileId};
}

class NotificationPreferences extends Table {
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  BoolColumn get prayer => boolean().withDefault(const Constant(false))();
  BoolColumn get study => boolean().withDefault(const Constant(false))();
  BoolColumn get workout => boolean().withDefault(const Constant(false))();
  BoolColumn get hydration => boolean().withDefault(const Constant(false))();
  BoolColumn get reflection => boolean().withDefault(const Constant(false))();
  // Minutes after midnight; null means quiet hours are off.
  IntColumn get quietStartMinute => integer().nullable()();
  IntColumn get quietEndMinute => integer().nullable()();
  // Bit i = remind for prayer i (fajr..isha); 31 = all five.
  IntColumn get prayerMask => integer().withDefault(const Constant(31))();
  IntColumn get prayerOffsetMinutes =>
      integer().withDefault(const Constant(0))();
  IntColumn get studyMinute => integer().withDefault(const Constant(1140))();
  IntColumn get workoutMinute => integer().withDefault(const Constant(1020))();
  IntColumn get hydrationIntervalMinutes =>
      integer().withDefault(const Constant(120))();
  IntColumn get reflectionMinute =>
      integer().withDefault(const Constant(1260))();
  BoolColumn get flashcards => boolean().withDefault(const Constant(false))();
  IntColumn get flashcardsMinute =>
      integer().withDefault(const Constant(1080))();
  BoolColumn get weeklyReport => boolean().withDefault(const Constant(false))();
  IntColumn get weeklyReportDay => integer().withDefault(const Constant(7))();
  // False keeps notification text generic (no prayer name, subject, etc.).
  BoolColumn get showDetails => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {profileId};
}

class PrivacyPreferences extends Table {
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  BoolColumn get cloudSyncEnabled =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get aiConsent => boolean().withDefault(const Constant(false))();
  // What the AI features may use, chosen separately. Journal text is never
  // sent to AI, so there is deliberately no switch for it.
  BoolColumn get aiShareStudy => boolean().withDefault(const Constant(false))();
  BoolColumn get aiShareFitness =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get aiSharePrayer =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {profileId};
}

class PrayerSettings extends Table {
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  // CalculationMethod enum name from adhan_dart.
  TextColumn get method =>
      text().withDefault(const Constant('muslimWorldLeague'))();
  // 'shafi' (standard) or 'hanafi'.
  TextColumn get asrMethod => text().withDefault(const Constant('shafi'))();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get locationLabel => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {profileId};
}

/// One row per recorded prayer. No row means "not recorded"; it is never
/// treated as missed.
class PrayerRecords extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  // Local calendar day, yyyy-MM-dd.
  TextColumn get day => text()();
  // fajr | dhuhr | asr | maghrib | isha
  TextColumn get prayer => text()();
  // onTime | late | missed
  TextColumn get status => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {profileId, day, prayer},
      ];
}

class Subjects extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SyllabusTopics extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get subjectId =>
      text().references(Subjects, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text().withLength(min: 1, max: 120)();
  TextColumn get description => text().nullable()();
  // 1 = high, 2 = medium, 3 = low.
  IntColumn get priority => integer().withDefault(const Constant(2))();
  IntColumn get estimateMinutes => integer().nullable()();
  // notStarted | inProgress | completed
  TextColumn get status => text().withDefault(const Constant('notStarted'))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Exams extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get subjectId =>
      text().nullable().references(Subjects, #id, onDelete: KeyAction.setNull)();
  TextColumn get name => text().withLength(min: 1, max: 120)();
  DateTimeColumn get examAt => dateTime()();
  IntColumn get priority => integer().withDefault(const Constant(2))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Focus and break sessions. A row with a null [endedAt] is the active
/// session; its timestamps fully determine the remaining time.
class StudySessions extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get subjectId =>
      text().nullable().references(Subjects, #id, onDelete: KeyAction.setNull)();
  // focus | shortBreak | longBreak
  TextColumn get kind => text()();
  IntColumn get plannedSeconds => integer()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get pausedAt => dateTime().nullable()();
  IntColumn get accumulatedPausedMs =>
      integer().withDefault(const Constant(0))();
  DateTimeColumn get endedAt => dateTime().nullable()();
  BoolColumn get cancelled => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Flashcards extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get subjectId =>
      text().nullable().references(Subjects, #id, onDelete: KeyAction.setNull)();
  TextColumn get front => text().withLength(min: 1, max: 2000)();
  TextColumn get back => text().withLength(min: 1, max: 4000)();
  TextColumn get tags => text().nullable()();
  RealColumn get ease => real().withDefault(const Constant(2.5))();
  IntColumn get intervalDays => integer().withDefault(const Constant(0))();
  IntColumn get repetitions => integer().withDefault(const Constant(0))();
  DateTimeColumn get dueAt => dateTime()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class FlashcardReviews extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get cardId =>
      text().references(Flashcards, #id, onDelete: KeyAction.cascade)();
  // again | hard | good | easy
  TextColumn get rating => text()();
  DateTimeColumn get reviewedAt => dateTime()();
  IntColumn get intervalAfterDays => integer()();
  RealColumn get easeAfter => real()();

  @override
  Set<Column> get primaryKey => {id};
}

class WaterLogs extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  IntColumn get amountMl => integer()();
  DateTimeColumn get loggedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class FastingSessions extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get startedAt => dateTime()();
  // Null for an open-ended fast.
  IntColumn get plannedSeconds => integer().nullable()();
  // Null while the fast is active.
  DateTimeColumn get endedAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Finished workout runs. [workoutKey] refers to the bundled library id, so
/// history survives library changes without a foreign key.
class WorkoutSessions extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get workoutKey => text()();
  TextColumn get workoutName => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime()();
  IntColumn get exercisesCompleted => integer()();
  IntColumn get exercisesTotal => integer()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// One reflection per profile per day. Private by default: nothing here is
/// ever sent to a cloud or AI service without explicit consent.
class JournalEntries extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  // Local calendar day, yyyy-MM-dd.
  TextColumn get day => text()();
  TextColumn get wentWell => text().withDefault(const Constant(''))();
  TextColumn get learned => text().withDefault(const Constant(''))();
  TextColumn get improve => text().withDefault(const Constant(''))();
  TextColumn get grateful => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {profileId, day},
      ];
}

class AchievementAwards extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get achievementId => text()();
  DateTimeColumn get awardedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {profileId, achievementId},
      ];
}

class DailyPlans extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get day => text()();
  DateTimeColumn get generatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {profileId, day},
      ];
}

class PlannedActivities extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get planId =>
      text().references(DailyPlans, #id, onDelete: KeyAction.cascade)();
  // study | review | workout | other
  TextColumn get kind => text()();
  TextColumn get title => text()();
  DateTimeColumn get startAt => dateTime()();
  DateTimeColumn get endAt => dateTime()();
  // planned | done | skipped
  TextColumn get status => text().withDefault(const Constant('planned'))();
  // Pinned blocks are kept exactly as they are when the plan is regenerated.
  BoolColumn get pinned => boolean().withDefault(const Constant(false))();
  // Short code explaining why it was suggested (e.g. exam_soon).
  TextColumn get reason => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local AI conversation history. Stored only on this device: it is not
/// included in backups or cloud sync, and can be cleared at any time.
class AiMessages extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  // user | assistant
  TextColumn get role => text()();
  // coach | flashcards | summarize | questions | explain
  TextColumn get kind => text()();
  TextColumn get body => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Per-profile cloud sync choices. Everything is off until the user opts in.
class SyncSettings extends Table {
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  BoolColumn get enabled => boolean().withDefault(const Constant(false))();
  BoolColumn get syncPrayer => boolean().withDefault(const Constant(false))();
  BoolColumn get syncStudy => boolean().withDefault(const Constant(false))();
  BoolColumn get syncFitness => boolean().withDefault(const Constant(false))();
  BoolColumn get syncJournal => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastSyncAt => dateTime().nullable()();
  TextColumn get lastError => text().nullable()();

  @override
  Set<Column> get primaryKey => {profileId};
}

/// Rows deleted locally that the server has not been told about yet.
/// Filled by database triggers (see [createSyncTriggers]).
class SyncTombstones extends Table {
  TextColumn get targetTable => text()();
  TextColumn get rowId => text()();
  TextColumn get profileId => text()();
  DateTimeColumn get deletedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {targetTable, rowId, profileId};
}

/// Small key/value store for sync cursors.
class SyncState extends Table {
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {profileId, key};
}

@DriftDatabase(tables: [
  Profiles,
  UserPreferences,
  NotificationPreferences,
  PrivacyPreferences,
  PrayerSettings,
  PrayerRecords,
  Subjects,
  SyllabusTopics,
  Exams,
  StudySessions,
  Flashcards,
  FlashcardReviews,
  WaterLogs,
  FastingSessions,
  WorkoutSessions,
  JournalEntries,
  AchievementAwards,
  DailyPlans,
  PlannedActivities,
  SyncSettings,
  SyncTombstones,
  SyncState,
  AiMessages,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.persistent() : super(driftDatabase(name: 'nuvora'));

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await createSyncTriggers(this);
        },
        onUpgrade: (m, from, to) async {
          // Additive steps only, applied oldest to newest; never drop user
          // data. Later steps may rely on tables from earlier ones (the sync
          // triggers in step 6 watch tables created in steps 2 to 5).
          if (from < 2) {
            await m.createTable(prayerSettings);
            await m.createTable(prayerRecords);
          }
          if (from < 3) {
            await m.createTable(subjects);
            await m.createTable(syllabusTopics);
            await m.createTable(exams);
            await m.createTable(studySessions);
            await m.createTable(flashcards);
            await m.createTable(flashcardReviews);
          }
          if (from < 4) {
            await m.addColumn(userPreferences, userPreferences.waterGoalMl);
            await m.createTable(waterLogs);
            await m.createTable(fastingSessions);
            await m.createTable(workoutSessions);
          }
          if (from < 5) {
            await m.createTable(journalEntries);
            await m.createTable(achievementAwards);
            await m.createTable(dailyPlans);
            await m.createTable(plannedActivities);
          }
          if (from < 6) {
            await m.createTable(syncSettings);
            await m.createTable(syncTombstones);
            await m.createTable(syncState);
            await createSyncTriggers(this);
          }
          if (from < 7) {
            await m.addColumn(
                privacyPreferences, privacyPreferences.aiShareStudy);
            await m.addColumn(
                privacyPreferences, privacyPreferences.aiShareFitness);
            await m.addColumn(
                privacyPreferences, privacyPreferences.aiSharePrayer);
            await m.createTable(aiMessages);
          }
          if (from < 8) {
            final n = notificationPreferences;
            await m.addColumn(n, n.prayerMask);
            await m.addColumn(n, n.prayerOffsetMinutes);
            await m.addColumn(n, n.studyMinute);
            await m.addColumn(n, n.workoutMinute);
            await m.addColumn(n, n.hydrationIntervalMinutes);
            await m.addColumn(n, n.reflectionMinute);
            await m.addColumn(n, n.flashcards);
            await m.addColumn(n, n.flashcardsMinute);
            await m.addColumn(n, n.weeklyReport);
            await m.addColumn(n, n.weeklyReportDay);
            await m.addColumn(n, n.showDetails);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

/// Creates one AFTER DELETE trigger per synced table that records a
/// tombstone, so deletions can be sent to the cloud without every repository
/// having to remember to do it. Triggers also fire for cascading deletes.
Future<void> createSyncTriggers(AppDatabase db) async {
  for (final spec in tableSpecs) {
    if (!spec.isSynced) continue;
    final rowId = spec.pk.length == 1 && spec.pk.first == 'id'
        ? 'OLD.id'
        : "'@profile'";
    await db.customStatement('''
      CREATE TRIGGER IF NOT EXISTS nuvora_tomb_${spec.name}
      AFTER DELETE ON ${spec.name}
      BEGIN
        INSERT OR REPLACE INTO sync_tombstones
          (target_table, row_id, profile_id, deleted_at)
        VALUES ('${spec.name}', $rowId, OLD.profile_id,
                CAST(strftime('%s', 'now') AS INTEGER));
      END
    ''');
  }
}
