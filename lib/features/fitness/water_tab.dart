import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import 'fitness_repository.dart';
import 'hydration.dart';

class WaterTab extends ConsumerWidget {
  const WaterTab({super.key});

  static const quickAmounts = [150, 250, 500];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final profileId = ref.watch(activeProfileIdProvider);
    final logs = ref.watch(waterLogsProvider).value ?? const [];
    final goal = ref.watch(preferencesProvider).value?.waterGoalMl ?? 2000;
    final accent = NuvoraSection.body.accent(Theme.of(context).brightness);
    final repo = ref.read(fitnessRepositoryProvider);
    if (profileId == null) return const SizedBox.shrink();

    final now = DateTime.now();
    final totals = FitnessRepository.dailyTotals(logs, now, 7);
    final today = totals.last.ml;

    Future<void> add(int ml) async {
      try {
        await repo.addWater(profileId, ml);
      } on ArgumentError {
        // Out-of-range amounts are rejected by the dialog validator; nothing
        // to do if one slips through.
      }
    }

    return ListView(
      padding: const EdgeInsets.all(Space.x2),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Space.x3),
            child: Column(children: [
              SizedBox(
                width: 160,
                height: 160,
                child: Stack(alignment: Alignment.center, children: [
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: goalFraction(today, goal),
                      strokeWidth: 12,
                      color: accent,
                      backgroundColor: accent.withValues(alpha: 0.16),
                    ),
                  ),
                  Text('$today ml', style: t.headlineSmall),
                ]),
              ),
              const SizedBox(height: Space.x2),
              Text(l.waterToday(today, goal), style: t.titleMedium),
            ]),
          ),
        ),
        const SizedBox(height: Space.x2),
        Wrap(spacing: Space.x1, runSpacing: Space.x1, children: [
          for (final ml in quickAmounts)
            FilledButton.tonal(
              onPressed: () => add(ml),
              child: Text(l.waterAddMl(ml)),
            ),
          OutlinedButton(
            onPressed: () async {
              final ml = await _askAmount(context, l.waterCustom, l.waterAmount, 1, 5000);
              if (ml != null) await add(ml);
            },
            child: Text(l.waterCustom),
          ),
          TextButton.icon(
            onPressed: logs.isEmpty ? null : () => repo.undoLastWater(profileId),
            icon: const Icon(Icons.undo),
            label: Text(l.waterUndo),
          ),
        ]),
        const SizedBox(height: Space.x3),
        Text(l.waterHistory, style: t.titleMedium),
        const SizedBox(height: Space.x1),
        for (final d in totals.reversed)
          Semantics(
            label:
                '${DateFormat.MMMEd(l.localeName).format(d.day)}: ${l.waterToday(d.ml, goal)}',
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(children: [
                SizedBox(
                    width: 96,
                    child: Text(DateFormat.MMMEd(l.localeName).format(d.day),
                        style: t.bodySmall)),
                Expanded(
                  child: LinearProgressIndicator(
                    value: goalFraction(d.ml, goal),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                    color: accent,
                    backgroundColor: accent.withValues(alpha: 0.16),
                  ),
                ),
                const SizedBox(width: Space.x1),
                SizedBox(
                    width: 64,
                    child: Text('${d.ml}',
                        textAlign: TextAlign.end, style: t.bodySmall)),
              ]),
            ),
          ),
        const SizedBox(height: Space.x2),
        OutlinedButton(
          onPressed: () async {
            final g = await _askAmount(context, l.waterGoal, l.waterGoal, 250, 10000,
                initial: goal);
            if (g != null) await repo.setWaterGoal(profileId, g);
          },
          child: Text('${l.waterGoal}: $goal'),
        ),
        const SizedBox(height: Space.x1),
        Text(l.waterGoalNote, style: t.bodySmall),
      ],
    );
  }

  Future<int?> _askAmount(
      BuildContext context, String title, String label, int min, int max,
      {int? initial}) {
    final l = AppLocalizations.of(context);
    final controller = TextEditingController(text: initial?.toString() ?? '');
    final formKey = GlobalKey<FormState>();
    return showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: label),
            validator: (v) {
              final n = int.tryParse((v ?? '').trim());
              return (n == null || n < min || n > max)
                  ? l.prayerInvalidNumber
                  : null;
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l.cancel)),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(ctx, int.parse(controller.text.trim()));
              }
            },
            child: Text(l.save),
          ),
        ],
      ),
    );
  }
}
