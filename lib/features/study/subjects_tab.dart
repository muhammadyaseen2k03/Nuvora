import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';

/// Asks for a single line of text. Returns null when cancelled or empty.
Future<String?> askText(BuildContext context,
    {required String title, required String label, String actionLabel = ''}) {
  final l = AppLocalizations.of(context);
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  return showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          autofocus: true,
          maxLength: 80,
          decoration: InputDecoration(labelText: label),
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? l.cardRequired : null,
          onFieldSubmitted: (_) {
            if (formKey.currentState!.validate()) {
              Navigator.pop(ctx, controller.text.trim());
            }
          },
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l.cancel)),
        FilledButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              Navigator.pop(ctx, controller.text.trim());
            }
          },
          child: Text(actionLabel.isEmpty ? l.save : actionLabel),
        ),
      ],
    ),
  );
}

class SubjectsTab extends ConsumerWidget {
  const SubjectsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final profileId = ref.watch(activeProfileIdProvider);
    final progress = ref.watch(subjectProgressProvider).value ?? const [];
    final exams = ref.watch(upcomingExamsProvider).value ?? const [];
    final accent = NuvoraSection.mind.accent(Theme.of(context).brightness);
    final repo = ref.read(studyRepositoryProvider);
    if (profileId == null) return const SizedBox.shrink();
    final today = DateTime.now();
    final startOfToday = DateTime(today.year, today.month, today.day);

    return ListView(
      padding: const EdgeInsets.all(Space.x2),
      children: [
        Row(children: [
          Expanded(child: Text(l.examsTitle, style: t.titleMedium)),
          TextButton.icon(
            onPressed: () => _addExam(context, ref, profileId),
            icon: const Icon(Icons.add),
            label: Text(l.examAdd),
          ),
        ]),
        if (exams.isEmpty)
          Padding(
              padding: const EdgeInsets.symmetric(vertical: Space.x1),
              child: Text(l.examsEmpty))
        else
          for (final e in exams)
            Card(
              child: ListTile(
                leading: Icon(Icons.event_outlined, color: accent),
                title: Text(e.name),
                subtitle: Text(DateFormat.yMMMd(l.localeName).format(e.examAt)),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(l.examDaysLeft(DateTime(
                          e.examAt.year, e.examAt.month, e.examAt.day)
                      .difference(startOfToday)
                      .inDays)),
                  IconButton(
                    tooltip: l.delete,
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => repo.deleteExam(profileId, e.id),
                  ),
                ]),
              ),
            ),
        const SizedBox(height: Space.x3),
        Row(children: [
          Expanded(child: Text(l.studyTabSubjects, style: t.titleMedium)),
          TextButton.icon(
            onPressed: () async {
              final name = await askText(context,
                  title: l.subjectAdd, label: l.subjectName);
              if (name != null) await repo.addSubject(profileId, name);
            },
            icon: const Icon(Icons.add),
            label: Text(l.subjectAdd),
          ),
        ]),
        if (progress.isEmpty)
          Padding(
              padding: const EdgeInsets.symmetric(vertical: Space.x2),
              child: Text(l.subjectsEmpty))
        else
          for (final p in progress)
            Padding(
              padding: const EdgeInsets.only(bottom: Space.x1),
              child: Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(Radii.card),
                  onTap: () => context.push('/study/subject/${p.subject.id}'),
                  child: Padding(
                    padding: const EdgeInsets.all(Space.x2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.subject.name, style: t.titleMedium),
                        const SizedBox(height: Space.x1),
                        Semantics(
                          label: l.subjectProgress(p.completed, p.total),
                          child: LinearProgressIndicator(
                            value: p.fraction,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(4),
                            color: accent,
                            backgroundColor: accent.withValues(alpha: 0.16),
                          ),
                        ),
                        const SizedBox(height: Space.x1 / 2),
                        Text(l.subjectProgress(p.completed, p.total),
                            style: t.bodySmall),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ],
    );
  }

  Future<void> _addExam(
      BuildContext context, WidgetRef ref, String profileId) async {
    final l = AppLocalizations.of(context);
    final name =
        await askText(context, title: l.examAdd, label: l.examName);
    if (name == null || !context.mounted) return;
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      helpText: l.examDate,
      initialDate: now.add(const Duration(days: 7)),
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (date == null) return;
    await ref.read(studyRepositoryProvider).addExam(profileId, name, date);
  }
}
