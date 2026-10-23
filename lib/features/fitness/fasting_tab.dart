import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import 'hydration.dart';

String formatHms(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$h:$m:$s';
}

class FastingTab extends ConsumerStatefulWidget {
  const FastingTab({super.key});

  @override
  ConsumerState<FastingTab> createState() => _FastingTabState();
}

class _FastingTabState extends ConsumerState<FastingTab> {
  Timer? _ticker;
  DateTime _now = DateTime.now();
  int? _plannedHours = 16;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final profileId = ref.watch(activeProfileIdProvider);
    final active = ref.watch(activeFastProvider).value;
    final history = ref.watch(fastHistoryProvider).value ?? const [];
    final accent = NuvoraSection.body.accent(Theme.of(context).brightness);
    final repo = ref.read(fitnessRepositoryProvider);
    if (profileId == null) return const SizedBox.shrink();

    Widget main;
    if (active != null) {
      final fast = Fast(
          startedAt: active.startedAt, plannedSeconds: active.plannedSeconds);
      final remaining = fast.remaining(_now);
      main = Card(
        child: Padding(
          padding: const EdgeInsets.all(Space.x3),
          child: Column(children: [
            Text(l.fastElapsed, style: t.titleMedium?.copyWith(color: accent)),
            Semantics(
              label: formatHms(fast.elapsed(_now)),
              child: ExcludeSemantics(
                child: Text(formatHms(fast.elapsed(_now)),
                    style: t.displaySmall),
              ),
            ),
            if (remaining != null)
              Text(fast.reachedGoal(_now)
                  ? l.fastGoalReached
                  : l.fastRemaining(formatHms(remaining))),
            const SizedBox(height: Space.x2),
            FilledButton(
              onPressed: () => repo.endFast(profileId, active.id),
              child: Text(l.fastEnd),
            ),
          ]),
        ),
      );
    } else {
      main = Card(
        child: Padding(
          padding: const EdgeInsets.all(Space.x3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l.fastTarget, style: t.titleMedium),
              const SizedBox(height: Space.x1),
              Wrap(spacing: Space.x1, children: [
                for (final h in const [12, 14, 16, 18])
                  ChoiceChip(
                    label: Text(l.fastHours(h)),
                    selected: _plannedHours == h,
                    onSelected: (_) => setState(() => _plannedHours = h),
                  ),
                ChoiceChip(
                  label: Text(l.fastNoTarget),
                  selected: _plannedHours == null,
                  onSelected: (_) => setState(() => _plannedHours = null),
                ),
              ]),
              const SizedBox(height: Space.x2),
              FilledButton(
                onPressed: () => repo.startFast(profileId,
                    plannedSeconds:
                        _plannedHours == null ? null : _plannedHours! * 3600),
                child: Text(l.fastStart),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(Space.x2),
      children: [
        main,
        const SizedBox(height: Space.x1),
        Text(l.fastSafety, style: t.bodySmall),
        const SizedBox(height: Space.x3),
        Text(l.fastHistory, style: t.titleMedium),
        const SizedBox(height: Space.x1),
        if (history.isEmpty)
          Text(l.fastHistoryEmpty)
        else
          for (final f in history)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.timer_outlined),
              title: Text(formatHms(f.endedAt!.difference(f.startedAt))),
              subtitle: Text(
                  DateFormat.MMMd(l.localeName).add_jm().format(f.startedAt)),
            ),
      ],
    );
  }
}
