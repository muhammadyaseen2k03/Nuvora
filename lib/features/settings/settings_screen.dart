import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import 'backup_section.dart';
import 'cloud_section.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final prefs = ref.watch(preferencesProvider).value;
    final profiles = ref.watch(profilesProvider).value ?? const [];
    final activeId = ref.watch(activeProfileIdProvider);
    final repo = ref.read(profileRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.settings)),
      body: ListView(
        padding: const EdgeInsets.all(Space.x2),
        children: [
          Text(l.appearance, style: t.titleMedium),
          const SizedBox(height: Space.x1),
          if (prefs != null) ...[
            SegmentedButton<String>(
              segments: [
                ButtonSegment(value: 'system', label: Text(l.themeSystem)),
                ButtonSegment(value: 'light', label: Text(l.themeLight)),
                ButtonSegment(value: 'dark', label: Text(l.themeDark)),
              ],
              selected: {prefs.themeMode},
              onSelectionChanged: (s) =>
                  repo.updatePreferences(activeId!, themeMode: s.first),
            ),
            const SizedBox(height: Space.x3),
            Text(l.language, style: t.titleMedium),
            const SizedBox(height: Space.x1),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'en', label: Text('English')),
                ButtonSegment(value: 'ur', label: Text('اردو')),
              ],
              selected: {prefs.languageCode},
              onSelectionChanged: (s) =>
                  repo.updatePreferences(activeId!, languageCode: s.first),
            ),
          ],
          const SizedBox(height: Space.x3),
          Text(l.profiles, style: t.titleMedium),
          const SizedBox(height: Space.x1),
          for (final p in profiles)
            Card(
              child: ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(p.displayName),
                subtitle: p.id == activeId ? Text(l.activeProfile) : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (p.id != activeId)
                      TextButton(
                        onPressed: () => ref
                            .read(activeProfileIdProvider.notifier)
                            .set(p.id),
                        child: Text(l.switchProfile),
                      ),
                    IconButton(
                      tooltip: l.deleteProfile,
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _confirmDelete(context, ref, p.id),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: Space.x1),
          OutlinedButton.icon(
            onPressed: () => context.go('/onboarding'),
            icon: const Icon(Icons.person_add_alt),
            label: Text(l.addProfile),
          ),
          const SizedBox(height: Space.x3),
          Card(
            child: ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: Text(l.notifTitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push("/notifications"),
            ),
          ),
          const SizedBox(height: Space.x3),
          const BackupSection(),
          const SizedBox(height: Space.x3),
          const CloudSection(),
          const SizedBox(height: Space.x3),
          Text(l.privacy, style: t.titleMedium),
          const SizedBox(height: Space.x1),
          Text(l.privacyLocalNote),
          const SizedBox(height: Space.x1),
          Text(l.recoveryNote, style: t.bodySmall),
          const SizedBox(height: Space.x1),
          Text(l.privacyEncryption, style: t.bodySmall),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, String id) async {
    final l = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.deleteProfileTitle),
        content: Text(l.deleteProfileBody),
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
    if (ok != true) return;
    final repo = ref.read(profileRepositoryProvider);
    await repo.deleteProfile(id);
    if (ref.read(activeProfileIdProvider) == id) {
      final remaining = await repo.watchProfiles().first;
      await ref
          .read(activeProfileIdProvider.notifier)
          .set(remaining.isEmpty ? null : remaining.first.id);
    }
  }
}
