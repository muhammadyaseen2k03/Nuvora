import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import '../prayer/prayer_screen.dart' show prayerLabel;
import '../prayer/prayer_service.dart';
import 'plan_generator.dart';
import 'planner.dart';
import 'planner_repository.dart';

String reasonText(AppLocalizations l, String? code) => switch (code) {
      'exam_soon' => l.reasonExamSoon,
      'cards_due' => l.reasonCardsDue,
      'topic_pending' => l.reasonTopicPending,
      'workout_goal' => l.reasonWorkoutGoal,
      _ => '',
    };

IconData kindIcon(String kind) => switch (kind) {
      'study' => Icons.menu_book_outlined,
      'review' => Icons.style_outlined,
      'workout' => Icons.fitness_center,
      _ => Icons.event_note_outlined,
    };

/// Where the "Begin" action for a kind of activity leads.
String? routeFor(String kind) => switch (kind) {
      'study' => '/study',
      'review' => '/study/review',
      'workout' => '/fitness',
      _ => null,
    };

class PlannerScreen extends ConsumerStatefulWidget {
  const PlannerScreen({super.key});

  @override
  ConsumerState<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends ConsumerState<PlannerScreen> {
  List<String> _notFit = const [];
  bool _generated = false;

  Future<void> _generate() async {
    final l = AppLocalizations.of(context);
    final id = ref.read(activeProfileIdProvider);
    if (id == null) return;
    final now = ref.read(clockProvider)();
    final day = DateTime(now.year, now.month, now.day);

    final prayerSettings = await ref.read(prayerSettingsProvider.future);
    final prayerTimes = <String, DateTime>{};
    if (prayerSettings?.latitude != null && prayerSettings?.longitude != null) {
      final times = const PrayerService().forDay(
        PrayerConfig(
          method: prayerSettings!.method,
          asrMethod: prayerSettings.asrMethod,
          latitude: prayerSettings.latitude!,
          longitude: prayerSettings.longitude!,
        ),
        day,
      );
      for (final p in PrayerName.values) {
        // Plan around the five prayers; times earlier than "now" are
        // harmless because the planner starts after now.
        prayerTimes[prayerLabel(l, p)] = times.times[p]!;
      }
    }

    final study = ref.read(studyRepositoryProvider);
    final dueCards = (await study.dueCards(id)).length;
    final exams = await ref.read(upcomingExamsProvider.future);
    final progress = await ref.read(subjectProgressProvider.future);
    final topics = <TopicInfo>[];
    for (final p in progress) {
      if (p.total == p.completed) continue;
      final rows = await study.watchTopics(id, p.subject.id).first;
      for (final t in rows.where((t) => t.status != 'completed')) {
        topics.add(TopicInfo('${p.subject.name}: ${t.title}', t.priority,
            dueInDays: t.dueDate?.difference(day).inDays));
      }
    }
    final prefs = await ref.read(preferencesProvider.future);

    // Keep pinned, done and skipped items; they are never discarded.
    final existing =
        await ref.read(plannerRepositoryProvider).watchDay(id, day).first;
    final kept = [
      for (final a in existing)
        if (a.pinned || a.status != ActivityStatus.planned.name)
          FixedBlock(a.title, a.startAt, a.endAt),
    ];

    final result = generatePlan(PlanInputs(
      day: day,
      now: now,
      prayerTimes: prayerTimes,
      dueCards: dueCards,
      exams: [
        for (final e in exams)
          ExamInfo(
              e.name,
              DateTime(e.examAt.year, e.examAt.month, e.examAt.day)
                  .difference(day)
                  .inDays),
      ],
      topics: topics,
      workoutMinutes: prefs?.workoutMinutes ?? 0,
      reviewTitle: l.cardsReview,
      workoutTitle: l.tileWorkout,
      kept: kept,
    ));
    await ref
        .read(plannerRepositoryProvider)
        .replaceSuggestions(id, day, result.blocks);
    if (mounted) {
      setState(() {
        _notFit = [for (final u in result.unscheduled) u.task.title];
        _generated = true;
      });
    }
  }

  Future<void> _addOwn() async {
    final l = AppLocalizations.of(context);
    final id = ref.read(activeProfileIdProvider);
    if (id == null) return;
    final title = TextEditingController();
    var start = const TimeOfDay(hour: 9, minute: 0);
    var end = const TimeOfDay(hour: 10, minute: 0);
    final formKey = GlobalKey<FormState>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(l.plannerAddOwn),
          content: Form(
            key: formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                controller: title,
                autofocus: true,
                maxLength: 80,
                decoration: InputDecoration(labelText: l.plannerActivityTitle),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? l.cardRequired : null,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.plannerStartTime),
                trailing: Text(start.format(ctx)),
                onTap: () async {
                  final p = await showTimePicker(context: ctx, initialTime: start);
                  if (p != null) setState(() => start = p);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.plannerEndTime),
                trailing: Text(end.format(ctx)),
                onTap: () async {
                  final p = await showTimePicker(context: ctx, initialTime: end);
                  if (p != null) setState(() => end = p);
                },
              ),
            ]),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l.cancel)),
            FilledButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                if (end.hour * 60 + end.minute <= start.hour * 60 + start.minute) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                      SnackBar(content: Text(l.plannerEndAfterStart)));
                  return;
                }
                Navigator.pop(ctx, true);
              },
              child: Text(l.save),
            ),
          ],
        ),
      ),
    );
    if (ok == true) {
      final now = DateTime.now();
      await ref.read(plannerRepositoryProvider).addManual(
            id,
            now,
            title: title.text,
            start: DateTime(now.year, now.month, now.day, start.hour, start.minute),
            end: DateTime(now.year, now.month, now.day, end.hour, end.minute),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    // Watched so these streams stay active; generation reads their data.
    ref.watch(upcomingExamsProvider);
    ref.watch(subjectProgressProvider);
    final items = ref.watch(todayPlanProvider).value ?? const [];
    final id = ref.watch(activeProfileIdProvider);
    final repo = ref.read(plannerRepositoryProvider);
    final fmt = DateFormat.jm(l.localeName);

    return Scaffold(
      appBar: AppBar(title: Text(l.plannerTitle)),
      body: ListView(
        padding: const EdgeInsets.all(Space.x2),
        children: [
          Text(l.plannerNote, style: t.bodySmall),
          const SizedBox(height: Space.x2),
          Row(children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: _generate,
                icon: const Icon(Icons.auto_awesome_outlined),
                label: Text(items.isEmpty ? l.plannerGenerate : l.plannerRegenerate),
              ),
            ),
            const SizedBox(width: Space.x1),
            OutlinedButton.icon(
              onPressed: _addOwn,
              icon: const Icon(Icons.add),
              label: Text(l.plannerAddOwn),
            ),
          ]),
          const SizedBox(height: Space.x2),
          if (_notFit.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: Space.x1),
              child: Text(l.plannerNotScheduled(_notFit.join(', ')),
                  style: t.bodySmall),
            ),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.all(Space.x3),
              child: Text(_generated ? l.plannerNothing : l.plannerEmpty,
                  textAlign: TextAlign.center),
            )
          else
            for (final a in items)
              Padding(
                padding: const EdgeInsets.only(bottom: Space.x1),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Space.x2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Icon(kindIcon(a.kind)),
                          const SizedBox(width: Space.x1),
                          Expanded(
                            child: Text(
                              a.title,
                              style: t.titleSmall?.copyWith(
                                decoration: a.status == 'planned'
                                    ? null
                                    : TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          if (a.pinned) const Icon(Icons.push_pin, size: 16),
                          PopupMenuButton<String>(
                            onSelected: (v) async {
                              if (id == null) return;
                              switch (v) {
                                case 'done':
                                  await repo.setStatus(id, a.id, ActivityStatus.done);
                                case 'skip':
                                  await repo.setStatus(id, a.id, ActivityStatus.skipped);
                                case 'reopen':
                                  await repo.setStatus(id, a.id, ActivityStatus.planned);
                                case 'pin':
                                  await repo.setPinned(id, a.id, !a.pinned);
                                case 'delete':
                                  await repo.delete(id, a.id);
                              }
                            },
                            itemBuilder: (_) => [
                              if (a.status == 'planned') ...[
                                PopupMenuItem(value: 'done', child: Text(l.plannerDone)),
                                PopupMenuItem(value: 'skip', child: Text(l.plannerSkip)),
                              ] else
                                PopupMenuItem(value: 'reopen', child: Text(l.plannerReopen)),
                              PopupMenuItem(
                                  value: 'pin',
                                  child: Text(a.pinned ? l.plannerUnpin : l.plannerPin)),
                              PopupMenuItem(value: 'delete', child: Text(l.plannerRemove)),
                            ],
                          ),
                        ]),
                        Text('${fmt.format(a.startAt)} – ${fmt.format(a.endAt)}'
                            '${a.status == 'done' ? ' · ${l.statusDone}' : a.status == 'skipped' ? ' · ${l.statusSkipped}' : ''}'),
                        if (reasonText(l, a.reason).isNotEmpty)
                          Text(reasonText(l, a.reason), style: t.bodySmall),
                        if (a.status == 'planned' && routeFor(a.kind) != null)
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: TextButton(
                              onPressed: () => context.go(routeFor(a.kind)!),
                              child: Text(l.plannerBegin),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
