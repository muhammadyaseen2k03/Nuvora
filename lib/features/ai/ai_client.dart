import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../auth/cloud_auth.dart';
import '../sync/cloud_config.dart';
import 'ai_models.dart';

/// Talks to the AI backend. The app never holds a provider key: requests go
/// to a server-side function (`backend/supabase/functions/ai`) that
/// authenticates the user, enforces quotas and calls the provider.
abstract class AiClient {
  Future<AiReply> send(AiRequest request);
}

class SupabaseAiClient implements AiClient {
  SupabaseAiClient(this._config, this._auth, {http.Client? client})
      : _http = client ?? http.Client();

  final CloudConfig _config;
  final CloudAuth _auth;
  final http.Client _http;

  static const _timeout = Duration(seconds: 45);

  @override
  Future<AiReply> send(AiRequest request) async {
    if (!_config.isConfigured) throw const AiException('not_configured');
    var session = await _auth.currentSession();
    if (session == null) throw const AiException('unauthorized');

    final body = jsonEncode({
      'kind': request.kind.name,
      if (request.text != null) 'text': request.text,
      'context': request.context,
    });

    for (var attempt = 0; attempt < 2; attempt++) {
      final http.Response res;
      try {
        res = await _http
            .post(
              _config.endpoint('/functions/v1/ai'),
              headers: {
                'apikey': _config.anonKey,
                'Authorization': 'Bearer ${session!.accessToken}',
                'Content-Type': 'application/json',
              },
              body: body,
            )
            .timeout(_timeout);
      } on TimeoutException {
        throw const AiException('offline');
      } on http.ClientException {
        throw const AiException('offline');
      }
      switch (res.statusCode) {
        case 200:
          try {
            return AiReply.parse(request.kind, jsonDecode(res.body));
          } on FormatException {
            throw const AiException('invalid_response');
          }
        case 401:
          if (attempt == 0) {
            session = await _auth.refresh();
            if (session == null) throw const AiException('unauthorized');
            continue;
          }
          throw const AiException('unauthorized');
        case 413:
          throw const AiException('input_too_long');
        case 429:
          throw const AiException('rate_limited');
        default:
          throw const AiException('server');
      }
    }
    throw const AiException('unauthorized');
  }
}
