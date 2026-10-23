import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../data/database.dart';
import '../../l10n/gen/app_localizations.dart';
import 'study_repository.dart';

String topicStatusLabel(AppLocalizations l, String status) => switch (status) {
      'inProgress' => l.topicStatusInProgress,
      'completed' => l.topicStatusCompleted,
      _ => l.topicStatusNotStarted,
    };

String priorityLabel(AppLocalizations l, int p) => switch (p) {
      1 => l.topicPriorityHigh,
      3 => l.topicPriorityLow,
      _ => l.topicPriorityMedium,
    };

class SubjectScreen extends ConsumerWidget {
  const SubjectScreen({super.key, required this.subjectId});

  final String subjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final profileId = ref.watch(activeProfileIdProvider);
    final subjects = ref.watch(subjectsProvider).value ?? const [];
    final subject = subjects.where((s) => s.id == subjectId);
    if (profileId == null) return const SizedBox.shrink();
    final repo = ref.read(studyRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(subject.isEmpty ? '' : subject.first.name),
        actions: [
          IconButton(
            tooltip: l.delete,
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(l.delete),
                  content: Text(l.subjectDeleteBody),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: Text(l.cancel)),
                    FilledButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: Text(l.delete)),
                  ],
                ),
              );
              if (ok == true) {
                await repo.deleteSubject(profileId, subjectId);
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addTopic(context, ref, profileId),
        icon: const Icon(Icons.add),
        label: Text(l.topicAdd),
      ),
      body: StreamBuilder<List<SyllabusTopic>>(
        stream: repo.watchTopics(profileId, subjectId),
        builder: (context, snap) {
          final topics = snap.data ?? const [];
          if (snap.connectionState == ConnectionState.waiting &&
              topics.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (topics.isEmpty) {
            return Center(
                child: Padding(
                    padding: const EdgeInsets.all(Space.x4),
                    child: Text(l.topicsEmpty, textAlign: TextAlign.center)));
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(
                Space.x2, Space.x2, Space.x2, Space.x5 * 2),
            children: [
              for (final t in topics)
                Padding(
                  padding: const EdgeInsets.only(bottom: Space.x1),
                  child: Card(
                    child: ListTile(
                      leading: Icon(switch (t.status) {
                        'completed' => Icons.check_circle,
                        'inProgress' => Icons.timelapse,
                        _ => Icons.radio_button_unchecked,
                      }),
                      title: Text(t.title),
                      subtitle: Text([
                        topicStatusLabel(l, t.status),
                        '${l.topicPriority}: ${priorityLabel(l, t.priority)}',
                        if (t.estimateMinutes != null)
                          l.focusMinutes(t.estimateMinutes!),
                      ].join(' · ')),
                      trailing: PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'delete') {
                            repo.deleteTopic(profileId, t.id);
                          } else {
                            repo.setTopicStatus(
                                profileId, t.id, TopicStatus.values.byName(v));
                          }
                        },
                        itemBuilder: (_) => [
                          for (final s in TopicStatus.values)
                            PopupMenuItem(
                                value: s.name,
                                child: Text(topicStatusLabel(l, s.name))),
                          PopupMenuItem(
                              value: 'delete', child: Text(l.delete)),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addTopic(
      BuildContext context, WidgetRef ref, String profileId) async {
    final l = AppLocalizations.of(context);
    final title = TextEditingController();
    final minutes = TextEditingController();
    final formKey = GlobalKey<FormState>();
    var priority = 2;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(l.topicAdd),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                  controller: title,
                  autofocus: true,
                  maxLength: 120,
                  decoration: InputDecoration(labelText: l.topicTitle),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? l.cardRequired : null,
                ),
                const SizedBox(height: Space.x1),
                SegmentedButton<int>(
                  segments: [
                    ButtonSegment(value: 1, label: Text(l.topicPriorityHigh)),
                    ButtonSegment(value: 2, label: Text(l.topicPriorityMedium)),
                    ButtonSegment(value: 3, label: Text(l.topicPriorityLow)),
                  ],
                  selected: {priority},
                  onSelectionChanged: (s) => setState(() => priority = s.first),
                ),
                const SizedBox(height: Space.x2),
                TextFormField(
                  controller: minutes,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: l.topicEstimate),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null;
                    final n = int.tryParse(v.trim());
                    return (n == null || n < 1 || n > 6000)
                        ? l.prayerInvalidNumber
                        : null;
                  },
                ),
              ]),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l.cancel)),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) Navigator.pop(ctx, true);
              },
              child: Text(l.save),
            ),
          ],
        ),
      ),
    );
    if (ok == true) {
      await ref.read(studyRepositoryProvider).addTopic(
            profileId,
            subjectId,
            title.text,
            priority: priority,
            estimateMinutes: int.tryParse(minutes.text.trim()),
          );
    }
  }
}
