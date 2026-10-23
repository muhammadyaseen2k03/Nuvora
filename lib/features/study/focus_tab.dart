import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import 'focus_timer.dart';

String focusKindLabel(AppLocalizations l, FocusKind k) => switch (k) {
      FocusKind.focus => l.focusKindFocus,
      FocusKind.shortBreak => l.focusKindShort,
      FocusKind.longBreak => l.focusKindLong,
    };

String formatClock(Duration d) {
  final total = d.inSeconds < 0 ? 0 : d.inSeconds;
  final m = (total ~/ 60).toString().padLeft(2, '0');
  final s = (total % 60).toString().padLeft(2, '0');
  return '$m:$s';
}

class FocusTab extends ConsumerStatefulWidget {
  const FocusTab({super.key});

  @override
  ConsumerState<FocusTab> createState() => _FocusTabState();
}

class _FocusTabState extends ConsumerState<FocusTab> {
  Timer? _ticker;
  DateTime _now = DateTime.now();
  FocusKind _kind = FocusKind.focus;
  int _minutes = PomodoroPreset.classic.focusMin;
  String? _subjectId;
  bool _completing = false;

  @override
  void initState() {
    super.initState();
    // Display tick only. Remaining time is always derived from timestamps.
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
      _maybeComplete();
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _maybeComplete() async {
    final s = ref.read(activeSessionProvider).value;
    if (s == null || _completing) return;
    _completing = true;
    try {
      await ref.read(studyRepositoryProvider).completeIfDue(s);
    } finally {
      _completing = false;
    }
  }

  int _presetMinutes(PomodoroPreset p, FocusKind k) => switch (k) {
        FocusKind.focus => p.focusMin,
        FocusKind.shortBreak => p.shortBreakMin,
        FocusKind.longBreak => p.longBreakMin,
      };

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final repo = ref.read(studyRepositoryProvider);
    final profileId = ref.watch(activeProfileIdProvider);
    final session = ref.watch(activeSessionProvider).value;
    final subjects = ref.watch(subjectsProvider).value ?? const [];
    final today = ref.watch(todayFocusProvider).value ?? const [];
    final accent = NuvoraSection.mind.accent(Theme.of(context).brightness);
    if (profileId == null) return const SizedBox.shrink();

    final doneToday = today.where((s) => !s.cancelled).toList();
    final doneMinutes = doneToday.fold<int>(
        0, (sum, s) => sum + repo.timerOf(s).elapsed(s.endedAt!).inMinutes);

    Widget body;
    if (session != null) {
      final timer = repo.timerOf(session);
      final remaining = timer.remaining(_now);
      final paused = session.pausedAt != null;
      final subject = subjects.where((s) => s.id == session.subjectId);
      body = Column(
        children: [
          Text(focusKindLabel(l, timer.kind),
              style: t.titleMedium?.copyWith(color: accent)),
          if (subject.isNotEmpty) Text(subject.first.name),
          const SizedBox(height: Space.x3),
          Semantics(
            label: formatClock(remaining),
            child: SizedBox(
              width: 240,
              height: 240,
              child: Stack(alignment: Alignment.center, children: [
                SizedBox.expand(
                  child: CircularProgressIndicator(
                    value: session.plannedSeconds == 0
                        ? 0
                        : timer.elapsed(_now).inSeconds /
                            session.plannedSeconds,
                    strokeWidth: 10,
                    color: accent,
                    backgroundColor: accent.withValues(alpha: 0.16),
                  ),
                ),
                ExcludeSemantics(
                  child: Text(formatClock(remaining),
                      style: t.displaySmall?.copyWith(
                          fontFeatures: const [FontFeature.tabularFigures()])),
                ),
              ]),
            ),
          ),
          const SizedBox(height: Space.x3),
          Row(children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () => paused
                    ? repo.resumeSession(session)
                    : repo.pauseSession(session),
                icon: Icon(paused ? Icons.play_arrow : Icons.pause),
                label: Text(paused ? l.focusResume : l.focusPause),
              ),
            ),
            const SizedBox(width: Space.x1),
            Expanded(
              child: OutlinedButton(
                onPressed: () => repo.cancelSession(session),
                child: Text(l.focusCancel),
              ),
            ),
          ]),
        ],
      );
    } else {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SegmentedButton<FocusKind>(
            segments: [
              for (final k in FocusKind.values)
                ButtonSegment(value: k, label: Text(focusKindLabel(l, k))),
            ],
            selected: {_kind},
            onSelectionChanged: (s) => setState(() {
              _kind = s.first;
              _minutes = _presetMinutes(PomodoroPreset.classic, _kind);
            }),
          ),
          const SizedBox(height: Space.x3),
          Center(child: Text(l.focusMinutes(_minutes), style: t.displaySmall)),
          Slider(
            value: _minutes.toDouble(),
            min: 1,
            max: 120,
            divisions: 119,
            label: '$_minutes',
            onChanged: (v) => setState(() => _minutes = v.round()),
          ),
          Wrap(spacing: Space.x1, children: [
            for (final p in PomodoroPreset.all)
              ActionChip(
                label: Text(l.focusMinutes(_presetMinutes(p, _kind))),
                onPressed: () =>
                    setState(() => _minutes = _presetMinutes(p, _kind)),
              ),
          ]),
          const SizedBox(height: Space.x2),
          if (_kind == FocusKind.focus)
            DropdownButtonFormField<String?>(
              initialValue: _subjectId,
              isExpanded: true,
              decoration: InputDecoration(labelText: l.focusSubjectOptional),
              items: [
                DropdownMenuItem(value: null, child: Text(l.focusNoSubject)),
                for (final s in subjects)
                  DropdownMenuItem(value: s.id, child: Text(s.name)),
              ],
              onChanged: (v) => setState(() => _subjectId = v),
            ),
          const SizedBox(height: Space.x3),
          FilledButton.icon(
            onPressed: () => repo.startSession(
              profileId,
              kind: _kind,
              plannedSeconds: _minutes * 60,
              subjectId: _kind == FocusKind.focus ? _subjectId : null,
            ),
            icon: const Icon(Icons.play_arrow),
            label: Text(l.focusStart),
          ),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.all(Space.x2),
      children: [
        body,
        const SizedBox(height: Space.x3),
        Text(l.focusTodaySummary(doneToday.length, doneMinutes),
            style: t.bodyMedium, textAlign: TextAlign.center),
      ],
    );
  }
}
