import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import 'workout_library.dart';

String categoryLabel(AppLocalizations l, WorkoutCategory c) => switch (c) {
      WorkoutCategory.fullBody => l.categoryFullBody,
      WorkoutCategory.upperBody => l.categoryUpperBody,
      WorkoutCategory.lowerBody => l.categoryLowerBody,
      WorkoutCategory.core => l.categoryCore,
      WorkoutCategory.mobility => l.categoryMobility,
      WorkoutCategory.quick => l.categoryQuick,
    };

class WorkoutsTab extends ConsumerWidget {
  const WorkoutsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final accent = NuvoraSection.body.accent(Theme.of(context).brightness);
    final history = ref.watch(workoutHistoryProvider).value ?? const [];

    return ListView(
      padding: const EdgeInsets.all(Space.x2),
      children: [
        Text(l.workoutSafety, style: t.bodySmall),
        const SizedBox(height: Space.x2),
        for (final w in workouts)
          Padding(
            padding: const EdgeInsets.only(bottom: Space.x1),
            child: Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(Radii.card),
                onTap: () => context.push('/fitness/workout/${w.id}'),
                child: Padding(
                  padding: const EdgeInsets.all(Space.x2),
                  child: Row(children: [
                    CircleAvatar(
                      backgroundColor: accent.withValues(alpha: 0.16),
                      child: Icon(Icons.fitness_center, color: accent),
                    ),
                    const SizedBox(width: Space.x2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(w.name, style: t.titleMedium),
                          Text(
                              '${categoryLabel(l, w.category)} · ${l.focusMinutes(w.estimatedMinutes)} · ${l.fitnessBeginner}',
                              style: t.bodySmall),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ]),
                ),
              ),
            ),
          ),
        const SizedBox(height: Space.x2),
        Text(l.workoutHistory, style: t.titleMedium),
        const SizedBox(height: Space.x1),
        if (history.isEmpty)
          Text(l.workoutHistoryEmpty)
        else
          for (final h in history.take(10))
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.check_circle_outline),
              title: Text(h.workoutName),
              subtitle: Text(
                  '${DateFormat.MMMd(l.localeName).add_jm().format(h.startedAt)} · ${l.workoutSummary(h.exercisesCompleted, h.exercisesTotal, h.endedAt.difference(h.startedAt).inMinutes)}'),
            ),
      ],
    );
  }
}
