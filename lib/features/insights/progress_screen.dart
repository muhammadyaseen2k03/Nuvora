import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import 'achievements.dart';
import 'weekly_report.dart';

String badgeTitle(AppLocalizations l, String id) => switch (id) {
      'prayer_streak_7' => l.badgePrayerStreak7,
      'focus_sessions_10' => l.badgeFocus10,
      'study_hours_20_month' => l.badgeStudy20h,
      'workouts_10' => l.badgeWorkouts10,
      'hydration_week' => l.badgeHydrationWeek,
      _ => id,
    };

String suggestionText(AppLocalizations l, String code) => switch (code) {
      'water' => l.suggestWater,
      'study' => l.suggestStudy,
      'workout' => l.suggestWorkout,
      'prayer_tracking' => l.suggestPrayerTracking,
      _ => l.suggestKeepGoing,
    };

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen> {
  AchievementStats _stats = const AchievementStats();
  int _xp = 0;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  /// Recomputes achievements from stored data and records any new awards.
  Future<void> _refresh() async {
    final id = ref.read(activeProfileIdProvider);
    if (id == null) return;
    final goal = ref.read(preferencesProvider).value?.waterGoalMl ?? 2000;
    final history = ref.read(historyRepositoryProvider);
    final stats = await history.achievementStats(id, goal);
    await history.syncAwards(id, earnedAchievements(stats));
    final records = await history.load(
        id, DateTime.now().subtract(const Duration(days: 400)), DateTime.now());
    final xp = experiencePoints(
      focusSessions: stats.focusSessionsTotal,
      workouts: stats.workoutsTotal,
      prayersCompleted:
          records.fold<int>(0, (s, r) => s + r.stats.prayersCompleted),
    );
    if (mounted) {
      setState(() {
        _stats = stats;
        _xp = xp;
        _loaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final accent = Theme.of(context).colorScheme.primary;
    final awards = ref.watch(awardsProvider).value ?? const [];
    final earnedIds = awards.map((a) => a.achievementId).toSet();
    final prefs = ref.watch(preferencesProvider).value;
    final records = ref.watch(historyProvider).value ?? const [];

    final last7 = records.length >= 7
        ? records.sublist(records.length - 7)
        : records;
    final report = buildWeeklyReport(
      [for (final r in last7) r.stats],
      WeeklyGoals(
        studyMinutesPerDay: prefs?.studyGoalMinutes ?? 60,
        waterMlPerDay: prefs?.waterGoalMl ?? 2000,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l.progressTitle)),
      body: ListView(
        padding: const EdgeInsets.all(Space.x2),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Space.x2),
              child: Row(children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: accent.withValues(alpha: 0.16),
                  child: Text('${levelFor(_xp)}', style: t.titleLarge),
                ),
                const SizedBox(width: Space.x2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.progressLevel(levelFor(_xp)), style: t.titleMedium),
                      Text(l.progressXp(_xp)),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(height: Space.x1),
          Text(l.progressXpNote, style: t.bodySmall),
          const SizedBox(height: Space.x3),
          Text(l.weeklyReport, style: t.titleMedium),
          const SizedBox(height: Space.x1),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Space.x2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(report.mostConsistentDay == null
                      ? l.reportNoBestDay
                      : l.reportBestDay(DateFormat.EEEE(l.localeName)
                          .format(report.mostConsistentDay!))),
                  const SizedBox(height: Space.x1),
                  Text(l.reportStudy(report.studyMinutesTotal)),
                  for (final s in report.studyBySubject)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: Space.x2),
                      child: Text('${s.key}: ${l.focusMinutes(s.value)}',
                          style: t.bodySmall),
                    ),
                  Text(l.reportWorkouts(report.workouts)),
                  Text(l.reportPrayers(
                      report.prayersCompleted, report.prayersRecorded)),
                  Text(l.reportWater(report.hydrationDaysMet)),
                  const Divider(height: Space.x3),
                  Text(l.reportSuggestion(
                      suggestionText(l, report.suggestion))),
                ],
              ),
            ),
          ),
          const SizedBox(height: Space.x3),
          Text(l.badges, style: t.titleMedium),
          const SizedBox(height: Space.x1),
          for (final d in achievementDefs)
            Padding(
              padding: const EdgeInsets.only(bottom: Space.x1),
              child: Card(
                child: ListTile(
                  leading: Icon(
                    earnedIds.contains(d.id)
                        ? Icons.emoji_events
                        : Icons.emoji_events_outlined,
                    color: earnedIds.contains(d.id)
                        ? accent
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  title: Text(badgeTitle(l, d.id)),
                  subtitle: _loaded
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: earnedIds.contains(d.id)
                              ? Text(l.badgeEarned)
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LinearProgressIndicator(
                                      value: (d.progress(_stats) / d.target)
                                          .clamp(0.0, 1.0),
                                      minHeight: 6,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    Text(
                                        '${d.progress(_stats).clamp(0, d.target)} / ${d.target}',
                                        style: t.bodySmall),
                                  ],
                                ),
                        )
                      : null,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
