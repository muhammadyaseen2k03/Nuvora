import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/data/database.dart';
import 'package:nuvora/features/auth/profile_repository.dart';
import 'package:nuvora/features/fitness/fitness_repository.dart';
import 'package:nuvora/features/habits/journal_repository.dart';
import 'package:nuvora/features/prayer/prayer_repository.dart';
import 'package:nuvora/features/prayer/prayer_service.dart';
import 'package:nuvora/features/prayer/prayer_streaks.dart';
import 'package:nuvora/features/study/study_repository.dart';
import 'package:nuvora/features/sync/remote.dart';
import 'package:nuvora/features/sync/sync_engine.dart';

/// One simulated device: its own database, its own clock and local profile id.
class Device {
  Device._(this.db, this.profileId, this.clock);

  final AppDatabase db;
  final String profileId;
  DateTime clock;

  late final study = StudyRepository(db, clock: () => clock);
  late final fitness = FitnessRepository(db, clock: () => clock);
  late final journal = JournalRepository(db, clock: () => clock);
  late final prayer = PrayerRepository(db, clock: () => clock);

  SyncEngine engine(SyncRemote remote) =>
      SyncEngine(db, remote, clock: () => clock);

  static Future<Device> create(
    DateTime start, {
    bool study = true,
    bool fitness = true,
    bool journal = false,
    bool prayer = false,
    bool enabled = true,
  }) async {
    final db = AppDatabase(NativeDatabase.memory());
    final id = await ProfileRepository(db)
        .createProfile(const NewProfile(displayName: 'Amina'));
    await db.into(db.syncSettings).insert(SyncSettingsCompanion.insert(
          profileId: id,
          enabled: Value(enabled),
          syncStudy: Value(study),
          syncFitness: Value(fitness),
          syncJournal: Value(journal),
          syncPrayer: Value(prayer),
        ));
    return Device._(db, id, start);
  }

  Future<int> count(String table) async =>
      (await db.customSelect('SELECT COUNT(*) AS c FROM $table').getSingle())
          .read<int>('c');
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  // Deletion times come from a database trigger that uses the real clock, so
  // the simulated device clocks are anchored to real time as well.
  final real = DateTime.now().subtract(const Duration(hours: 1));
  final t0 = DateTime(real.year, real.month, real.day, real.hour, real.minute);
  late InMemoryRemote remote;
  late Device a;
  late Device b;

  setUp(() async {
    remote = InMemoryRemote();
    a = await Device.create(t0);
    b = await Device.create(t0); // a different local profile id on purpose
  });
  tearDown(() async {
    await a.db.close();
    await b.db.close();
  });

  test('data flows between devices with different local profile ids',
      () async {
    final math = await a.study.addSubject(a.profileId, 'Math');
    await a.study.addTopic(a.profileId, math, 'Limits');
    await a.fitness.addWater(a.profileId, 250);

    final pushed = (await a.engine(remote).sync(a.profileId)).pushed;
    expect(pushed, greaterThanOrEqualTo(3));
    await b.engine(remote).sync(b.profileId);

    final subjects = await b.db.select(b.db.subjects).get();
    expect(subjects.single.name, 'Math');
    expect(subjects.single.profileId, b.profileId); // remapped, not a's id
    expect(await b.count('syllabus_topics'), 1);
    expect(await b.count('water_logs'), 1);
    expect(a.profileId, isNot(b.profileId));
  });

  test('only opted-in categories and non-secret tables are uploaded',
      () async {
    await a.study.addSubject(a.profileId, 'Math');
    await a.journal.save(a.profileId, t0, wentWell: 'private journal text');
    await a.prayer
        .setStatus(a.profileId, t0, PrayerName.fajr, PrayerStatus.onTime);
    await a.engine(remote).sync(a.profileId);

    final tables = remote.all.map((r) => r.table).toSet();
    expect(tables, contains('subjects'));
    expect(tables, isNot(contains('journal_entries'))); // opt-in, off
    expect(tables, isNot(contains('prayer_records'))); // opt-in, off
    expect(tables, isNot(contains('profiles')));
    expect(tables, isNot(contains('privacy_preferences')));
    expect(tables, isNot(contains('notification_preferences')));
    final blob = remote.all.map((r) => r.data?.toString() ?? '').join();
    expect(blob.contains('private journal text'), isFalse);
    expect(blob.contains('recovery'), isFalse);
  });

  test('journal and prayer data sync only when their toggles are on',
      () async {
    final j = await Device.create(t0, journal: true, prayer: true);
    addTearDown(j.db.close);
    await j.journal.save(j.profileId, t0, wentWell: 'shared by choice');
    await j.prayer
        .setStatus(j.profileId, t0, PrayerName.asr, PrayerStatus.late);
    await j.engine(remote).sync(j.profileId);
    expect(remote.all.map((r) => r.table),
        containsAll(['journal_entries', 'prayer_records']));
  });

