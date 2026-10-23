import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nuvora/features/auth/cloud_auth.dart';
import 'package:nuvora/features/sync/cloud_config.dart';
import 'package:nuvora/features/sync/remote.dart';
import 'package:nuvora/features/sync/supabase_remote.dart';

const config = CloudConfig(url: 'https://example.supabase.co', anonKey: 'anon-key');

http.Response json(Object body, [int status = 200]) => http.Response(
    jsonEncode(body), status,
    headers: {'content-type': 'application/json'});

Map<String, Object?> tokenBody({String access = 'access1', String refresh = 'refresh1'}) => {
      'access_token': access,
      'refresh_token': refresh,
      'expires_in': 3600,
      'user': {'id': 'user-1', 'email': 'amina@example.com'},
    };

void main() {
  var now = DateTime(2024, 5, 10, 9, 0);
  late MemorySessionStore store;

  setUp(() {
    now = DateTime(2024, 5, 10, 9, 0);
    store = MemorySessionStore();
  });

  CloudAuth auth(MockClient c, {CloudConfig cfg = config}) =>
      CloudAuth(cfg, store, client: c, clock: () => now);

  group('CloudAuth', () {
    test('refuses to run when cloud is not configured', () async {
      final a = auth(MockClient((_) async => json({})),
          cfg: const CloudConfig(url: '', anonKey: ''));
      await expectLater(a.signIn('a@b.c', 'pw'),
          throwsA(isA<AuthFailure>().having((e) => e.code, 'code', 'not_configured')));
    });

    test('sign in sends credentials once and stores only tokens', () async {
      late http.Request seen;
      final a = auth(MockClient((req) async {
        seen = req;
        return json(tokenBody());
      }));
      final s = await a.signIn('amina@example.com', 'correct horse');
      expect(s.userId, 'user-1');
      expect(seen.url.path, '/auth/v1/token');
      expect(seen.url.queryParameters['grant_type'], 'password');
      expect(seen.headers['apikey'], 'anon-key');
      final saved = await store.read();
      expect(saved, isNotNull);
      expect(saved!.contains('correct horse'), isFalse,
          reason: 'the password must never be stored');
      expect((await a.currentSession())!.accessToken, 'access1');
    });

    test('maps provider errors to safe codes', () async {
      Future<String> code(int status, Map<String, Object?> body,
          {bool signUp = false}) async {
        final a = auth(MockClient((_) async => json(body, status)));
        try {
          if (signUp) {
            await a.signUp('a@b.c', 'pw');
          } else {
            await a.signIn('a@b.c', 'pw');
          }
        } on AuthFailure catch (e) {
          return e.code;
        }
        return 'ok';
      }

      expect(await code(400, {'error_code': 'invalid_credentials', 'msg': 'Invalid login credentials'}),
          'invalid_credentials');
      expect(await code(400, {'error_code': 'email_not_confirmed', 'msg': 'Email not confirmed'}),
          'email_not_verified');
      expect(await code(429, {'msg': 'slow down'}), 'rate_limited');
      expect(await code(500, {'msg': 'boom'}), 'server');
      expect(await code(422, {'error_code': 'weak_password', 'msg': 'Password should be at least 6 characters'}, signUp: true),
          'weak_password');
      expect(await code(422, {'error_code': 'user_already_exists', 'msg': 'User already registered'}, signUp: true),
          'email_taken');
    });

    test('sign up reports when email verification is required', () async {
      final needsVerify = auth(MockClient((_) async =>
          json({'id': 'u', 'email': 'a@b.c', 'confirmation_sent_at': 'x'})));
      expect(await needsVerify.signUp('a@b.c', 'long-enough-pw'),
          SignUpOutcome.verifyEmail);
      expect(await store.read(), isNull, reason: 'no session before verification');

      final immediate = auth(MockClient((_) async => json(tokenBody())));
      expect(await immediate.signUp('a@b.c', 'long-enough-pw'),
          SignUpOutcome.signedIn);
    });

    test('password reset asks the provider to send the email', () async {
      late http.Request seen;
      final a = auth(MockClient((req) async {
        seen = req;
        return json({});
      }));
      await a.requestPasswordReset('amina@example.com');
      expect(seen.url.path, '/auth/v1/recover');
      expect(jsonDecode(seen.body), {'email': 'amina@example.com'});
    });

    test('an expired session is refreshed with the rotated token; a rejected refresh signs out',
        () async {
      final refreshTokensSeen = <String>[];
      var step = 0;
      final a = auth(MockClient((req) async {
        step++;
        if (req.url.queryParameters['grant_type'] == 'password') {
          return json(tokenBody());
        }
        // refresh
        refreshTokensSeen.add((jsonDecode(req.body) as Map)['refresh_token'] as String);
        return step == 2
            ? json(tokenBody(access: 'access2', refresh: 'refresh2'))
            : json({'error': 'invalid_grant'}, 400);
      }));
      await a.signIn('amina@example.com', 'pw');
      now = now.add(const Duration(hours: 2));
      expect((await a.currentSession())!.accessToken, 'access2');

      now = now.add(const Duration(hours: 2));
      expect(await a.currentSession(), isNull);
      expect(refreshTokensSeen, ['refresh1', 'refresh2']);
      expect(await store.read(), isNull, reason: 'dead session is forgotten');
    });

    test('network failures are reported as offline', () async {
      final a = auth(MockClient((_) async => throw http.ClientException('x')));
      await expectLater(a.signIn('a@b.c', 'pw'),
          throwsA(isA<AuthFailure>().having((e) => e.code, 'code', 'offline')));
    });

    test('sign out clears local state even when offline', () async {
      var offline = false;
      final a = auth(MockClient((_) async {
        if (offline) throw http.ClientException('down');
        return json(tokenBody());
      }));
      await a.signIn('amina@example.com', 'pw');
      offline = true;
      await a.signOut();
      expect(await store.read(), isNull);
      expect(await a.currentSession(), isNull);
    });

    test('a corrupt stored session is discarded', () async {
      await store.write('not json');
      expect(await auth(MockClient((_) async => json({}))).currentSession(), isNull);
      expect(await store.read(), isNull);
    });
  });

  group('SupabaseRemote', () {
    Future<(CloudAuth, List<http.Request>)> signedIn(
        http.Response Function(http.Request) handler) async {
      final seen = <http.Request>[];
      late CloudAuth a;
      final client = MockClient((req) async {
        if (req.url.path.startsWith('/auth/v1/')) {
          return json(tokenBody(access: 'fresh', refresh: 'r2'));
        }
        seen.add(req);
        return handler(req);
      });
      a = CloudAuth(config, store, client: client, clock: () => now);
      await a.signIn('amina@example.com', 'pw');
      seen.clear();
      return (a, seen);
    }

    test('push sends an authorized rpc call with tombstones as deleted',
        () async {
      final (a, seen) = await signedIn((_) => json({}, 204));
      final remote = SupabaseRemote(config, a,
          client: MockClient((req) async {
            seen.add(req);
            return http.Response('', 204);
          }));
      await remote.push([
        RemoteRecord(
            table: 'subjects',
            rowId: 's1',
            updatedAt: DateTime.utc(2024, 5, 10, 9),
            data: {'id': 's1', 'name': 'Math'}),
        RemoteRecord(
            table: 'subjects',
            rowId: 's2',
            updatedAt: DateTime.utc(2024, 5, 10, 10)),
      ]);
      final req = seen.single;
      expect(req.url.path, '/rest/v1/rpc/push_sync_records');
      expect(req.headers['Authorization'], 'Bearer fresh');
      expect(req.headers['apikey'], 'anon-key');
      final body = jsonDecode(req.body) as Map<String, dynamic>;
      final recs = body['records'] as List;
      expect(recs[0]['deleted'], false);
      expect(recs[1]['deleted'], true);
      expect(recs[1]['data'], isNull);
      expect(recs[0]['updated_at'], '2024-05-10T09:00:00.000Z');
    });

    test('pull parses rows and uses the sequence cursor', () async {
      final (a, _) = await signedIn((_) => json({}));
      late http.Request seen;
      final remote = SupabaseRemote(config, a,
          client: MockClient((req) async {
            seen = req;
            return json([
              {
                'table_name': 'subjects',
                'row_id': 's1',
                'data': {'id': 's1'},
                'deleted': false,
                'updated_at': '2024-05-10T09:00:00+00:00',
                'seq': 7
              },
              {
                'table_name': 'subjects',
                'row_id': 's2',
                'data': null,
                'deleted': true,
                'updated_at': '2024-05-10T09:30:00+00:00',
                'seq': 9
              },
            ]);
          }));
      final page = await remote.pull(5, limit: 50);
      expect(seen.url.queryParameters['seq'], 'gt.5');
      expect(seen.url.queryParameters['order'], 'seq.asc');
      expect(seen.url.queryParameters['limit'], '50');
      expect(page.lastSeq, 9);
      expect(page.records.first.data, {'id': 's1'});
      expect(page.records.last.isDeleted, isTrue);
    });

    test('malformed server responses are rejected, not applied', () async {
      final (a, _) = await signedIn((_) => json({}));
      final remote = SupabaseRemote(config, a,
          client: MockClient((_) async => json([
                {'table_name': 1}
              ])));
      await expectLater(remote.pull(0),
          throwsA(isA<SyncException>().having((e) => e.code, 'code', 'invalid_response')));
    });

    test('a 401 triggers one refresh and retry, then gives up', () async {
      final (a, _) = await signedIn((_) => json({}));
      var calls = 0;
      final tokens = <String?>[];
      final remote = SupabaseRemote(config, a,
          client: MockClient((req) async {
            calls++;
            tokens.add(req.headers['Authorization']);
            return calls == 1 ? http.Response('', 401) : json([]);
          }));
      await remote.pull(0);
      expect(calls, 2);

      calls = 0;
      final stubborn = SupabaseRemote(config, a,
          client: MockClient((_) async {
            calls++;
            return http.Response('', 401);
          }));
      await expectLater(stubborn.pull(0),
          throwsA(isA<SyncException>().having((e) => e.code, 'code', 'unauthorized')));
      expect(calls, 2);
    });

    test('signed-out and offline states produce safe errors', () async {
      final signedOut = SupabaseRemote(
          config, CloudAuth(config, MemorySessionStore(), client: MockClient((_) async => json({}))),
          client: MockClient((_) async => json([])));
      await expectLater(signedOut.pull(0),
          throwsA(isA<SyncException>().having((e) => e.code, 'code', 'unauthorized')));

      final (a, _) = await signedIn((_) => json({}));
      final offline = SupabaseRemote(config, a,
          client: MockClient((_) async => throw http.ClientException('down')));
      await expectLater(offline.pull(0),
          throwsA(isA<SyncException>().having((e) => e.code, 'code', 'offline')));
    });
  });

  test('no service-role or provider secret appears in app code', () {
    final forbidden = [
      RegExp('service_role', caseSensitive: false),
      RegExp('SERVICE_ROLE'),
      RegExp(r'sk-[A-Za-z0-9]{20,}'),
      RegExp(r'eyJ[A-Za-z0-9_-]{30,}\.'), // JWT-looking literals
    ];
    final offenders = <String>[];
    for (final f in Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart') && !f.path.endsWith('.g.dart'))) {
      final text = f.readAsStringSync();
      for (final re in forbidden) {
        // Comments that merely warn about the key are allowed.
        final code = text
            .split('\n')
            .where((l) => !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
            .join('\n');
        if (re.hasMatch(code)) offenders.add('${f.path}: ${re.pattern}');
      }
    }
    expect(offenders, isEmpty);
  });
}
