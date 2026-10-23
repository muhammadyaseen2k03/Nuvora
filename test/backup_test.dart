import 'dart:convert';

import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/data/database.dart';
import 'package:nuvora/features/auth/profile_repository.dart';
import 'package:nuvora/features/backup/backup_service.dart';
import 'package:nuvora/features/fitness/fitness_repository.dart';
import 'package:nuvora/features/habits/journal_repository.dart';
import 'package:nuvora/features/prayer/prayer_repository.dart';
import 'package:nuvora/features/prayer/prayer_service.dart';
import 'package:nuvora/features/prayer/prayer_streaks.dart';
import 'package:nuvora/features/study/srs.dart';
import 'package:nuvora/features/study/study_repository.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late AppDatabase db;
  late String a;
  late BackupService backup;
  final clock = DateTime(2024, 5, 10, 9, 0);

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    backup = BackupService(db, clock: () => clock);
    a = await ProfileRepository(db).createProfile(const NewProfile(
        displayName: 'Amina',
        recoveryQuestion: 'First school?',
        recoveryAnswer: 'Green Valley'));
    final study = StudyRepository(db, clock: () => clock);
    final math = await study.addSubject(a, 'Math');
    await study.addTopic(a, math, 'Limits');
    final card = await study.addCard(a, 'Q?', 'A.', subjectId: math);
    final due = (await study.dueCards(a)).single;
    expect(due.id, card);
    await study.reviewCard(a, due, Rating.good);
    await study.addExam(a, 'Midterm', DateTime(2024, 6, 1), subjectId: math);
    await FitnessRepository(db, clock: () => clock).addWater(a, 250);
    await PrayerRepository(db, clock: () => clock)
        .setStatus(a, clock, PrayerName.fajr, PrayerStatus.onTime);
    await JournalRepository(db, clock: () => clock)
        .save(a, clock, wentWell: 'Private thought');
  });
  tearDown(() => db.close());

  Future<int> count(String table) async =>
      (await db.customSelect('SELECT COUNT(*) AS c FROM $table').getSingle())
          .read<int>('c');

  test('export contains data but never secrets', () async {
    final json = await backup.export(a);
    final data = jsonDecode(json) as Map<String, dynamic>;
    expect(data['format'], 'nuvora-backup');
    expect(data['version'], 1);
    final profile = (data['tables']['profiles'] as List).single as Map;
    expect(profile['display_name'], 'Amina');
    for (final secret in [
      'recovery_question',
      'recovery_hash',
      'recovery_salt',
      'cloud_user_id'
    ]) {
      expect(profile.containsKey(secret), isFalse, reason: secret);
    }
    expect(json.contains('Green Valley'), isFalse);
    expect((data['tables']['subjects'] as List), hasLength(1));
    expect((data['tables']['journal_entries'] as List), hasLength(1));
  });

  test('restore as a new profile keeps the original and remaps ids', () async {
    final json = await backup.export(a);
    final preview = await backup.validate(json);
    expect(preview.profileName, 'Amina');
    expect(preview.rowCounts['subjects'], 1);

    final restoredId = await backup.restoreAsNewProfile(json);
    expect(restoredId, isNot(a));
    expect(await count('profiles'), 2);
    expect(await count('subjects'), 2);
    expect(await count('flashcard_reviews'), 2);

    // The restored child rows point at the restored parents, not the originals.
    final orphans = await db.customSelect(
      'SELECT COUNT(*) AS c FROM syllabus_topics t '
      'JOIN subjects s ON s.id = t.subject_id WHERE t.profile_id != s.profile_id',
    ).getSingle();
    expect(orphans.read<int>('c'), 0);

    // Original profile is intact and still has its recovery verifier.
    final original = await ProfileRepository(db).getProfile(a);
    expect(original!.recoveryHash, isNotNull);
    // The restored profile has none (secrets are not in backups).
    final restored = await ProfileRepository(db).getProfile(restoredId);
    expect(restored!.recoveryHash, isNull);

    // Restoring the same file again does not collide.
    await backup.restoreAsNewProfile(json);
    expect(await count('profiles'), 3);
  });

  test('restore into a fresh database reproduces the data', () async {
    final json = await backup.export(a);
    final other = AppDatabase(NativeDatabase.memory());
    addTearDown(other.close);
    final id = await BackupService(other).restoreAsNewProfile(json);
    final cards = await other.select(other.flashcards).get();
    expect(cards.single.front, 'Q?');
    expect(cards.single.profileId, id);
    final journal = await other.select(other.journalEntries).get();
    expect(journal.single.wentWell, 'Private thought');
  });

  test('replace mode swaps data atomically and keeps recovery data', () async {
    final json = await backup.export(a);
    // Change current data after the backup was taken.
    await FitnessRepository(db, clock: () => clock).addWater(a, 500);
    expect(await count('water_logs'), 2);

    await backup.restoreReplacingProfile(json, a);
    expect(await count('profiles'), 1);
    expect(await count('water_logs'), 1); // back to the backed-up state
    final p = await ProfileRepository(db).getProfile(a);
    expect(p!.recoveryHash, isNotNull, reason: 'target secrets are kept');
  });

  test('a failed replace leaves the original data untouched', () async {
    final data = jsonDecode(await backup.export(a)) as Map<String, dynamic>;
    // Valid shape, but a topic points at a subject that is not in the file.
    (data['tables']['syllabus_topics'] as List).first['subject_id'] = 'missing';
    final before = await count('subjects');
    await expectLater(
      backup.restoreReplacingProfile(jsonEncode(data), a),
      throwsA(isA<BackupException>()),
    );
    expect(await count('subjects'), before);
    expect(await count('profiles'), 1);
    expect(await count('water_logs'), 1);
  });

  group('validation', () {
    Future<String> expectCode(String source) async {
      try {
        await backup.validate(source);
      } on BackupException catch (e) {
        return e.code;
      }
      return 'ok';
    }

    test('rejects bad input without touching the database', () async {
      expect(await expectCode('not json'), 'not_json');
      expect(await expectCode('[]'), 'wrong_format');
      expect(await expectCode('{"format":"other"}'), 'wrong_format');
      expect(await expectCode('{' * 3), 'not_json');

      final good = jsonDecode(await backup.export(a)) as Map<String, dynamic>;
      String mod(void Function(Map<String, dynamic>) f) {
        final c = jsonDecode(jsonEncode(good)) as Map<String, dynamic>;
        f(c);
        return jsonEncode(c);
      }

      expect(await expectCode(mod((m) => m['version'] = 99)), 'newer_version');
      expect(await expectCode(mod((m) => m['version'] = 'x')),
          'invalid_structure');
      expect(await expectCode(mod((m) => m['createdAt'] = 'yesterday')),
          'invalid_structure');
      expect(await expectCode(mod((m) => m['tables'] = [])), 'invalid_structure');
      expect(await expectCode(mod((m) => m['tables']['evil_table'] = [])),
          'unknown_table');
      expect(
          await expectCode(
              mod((m) => (m['tables']['subjects'] as List).first['bogus'] = 1)),
          'invalid_row');
      expect(
          await expectCode(mod((m) =>
              (m['tables']['subjects'] as List).first['name'] = {'a': 1})),
          'invalid_row');
      expect(await expectCode(mod((m) => m['tables']['profiles'] = [])),
          'invalid_structure');
      expect(await expectCode('x' * (BackupService.maxBytes + 1)), 'too_large');
      expect(await expectCode(jsonEncode(good)), 'ok');
      expect(await count('profiles'), 1);
    });

    test('SQL-looking values are stored as data, never executed', () async {
      final data = jsonDecode(await backup.export(a)) as Map<String, dynamic>;
      (data['tables']['subjects'] as List).first['name'] =
          "x'); DROP TABLE profiles; --";
      final id = await backup.restoreAsNewProfile(jsonEncode(data));
      expect(await count('profiles'), 2);
      final names = await db.select(db.subjects).get();
      expect(names.map((s) => s.name), contains("x'); DROP TABLE profiles; --"));
      expect(id, isNotEmpty);
    });
  });
}
