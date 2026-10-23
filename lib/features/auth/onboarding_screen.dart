import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import 'profile_repository.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  static const _lastStep = 4;
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  int _step = 0;
  String _theme = 'system';
  String _language = 'en';
  int _studyMinutes = 60;
  String _fitness = 'beginner';
  int _workoutMinutes = 20;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    setState(() => _saving = true);
    final repo = ref.read(profileRepositoryProvider);
    final id = await repo.createProfile(NewProfile(
      displayName: _name.text,
      themeMode: _theme,
      languageCode: _language,
      studyGoalMinutes: _studyMinutes,
      fitnessLevel: _fitness,
      workoutMinutes: _workoutMinutes,
    ));
    await ref.read(activeProfileIdProvider.notifier).set(id);
    if (mounted) context.go('/home');
  }

  void _next() {
    if (_step == 0 && !_formKey.currentState!.validate()) return;
    if (_step == _lastStep) {
      _finish();
    } else {
      setState(() => _step++);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final canLeave = ref.watch(activeProfileIdProvider) != null;
    return Scaffold(
      appBar: AppBar(
        leading: _step > 0
            ? IconButton(
                tooltip: l.back,
                icon: const Icon(Icons.arrow_back),
                onPressed: () => setState(() => _step--))
            : (canLeave
                ? IconButton(
                    tooltip: l.cancel,
                    icon: const Icon(Icons.close),
                    onPressed: () => context.go('/settings'))
                : null),
        actions: [
          if (_step >= 2)
            TextButton(
                onPressed: _saving ? null : _next, child: Text(l.skip)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Space.x3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(value: (_step + 1) / (_lastStep + 1)),
              const SizedBox(height: Space.x3),
              Expanded(
                child: SingleChildScrollView(
                  child: AnimatedSwitcher(
                    duration: MediaQuery.of(context).disableAnimations
                        ? Duration.zero
                        : const Duration(milliseconds: 200),
                    child: KeyedSubtree(
                        key: ValueKey(_step), child: _stepBody(context, l)),
                  ),
                ),
              ),
              const SizedBox(height: Space.x2),
              FilledButton(
                onPressed: _saving ? null : _next,
                child: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : Text(_step == _lastStep ? l.finish : l.next),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stepBody(BuildContext context, AppLocalizations l) {
    final t = Theme.of(context).textTheme;
    switch (_step) {
      case 0:
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.welcomeTitle, style: t.headlineSmall),
              const SizedBox(height: Space.x1),
              Text(l.tagline, style: t.bodyLarge),
              const SizedBox(height: Space.x4),
              Text(l.nameTitle, style: t.titleMedium),
              const SizedBox(height: Space.x1),
              TextFormField(
                controller: _name,
                maxLength: 60,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: l.nameHint),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? l.nameRequired : null,
                onFieldSubmitted: (_) => _next(),
              ),
            ],
          ),
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.modeTitle, style: t.headlineSmall),
            const SizedBox(height: Space.x3),
            _ChoiceCard(
              icon: Icons.phone_android,
              title: l.modeLocal,
              subtitle: l.modeLocalDesc,
              selected: true,
              onTap: () {},
            ),
            const SizedBox(height: Space.x1),
            _ChoiceCard(
              icon: Icons.cloud_outlined,
              title: l.modeCloud,
              subtitle: l.modeCloudDesc,
              selected: false,
              enabled: false,
            ),
            const SizedBox(height: Space.x3),
            Text(l.recoveryNote, style: t.bodySmall),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.themeTitle, style: t.headlineSmall),
            const SizedBox(height: Space.x2),
            SegmentedButton<String>(
              segments: [
                ButtonSegment(value: 'system', label: Text(l.themeSystem)),
                ButtonSegment(value: 'light', label: Text(l.themeLight)),
                ButtonSegment(value: 'dark', label: Text(l.themeDark)),
              ],
              selected: {_theme},
              onSelectionChanged: (s) => setState(() => _theme = s.first),
            ),
            const SizedBox(height: Space.x4),
            Text(l.languageTitle, style: t.headlineSmall),
            const SizedBox(height: Space.x2),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'en', label: Text('English')),
                ButtonSegment(value: 'ur', label: Text('اردو')),
              ],
              selected: {_language},
              onSelectionChanged: (s) => setState(() => _language = s.first),
            ),
            const SizedBox(height: Space.x3),
            Text(l.optionalLater, style: t.bodySmall),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.studyTitle, style: t.headlineSmall),
            const SizedBox(height: Space.x2),
            Text(l.studyMinutes(_studyMinutes), style: t.titleMedium),
            Slider(
              value: _studyMinutes.toDouble(),
              min: 15,
              max: 240,
              divisions: 15,
              label: '$_studyMinutes',
              onChanged: (v) => setState(() => _studyMinutes = v.round()),
            ),
            const SizedBox(height: Space.x2),
            Text(l.optionalLater, style: t.bodySmall),
          ],
        );
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.fitnessTitle, style: t.headlineSmall),
            const SizedBox(height: Space.x2),
            SegmentedButton<String>(
              segments: [
                ButtonSegment(value: 'beginner', label: Text(l.fitnessBeginner)),
                ButtonSegment(
                    value: 'intermediate', label: Text(l.fitnessIntermediate)),
                ButtonSegment(value: 'advanced', label: Text(l.fitnessAdvanced)),
              ],
              selected: {_fitness},
              onSelectionChanged: (s) => setState(() => _fitness = s.first),
            ),
            const SizedBox(height: Space.x3),
            Text(l.workoutMinutes(_workoutMinutes), style: t.titleMedium),
            Slider(
              value: _workoutMinutes.toDouble(),
              min: 10,
              max: 90,
              divisions: 16,
              label: '$_workoutMinutes',
              onChanged: (v) => setState(() => _workoutMinutes = v.round()),
            ),
            const SizedBox(height: Space.x2),
            Text(l.privacyLocalNote, style: t.bodySmall),
          ],
        );
    }
  }
}

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    this.onTap,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      selected: selected,
      enabled: enabled,
      label: '$title. $subtitle',
      child: Opacity(
        opacity: enabled ? 1 : 0.55,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.card),
            side: BorderSide(
                color: selected ? scheme.primary : scheme.outlineVariant,
                width: selected ? 2 : 1),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(Radii.card),
            onTap: enabled ? onTap : null,
            child: Padding(
              padding: const EdgeInsets.all(Space.x2),
              child: Row(
                children: [
                  Icon(icon, color: scheme.primary),
                  const SizedBox(width: Space.x2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: Theme.of(context).textTheme.titleMedium),
                        Text(subtitle),
                      ],
                    ),
                  ),
                  if (selected) Icon(Icons.check_circle, color: scheme.primary),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
