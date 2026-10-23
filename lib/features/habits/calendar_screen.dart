import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import '../home/daily_score.dart';
import '../insights/history_repository.dart';
import 'day_status.dart';

/// Status for one day against the profile's goals. Uses the same four goals
/// and equal weights as the Home score.
DayStatus statusOf(DayRecord r, int studyGoal, int waterGoal) {
  return classifyDay(
    goals: [
      GoalProgress('prayers', fractionOf(r.stats.prayersCompleted, 5)),
      GoalProgress('study', fractionOf(r.stats.studyMinutes, studyGoal)),
      GoalProgress('workout', r.stats.workouts > 0 ? 1 : 0),
      GoalProgress('water', fractionOf(r.stats.waterMl, waterGoal)),
    ],
    anyRecord: r.anyRecord,
    explicitMissOnly: r.explicitMissOnly,
  );
}

String statusLabel(AppLocalizations l, DayStatus s) => switch (s) {
      DayStatus.complete => l.calendarComplete,
      DayStatus.partial => l.calendarPartial,
      DayStatus.missed => l.calendarMissed,
      DayStatus.unrecorded => l.calendarUnrecorded,
    };

/// Status is shown by icon as well as color, so it never relies on color alone.
IconData statusIcon(DayStatus s) => switch (s) {
      DayStatus.complete => Icons.check_circle,
      DayStatus.partial => Icons.timelapse,
      DayStatus.missed => Icons.cancel_outlined,
      DayStatus.unrecorded => Icons.circle_outlined,
    };

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final prefs = ref.watch(preferencesProvider).value;
    final studyGoal = prefs?.studyGoalMinutes ?? 60;
    final waterGoal = prefs?.waterGoalMl ?? 2000;
    final records = ref.watch(monthRecordsProvider(_month)).value ?? const [];
    final byDay = {for (final r in records) r.stats.day.day: r};

    final first = DateTime(_month.year, _month.month, 1);
    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;
    // Week starts on Monday.
    final lead = (first.weekday + 6) % 7;
    final today = DateTime.now();

    Color colorFor(DayStatus s) => switch (s) {
          DayStatus.complete => NuvoraColors.success,
          DayStatus.partial => NuvoraColors.warning,
          DayStatus.missed => scheme.error,
          DayStatus.unrecorded => scheme.onSurfaceVariant,
        };

    return Scaffold(
      appBar: AppBar(title: Text(l.calendarTitle)),
      body: ListView(
        padding: const EdgeInsets.all(Space.x2),
        children: [
          Row(children: [
            IconButton(
              tooltip: DateFormat.yMMMM(l.localeName)
                  .format(DateTime(_month.year, _month.month - 1)),
              icon: const Icon(Icons.chevron_left),
              onPressed: () => setState(
                  () => _month = DateTime(_month.year, _month.month - 1)),
            ),
            Expanded(
              child: Text(DateFormat.yMMMM(l.localeName).format(_month),
                  textAlign: TextAlign.center, style: t.titleMedium),
            ),
            IconButton(
              tooltip: DateFormat.yMMMM(l.localeName)
                  .format(DateTime(_month.year, _month.month + 1)),
              icon: const Icon(Icons.chevron_right),
              onPressed: () => setState(
                  () => _month = DateTime(_month.year, _month.month + 1)),
            ),
          ]),
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 0.85,
            children: [
              for (var i = 0; i < lead; i++) const SizedBox.shrink(),
              for (var d = 1; d <= daysInMonth; d++)
                () {
                  final rec = byDay[d];
                  final isFuture = DateTime(_month.year, _month.month, d)
                      .isAfter(DateTime(today.year, today.month, today.day));
                  final status = rec == null || isFuture
                      ? DayStatus.unrecorded
                      : statusOf(rec, studyGoal, waterGoal);
                  final label = DateFormat.MMMEd(l.localeName)
                      .format(DateTime(_month.year, _month.month, d));
                  return Semantics(
                    button: rec != null,
                    label: '$label, ${statusLabel(l, status)}',
                    child: InkWell(
                      borderRadius: BorderRadius.circular(Radii.control),
                      onTap: rec == null || isFuture
                          ? null
                          : () => _showDay(context, rec, status),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ExcludeSemantics(child: Text('$d', style: t.bodyMedium)),
                          const SizedBox(height: 2),
                          Icon(statusIcon(status),
                              size: 20,
                              color: isFuture
                                  ? scheme.outlineVariant
                                  : colorFor(status)),
                        ],
                      ),
                    ),
                  );
                }(),
            ],
          ),
          const SizedBox(height: Space.x2),
          Wrap(spacing: Space.x2, runSpacing: Space.x1, children: [
            for (final s in DayStatus.values)
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(statusIcon(s), size: 18, color: colorFor(s)),
                const SizedBox(width: 4),
                Text(statusLabel(l, s), style: t.bodySmall),
              ]),
          ]),
          const SizedBox(height: Space.x2),
          Text(l.calendarLegend, style: t.bodySmall),
        ],
      ),
    );
  }

  void _showDay(BuildContext context, DayRecord r, DayStatus status) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(Space.x3, 0, Space.x3, Space.x4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat.yMMMMEEEEd(l.localeName).format(r.stats.day),
                style: t.titleLarge),
            const SizedBox(height: 4),
            Text(statusLabel(l, status), style: t.titleSmall),
            const SizedBox(height: Space.x2),
            Text(l.dayDetailPrayers(r.stats.prayersCompleted)),
            Text(l.dayDetailStudy(r.stats.studyMinutes)),
            Text(l.dayDetailWorkouts(r.stats.workouts)),
            Text(l.dayDetailWater(r.stats.waterMl)),
          ],
        ),
      ),
    );
  }
}
