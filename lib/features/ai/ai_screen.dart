import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import '../insights/progress_screen.dart' show suggestionText;
import '../insights/weekly_report.dart';
import '../settings/cloud_section.dart' show cloudErrorText;
import 'ai_models.dart';
import 'ai_service.dart' show AiConsent;

String aiErrorText(AppLocalizations l, String code) => switch (code) {
      'consent_required' => l.aiErrConsent,
      'too_soon' => l.aiErrTooSoon,
      'rate_limited' => l.aiErrRateLimited,
      'input_too_long' => l.aiErrTooLong,
      'invalid_response' => l.aiErrInvalid,
      _ => cloudErrorText(l, code),
    };

class _Draft {
  _Draft(AiCard c)
      : front = TextEditingController(text: c.front),
        back = TextEditingController(text: c.back);
  bool selected = true;
  final TextEditingController front;
  final TextEditingController back;
  void dispose() {
    front.dispose();
    back.dispose();
  }
}

/// The optional AI assistant. Core tracking never depends on this screen, and
/// every request needs explicit consent.
class AiScreen extends ConsumerStatefulWidget {
  const AiScreen({super.key});

  @override
  ConsumerState<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends ConsumerState<AiScreen> {
  final _notes = TextEditingController();
  AiReply? _reply;
  List<_Draft> _drafts = [];
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _notes.dispose();
    for (final d in _drafts) {
      d.dispose();
    }
    super.dispose();
  }