  test('a failed push can be retried without duplicates', () async {
    await a.fitness.addWater(a.profileId, 250);
    await a.fitness.addWater(a.profileId, 500);
    remote.failNextPushes = 1;
    await expectLater(a.engine(remote).sync(a.profileId),
        throwsA(isA<SyncException>()));
    final settings = await a.db.select(a.db.syncSettings).getSingle();
    expect(settings.lastError, 'offline');

    await a.engine(remote).sync(a.profileId);
    await a.engine(remote).sync(a.profileId); // extra run: still idempotent
    expect(remote.all.where((r) => r.table == 'water_logs'), hasLength(2));

    await b.engine(remote).sync(b.profileId);
    await b.engine(remote).sync(b.profileId);
    expect(await b.count('water_logs'), 2);
    final ok = await a.db.select(a.db.syncSettings).getSingle();
    expect(ok.lastError, isNull);
    expect(ok.lastSyncAt, isNotNull);
  });

  test('last writer wins on conflicting edits; ties keep local', () async {
    final math = await a.study.addSubject(a.profileId, 'Math');
    final topic = await a.study.addTopic(a.profileId, math, 'Limits');
    await a.engine(remote).sync(a.profileId);
    await b.engine(remote).sync(b.profileId);
    final bTopic = (await b.db.select(b.db.syllabusTopics).getSingle()).id;
    expect(bTopic, topic);

    // Concurrent edits, B later than A.
    a.clock = t0.add(const Duration(minutes: 5));
    b.clock = t0.add(const Duration(minutes: 9));
    await a.study.setTopicStatus(a.profileId, topic, TopicStatus.inProgress);
    await b.study.setTopicStatus(b.profileId, topic, TopicStatus.completed);

    // A syncs first, then B (newer wins on the server), then A pulls it.
    await a.engine(remote).sync(a.profileId);
    await b.engine(remote).sync(b.profileId);
    await a.engine(remote).sync(a.profileId);
    for (final d in [a, b]) {
      final t = await d.db.select(d.db.syllabusTopics).getSingle();
      expect(t.status, 'completed', reason: 'newer edit wins everywhere');
    }

    // The older device cannot overwrite newer data even if it syncs last.
    a.clock = t0.add(const Duration(hours: 1));
    b.clock = t0.add(const Duration(hours: 2));
    await b.study.setTopicStatus(b.profileId, topic, TopicStatus.notStarted);
    await a.study.setTopicStatus(a.profileId, topic, TopicStatus.inProgress);
    await b.engine(remote).sync(b.profileId);
    await a.engine(remote).sync(a.profileId);
    await b.engine(remote).sync(b.profileId);
    for (final d in [a, b]) {
      final t = await d.db.select(d.db.syllabusTopics).getSingle();
      expect(t.status, 'notStarted');
    }

    // Tie: same second on both sides keeps the local value.
    a.clock = t0.add(const Duration(hours: 5));
    b.clock = t0.add(const Duration(hours: 5));
    await a.study.setTopicStatus(a.profileId, topic, TopicStatus.inProgress);
    await b.study.setTopicStatus(b.profileId, topic, TopicStatus.completed);
    await a.engine(remote).sync(a.profileId);
    await b.engine(remote).sync(b.profileId);
    expect((await b.db.select(b.db.syllabusTopics).getSingle()).status,
        'completed'); // B kept local on the tie
  });

  test('deletes propagate, cascade, and do not echo back', () async {
    final math = await a.study.addSubject(a.profileId, 'Math');
    await a.study.addTopic(a.profileId, math, 'Limits');
    await a.engine(remote).sync(a.profileId);
    await b.engine(remote).sync(b.profileId);
    expect(await b.count('subjects'), 1);

    a.clock = t0.add(const Duration(minutes: 30));
    await a.study.deleteSubject(a.profileId, math);
    expect(await a.count('sync_tombstones'), greaterThanOrEqualTo(2));
    await a.engine(remote).sync(a.profileId);
    expect(await a.count('sync_tombstones'), 0); // acknowledged

    await b.engine(remote).sync(b.profileId);
    expect(await b.count('subjects'), 0);
    expect(await b.count('syllabus_topics'), 0);
    expect(await b.count('sync_tombstones'), 0, reason: 'no echo');
  });

  test('an edit newer than a delete resurrects the row', () async {
    final math = await a.study.addSubject(a.profileId, 'Math');
    final topic = await a.study.addTopic(a.profileId, math, 'Limits');
    await a.engine(remote).sync(a.profileId);
    await b.engine(remote).sync(b.profileId);

    a.clock = t0.add(const Duration(minutes: 10));
    await a.study.deleteTopic(a.profileId, topic);
    b.clock = DateTime.now().add(const Duration(hours: 1)); // later than the delete
    await b.study.setTopicStatus(b.profileId, topic, TopicStatus.completed);

    await a.engine(remote).sync(a.profileId); // pushes the tombstone
    await b.engine(remote).sync(b.profileId); // keeps its newer edit, pushes it
    expect(await b.count('syllabus_topics'), 1);
    await a.engine(remote).sync(a.profileId);
    final back = await a.db.select(a.db.syllabusTopics).getSingle();
    expect(back.status, 'completed');
  });

