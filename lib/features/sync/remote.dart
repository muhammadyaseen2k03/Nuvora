/// One synced row as stored on the server.
class RemoteRecord {
  const RemoteRecord({
    required this.table,
    required this.rowId,
    required this.updatedAt,
    this.data,
    this.seq = 0,
  });

  final String table;

  /// Row key. `@profile` for one-row-per-profile tables.
  final String rowId;

  /// Client-side change time of the row (or the deletion time). Used to
  /// resolve conflicts; never trusted for ordering pulls.
  final DateTime updatedAt;

  /// Column values with the profile id replaced by `@profile`. Null means the
  /// row was deleted (a tombstone).
  final Map<String, Object?>? data;

  /// Server-assigned, strictly increasing sequence number.
  final int seq;

  bool get isDeleted => data == null;
}

class RemotePage {
  const RemotePage(this.records, this.lastSeq);
  final List<RemoteRecord> records;

  /// Highest sequence number covered by this page (the next cursor).
  final int lastSeq;
}

class SyncException implements Exception {
  const SyncException(this.code, [this.detail]);

  /// `offline`, `unauthorized`, `server`, `disabled`, `invalid_response`.
  final String code;
  final String? detail;

  @override
  String toString() => 'SyncException($code${detail == null ? '' : ': $detail'})';
}

/// The server side of sync. Implementations: [InMemoryRemote] (tests) and
/// `SupabaseRemote` (PostgREST over HTTPS, authorized per user by RLS).
abstract class SyncRemote {
  /// Idempotent upsert. The server keeps an incoming record only when its
  /// `updatedAt` is newer than or equal to the stored one, so an old device
  /// can never overwrite newer data.
  Future<void> push(List<RemoteRecord> records);

  /// Records with `seq > afterSeq`, ordered by `seq`, at most [limit].
  Future<RemotePage> pull(int afterSeq, {int limit = 200});
}

/// A faithful in-memory stand-in for the server rules, used by tests.
class InMemoryRemote implements SyncRemote {
  final Map<String, RemoteRecord> _rows = {};
  int _seq = 0;

  /// Makes the next [push] calls throw, to test retries.
  int failNextPushes = 0;
  int pushCalls = 0;

  int get length => _rows.length;
  Iterable<RemoteRecord> get all => _rows.values;
  RemoteRecord? get(String table, String rowId) => _rows['$table/$rowId'];

  @override
  Future<void> push(List<RemoteRecord> records) async {
    pushCalls++;
    if (failNextPushes > 0) {
      failNextPushes--;
      throw const SyncException('offline');
    }
    for (final r in records) {
      final key = '${r.table}/${r.rowId}';
      final existing = _rows[key];
      if (existing != null && r.updatedAt.isBefore(existing.updatedAt)) {
        continue; // never overwrite newer data
      }
      _rows[key] = RemoteRecord(
        table: r.table,
        rowId: r.rowId,
        updatedAt: r.updatedAt,
        data: r.data,
        seq: ++_seq,
      );
    }
  }

  @override
  Future<RemotePage> pull(int afterSeq, {int limit = 200}) async {
    final list = _rows.values.where((r) => r.seq > afterSeq).toList()
      ..sort((a, b) => a.seq.compareTo(b.seq));
    final page = list.take(limit).toList();
    return RemotePage(page, page.isEmpty ? afterSeq : page.last.seq);
  }
}
