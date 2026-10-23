import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../data/database.dart';
import '../fitness/hydration.dart' show totalMl;
import '../prayer/prayer_service.dart';
import '../prayer/prayer_streaks.dart';
import '../study/focus_timer.dart';
import 'achievements.dart';
import 'weekly_report.dart';

/// One day of stored activity.
class DayRecord {
  const DayRecord({
    required this.stats,
    required this.anyRecord,
    required this.explicitMissOnly,
    required this.prayers,
  });

  final DayStats stats;

  /// True when anything was recorded that day (including explicit misses).
  final bool anyRecord;

  /// True when the only records are explicitly missed prayers.
  final bool explicitMissOnly;
  final Map<PrayerName, PrayerStatus> prayers;
}

/// Reads stored records across features. Everything is derived from the
/// database; nothing is estimated or filled in.
class HistoryRepository {
  HistoryRepository(this._db, {DateTime Function()? clock})
      : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _now;
  static const _uuid = Uuid();

  /// Records for each calendar day from [from] to [to] inclusive.
  Future<List<DayRecord>> load(
      String profileId, DateTime from, DateTime to) async {
    final start = DateTime(from.year, from.month, from.day);
    final endExclusive = DateTime(to.year, to.month, to.day + 1);

    final prayerRows = await (_db.select(_db.prayerRecords)
          ..where((r) =>
              r.profileId.equals(profileId) &
              r.day.isBetweenValues(dayKey(start), dayKey(to))))
        .get();
    final sessions = await (_db.select(_db.studySessions)
          ..where((s) =>
              s.profileId.equals(profileId) &
              s.kind.equals(FocusKind.focus.name) &
              s.cancelled.equals(false) &
              s.endedAt.isBiggerOrEqualValue(start) &
              s.endedAt.isSmallerThanValue(endExclusive)))
        .get();
    final subjects = {
      for (final s in await (_db.select(_db.subjects)
            ..where((s) => s.profileId.equals(profileId)))
          .get())
        s.id: s.name
    };
    final workoutRows = await (_db.select(_db.workoutSessions)
          ..where((w) =>
              w.profileId.equals(profileId) &
              w.startedAt.isBiggerOrEqualValue(start) &
              w.startedAt.isSmallerThanValue(endExclusive)))
        .get();
    final waterRows = await (_db.select(_db.waterLogs)
          ..where((w) =>
              w.profileId.equals(profileId) &
              w.loggedAt.isBiggerOrEqualValue(start) &
              w.loggedAt.isSmallerThanValue(endExclusive)))
        .get();

    final out = <DayRecord>[];
    final days = DateTime(to.year, to.month, to.day).difference(start).inDays;
    // Iterate by calendar fields so daylight-saving changes cannot skip a day.
    for (var n = 0; n <= days; n++) {
      final day = DateTime(start.year, start.month, start.day + n);
      final key = dayKey(day);
      final next = DateTime(day.year, day.month, day.day + 1);

      final prayers = <PrayerName, PrayerStatus>{};
      for (final r in prayerRows.where((r) => r.day == key)) {
        final p = PrayerName.values.asNameMap()[r.prayer];
        final s = PrayerStatus.values.asNameMap()[r.status];
        if (p != null && s != null) prayers[p] = s;
      }
      final completed =
          prayers.values.where((s) => s != PrayerStatus.missed).length;
      final missed = prayers.length - completed;

      var studyMinutes = 0;
      final bySubject = <String, int>{};
      for (final s in sessions.where((s) =>
          !s.endedAt!.isBefore(day) && s.endedAt!.isBefore(next))) {
        final mins = FocusTimer(
          kind: FocusKind.focus,
          plannedSeconds: s.plannedSeconds,
          startedAt: s.startedAt,
          pausedAt: s.pausedAt,
          accumulatedPausedMs: s.accumulatedPausedMs,
          endedAt: s.endedAt,
        ).elapsed(s.endedAt!).inMinutes;
        studyMinutes += mins;
        final name = subjects[s.subjectId];
        if (name != null) bySubject[name] = (bySubject[name] ?? 0) + mins;
      }
      final workouts = workoutRows
          .where((w) => !w.startedAt.isBefore(day) && w.startedAt.isBefore(next))
          .length;
      final water = totalMl(waterRows
          .where((w) => !w.loggedAt.isBefore(day) && w.loggedAt.isBefore(next))
          .map((w) => w.amountMl));

      final anyCompletion =
          completed > 0 || studyMinutes > 0 || workouts > 0 || water > 0;
      out.add(DayRecord(
        stats: DayStats(
          day: day,
          prayersCompleted: completed,
          prayersMissed: missed,
          studyMinutes: studyMinutes,
          studyBySubject: bySubject,
          workouts: workouts,
          waterMl: water,
        ),
        anyRecord: anyCompletion || missed > 0,
        explicitMissOnly: missed > 0 && !anyCompletion,
        prayers: prayers,
      ));
    }
    return out;
  }

