import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../data/database.dart';
import '../prayer/prayer_streaks.dart' show dayKey;
import 'planner.dart';

enum ActivityStatus { planned, done, skipped }

class PlannerRepository {
  PlannerRepository(this._db, {DateTime Function()? clock})
      : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _now;
  static const _uuid = Uuid();

  Stream<List<PlannedActivity>> watchDay(String profileId, DateTime day) {
    final key = dayKey(day);
    return (_db.select(_db.plannedActivities).join([
      innerJoin(_db.dailyPlans,
          _db.dailyPlans.id.equalsExp(_db.plannedActivities.planId)),
    ])
          ..where(_db.plannedActivities.profileId.equals(profileId) &
              _db.dailyPlans.day.equals(key))
          ..orderBy([OrderingTerm.asc(_db.plannedActivities.startAt)]))
        .watch()
        .map((rows) =>
            [for (final r in rows) r.readTable(_db.plannedActivities)]);
  }

  Future<String> _planId(String profileId, DateTime day) async {
    final key = dayKey(day);
    final existing = await (_db.select(_db.dailyPlans)
          ..where((p) => p.profileId.equals(profileId) & p.day.equals(key)))
        .getSingleOrNull();
    if (existing != null) return existing.id;
    final id = _uuid.v4();
    await _db.into(_db.dailyPlans).insert(DailyPlansCompanion.insert(
        id: id, profileId: profileId, day: key, generatedAt: _now()));
    return id;
  }

  /// Replaces only the *unpinned, still-planned* suggestions for [day].
  /// Pinned, completed and skipped items are never deleted or changed, so
  /// regenerating cannot discard the user's own work.
  Future<void> replaceSuggestions(
      String profileId, DateTime day, List<PlanBlock> blocks) async {
    final planId = await _planId(profileId, day);
    final now = _now();
    await _db.transaction(() async {
      await (_db.delete(_db.plannedActivities)
            ..where((a) =>
                a.planId.equals(planId) &
                a.status.equals(ActivityStatus.planned.name) &
                a.pinned.equals(false)))
          .go();
      for (final b in blocks.where((b) => !b.isFixed)) {
        await _db.into(_db.plannedActivities).insert(
              PlannedActivitiesCompanion.insert(
                id: _uuid.v4(),
                profileId: profileId,
                planId: planId,
                kind: (b.kind ?? PlanKind.other).name,
                title: b.title,
                startAt: b.start,
                endAt: b.end,
                reason: Value(b.reason),
                createdAt: now,
                updatedAt: now,
              ),
            );
      }
      await (_db.update(_db.dailyPlans)..where((p) => p.id.equals(planId)))
          .write(DailyPlansCompanion(generatedAt: Value(now)));
    });
  }

  /// Adds a user-created activity (always pinned).
  Future<void> addManual(String profileId, DateTime day,
      {required String title,
      required DateTime start,
      required DateTime end,
      PlanKind kind = PlanKind.other}) async {
    if (!end.isAfter(start)) {
      throw ArgumentError('end must be after start');
    }
    final planId = await _planId(profileId, day);
    final now = _now();
    await _db.into(_db.plannedActivities).insert(
          PlannedActivitiesCompanion.insert(
            id: _uuid.v4(),
            profileId: profileId,
            planId: planId,
            kind: kind.name,
            title: title.trim(),
            startAt: start,
            endAt: end,
            pinned: const Value(true),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  Future<void> setStatus(
          String profileId, String id, ActivityStatus status) =>
      _update(profileId, id,
          PlannedActivitiesCompanion(status: Value(status.name)));

  Future<void> setPinned(String profileId, String id, bool pinned) =>
      _update(profileId, id, PlannedActivitiesCompanion(pinned: Value(pinned)));

  /// Moves an activity. A moved activity becomes pinned so a later
  /// regeneration keeps it where the user put it.
  Future<void> move(
      String profileId, String id, DateTime start, DateTime end) {
    if (!end.isAfter(start)) {
      throw ArgumentError('end must be after start');
    }
    return _update(
        profileId,
        id,
        PlannedActivitiesCompanion(
            startAt: Value(start), endAt: Value(end), pinned: const Value(true)));
  }

  Future<void> delete(String profileId, String id) =>
      (_db.delete(_db.plannedActivities)
            ..where((a) => a.id.equals(id) & a.profileId.equals(profileId)))
          .go();

  Future<void> _update(
          String profileId, String id, PlannedActivitiesCompanion c) =>
      (_db.update(_db.plannedActivities)
            ..where((a) => a.id.equals(id) & a.profileId.equals(profileId)))
          .write(c.copyWith(updatedAt: Value(_now())));
}
