import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nuvora/data/database.dart';
import 'package:nuvora/features/auth/cloud_auth.dart';
import 'package:nuvora/features/auth/profile_repository.dart';
import 'package:nuvora/features/study/study_repository.dart';
import 'package:nuvora/features/sync/cloud_account.dart';
import 'package:nuvora/features/sync/cloud_config.dart';
import 'package:nuvora/features/sync/sync_settings_repository.dart';

const config = CloudConfig(url: 'https://example.supabase.co', anonKey: 'anon-key');

http.Response json(Object body, [int status = 200]) =>
    http.Response(jsonEncode(body), status);

Future<CloudAuth> signedInAuth(http.Client apiClient, MemorySessionStore store) async {
  final auth = CloudAuth(
    config,
    store,
    client: MockClient((req) async => json({
          'access_token': 'tok',
          'refresh_token': 'ref',
          'expires_in': 3600,
          'user': {'id': 'u1', 'email': 'a@b.c'},
        })),
  );
  await auth.signIn('a@b.c', 'pw');
  return auth;
}

void main() {
  test('account deletion calls the server function with the user token',
      () async {
    final store = MemorySessionStore();
    final auth = await signedInAuth(MockClient((_) async => json({})), store);
    late http.Request seen;
    final svc = CloudAccountService(config, auth,
        client: MockClient((req) async {
          seen = req;
          return json({'ok': true});
        }));
    await svc.deleteAccount();
    expect(seen.url.path, '/functions/v1/delete-account');
    expect(seen.headers['Authorization'], 'Bearer tok');
    expect(seen.body, '{}', reason: 'no user id is sent; the server reads the JWT');
    expect(await store.read(), isNull, reason: 'signed out after deletion');
  });

  test('failures are reported and the session is kept', () async {
    Future<String> codeFor(http.Response res) async {
      final store = MemorySessionStore();
      final auth = await signedInAuth(MockClient((_) async => json({})), store);
      try {
        await CloudAccountService(config, auth,
            client: MockClient((_) async => res)).deleteAccount();
      } on AccountDeletionException catch (e) {
        expect(await store.read(), isNotNull);
        return e.code;
      }
      return 'ok';
    }

    expect(await codeFor(json({}, 401)), 'unauthorized');
    expect(await codeFor(json({}, 500)), 'server');

    final store = MemorySessionStore();
    final auth = await signedInAuth(MockClient((_) async => json({})), store);
    await expectLater(
        CloudAccountService(config, auth,
            client: MockClient((_) async => throw http.ClientException('x')))
            .deleteAccount(),
        throwsA(isA<AccountDeletionException>().having((e) => e.code, 'code', 'offline')));

    await expectLater(
        CloudAccountService(config, CloudAuth(config, MemorySessionStore()),
                client: MockClient((_) async => json({})))
            .deleteAccount(),
        throwsA(isA<AccountDeletionException>().having((e) => e.code, 'code', 'unauthorized')));
  });

  test('sync settings default to off and disabling keeps local data', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final id = await ProfileRepository(db)
        .createProfile(const NewProfile(displayName: 'A'));
    final repo = SyncSettingsRepository(db);
    expect(await repo.watch(id).first, isNull);

    await repo.update(id, enabled: true, study: true);
    var s = (await repo.watch(id).first)!;
    expect((s.enabled, s.syncStudy, s.syncPrayer, s.syncJournal, s.syncFitness),
        (true, true, false, false, false));

    await repo.linkCloudUser(id, 'cloud-1');
    expect((await ProfileRepository(db).getProfile(id))!.mode, 'cloud');

    // Create a deletion that has not been uploaded, then disable.
    final study = StudyRepository(db);
    final subject = await study.addSubject(id, 'Math');
    await study.deleteSubject(id, subject);
    expect(await repo.watchPendingDeletes(id).first, 1);

    await repo.disableAndReset(id);
    await repo.linkCloudUser(id, null);
    s = (await repo.watch(id).first)!;
    expect(s.enabled, isFalse);
    expect(await repo.watchPendingDeletes(id).first, 0);
    expect((await ProfileRepository(db).getProfile(id))!.mode, 'local');
    expect(await ProfileRepository(db).getProfile(id), isNotNull);
  });
}
