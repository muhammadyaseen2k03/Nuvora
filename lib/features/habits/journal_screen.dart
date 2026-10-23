import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../data/database.dart';
import '../../l10n/gen/app_localizations.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final entries = ref.watch(journalEntriesProvider(_query)).value ?? const [];
    final profileId = ref.watch(activeProfileIdProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.journalTitle)),
      floatingActionButton: profileId == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _edit(context, profileId, DateTime.now()),
              icon: const Icon(Icons.edit_outlined),
              label: Text(l.journalToday),
            ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
            Space.x2, Space.x1, Space.x2, Space.x5 * 2),
        children: [
          Text(l.journalPrivate, style: t.bodySmall),
          const SizedBox(height: Space.x2),
          TextField(
            decoration: InputDecoration(
              labelText: l.journalSearch,
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
          const SizedBox(height: Space.x2),
          if (entries.isEmpty)
            Padding(
              padding: const EdgeInsets.all(Space.x3),
              child: Text(l.journalNoEntries, textAlign: TextAlign.center),
            )
          else
            for (final e in entries)
              Padding(
                padding: const EdgeInsets.only(bottom: Space.x1),
                child: Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(Radii.card),
                    onTap: profileId == null
                        ? null
                        : () => _edit(context, profileId, DateTime.parse(e.day)),
                    child: Padding(
                      padding: const EdgeInsets.all(Space.x2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Expanded(
                              child: Text(
                                DateFormat.yMMMMEEEEd(l.localeName)
                                    .format(DateTime.parse(e.day)),
                                style: t.titleSmall,
                              ),
                            ),
                            IconButton(
                              tooltip: l.delete,
                              icon: const Icon(Icons.delete_outline),
                              onPressed: profileId == null
                                  ? null
                                  : () => _confirmDelete(context, profileId, e),
                            ),
                          ]),
                          _answer(context, l.journalPromptWell, e.wentWell),
                          _answer(context, l.journalPromptLearned, e.learned),
                          _answer(context, l.journalPromptImprove, e.improve),
                          _answer(context, l.journalPromptGrateful, e.grateful),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget _answer(BuildContext context, String prompt, String text) {
    if (text.isEmpty) return const SizedBox.shrink();
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: Space.x1),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(prompt, style: t.labelMedium),
        Text(text),
      ]),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, String profileId, JournalEntry e) async {
    final l = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.journalDeleteTitle),
        content: Text(l.journalDeleteBody),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel)),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true), child: Text(l.delete)),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(journalRepositoryProvider).delete(profileId, e.id);
    }
  }

  Future<void> _edit(
      BuildContext context, String profileId, DateTime day) async {
    final l = AppLocalizations.of(context);
    final repo = ref.read(journalRepositoryProvider);
    final existing = await repo.forDay(profileId, day);
    if (!context.mounted) return;
    final well = TextEditingController(text: existing?.wentWell ?? '');
    final learned = TextEditingController(text: existing?.learned ?? '');
    final improve = TextEditingController(text: existing?.improve ?? '');
    final grateful = TextEditingController(text: existing?.grateful ?? '');

    Widget field(TextEditingController c, String label) => Padding(
          padding: const EdgeInsets.only(bottom: Space.x2),
          child: TextField(
            controller: c,
            minLines: 2,
            maxLines: 5,
            maxLength: 1000,
            decoration: InputDecoration(labelText: label),
          ),
        );

    final save = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: Space.x3,
          right: Space.x3,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + Space.x3,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(DateFormat.yMMMMEEEEd(l.localeName).format(day),
                  style: Theme.of(ctx).textTheme.titleLarge),
              const SizedBox(height: Space.x2),
              field(well, l.journalPromptWell),
              field(learned, l.journalPromptLearned),
              field(improve, l.journalPromptImprove),
              field(grateful, l.journalPromptGrateful),
              FilledButton(
                  onPressed: () => Navigator.pop(ctx, true), child: Text(l.save)),
            ],
          ),
        ),
      ),
    );
    if (save == true) {
      await repo.save(profileId, day,
          wentWell: well.text,
          learned: learned.text,
          improve: improve.text,
          grateful: grateful.text);
    }
  }
}