  Future<void> _run(Future<AiReply> Function(String profileId) call) async {
    final id = ref.read(activeProfileIdProvider);
    if (id == null) return;
    final l = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final reply = await call(id);
      for (final d in _drafts) {
        d.dispose();
      }
      if (mounted) {
        setState(() {
          _reply = reply;
          _drafts = [for (final c in reply.cards) _Draft(c)];
        });
      }
    } on AiException catch (e) {
      if (mounted) setState(() => _error = aiErrorText(l, e.code));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final profileId = ref.watch(activeProfileIdProvider);
    final consent = ref.watch(aiConsentProvider).value ?? const AiConsent();
    final config = ref.watch(cloudConfigProvider);
    final service = ref.read(aiServiceProvider);
    final history = ref.watch(aiHistoryProvider).value ?? const [];
    final records = ref.watch(historyProvider).value ?? const [];
    final prefs = ref.watch(preferencesProvider).value;
    final accent = Theme.of(context).colorScheme.primary;

    // Offline alternative: the same rule-based suggestion used by the weekly
    // report, computed on this device from the user's own data.
    final last7 = records.length >= 7 ? records.sublist(records.length - 7) : records;
    final offline = buildWeeklyReport(
      [for (final r in last7) r.stats],
      WeeklyGoals(
        studyMinutesPerDay: prefs?.studyGoalMinutes ?? 60,
        waterMlPerDay: prefs?.waterGoalMl ?? 2000,
      ),
    );

    Widget aiLabel() => Chip(
          avatar: Icon(Icons.auto_awesome, size: 16, color: accent),
          label: Text(l.aiLabel),
          visualDensity: VisualDensity.compact,
        );

    return Scaffold(
      appBar: AppBar(title: Text(l.aiTitle)),
      body: ListView(
        padding: const EdgeInsets.all(Space.x2),
        children: [
          Text(l.aiDisclaimer, style: t.bodySmall),
          const SizedBox(height: Space.x2),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Space.x2),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(l.aiOfflineTitle, style: t.titleSmall),
                const SizedBox(height: 4),
                Text(suggestionText(l, offline.suggestion)),
              ]),
            ),
          ),
          const SizedBox(height: Space.x2),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Space.x2),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(l.aiConsentTitle, style: t.titleSmall),
                const SizedBox(height: 4),
                Text(l.aiConsentBody, style: t.bodySmall),
                if (!config.isConfigured) ...[
                  const SizedBox(height: Space.x1),
                  Text(l.aiNeedsCloud, style: t.bodySmall),
                ],
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l.aiEnable),
                  value: consent.enabled,
                  onChanged: profileId == null
                      ? null
                      : (v) => service.setConsent(profileId, enabled: v),
                ),
                if (consent.enabled) ...[
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l.aiShareStudy),
                    value: consent.study,
                    onChanged: (v) => service.setConsent(profileId!, study: v ?? false),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l.aiShareFitness),
                    value: consent.fitness,
                    onChanged: (v) => service.setConsent(profileId!, fitness: v ?? false),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l.aiSharePrayer),
                    value: consent.prayer,
                    onChanged: (v) => service.setConsent(profileId!, prayer: v ?? false),
                  ),
                ],
              ]),
            ),
          ),
          if (consent.enabled) ...[
            const SizedBox(height: Space.x2),
            FilledButton.icon(
              onPressed: _busy || profileId == null
                  ? null
                  : () => _run((id) => service.coach(id)),
              icon: const Icon(Icons.auto_awesome),
              label: Text(_busy ? l.aiThinking : l.aiCoachButton),
            ),
            const SizedBox(height: Space.x3),
            Text(l.aiToolsTitle, style: t.titleMedium),
            const SizedBox(height: Space.x1),
            Text(l.aiNotesWarn, style: t.bodySmall),
            const SizedBox(height: Space.x1),
            TextField(
              controller: _notes,
              minLines: 4,
              maxLines: 8,
              decoration: InputDecoration(labelText: l.aiNotesLabel),
            ),
            const SizedBox(height: Space.x1),
            Wrap(spacing: Space.x1, runSpacing: Space.x1, children: [
              for (final tool in [
                (l.aiDraftCards, AiKind.flashcards),
                (l.aiSummarize, AiKind.summarize),
                (l.aiQuestions, AiKind.questions),
                (l.aiExplain, AiKind.explain),
              ])
                OutlinedButton(
                  onPressed: _busy || profileId == null
                      ? null
                      : () {
                          if (_notes.text.trim().isEmpty) {
                            setState(() => _error = l.aiErrEmpty);
                            return;
                          }
                          _run((id) => service.studyTool(id, tool.$2, _notes.text));
                        },
                  child: Text(tool.$1),
                ),
            ]),
          ],
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(top: Space.x2),
              child: Semantics(
                liveRegion: true,
                child: Text(_error!,
                    style: t.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.error)),
              ),
            ),
          if (_reply != null) ...[
            const SizedBox(height: Space.x2),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Space.x2),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  aiLabel(),
                  if (_reply!.text.isNotEmpty) ...[
                    const SizedBox(height: Space.x1),
                    SelectableText(_reply!.text),
                  ],
                  if (_drafts.isNotEmpty) ...[
                    const SizedBox(height: Space.x1),
                    Text(l.aiReviewCards, style: t.bodySmall),
                    for (final d in _drafts)
                      Padding(
                        padding: const EdgeInsets.only(top: Space.x1),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Checkbox(
                            value: d.selected,
                            onChanged: (v) => setState(() => d.selected = v ?? false),
                          ),
                          Expanded(
                            child: Column(children: [
                              TextField(
                                controller: d.front,
                                minLines: 1,
                                maxLines: 3,
                                decoration: InputDecoration(labelText: l.cardFront),
                              ),
                              const SizedBox(height: 6),
                              TextField(
                                controller: d.back,
                                minLines: 1,
                                maxLines: 4,
                                decoration: InputDecoration(labelText: l.cardBack),
                              ),
                            ]),
                          ),
                        ]),
                      ),
                    const SizedBox(height: Space.x1),
                    FilledButton(
                      onPressed: profileId == null || !_drafts.any((d) => d.selected)
                          ? null
                          : () async {
                              final repo = ref.read(studyRepositoryProvider);
                              final messenger = ScaffoldMessenger.of(context);
                              for (final d in _drafts.where((d) => d.selected)) {
                                final f = d.front.text.trim();
                                final b = d.back.text.trim();
                                if (f.isEmpty || b.isEmpty) continue;
                                await repo.addCard(profileId, f, b, tags: 'ai-assisted');
                              }
                              messenger.showSnackBar(SnackBar(content: Text(l.aiCardsSaved)));
                              if (mounted) {
                                setState(() {
                                  for (final d in _drafts) {
                                    d.dispose();
                                  }
                                  _drafts = [];
                                });
                              }
                            },
                      child: Text(l.aiSaveCards(_drafts.where((d) => d.selected).length)),
                    ),
                  ],
                ]),
              ),
            ),
          ],
          const SizedBox(height: Space.x3),
          Row(children: [
            Expanded(child: Text(l.aiHistory, style: t.titleMedium)),
            TextButton(
              onPressed: profileId == null || history.isEmpty
                  ? null
                  : () async {
                      final messenger = ScaffoldMessenger.of(context);
                      await service.clearHistory(profileId);
                      messenger.showSnackBar(SnackBar(content: Text(l.aiHistoryCleared)));
                    },
              child: Text(l.aiClearHistory),
            ),
          ]),
          if (history.isEmpty)
            Text(l.aiHistoryEmpty)
          else
            for (final m in history.take(10))
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: Icon(m.role == 'user' ? Icons.person_outline : Icons.auto_awesome, size: 18),
                title: Text(m.body, maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
        ],
      ),
    );
  }
}
