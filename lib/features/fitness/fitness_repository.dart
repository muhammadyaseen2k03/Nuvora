import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../data/database.dart';
import 'hydration.dart';

class FitnessRepository {
  FitnessRepository(this._db, {DateTime Function()? clock})
      : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _now;
  static const _uuid = Uuid();

  // --- Water ----------------------------------------------------------------

  Future<void> addWater(String profileId, int amountMl, {DateTime? at}) async {
    if (amountMl <= 0 || amountMl > 5000) {
      throw ArgumentError.value(amountMl, 'amountMl', 'must be 1..5000');
    }
    final now = _now();
    await _db.into(_db.waterLogs).insert(WaterLogsCompanion.insert(
          id: _uuid.v4(),
          profileId: profileId,
          amountMl: amountMl,
          loggedAt: at ?? now,
          createdAt: now,
        ));
  }

  Future<void> deleteWater(String profileId, String id) =>
      (_db.delete(_db.waterLogs)
            ..where((w) => w.id.equals(id) & w.profileId.equals(profileId)))
          .go();

  /// Removes the most recent log, for a quick undo.
  Future<void> undoLastWater(String profileId) async {
    final last = await (_db.select(_db.waterLogs)
          ..where((w) => w.profileId.equals(profileId))
          // Timestamps are stored with one-second resolution, so break ties
          // with insertion order (rowid).
          ..orderBy([
            (w) => OrderingTerm.desc(w.loggedAt),
            (w) => OrderingTerm.desc(const CustomExpression<int>('rowid')),
          ])
          ..limit(1))
        .getSingleOrNull();
    if (last != null) await deleteWater(profileId, last.id);
  }

  Stream<List<WaterLog>> watchWaterSince(String profileId, DateTime from) =>
      (_db.select(_db.waterLogs)
            ..where((w) =>
                w.profileId.equals(profileId) &
                w.loggedAt.isBiggerOrEqualValue(from))
            ..orderBy([(w) => OrderingTerm.desc(w.loggedAt)]))
          .watch();

  Future<void> setWaterGoal(String profileId, int goalMl) {
    if (goalMl < 250 || goalMl > 10000) {
      throw ArgumentError.value(goalMl, 'goalMl', 'must be 250..10000');
    }
    return (_db.update(_db.userPreferences)
          ..where((p) => p.profileId.equals(profileId)))
        .write(UserPreferencesCompanion(
            waterGoalMl: Value(goalMl), updatedAt: Value(_now())));
  }

  /// Daily totals for the [days] days ending on [end] (oldest first).
  static List<({DateTime day, int ml})> dailyTotals(
      List<WaterLog> logs, DateTime end, int days) {
    return [
      for (var i = days - 1; i >= 0; i--)
        () {
          final d = DateTime(end.year, end.month, end.day - i);
          final next = DateTime(d.year, d.month, d.day + 1);
          final ml = totalMl(logs
              .where((l) => !l.loggedAt.isBefore(d) && l.loggedAt.isBefore(next))
              .map((l) => l.amountMl));
          return (day: d, ml: ml);
        }(),
    ];
  }

  // --- Fasting ----------------------------------------------------------------

  Stream<FastingSession?> watchActiveFast(String profileId) =>
      (_db.select(_db.fastingSessions)
            ..where((f) => f.profileId.equals(profileId) & f.endedAt.isNull())
            ..limit(1))
          .watchSingleOrNull();

  /// Starts a fast, ending any fast that was still open so there is only one.
  Future<String> startFast(String profileId, {int? plannedSeconds}) async {
    final id = _uuid.v4();
    final now = _now();
    await _db.transaction(() async {
      await (_db.update(_db.fastingSessions)
            ..where((f) => f.profileId.equals(profileId) & f.endedAt.isNull()))
          .write(FastingSessionsCompanion(
              endedAt: Value(now), updatedAt: Value(now)));
      await _db.into(_db.fastingSessions).insert(FastingSessionsCompanion.insert(
            id: id,
            profileId: profileId,
            startedAt: now,
            plannedSeconds: Value(plannedSeconds),
            createdAt: now,
            updatedAt: now,
          ));
    });
    return id;
  }

  Future<void> endFast(String profileId, String id, {String? notes}) =>
      (_db.update(_db.fastingSessions)
            ..where((f) => f.id.equals(id) & f.profileId.equals(profileId)))
          .write(FastingSessionsCompanion(
        endedAt: Value(_now()),
        notes: Value.absentIfNull(notes),
        updatedAt: Value(_now()),
      ));

  Stream<List<FastingSession>> watchFastHistory(String profileId,
          {int limit = 30}) =>
      (_db.select(_db.fastingSessions)
            ..where((f) => f.profileId.equals(profileId) & f.endedAt.isNotNull())
            ..orderBy([(f) => OrderingTerm.desc(f.startedAt)])
            ..limit(limit))
          .watch();

  // --- Workouts -----------------------------------------------------------------

  Future<void> saveWorkoutSession(
    String profileId, {
    required String workoutKey,
    required String workoutName,
    required DateTime startedAt,
    required DateTime endedAt,
    required int exercisesCompleted,
    required int exercisesTotal,
  }) =>
      _db.into(_db.workoutSessions).insert(WorkoutSessionsCompanion.insert(
            id: _uuid.v4(),
            profileId: profileId,
            workoutKey: workoutKey,
            workoutName: workoutName,
            startedAt: startedAt,
            endedAt: endedAt,
            exercisesCompleted: exercisesCompleted,
            exercisesTotal: exercisesTotal,
            createdAt: _now(),
          ));

  Stream<List<WorkoutSession>> watchWorkoutHistory(String profileId,
          {int limit = 30}) =>
      (_db.select(_db.workoutSessions)
            ..where((w) => w.profileId.equals(profileId))
            ..orderBy([(w) => OrderingTerm.desc(w.startedAt)])
            ..limit(limit))
          .watch();
}