  test('a delete newer than an edit removes the row everywhere', () async {
    final math = await a.study.addSubject(a.profileId, 'Math');
    final topic = await a.study.addTopic(a.profileId, math, 'Limits');
    await a.engine(remote).sync(a.profileId);
    await b.engine(remote).sync(b.profileId);

    b.clock = t0.add(const Duration(minutes: 10));
    await b.study.setTopicStatus(b.profileId, topic, TopicStatus.completed);
    a.clock = t0.add(const Duration(minutes: 20)); // delete is later
    await a.study.deleteTopic(a.profileId, topic);

    await a.engine(remote).sync(a.profileId);
    await b.engine(remote).sync(b.profileId);
    expect(await b.count('syllabus_topics'), 0);
    expect(await a.count('syllabus_topics'), 0);
  });

  test('append-only rows converge to the union', () async {
    await a.fitness.addWater(a.profileId, 100);
    await b.fitness.addWater(b.profileId, 200);
    for (var i = 0; i < 2; i++) {
      await a.engine(remote).sync(a.profileId);
      await b.engine(remote).sync(b.profileId);
    }
    for (final d in [a, b]) {
      final ml = (await d.db.select(d.db.waterLogs).get())
          .map((w) => w.amountMl)
          .toList()
        ..sort();
      expect(ml, [100, 200]);
    }
  });

  test('large datasets are paged', () async {
    await a.db.batch((batch) {
      for (var i = 0; i < 450; i++) {
        batch.insert(
            a.db.waterLogs,
            WaterLogsCompanion.insert(
                id: 'w$i',
                profileId: a.profileId,
                amountMl: 100 + i % 5,
                loggedAt: t0,
                createdAt: t0));
      }
    });
    await a.engine(remote).sync(a.profileId);
    expect(remote.all.where((r) => r.table == 'water_logs'), hasLength(450));
    await b.engine(remote).sync(b.profileId);
    expect(await b.count('water_logs'), 450);
  });

  test('disabled sync refuses to run and nothing leaves the device', () async {
    final off = await Device.create(t0, enabled: false);
    addTearDown(off.db.close);
    await off.study.addSubject(off.profileId, 'Secret');
    await expectLater(off.engine(remote).sync(off.profileId),
        throwsA(isA<SyncException>().having((e) => e.code, 'code', 'disabled')));
    expect(remote.length, 0);
    expect(remote.pushCalls, 0);
  });

  test('another account never sees these records', () async {
    await a.study.addSubject(a.profileId, 'Mine');
    await a.engine(remote).sync(a.profileId);
    final otherRemote = InMemoryRemote(); // a different user's server space
    await b.engine(otherRemote).sync(b.profileId);
    expect(await b.count('subjects'), 0);
  });

  test('invalid or hostile remote records are skipped, not applied',
      () async {
    final updated = DateTime.utc(2024, 5, 10, 12);
    await remote.push([
      RemoteRecord(
          table: 'subjects',
          rowId: 'x1',
          updatedAt: updated,
          data: {
            'id': 'x1',
            'profile_id': '@profile',
            'name': 'ok',
            'created_at': 1715342400,
            'updated_at': 1715342400,
            'evil_column': 'x'
          }),
      RemoteRecord(
          table: 'sqlite_master',
          rowId: 'x',
          updatedAt: updated,
          data: {'name': 'x'}),
      RemoteRecord(
          table: 'syllabus_topics',
          rowId: 't1',
          updatedAt: updated,
          data: {
            'id': 't1',
            'profile_id': '@profile',
            'subject_id': 'no-such-subject',
            'title': 'orphan',
            'created_at': 1715342400,
            'updated_at': 1715342400,
          }),
    ]);
    final result = await b.engine(remote).sync(b.profileId);
    expect(result.skipped, 3);
    expect(await b.count('subjects'), 0);
    expect(await b.count('syllabus_topics'), 0);
  });

  test('profile switching: syncing one profile does not touch another',
      () async {
    final other = await ProfileRepository(b.db)
        .createProfile(const NewProfile(displayName: 'Other'));
    await a.study.addSubject(a.profileId, 'Math');
    await a.engine(remote).sync(a.profileId);
    await b.engine(remote).sync(b.profileId);
    final otherSubjects = await (b.db.select(b.db.subjects)
          ..where((s) => s.profileId.equals(other)))
        .get();
    expect(otherSubjects, isEmpty);
  });
}
