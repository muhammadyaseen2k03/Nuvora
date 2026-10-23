import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import '../study/focus_timer.dart';
import '../study/focus_tab.dart' show formatClock;
import 'workout_library.dart';

/// Plays a workout step by step. Each timed step reuses the timestamp-based
/// [FocusTimer], so pausing and display ticks cannot drift the countdown.
class WorkoutPlayer extends ConsumerStatefulWidget {
  const WorkoutPlayer({super.key, required this.workoutId});

  final String workoutId;

  @override
  ConsumerState<WorkoutPlayer> createState() => _WorkoutPlayerState();
}

class _WorkoutPlayerState extends ConsumerState<WorkoutPlayer> {
  late final Workout? _workout = workoutById(widget.workoutId);
  late final List<WorkoutStep> _steps =
      _workout == null ? const [] : buildSteps(_workout);
  Timer? _ticker;
  DateTime _now = DateTime.now();
  DateTime? _startedAt;
  bool _started = false;
  bool _finished = false;
  int _index = 0;
  FocusTimer? _timer;
  final Set<int> _completed = {};

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _begin() {
    _startedAt = DateTime.now();
    _started = true;
    _enter(0);
    _ticker = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
      final t = _timer;
      if (t != null &&
          !_finished &&
          t.pausedAt == null &&
          t.remaining(_now) <= Duration.zero) {
        _advance(markDone: !_steps[_index].isRest);
      }
    });
    setState(() {});
  }

  void _enter(int i) {
    _index = i;
    final secs = _steps[i].durationSeconds;
    _timer = secs == null
        ? null
        : FocusTimer.start(FocusKind.focus, secs, DateTime.now());
  }

  void _advance({bool markDone = false}) {
    if (markDone && !_steps[_index].isRest) {
      _completed.add(_steps[_index].exerciseIndex);
    }
    if (_index >= _steps.length - 1) {
      _finish();
    } else {
      setState(() => _enter(_index + 1));
    }
  }

  void _previous() {
    if (_index > 0) setState(() => _enter(_index - 1));
  }

  Future<void> _finish() async {
    _ticker?.cancel();
    final profileId = ref.read(activeProfileIdProvider);
    final w = _workout!;
    final end = DateTime.now();
    // Only record workouts where something was actually completed.
    if (profileId != null && _completed.isNotEmpty) {
      await ref.read(fitnessRepositoryProvider).saveWorkoutSession(
            profileId,
            workoutKey: w.id,
            workoutName: w.name,
            startedAt: _startedAt!,
            endedAt: end,
            exercisesCompleted: _completed.length,
            exercisesTotal: w.exercises.length,
          );
    }
    if (mounted) setState(() => _finished = true);
  }

  void _togglePause() {
    final t = _timer;
    if (t == null) return;
    setState(() => _timer = t.pausedAt == null
        ? t.pause(DateTime.now())
        : t.resume(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final accent = NuvoraSection.body.accent(Theme.of(context).brightness);
    final w = _workout;
    if (w == null) return Scaffold(appBar: AppBar());

    Widget body;
    if (!_started) {
      body = ListView(
        padding: const EdgeInsets.all(Space.x2),
        children: [
          Text(l.focusMinutes(w.estimatedMinutes), style: t.titleMedium),
          const SizedBox(height: Space.x1),
          Text(l.workoutSafety, style: t.bodySmall),
          const SizedBox(height: Space.x2),
          for (final e in w.exercises)
            Card(
              child: ListTile(
                title: Text(e.name),
                subtitle: Text(e.isTimed
                    ? l.workoutSeconds(e.seconds!)
                    : l.workoutReps(e.reps!)),
              ),
            ),
          const SizedBox(height: Space.x2),
          FilledButton.icon(
            onPressed: _begin,
            icon: const Icon(Icons.play_arrow),
            label: Text(l.workoutStart),
          ),
        ],
      );
    } else if (_finished) {
      final minutes = DateTime.now().difference(_startedAt!).inMinutes;
      body = Center(
        child: Padding(
          padding: const EdgeInsets.all(Space.x4),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.check_circle_outline, size: 64, color: accent),
            const SizedBox(height: Space.x2),
            Text(l.workoutComplete, style: t.headlineSmall),
            const SizedBox(height: Space.x1),
            Text(l.workoutSummary(_completed.length, w.exercises.length, minutes),
                textAlign: TextAlign.center),
            const SizedBox(height: Space.x3),
            FilledButton(
                onPressed: () => context.pop(), child: Text(l.workoutDone)),
          ]),
        ),
      );
    } else {
      final step = _steps[_index];
      final timer = _timer;
      final upcoming = step.isRest ? w.exercises[step.exerciseIndex] : null;
      final paused = timer?.pausedAt != null;
      final isLast = _index == _steps.length - 1;
      body = ListView(
        padding: const EdgeInsets.all(Space.x2),
        children: [
          Text(
            '${(step.exerciseIndex + (step.isRest ? 0 : 1)).clamp(1, w.exercises.length)} / ${w.exercises.length}',
            textAlign: TextAlign.center,
            style: t.bodySmall,
          ),
          const SizedBox(height: Space.x1),
          Text(step.isRest ? l.workoutRest : step.exercise!.name,
              textAlign: TextAlign.center,
              style: t.headlineSmall?.copyWith(color: accent)),
          const SizedBox(height: Space.x2),
          if (timer != null)
            Semantics(
              label: formatClock(timer.remaining(_now)),
              child: ExcludeSemantics(
                child: Text(formatClock(timer.remaining(_now)),
                    textAlign: TextAlign.center, style: t.displaySmall),
              ),
            )
          else
            Text(l.workoutReps(step.exercise!.reps!),
                textAlign: TextAlign.center, style: t.displaySmall),
          const SizedBox(height: Space.x2),
          if (step.isRest)
            Text(l.workoutUpNext(upcoming!.name),
                textAlign: TextAlign.center, style: t.titleMedium)
          else ...[
            Text(step.exercise!.instructions, style: t.bodyLarge),
            const SizedBox(height: Space.x1),
            Text(l.workoutEasier(step.exercise!.modification),
                style: t.bodyMedium),
          ],
          const SizedBox(height: Space.x3),
          if (timer != null)
            OutlinedButton.icon(
              onPressed: _togglePause,
              icon: Icon(paused ? Icons.play_arrow : Icons.pause),
              label: Text(paused ? l.focusResume : l.focusPause),
            ),
          if (!step.isRest && timer == null) ...[
            FilledButton(
              onPressed: () => _advance(markDone: true),
              child: Text(isLast ? l.workoutComplete : l.workoutDone),
            ),
          ],
          const SizedBox(height: Space.x1),
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _index == 0 ? null : _previous,
                child: Text(l.workoutPrevious),
              ),
            ),
            const SizedBox(width: Space.x1),
            Expanded(
              child: OutlinedButton(
                onPressed: () => _advance(),
                child: Text(l.workoutSkip),
              ),
            ),
          ]),
          const SizedBox(height: Space.x1),
          TextButton(onPressed: _finish, child: Text(l.workoutEnd)),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(w.name)),
      body: SafeArea(child: body),
    );
  }
}
