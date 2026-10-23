import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

/// Derives a verifier for a local recovery answer with PBKDF2-HMAC-SHA256.
///
/// This only helps on the device that holds the profile. It is not an
/// identity check and offers no protection against someone with access to the
/// device storage who can brute-force a weak answer offline.
class RecoveryVerifier {
  static const iterations = 100000;
  static const _keyLength = 32;

  static String newSalt([Random? random]) {
    final r = random ?? Random.secure();
    return base64Encode(List<int>.generate(16, (_) => r.nextInt(256)));
  }

  static String normalize(String answer) =>
      answer.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');

  static String derive(String answer, String saltB64) {
    final key = pbkdf2(
      utf8.encode(normalize(answer)),
      base64Decode(saltB64),
      iterations,
      _keyLength,
    );
    return base64Encode(key);
  }

  static bool verify(String answer, String saltB64, String expectedHash) {
    final actual = derive(answer, saltB64);
    // Constant-time comparison.
    if (actual.length != expectedHash.length) return false;
    var diff = 0;
    for (var i = 0; i < actual.length; i++) {
      diff |= actual.codeUnitAt(i) ^ expectedHash.codeUnitAt(i);
    }
    return diff == 0;
  }

  @visibleForTesting
  static Uint8List pbkdf2(
      List<int> password, List<int> salt, int rounds, int length) {
    final hmac = Hmac(sha256, password);
    final blocks = (length / 32).ceil();
    final out = BytesBuilder();
    for (var block = 1; block <= blocks; block++) {
      var u = hmac.convert([...salt, 0, 0, 0, block]).bytes;
      final t = List<int>.from(u);
      for (var i = 1; i < rounds; i++) {
        u = hmac.convert(u).bytes;
        for (var j = 0; j < t.length; j++) {
          t[j] ^= u[j];
        }
      }
      out.add(t);
    }
    return Uint8List.fromList(out.toBytes().sublist(0, length));
  }
}
