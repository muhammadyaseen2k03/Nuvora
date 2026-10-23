import 'dart:async';

import 'package:http/http.dart' as http;

import '../auth/cloud_auth.dart';
import 'cloud_config.dart';

class AccountDeletionException implements Exception {
  const AccountDeletionException(this.code);

  /// `unauthorized`, `offline`, `server`, `not_configured`.
  final String code;

  @override
  String toString() => 'AccountDeletionException($code)';
}

/// Deletes the signed-in user's cloud account through the server-side
/// `delete-account` function (which holds the privileged key; the app never
/// does). Local data on this device is not touched.
class CloudAccountService {
  CloudAccountService(this._config, this._auth, {http.Client? client})
      : _http = client ?? http.Client();

  final CloudConfig _config;
  final CloudAuth _auth;
  final http.Client _http;

  Future<void> deleteAccount() async {
    if (!_config.isConfigured) {
      throw const AccountDeletionException('not_configured');
    }
    final session = await _auth.currentSession();
    if (session == null) throw const AccountDeletionException('unauthorized');
    final http.Response res;
    try {
      res = await _http.post(
        _config.endpoint('/functions/v1/delete-account'),
        headers: {
          'apikey': _config.anonKey,
          'Authorization': 'Bearer ${session.accessToken}',
          'Content-Type': 'application/json',
        },
        body: '{}',
      ).timeout(const Duration(seconds: 30));
    } on TimeoutException {
      throw const AccountDeletionException('offline');
    } on http.ClientException {
      throw const AccountDeletionException('offline');
    }
    if (res.statusCode == 401) throw const AccountDeletionException('unauthorized');
    if (res.statusCode != 200) throw const AccountDeletionException('server');
    await _auth.signOut();
  }
}
