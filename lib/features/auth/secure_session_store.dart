import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'cloud_auth.dart';

/// Keeps the cloud session in platform secure storage (Android Keystore
/// backed). Tokens are never written to the app database, preferences or
/// backups.
class SecureSessionStore implements SessionStore {
  SecureSessionStore([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  static const _key = 'nuvora_cloud_session';

  @override
  Future<String?> read() async {
    try {
      return await _storage.read(key: _key);
    } catch (_) {
      return null; // unreadable storage is treated as signed out
    }
  }

  @override
  Future<void> write(String value) => _storage.write(key: _key, value: value);

  @override
  Future<void> clear() async {
    try {
      await _storage.delete(key: _key);
    } catch (_) {}
  }
}
