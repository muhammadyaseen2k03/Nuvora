import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';

class CardsTab extends ConsumerWidget {
  const CardsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final profileId = ref.watch(activeProfileIdProvider);
    final cards = ref.watch(cardsProvider).value ?? const [];
    final reviews = ref.watch(recentReviewsProvider).value ?? const [];
    final repo = ref.read(studyRepositoryProvider);
    if (profileId == null) return const SizedBox.shrink();

    final now = DateTime.now();
    final dueCount = cards.where((c) => !c.dueAt.isAfter(now)).length;
    final recalled =
        reviews.where((r) => r.rating == 'good' || r.rating == 'easy').length;
    final retention =
        reviews.isEmpty ? 0 : (recalled * 100 / reviews.length).round();

    return ListView(
      padding: const EdgeInsets.all(Space.x2),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Space.x2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l.cardsDue(dueCount), style: t.titleLarge),
                const SizedBox(height: Space.x1 / 2),
                Text(reviews.isEmpty
                    ? l.cardsStatsNone
                    : l.cardsStats(reviews.length, retention)),
                const SizedBox(height: Space.x2),
                FilledButton.icon(
                  onPressed:
                      dueCount == 0 ? null : () => context.push('/study/review'),
                  icon: const Icon(Icons.style_outlined),
                  label: Text(l.cardsReview),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Space.x2),
        OutlinedButton.icon(
          onPressed: () => _addCard(context, ref, profileId),
          icon: const Icon(Icons.add),
          label: Text(l.cardAdd),
        ),
        const SizedBox(height: Space.x2),
        if (cards.isEmpty)
          Text(l.cardsEmpty, textAlign: TextAlign.center)
        else
          for (final c in cards)
            Padding(
              padding: const EdgeInsets.only(bottom: Space.x1),
              child: Card(
                child: ListTile(
                  title: Text(c.front, maxLines: 2, overflow: TextOverflow.ellipsis),
                  subtitle: Text(l.cardNextReview(
                      DateFormat.MMMd(l.localeName).format(c.dueAt))),
                  trailing: PopupMenuButton<String>(
                    onSelected: (v) => v == 'archive'
                        ? repo.setArchived(profileId, c.id, true)
                        : repo.deleteCard(profileId, c.id),
                    itemBuilder: (_) => [
                      PopupMenuItem(value: 'archive', child: Text(l.cardArchive)),
                      PopupMenuItem(value: 'delete', child: Text(l.cardDelete)),
                    ],
                  ),
                ),
              ),
            ),
      ],
    );
  }

  Future<void> _addCard(
      BuildContext context, WidgetRef ref, String profileId) async {
    final l = AppLocalizations.of(context);
    final front = TextEditingController();
    final back = TextEditingController();
    final formKey = GlobalKey<FormState>();
    String? validator(String? v) =>
        (v == null || v.trim().isEmpty) ? l.cardRequired : null;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.cardAdd),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                controller: front,
                autofocus: true,
                minLines: 2,
                maxLines: 4,
                maxLength: 2000,
                decoration: InputDecoration(labelText: l.cardFront),
                validator: validator,
              ),
              const SizedBox(height: Space.x1),
              TextFormField(
                controller: back,
                minLines: 2,
                maxLines: 6,
                maxLength: 4000,
                decoration: InputDecoration(labelText: l.cardBack),
                validator: validator,
              ),
            ]),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel)),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) Navigator.pop(ctx, true);
            },
            child: Text(l.save),
          ),
        ],
      ),
    );
    if (ok == true) {
      await ref
          .read(studyRepositoryProvider)
          .addCard(profileId, front.text, back.text);
    }
  }
}
