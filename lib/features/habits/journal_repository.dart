import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../data/database.dart';
import '../prayer/prayer_streaks.dart' show dayKey;

/// Journal storage. Content is never logged or transmitted from here.
class JournalRepository {
  JournalRepository(this._db, {DateTime Function()? clock})
      : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _now;
  static const _uuid = Uuid();

  /// Creates or updates the entry for [day]. Saving four empty answers
  /// removes the entry instead of keeping a blank one.
  Future<void> save(
    String profileId,
    DateTime day, {
    String wentWell = '',
    String learned = '',
    String improve = '',
    String grateful = '',
  }) async {
    final key = dayKey(day);
    final blank = [wentWell, learned, improve, grateful]
        .every((s) => s.trim().isEmpty);
    final existing = await (_db.select(_db.journalEntries)
          ..where((e) => e.profileId.equals(profileId) & e.day.equals(key)))
        .getSingleOrNull();
    if (blank) {
      if (existing != null) await delete(profileId, existing.id);
      return;
    }
    final now = _now();
    if (existing == null) {
      await _db.into(_db.journalEntries).insert(JournalEntriesCompanion.insert(
            id: _uuid.v4(),
            profileId: profileId,
            day: key,
            wentWell: Value(wentWell.trim()),
            learned: Value(learned.trim()),
            improve: Value(improve.trim()),
            grateful: Value(grateful.trim()),
            createdAt: now,
            updatedAt: now,
          ));
    } else {
      await (_db.update(_db.journalEntries)
            ..where((e) => e.id.equals(existing.id)))
          .write(JournalEntriesCompanion(
        wentWell: Value(wentWell.trim()),
        learned: Value(learned.trim()),
        improve: Value(improve.trim()),
        grateful: Value(grateful.trim()),
        updatedAt: Value(now),
      ));
    }
  }

  Future<void> delete(String profileId, String id) =>
      (_db.delete(_db.journalEntries)
            ..where((e) => e.id.equals(id) & e.profileId.equals(profileId)))
          .go();

  Future<JournalEntry?> forDay(String profileId, DateTime day) =>
      (_db.select(_db.journalEntries)
            ..where((e) =>
                e.profileId.equals(profileId) & e.day.equals(dayKey(day))))
          .getSingleOrNull();

  /// Newest first. A non-empty [query] matches any of the four answers,
  /// case-insensitively.
  Stream<List<JournalEntry>> watch(String profileId, {String query = ''}) {
    final q = query.trim();
    final select = _db.select(_db.journalEntries)
      ..where((e) {
        final mine = e.profileId.equals(profileId);
        if (q.isEmpty) return mine;
        final pattern = '%${_escape(q)}%';
        return mine &
            (e.wentWell.like(pattern, escapeChar: r'\') |
                e.learned.like(pattern, escapeChar: r'\') |
                e.improve.like(pattern, escapeChar: r'\') |
                e.grateful.like(pattern, escapeChar: r'\'));
      })
      ..orderBy([(e) => OrderingTerm.desc(e.day)]);
    return select.watch();
  }

  static String _escape(String s) => s
      .replaceAll(r'\', r'\\')
      .replaceAll('%', r'\%')
      .replaceAll('_', r'\_');
}
