import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../auth/cloud_auth.dart';
import 'cloud_config.dart';
import 'remote.dart';

/// [SyncRemote] backed by Supabase PostgREST over HTTPS.
///
/// Every request carries the signed-in user's access token. The database
/// enforces isolation with row-level security (see
/// `backend/supabase/migrations/0001_sync.sql`), so even a modified client
/// cannot read or write another user's rows. An expired token is refreshed
/// once; if that fails the sync stops with `unauthorized`.
class SupabaseRemote implements SyncRemote {
  SupabaseRemote(this._config, this._auth, {http.Client? client})
      : _http = client ?? http.Client();

  final CloudConfig _config;
  final CloudAuth _auth;
  final http.Client _http;

  static const _timeout = Duration(seconds: 30);

  @override
  Future<void> push(List<RemoteRecord> records) async {
    if (records.isEmpty) return;
    final payload = [
      for (final r in records)
        {
          'table_name': r.table,
          'row_id': r.rowId,
          'data': r.data,
          'deleted': r.isDeleted,
          'updated_at': r.updatedAt.toUtc().toIso8601String(),
        },
    ];
    final res = await _send(
      (token) => _http.post(
        _config.endpoint('/rest/v1/rpc/push_sync_records'),
        headers: _headers(token),
        body: jsonEncode({'records': payload}),
      ),
    );
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw SyncException('server', '${res.statusCode}');
    }
  }

  @override
  Future<RemotePage> pull(int afterSeq, {int limit = 200}) async {
    final res = await _send(
      (token) => _http.get(
        _config.endpoint('/rest/v1/sync_records', {
          'select': 'table_name,row_id,data,deleted,updated_at,seq',
          'seq': 'gt.$afterSeq',
          'order': 'seq.asc',
          'limit': '$limit',
        }),
        headers: _headers(token),
      ),
    );
    if (res.statusCode != 200) {
      throw SyncException('server', '${res.statusCode}');
    }
    final List<dynamic> rows;
    try {
      rows = jsonDecode(res.body) as List<dynamic>;
    } catch (_) {
      throw const SyncException('invalid_response');
    }
    final records = <RemoteRecord>[];
    var last = afterSeq;
    for (final row in rows) {
      if (row is! Map<String, dynamic>) {
        throw const SyncException('invalid_response');
      }
      final seq = row['seq'];
      final table = row['table_name'];
      final rowId = row['row_id'];
      final updated = row['updated_at'];
      if (seq is! int || table is! String || rowId is! String || updated is! String) {
        throw const SyncException('invalid_response');
      }
      final when = DateTime.tryParse(updated);
      if (when == null) throw const SyncException('invalid_response');
      final deleted = row['deleted'] == true;
      final data = row['data'];
      records.add(RemoteRecord(
        table: table,
        rowId: rowId,
        updatedAt: when.toUtc(),
        data: deleted || data is! Map<String, dynamic> ? null : data,
        seq: seq,
      ));
      if (seq > last) last = seq;
    }
    return RemotePage(records, last);
  }

  Map<String, String> _headers(String token) => {
        'apikey': _config.anonKey,
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

  Future<http.Response> _send(
      Future<http.Response> Function(String token) request) async {
    if (!_config.isConfigured) throw const SyncException('disabled');
    var session = await _auth.currentSession();
    if (session == null) throw const SyncException('unauthorized');
    for (var attempt = 0; attempt < 2; attempt++) {
      try {
        final res = await request(session!.accessToken).timeout(_timeout);
        if (res.statusCode == 401 && attempt == 0) {
          session = await _auth.refresh();
          if (session == null) throw const SyncException('unauthorized');
          continue;
        }
        if (res.statusCode == 401) throw const SyncException('unauthorized');
        return res;
      } on TimeoutException {
        throw const SyncException('offline');
      } on http.ClientException {
        throw const SyncException('offline');
      } on AuthFailure catch (e) {
        throw SyncException(e.code == 'offline' ? 'offline' : 'unauthorized');
      }
    }
    throw const SyncException('unauthorized');
  }
}
