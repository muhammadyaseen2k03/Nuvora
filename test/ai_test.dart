import 'dart:convert';

import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nuvora/data/database.dart';
import 'package:nuvora/features/ai/ai_client.dart';
import 'package:nuvora/features/ai/ai_models.dart';
import 'package:nuvora/features/ai/ai_service.dart';
import 'package:nuvora/features/auth/cloud_auth.dart';
import 'package:nuvora/features/auth/profile_repository.dart';
import 'package:nuvora/features/fitness/fitness_repository.dart';
import 'package:nuvora/features/habits/journal_repository.dart';
import 'package:nuvora/features/insights/history_repository.dart';
import 'package:nuvora/features/insights/weekly_report.dart';
import 'package:nuvora/features/prayer/prayer_repository.dart';
import 'package:nuvora/features/prayer/prayer_service.dart';
import 'package:nuvora/features/prayer/prayer_streaks.dart';
import 'package:nuvora/features/study/study_repository.dart';
import 'package:nuvora/features/sync/cloud_config.dart';

class FakeAiClient implements AiClient {
  final List<AiRequest> requests = [];
  Object? error;
  AiReply reply = const AiReply(kind: AiKind.coach, text: 'Try a 25 minute session.');

  @override
  Future<AiReply> send(AiRequest request) async {
    requests.add(request);
    if (error != null) throw error!;
    return reply;
  }
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late AppDatabase db;
  late String a;
  late String b;
  late FakeAiClient client;
  var clock = DateTime(2024, 5, 10, 9, 0);
  late AiService service;

  setUp(() async {
    clock = DateTime(2024, 5, 10, 9, 0);
    db = AppDatabase(NativeDatabase.memory());
    final profiles = ProfileRepository(db);
    a = await profiles.createProfile(const NewProfile(displayName: 'Amina Private Name'));
    b = await profiles.createProfile(const NewProfile(displayName: 'B'));
    client = FakeAiClient();
    service = AiService(db, client, HistoryRepository(db, clock: () => clock),
        clock: () => clock, minInterval: const Duration(seconds: 3));
  });
  tearDown(() => db.close());

  group('consent', () {
    test('everything is off by default and nothing is sent', () async {
      final c = await service.consentFor(a);
      expect((c.enabled, c.study, c.fitness, c.prayer), (false, false, false, false));
      await expectLater(service.coach(a),
          throwsA(isA<AiException>().having((e) => e.code, 'code', 'consent_required')));
      await expectLater(service.studyTool(a, AiKind.summarize, 'my notes'),
          throwsA(isA<AiException>().having((e) => e.code, 'code', 'consent_required')));
      expect(client.requests, isEmpty);
    });

    test('consent is per profile and can be withdrawn', () async {
      await service.setConsent(a, enabled: true, study: true);
      expect((await service.consentFor(a)).enabled, isTrue);
      expect((await service.consentFor(b)).enabled, isFalse);
      await service.coach(a);
      expect(client.requests, hasLength(1));

      await service.setConsent(a, enabled: false);
      clock = clock.add(const Duration(minutes: 1));
      await expectLater(service.coach(a), throwsA(isA<AiException>()));
      expect(client.requests, hasLength(1));
    });
  });

