import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../sync/cloud_config.dart';

class CloudSession {
  const CloudSession({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    required this.userId,
    required this.email,
  });

  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;
  final String userId;
  final String email;

  bool isExpired(DateTime now) =>
      !now.isBefore(expiresAt.subtract(const Duration(seconds: 30)));

  Map<String, Object?> toJson() => {
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'expires_at': expiresAt.millisecondsSinceEpoch,
        'user_id': userId,
        'email': email,
      };

  static CloudSession? fromJson(Map<String, dynamic> j) {
    final access = j['access_token'];
    final refresh = j['refresh_token'];
    final exp = j['expires_at'];
    final uid = j['user_id'];
    final email = j['email'];
    if (access is! String ||
        refresh is! String ||
        exp is! int ||
        uid is! String ||
        email is! String) {
      return null;
    }
    return CloudSession(
      accessToken: access,
      refreshToken: refresh,
      expiresAt: DateTime.fromMillisecondsSinceEpoch(exp),
      userId: uid,
      email: email,
    );
  }
}

/// Failure reasons are codes the UI maps to friendly, localized text. Server
/// messages are never shown verbatim and passwords are never included.
class AuthFailure implements Exception {
  const AuthFailure(this.code);

  /// `invalid_credentials`, `email_not_verified`, `weak_password`,
  /// `email_taken`, `rate_limited`, `offline`, `not_configured`, `server`.
  final String code;

  @override
  String toString() => 'AuthFailure($code)';
}

enum SignUpOutcome { signedIn, verifyEmail }

/// Where tokens are kept between launches. The production implementation
/// uses platform secure storage (Android Keystore-backed).
abstract class SessionStore {
  Future<String?> read();
  Future<void> write(String value);
  Future<void> clear();
}

class MemorySessionStore implements SessionStore {
  String? _value;
  @override
  Future<String?> read() async => _value;
  @override
  Future<void> write(String value) async => _value = value;
  @override
  Future<void> clear() async => _value = null;
}

/// Email and password authentication against Supabase Auth (GoTrue) over
/// HTTPS. Password handling is delegated entirely to the provider: this class
/// forwards the password once and never stores or logs it.
class CloudAuth {
  CloudAuth(this._config, this._store, {http.Client? client, DateTime Function()? clock})
      : _http = client ?? http.Client(),
        _now = clock ?? DateTime.now;

  final CloudConfig _config;
  final SessionStore _store;
  final http.Client _http;
  final DateTime Function() _now;
  CloudSession? _session;

  Map<String, String> get _headers => {
        'apikey': _config.anonKey,
        'Content-Type': 'application/json',
      };

  /// The saved session, refreshed if it has expired. Null when signed out or
  /// when the refresh token is no longer accepted.
  Future<CloudSession?> currentSession() async {
    var s = _session;
    if (s == null) {
      final raw = await _store.read();
      if (raw == null) return null;
      try {
        s = CloudSession.fromJson(jsonDecode(raw) as Map<String, dynamic>);
      } catch (_) {
        s = null;
      }
      if (s == null) {
        await _store.clear();
        return null;
      }
      _session = s;
    }
    if (s.isExpired(_now())) return refresh();
    return s;
  }

  Future<CloudSession?> refresh() async {
    final s = _session;
    if (s == null) return null;
    final res = await _post('/auth/v1/token', {'refresh_token': s.refreshToken},
        query: {'grant_type': 'refresh_token'});
    if (res.statusCode == 200) {
      return _save(jsonDecode(res.body) as Map<String, dynamic>, s.email);
    }
    if (res.statusCode == 400 || res.statusCode == 401) {
      // The refresh token is no longer valid: sign the user out locally.
      await _forget();
      return null;
    }
    throw const AuthFailure('server');
  }

  Future<CloudSession> signIn(String email, String password) async {
    final res = await _post('/auth/v1/token', {'email': email, 'password': password},
        query: {'grant_type': 'password'});
    if (res.statusCode == 200) {
      return _save(jsonDecode(res.body) as Map<String, dynamic>, email);
    }
    throw _failure(res);
  }

  Future<SignUpOutcome> signUp(String email, String password) async {
    final res = await _post('/auth/v1/signup', {'email': email, 'password': password});
    if (res.statusCode == 200 || res.statusCode == 201) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      if (body['access_token'] is String) {
        _save(body, email);
        return SignUpOutcome.signedIn;
      }
      // With email confirmation enabled no session is issued until the user
      // clicks the link in the verification email.
      return SignUpOutcome.verifyEmail;
    }
    throw _failure(res);
  }

  /// Asks the provider to email a password reset link.
  Future<void> requestPasswordReset(String email) async {
    final res = await _post('/auth/v1/recover', {'email': email});
    if (res.statusCode != 200) throw _failure(res);
  }

  Future<void> signOut() async {
    final s = _session;
    try {
      if (s != null) {
        await _http
            .post(_config.endpoint('/auth/v1/logout'),
                headers: {..._headers, 'Authorization': 'Bearer ${s.accessToken}'})
            .timeout(const Duration(seconds: 10));
      }
    } catch (_) {
      // Signing out locally must always succeed, even when offline.
    }
    await _forget();
  }

  Future<void> _forget() async {
    _session = null;
    await _store.clear();
  }

  Future<CloudSession> _save(Map<String, dynamic> body, String fallbackEmail) async {
    final access = body['access_token'] as String;
    final refresh = body['refresh_token'] as String;
    final expiresIn = (body['expires_in'] as num?)?.toInt() ?? 3600;
    final user = (body['user'] as Map<String, dynamic>?) ?? const {};
    final session = CloudSession(
      accessToken: access,
      refreshToken: refresh,
      expiresAt: _now().add(Duration(seconds: expiresIn)),
      userId: (user['id'] as String?) ?? _session?.userId ?? '',
      email: (user['email'] as String?) ?? fallbackEmail,
    );
    _session = session;
    await _store.write(jsonEncode(session.toJson()));
    return session;
  }

  Future<http.Response> _post(String path, Map<String, Object?> body,
      {Map<String, String>? query}) async {
    if (!_config.isConfigured) throw const AuthFailure('not_configured');
    try {
      return await _http
          .post(_config.endpoint(path, query),
              headers: _headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: 20));
    } on TimeoutException {
      throw const AuthFailure('offline');
    } on http.ClientException {
      throw const AuthFailure('offline');
    }
  }

  AuthFailure _failure(http.Response res) {
    String text = '';
    try {
      final j = jsonDecode(res.body);
      if (j is Map) {
        text = '${j['error_code'] ?? ''} ${j['msg'] ?? j['error_description'] ?? j['message'] ?? ''}'
            .toLowerCase();
      }
    } catch (_) {}
    if (res.statusCode == 429) return const AuthFailure('rate_limited');
    if (text.contains('email_not_confirmed') || text.contains('not confirmed')) {
      return const AuthFailure('email_not_verified');
    }
    if (text.contains('weak_password') || text.contains('password should')) {
      return const AuthFailure('weak_password');
    }
    if (text.contains('already') || text.contains('user_already_exists')) {
      return const AuthFailure('email_taken');
    }
    if (res.statusCode == 400 || res.statusCode == 401 || res.statusCode == 422) {
      return const AuthFailure('invalid_credentials');
    }
    return const AuthFailure('server');
  }
}
