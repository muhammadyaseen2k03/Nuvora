import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../data/database.dart';
import '../../l10n/gen/app_localizations.dart';
import 'srs.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  List<Flashcard>? _queue;
  int _index = 0;
  bool _revealed = false;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final id = ref.read(activeProfileIdProvider);
    if (id == null) return;
    // The queue is fixed when the session starts; rated cards leave it.
    final due = await ref.read(studyRepositoryProvider).dueCards(id);
    if (mounted) setState(() => _queue = due);
  }

  Future<void> _rate(Rating r) async {
    if (_busy) return;
    final id = ref.read(activeProfileIdProvider);
    if (id == null) return;
    setState(() => _busy = true);
    await ref.read(studyRepositoryProvider).reviewCard(id, _queue![_index], r);
    if (!mounted) return;
    setState(() {
      _index++;
      _revealed = false;
      _busy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final accent = NuvoraSection.mind.accent(Theme.of(context).brightness);
    final queue = _queue;

    Widget body;
    if (queue == null) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_index >= queue.length) {
      body = Center(
        child: Padding(
          padding: const EdgeInsets.all(Space.x4),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.check_circle_outline, size: 56, color: accent),
            const SizedBox(height: Space.x2),
            Text(l.reviewAllDone,
                style: t.titleMedium, textAlign: TextAlign.center),
          ]),
        ),
      );
    } else {
      final card = queue[_index];
      body = Padding(
        padding: const EdgeInsets.all(Space.x2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l.reviewProgress(_index + 1, queue.length),
                textAlign: TextAlign.center, style: t.bodySmall),
            const SizedBox(height: Space.x1),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(Space.x3),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(card.front, style: t.titleLarge),
                        if (_revealed) ...[
                          const Divider(height: Space.x4),
                          Text(card.back, style: t.bodyLarge),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: Space.x2),
            if (!_revealed)
              FilledButton(
                onPressed: () => setState(() => _revealed = true),
                child: Text(l.cardShowAnswer),
              )
            else
              Row(children: [
                for (final r in Rating.values)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: OutlinedButton(
                        onPressed: _busy ? null : () => _rate(r),
                        child: Text(
                          switch (r) {
                            Rating.again => l.ratingAgain,
                            Rating.hard => l.ratingHard,
                            Rating.good => l.ratingGood,
                            Rating.easy => l.ratingEasy,
                          },
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
              ]),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.cardsReview)),
      body: SafeArea(child: body),
    );
  }
}
