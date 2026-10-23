import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../data/database.dart';
import 'recovery.dart';

class NewProfile {
  const NewProfile({
    required this.displayName,
    this.themeMode = 'system',
    this.languageCode = 'en',
    this.fitnessLevel = 'beginner',
    this.workoutMinutes = 20,
    this.studyGoalMinutes = 60,
    this.recoveryQuestion,
    this.recoveryAnswer,
  });

  final String displayName;
  final String themeMode;
  final String languageCode;
  final String fitnessLevel;
  final int workoutMinutes;
  final int studyGoalMinutes;
  final String? recoveryQuestion;
  final String? recoveryAnswer;
}

/// All access to profile-owned rows goes through a profile id, so one
/// profile can never read another's preferences.
class ProfileRepository {
  ProfileRepository(this._db, {DateTime Function()? clock})
      : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _now;
  static const _uuid = Uuid();

  Stream<List<Profile>> watchProfiles() => (_db.select(_db.profiles)
        ..where((p) => p.deletedAt.isNull())
        ..orderBy([(p) => OrderingTerm.asc(p.createdAt)]))
      .watch();

  Future<Profile?> getProfile(String id) => (_db.select(_db.profiles)
        ..where((p) => p.id.equals(id) & p.deletedAt.isNull()))
      .getSingleOrNull();

  Stream<UserPreference?> watchPreferences(String profileId) =>
      (_db.select(_db.userPreferences)
            ..where((p) => p.profileId.equals(profileId)))
          .watchSingleOrNull();

  Future<String> createProfile(NewProfile p) async {
    final id = _uuid.v4();
    final now = _now();
    String? salt;
    String? hash;
    final answer = p.recoveryAnswer?.trim() ?? '';
    final hasRecovery = (p.recoveryQuestion?.trim().isNotEmpty ?? false) &&
        answer.isNotEmpty;
    if (hasRecovery) {
      salt = RecoveryVerifier.newSalt();
      hash = RecoveryVerifier.derive(answer, salt);
    }
    await _db.transaction(() async {
      await _db.into(_db.profiles).insert(ProfilesCompanion.insert(
            id: id,
            displayName: p.displayName.trim(),
            recoveryQuestion: Value(hasRecovery ? p.recoveryQuestion : null),
            recoveryHash: Value(hash),
            recoverySalt: Value(salt),
            createdAt: now,
            updatedAt: now,
          ));
      await _db.into(_db.userPreferences).insert(UserPreferencesCompanion.insert(
            profileId: id,
            themeMode: Value(p.themeMode),
            languageCode: Value(p.languageCode),
            fitnessLevel: Value(p.fitnessLevel),
            workoutMinutes: Value(p.workoutMinutes),
            studyGoalMinutes: Value(p.studyGoalMinutes),
            updatedAt: now,
          ));
      await _db
          .into(_db.notificationPreferences)
          .insert(NotificationPreferencesCompanion.insert(
              profileId: id, updatedAt: now));
      await _db
          .into(_db.privacyPreferences)
          .insert(PrivacyPreferencesCompanion.insert(
              profileId: id, updatedAt: now));
    });
    return id;
  }

  Future<void> updatePreferences(
    String profileId, {
    String? themeMode,
    String? languageCode,
    String? fitnessLevel,
    int? workoutMinutes,
    int? studyGoalMinutes,
  }) {
    return (_db.update(_db.userPreferences)
          ..where((p) => p.profileId.equals(profileId)))
        .write(UserPreferencesCompanion(
      themeMode: Value.absentIfNull(themeMode),
      languageCode: Value.absentIfNull(languageCode),
      fitnessLevel: Value.absentIfNull(fitnessLevel),
      workoutMinutes: Value.absentIfNull(workoutMinutes),
      studyGoalMinutes: Value.absentIfNull(studyGoalMinutes),
      updatedAt: Value(_now()),
    ));
  }

  Future<bool> verifyRecoveryAnswer(String profileId, String answer) async {
    final p = await getProfile(profileId);
    if (p?.recoveryHash == null || p?.recoverySalt == null) return false;
    return RecoveryVerifier.verify(answer, p!.recoverySalt!, p.recoveryHash!);
  }

  /// Permanently removes the profile and, via cascading foreign keys, all of
  /// its owned rows. Local-only profiles have nothing to tombstone.
  Future<void> deleteProfile(String id) async {
    await _db.transaction(() async {
      await (_db.delete(_db.profiles)..where((p) => p.id.equals(id))).go();
      // Deletion triggers recorded tombstones for the cascaded rows; the
      // profile is gone, so there is nothing left to tell a server about.
      await (_db.delete(_db.syncTombstones)
            ..where((t) => t.profileId.equals(id)))
          .go();
    });
  }
}