  /// Stats used to decide achievements, from all stored data.
  Future<AchievementStats> achievementStats(
      String profileId, int waterGoalMl) async {
    final now = _now();
    final today = DateTime(now.year, now.month, now.day);
    final monthStart = DateTime(today.year, today.month, 1);
    final recent = await load(
        profileId, DateTime(today.year, today.month, today.day - 400), today);

    final log = <String, Map<PrayerName, PrayerStatus>>{
      for (final r in recent)
        if (r.prayers.isNotEmpty) dayKey(r.stats.day): r.prayers,
    };
    final totals = {
      for (final r in recent) dayKey(r.stats.day): r.stats.waterMl,
    };
    final monthMinutes = recent
        .where((r) => !r.stats.day.isBefore(monthStart))
        .fold<int>(0, (s, r) => s + r.stats.studyMinutes);

    final focusTotal = await (_db.selectOnly(_db.studySessions)
          ..addColumns([_db.studySessions.id.count()])
          ..where(_db.studySessions.profileId.equals(profileId) &
              _db.studySessions.kind.equals(FocusKind.focus.name) &
              _db.studySessions.cancelled.equals(false) &
              _db.studySessions.endedAt.isNotNull()))
        .map((r) => r.read(_db.studySessions.id.count()) ?? 0)
        .getSingle();
    final workoutTotal = await (_db.selectOnly(_db.workoutSessions)
          ..addColumns([_db.workoutSessions.id.count()])
          ..where(_db.workoutSessions.profileId.equals(profileId)))
        .map((r) => r.read(_db.workoutSessions.id.count()) ?? 0)
        .getSingle();

    return AchievementStats(
      prayerStreak: currentStreak(log, today),
      focusSessionsTotal: focusTotal,
      studyMinutesThisMonth: monthMinutes,
      workoutsTotal: workoutTotal,
      hydrationGoalStreak: hydrationStreak(totals, waterGoalMl, today),
    );
  }

  /// Records newly earned achievements. Existing awards are never changed,
  /// and an award is never removed if the underlying numbers later drop.
  /// Returns the ids awarded by this call.
  Future<List<String>> syncAwards(String profileId, Set<String> earned) async {
    final existing = (await (_db.select(_db.achievementAwards)
              ..where((a) => a.profileId.equals(profileId)))
            .get())
        .map((a) => a.achievementId)
        .toSet();
    final fresh = earned.difference(existing).toList()..sort();
    final now = _now();
    for (final id in fresh) {
      await _db.into(_db.achievementAwards).insert(
            AchievementAwardsCompanion.insert(
                id: _uuid.v4(),
                profileId: profileId,
                achievementId: id,
                awardedAt: now),
            mode: InsertMode.insertOrIgnore,
          );
    }
    return fresh;
  }

  Stream<List<AchievementAward>> watchAwards(String profileId) =>
      (_db.select(_db.achievementAwards)
            ..where((a) => a.profileId.equals(profileId))
            ..orderBy([(a) => OrderingTerm.asc(a.awardedAt)]))
          .watch();
}