  group('data minimisation', () {
    DayStats day(int i) => DayStats(
          day: DateTime(2024, 5, 4 + i),
          prayersCompleted: 5,
          prayersMissed: 1,
          studyMinutes: 30,
          studyBySubject: {'Math': 30},
          workouts: 1,
          waterMl: 2500,
        );

    test('only allowed categories appear, and only as aggregates', () {
      final days = [for (var i = 0; i < 7; i++) day(i)];
      const goals = WeeklyGoals();
      final none = buildCoachContext(
          consent: const AiConsent(enabled: true),
          days: days, goals: goals, fitnessLevel: 'beginner', workoutMinutes: 20);
      expect(none.keys, ['window_days']);

      final study = buildCoachContext(
          consent: const AiConsent(enabled: true, study: true),
          days: days, goals: goals, fitnessLevel: 'beginner', workoutMinutes: 20);
      expect(study.keys, containsAll(['window_days', 'study']));
      expect(study.containsKey('fitness'), isFalse);
      expect(study.containsKey('prayer'), isFalse);
      expect((study['study'] as Map)['minutes_total'], 210);

      final all = buildCoachContext(
          consent: const AiConsent(enabled: true, study: true, fitness: true, prayer: true),
          days: days, goals: goals, fitnessLevel: 'beginner', workoutMinutes: 20);
      expect((all['prayer'] as Map)['completed'], 35);
      expect((all['fitness'] as Map)['water_days_goal_met'], 7);
    });

    test('private content never reaches the AI client', () async {
      await service.setConsent(a,
          enabled: true, study: true, fitness: true, prayer: true);
      await JournalRepository(db, clock: () => clock)
          .save(a, clock, wentWell: 'SECRET JOURNAL TEXT');
      final study = StudyRepository(db, clock: () => clock);
      await study.addSubject(a, 'Math');
      await FitnessRepository(db, clock: () => clock).addWater(a, 500);
      await PrayerRepository(db, clock: () => clock)
          .setStatus(a, clock, PrayerName.fajr, PrayerStatus.onTime);

      await service.coach(a);
      final sent = jsonEncode({
        'text': client.requests.single.text,
        'context': client.requests.single.context,
      });
      expect(sent.contains('SECRET JOURNAL TEXT'), isFalse);
      expect(sent.contains('Amina Private Name'), isFalse);
      expect(sent.contains(a), isFalse, reason: 'no profile id');
      expect(client.requests.single.text, isNull);
    });

    test('study tools send only the text the user supplied', () async {
      await service.setConsent(a, enabled: true); // no categories needed
      await service.studyTool(a, AiKind.flashcards, '  Photosynthesis notes  ');
      final r = client.requests.single;
      expect(r.text, 'Photosynthesis notes');
      expect(r.context, isEmpty);
    });
  });

  group('input and rate limits', () {
    setUp(() => service.setConsent(a, enabled: true));

    test('empty and oversized input is rejected before sending', () async {
      await expectLater(service.studyTool(a, AiKind.summarize, '   '), throwsA(isA<AiException>()));
      await expectLater(
          service.studyTool(a, AiKind.summarize, 'x' * (AiService.maxInputChars + 1)),
          throwsA(isA<AiException>().having((e) => e.code, 'code', 'input_too_long')));
      expect(client.requests, isEmpty);
    });

    test('requests are spaced out', () async {
      await service.studyTool(a, AiKind.explain, 'one');
      await expectLater(service.studyTool(a, AiKind.explain, 'two'),
          throwsA(isA<AiException>().having((e) => e.code, 'code', 'too_soon')));
      clock = clock.add(const Duration(seconds: 4));
      await service.studyTool(a, AiKind.explain, 'two');
      expect(client.requests, hasLength(2));
    });

    test('provider failures propagate as safe codes and save no history',
        () async {
      client.error = const AiException('offline');
      await expectLater(service.coach(a),
          throwsA(isA<AiException>().having((e) => e.code, 'code', 'offline')));
      expect(await service.watchHistory(a).first, isEmpty);
    });
  });

  group('history', () {
    test('saved locally, isolated per profile, and clearable', () async {
      await service.setConsent(a, enabled: true);
      await service.setConsent(b, enabled: true);
      await service.coach(a);
      clock = clock.add(const Duration(minutes: 1));
      await service.coach(b);

      var h = await service.watchHistory(a).first;
      expect(h.map((m) => m.role), containsAll(['user', 'assistant']));
      expect(h.any((m) => m.body.contains('25 minute')), isTrue);
      expect((await service.watchHistory(b).first), hasLength(2));

      await service.clearHistory(a);
      expect(await service.watchHistory(a).first, isEmpty);
      expect(await service.watchHistory(b).first, hasLength(2));
    });

    test('history is not part of backups', () async {
      // AI messages are local-only by design: not in the table specs used
      // for backup or sync.
      final names = (await db.customSelect(
              "SELECT name FROM sqlite_master WHERE type='table' AND name='ai_messages'")
          .get());
      expect(names, hasLength(1));
    });
  });

