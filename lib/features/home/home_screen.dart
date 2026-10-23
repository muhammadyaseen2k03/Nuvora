import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import '../fitness/fitness_repository.dart';
import '../prayer/prayer_screen.dart' show prayerLabel;
import '../prayer/prayer_service.dart';
import '../prayer/prayer_streaks.dart';
import 'daily_score.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final brightness = Theme.of(context).brightness;
    final profile = ref.watch(activeProfileProvider).value;
    final prefs = ref.watch(preferencesProvider).value;
    final prayerLog = ref.watch(prayerLogProvider).value ?? const {};
    final prayerSettings = ref.watch(prayerSettingsProvider).value;
    final focus = ref.watch(todayFocusProvider).value ?? const [];
    final workoutsDone = ref.watch(workoutHistoryProvider).value ?? const [];
    final water = ref.watch(waterLogsProvider).value ?? const [];
    final studyRepo = ref.read(studyRepositoryProvider);
    final profileId = ref.watch(activeProfileIdProvider);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final name = profile?.displayName ?? '';
    final greeting = now.hour < 12
        ? l.greetingMorning(name)
        : now.hour < 17
            ? l.greetingAfternoon(name)
            : l.greetingEvening(name);

    // Today's numbers, all from stored records.
    final todayPrayers = prayerLog[dayKey(today)] ?? const {};
    final prayersDone =
        todayPrayers.values.where((s) => s != PrayerStatus.missed).length;
    final studyMinutes = focus
        .where((s) => !s.cancelled)
        .fold<int>(0, (sum, s) => sum + studyRepo.timerOf(s).elapsed(s.endedAt!).inMinutes);
    final studyGoal = prefs?.studyGoalMinutes ?? 60;
    final workoutToday = workoutsDone.any((w) =>
        !w.startedAt.isBefore(today) &&
        w.startedAt.isBefore(DateTime(today.year, today.month, today.day + 1)));
    final waterToday = FitnessRepository.dailyTotals(water, now, 1).single.ml;
    final waterGoal = prefs?.waterGoalMl ?? 2000;

    final score = dailyScore([
      GoalProgress('prayers', fractionOf(prayersDone, 5)),
      GoalProgress('study', fractionOf(studyMinutes, studyGoal)),
      GoalProgress('workout', workoutToday ? 1 : 0),
      GoalProgress('water', fractionOf(waterToday, waterGoal)),
    ]);
    final percent = ((score ?? 0) * 100).round();

    // Next prayer, if a location is configured.
    String? nextPrayerText;
    if (prayerSettings?.latitude != null && prayerSettings?.longitude != null) {
      final times = const PrayerService().forDay(
        PrayerConfig(
          method: prayerSettings!.method,
          asrMethod: prayerSettings.asrMethod,
          latitude: prayerSettings.latitude!,
          longitude: prayerSettings.longitude!,
        ),
        today,
      );
      final next = times.next(now);
      nextPrayerText = l.homeNextPrayerAt(
        next.prayer == null ? l.prayerFajr : prayerLabel(l, next.prayer!),
        DateFormat.jm(l.localeName).format(next.time),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l.appName),
        actions: [
          IconButton(
            tooltip: l.settings,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(Space.x2),
        children: [
          Semantics(
              header: true, child: Text(greeting, style: t.headlineSmall)),
          const SizedBox(height: Space.x1 / 2),
          Text(DateFormat.yMMMMEEEEd(l.localeName).format(now),
              style: t.bodyMedium),
          const SizedBox(height: Space.x2),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Space.x2),
              child: Row(children: [
                Semantics(
                  label: '${l.homeScoreTitle}: $percent%',
                  child: SizedBox(
                    width: 96,
                    height: 96,
                    child: Stack(alignment: Alignment.center, children: [
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: score ?? 0,
                          strokeWidth: 9,
                          color: Theme.of(context).colorScheme.primary,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.16),
                        ),
                      ),
                      ExcludeSemantics(
                          child: Text('$percent%', style: t.titleLarge)),
                    ]),
                  ),
                ),
                const SizedBox(width: Space.x2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.homeScoreTitle, style: t.titleMedium),
                      const SizedBox(height: 4),
                      Text(l.homeBuilding, style: t.bodyMedium),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(height: Space.x1),
          Text(l.homeScoreNote, style: t.bodySmall),
          const SizedBox(height: Space.x2),
          InkWell(
            borderRadius: BorderRadius.circular(Radii.card),
            onTap: () => context.go('/prayer'),
            child: Card(
              child: ListTile(
                leading: Icon(NuvoraSection.soul.icon,
                    color: NuvoraSection.soul.accent(brightness)),
                title: Text(l.navPrayer),
                subtitle: Text(nextPrayerText ?? l.homeNoLocation),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ),
          const SizedBox(height: Space.x1),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: Space.x1,
            crossAxisSpacing: Space.x1,
            childAspectRatio: 1.6,
            children: [
              _Tile(
                icon: NuvoraSection.soul.icon,
                color: NuvoraSection.soul.accent(brightness),
                title: l.tilePrayers,
                value: l.tilePrayersValue(prayersDone),
                fraction: fractionOf(prayersDone, 5),
              ),
              _Tile(
                icon: NuvoraSection.mind.icon,
                color: NuvoraSection.mind.accent(brightness),
                title: l.tileStudy,
                value: l.tileStudyValue(studyMinutes, studyGoal),
                fraction: fractionOf(studyMinutes, studyGoal),
              ),
              _Tile(
                icon: Icons.fitness_center,
                color: NuvoraSection.body.accent(brightness),
                title: l.tileWorkout,
                value: workoutToday ? l.tileWorkoutDone : l.tileWorkoutNotYet,
                fraction: workoutToday ? 1 : 0,
              ),
              _Tile(
                icon: Icons.water_drop_outlined,
                color: NuvoraSection.body.accent(brightness),
                title: l.tileWater,
                value: l.tileWaterValue(waterToday, waterGoal),
                fraction: fractionOf(waterToday, waterGoal),
              ),
            ],
          ),
          const SizedBox(height: Space.x3),
          Text(l.moreTitle, style: t.titleMedium),
          const SizedBox(height: Space.x1),
          for (final item in [
            (Icons.event_note_outlined, l.plannerTitle, '/planner'),
            (Icons.calendar_month_outlined, l.calendarTitle, '/calendar'),
            (Icons.edit_note_outlined, l.journalTitle, '/journal'),
            (Icons.emoji_events_outlined, l.progressTitle, '/progress'),
            (Icons.auto_awesome_outlined, l.aiTitle, "/ai"),
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: Space.x1),
              child: Card(
                child: ListTile(
                  leading: Icon(item.$1),
                  title: Text(item.$2),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push(item.$3),
                ),
              ),
            ),
          const SizedBox(height: Space.x2),
          Text(l.quickActions, style: t.titleMedium),
          const SizedBox(height: Space.x1),
          Wrap(spacing: Space.x1, runSpacing: Space.x1, children: [
            FilledButton.tonalIcon(
              onPressed: () => context.go('/prayer'),
              icon: const Icon(Icons.check_circle_outline),
              label: Text(l.quickPrayer),
            ),
            FilledButton.tonalIcon(
              onPressed: () => context.go('/study'),
              icon: const Icon(Icons.timer_outlined),
              label: Text(l.quickFocus),
            ),
            FilledButton.tonalIcon(
              onPressed: () => context.go('/fitness'),
              icon: const Icon(Icons.fitness_center),
              label: Text(l.quickWorkout),
            ),
            FilledButton.tonalIcon(
              onPressed: profileId == null
                  ? null
                  : () => ref
                      .read(fitnessRepositoryProvider)
                      .addWater(profileId, 250),
              icon: const Icon(Icons.water_drop_outlined),
              label: Text(l.quickWater),
            ),
          ]),
          const SizedBox(height: Space.x3),
          Text(l.homeOffline, style: t.bodySmall),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    required this.fraction,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String value;
  final double fraction;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Semantics(
      container: true,
      label: '$title: $value',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(Space.x2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 6),
                Flexible(child: Text(title, style: t.labelLarge)),
              ]),
              Text(value, style: t.bodyMedium),
              LinearProgressIndicator(
                value: fraction,
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
                color: color,
                backgroundColor: color.withValues(alpha: 0.16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
