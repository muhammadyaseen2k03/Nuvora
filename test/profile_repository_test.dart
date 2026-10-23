import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/data/database.dart';
import 'package:nuvora/features/auth/profile_repository.dart';
import 'package:nuvora/features/auth/recovery.dart';

void main() {
  late AppDatabase db;
  late ProfileRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = ProfileRepository(db);
  });
  tearDown(() => db.close());

  test('multiple profiles coexist with isolated preferences', () async {
    final a = await repo.createProfile(
        const NewProfile(displayName: 'Amina', themeMode: 'dark'));
    final b = await repo.createProfile(
        const NewProfile(displayName: 'Bilal', languageCode: 'ur'));

    expect((await repo.watchProfiles().first).map((p) => p.displayName),
        ['Amina', 'Bilal']);

    await repo.updatePreferences(a, studyGoalMinutes: 120);
    final prefsA = await repo.watchPreferences(a).first;
    final prefsB = await repo.watchPreferences(b).first;
    expect(prefsA!.themeMode, 'dark');
    expect(prefsA.studyGoalMinutes, 120);
    expect(prefsB!.themeMode, 'system');
    expect(prefsB.languageCode, 'ur');
    expect(prefsB.studyGoalMinutes, 60);
  });

  test('deleting a profile removes its rows but not another profile', () async {
    final a = await repo.createProfile(const NewProfile(displayName: 'A'));
    final b = await repo.createProfile(const NewProfile(displayName: 'B'));
    await repo.deleteProfile(a);

    expect(await repo.getProfile(a), isNull);
    expect(await repo.watchPreferences(a).first, isNull);
    expect(await db.select(db.notificationPreferences).get(), hasLength(1));
    expect(await db.select(db.privacyPreferences).get(), hasLength(1));
    expect(await repo.getProfile(b), isNotNull);
  });

  test('recovery answer is stored only as a verifier', () async {
    final id = await repo.createProfile(const NewProfile(
      displayName: 'A',
      recoveryQuestion: 'First school?',
      recoveryAnswer: 'Green Valley',
    ));
    final p = (await repo.getProfile(id))!;
    expect(p.recoveryHash, isNotNull);
    expect(p.recoveryHash!.toLowerCase(), isNot(contains('green')));
    expect(await repo.verifyRecoveryAnswer(id, '  green   VALLEY '), isTrue);
    expect(await repo.verifyRecoveryAnswer(id, 'other'), isFalse);
  });

  test('profile without recovery question never verifies', () async {
    final id = await repo.createProfile(const NewProfile(displayName: 'A'));
    expect(await repo.verifyRecoveryAnswer(id, ''), isFalse);
  });

  test('new profiles default to cloud sync and AI off', () async {
    final id = await repo.createProfile(const NewProfile(displayName: 'A'));
    final privacy = await (db.select(db.privacyPreferences)
          ..where((p) => p.profileId.equals(id)))
        .getSingle();
    expect(privacy.cloudSyncEnabled, isFalse);
    expect(privacy.aiConsent, isFalse);
  });

  test('PBKDF2-HMAC-SHA256 matches a published test vector', () {
    // password="password", salt="salt", c=1, dkLen=32 (RFC 7914 / common vectors).
    final out = RecoveryVerifier.pbkdf2(
        utf8.encode('password'), utf8.encode('salt'), 1, 32);
    final hex = out.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    expect(hex,
        '120fb6cffcf8b32c43e7225256c4f837a86548c92ccc35480805987cb70be17b');
  });

  test('derivation is deterministic per salt and differs across salts', () {
    final s1 = RecoveryVerifier.newSalt();
    final s2 = RecoveryVerifier.newSalt();
    expect(RecoveryVerifier.derive('x', s1), RecoveryVerifier.derive('x', s1));
    expect(RecoveryVerifier.derive('x', s1),
        isNot(RecoveryVerifier.derive('x', s2)));
  });
}