  group('reply validation', () {
    test('accepts well-formed replies and trims oversize content', () {
      final r = AiReply.parse(AiKind.flashcards, {
        'text': 'Here are drafts',
        'cards': [
          {'front': ' Q1 ', 'back': ' A1 '},
          {'front': '', 'back': 'dropped'},
          {'front': 'x' * 900, 'back': 'y' * 2000},
        ],
      });
      expect(r.cards, hasLength(2));
      expect(r.cards.first.front, 'Q1');
      expect(r.cards.last.front.length, AiReply.maxFront);
      expect(r.cards.last.back.length, AiReply.maxBack);
    });

    test('caps the number of cards and the text length', () {
      final r = AiReply.parse(AiKind.flashcards, {
        'text': 'x' * 20000,
        'cards': [for (var i = 0; i < 50; i++) {'front': 'q$i', 'back': 'a$i'}],
      });
      expect(r.cards, hasLength(AiReply.maxCards));
      expect(r.text.length, AiReply.maxText);
    });

    test('malformed replies are rejected', () {
      for (final bad in <Object?>[
        null,
        'a string',
        <String, Object?>{},
        {'text': 5},
        {'text': 'ok', 'cards': 'nope'},
        {'cards': [1, 2]},
        {'cards': [{'front': 1, 'back': 'b'}]},
        {'text': '   '},
      ]) {
        expect(() => AiReply.parse(AiKind.explain, bad), throwsA(isA<AiException>()),
            reason: '$bad');
      }
    });
  });

  group('SupabaseAiClient', () {
    const config = CloudConfig(url: 'https://example.supabase.co', anonKey: 'anon');

    Future<CloudAuth> signedIn() async {
      final auth = CloudAuth(
        config,
        MemorySessionStore(),
        client: MockClient((_) async => http.Response(
            jsonEncode({
              'access_token': 'tok',
              'refresh_token': 'ref',
              'expires_in': 3600,
              'user': {'id': 'u', 'email': 'a@b.c'}
            }),
            200)),
      );
      await auth.signIn('a@b.c', 'pw');
      return auth;
    }

    Future<String> codeFor(int status, [Object? body]) async {
      final c = SupabaseAiClient(config, await signedIn(),
          client: MockClient((_) async => http.Response(jsonEncode(body ?? {}), status)));
      try {
        await c.send(const AiRequest(AiKind.explain, text: 'x'));
      } on AiException catch (e) {
        return e.code;
      }
      return 'ok';
    }

    test('sends an authorized request to the server function', () async {
      late http.Request seen;
      final c = SupabaseAiClient(config, await signedIn(),
          client: MockClient((req) async {
            seen = req;
            return http.Response(jsonEncode({'text': 'hi'}), 200);
          }));
      final reply = await c.send(const AiRequest(AiKind.explain, text: 'entropy'));
      expect(reply.text, 'hi');
      expect(seen.url.path, '/functions/v1/ai');
      expect(seen.headers['Authorization'], 'Bearer tok');
      final body = jsonDecode(seen.body) as Map<String, dynamic>;
      expect(body['kind'], 'explain');
      expect(body['text'], 'entropy');
      expect(body.containsKey('api_key'), isFalse);
    });

    test('maps failures to safe codes', () async {
      expect(await codeFor(429), 'rate_limited');
      expect(await codeFor(413), 'input_too_long');
      expect(await codeFor(500), 'server');
      expect(await codeFor(200, {'unexpected': true}), 'invalid_response');
    });

    test('requires configuration and a signed-in user', () async {
      final unconfigured = SupabaseAiClient(
          const CloudConfig(url: '', anonKey: ''),
          CloudAuth(const CloudConfig(url: '', anonKey: ''), MemorySessionStore()));
      await expectLater(unconfigured.send(const AiRequest(AiKind.explain, text: 'x')),
          throwsA(isA<AiException>().having((e) => e.code, 'code', 'not_configured')));
      final signedOut = SupabaseAiClient(
          config, CloudAuth(config, MemorySessionStore(),
              client: MockClient((_) async => http.Response('{}', 200))));
      await expectLater(signedOut.send(const AiRequest(AiKind.explain, text: 'x')),
          throwsA(isA<AiException>().having((e) => e.code, 'code', 'unauthorized')));
    });

    test('offline is reported without exposing details', () async {
      final c = SupabaseAiClient(config, await signedIn(),
          client: MockClient((_) async => throw http.ClientException('down')));
      await expectLater(c.send(const AiRequest(AiKind.explain, text: 'x')),
          throwsA(isA<AiException>().having((e) => e.code, 'code', 'offline')));
    });
  });
}
