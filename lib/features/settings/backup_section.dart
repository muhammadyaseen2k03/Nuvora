import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import '../backup/backup_service.dart';

String backupErrorText(AppLocalizations l, BackupException e) => switch (e.code) {
      'newer_version' => l.backupErrNewer,
      'too_large' => l.backupErrLarge,
      'not_json' || 'wrong_format' || 'invalid_structure' || 'invalid_row' ||
      'unknown_table' =>
        l.backupErrFormat,
      _ => l.backupErrGeneric,
    };

/// Export and restore of the active profile's data.
class BackupSection extends ConsumerWidget {
  const BackupSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final profileId = ref.watch(activeProfileIdProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.backupTitle, style: t.titleMedium),
        const SizedBox(height: Space.x1),
        Text(l.backupNote, style: t.bodySmall),
        const SizedBox(height: Space.x1),
        Wrap(spacing: Space.x1, runSpacing: Space.x1, children: [
          OutlinedButton.icon(
            onPressed: profileId == null ? null : () => _export(context, ref, profileId),
            icon: const Icon(Icons.ios_share),
            label: Text(l.backupExport),
          ),
          OutlinedButton.icon(
            onPressed: profileId == null ? null : () => _restore(context, ref, profileId),
            icon: const Icon(Icons.restore),
            label: Text(l.backupRestore),
          ),
        ]),
      ],
    );
  }

  Future<void> _export(BuildContext context, WidgetRef ref, String profileId) async {
    final l = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final json = await ref.read(backupServiceProvider).export(profileId);
      final dir = await getTemporaryDirectory();
      final stamp = DateFormat('yyyyMMdd-HHmm').format(DateTime.now());
      final file = File('${dir.path}/nuvora-backup-$stamp.json');
      await file.writeAsString(json, flush: true);
      await SharePlus.instance.share(
          ShareParams(files: [XFile(file.path)], text: l.backupShareText));
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l.backupErrGeneric)));
    }
  }

  Future<void> _restore(BuildContext context, WidgetRef ref, String profileId) async {
    final l = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final service = ref.read(backupServiceProvider);

    final picked = await FilePicker.pickFile(
        type: FileType.custom, allowedExtensions: const ['json']);
    if (picked == null) return;
    if ((await picked.length() ?? 0) > BackupService.maxBytes) {
      messenger.showSnackBar(SnackBar(content: Text(l.backupErrLarge)));
      return;
    }

    BackupPreview preview;
    String source;
    try {
      source = utf8.decode(await picked.readAsBytes());
      preview = await service.validate(source);
    } on BackupException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(backupErrorText(l, e))));
      return;
    } on FormatException {
      messenger.showSnackBar(SnackBar(content: Text(l.backupErrFormat)));
      return;
    }
    if (!context.mounted) return;

    final choice = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.backupRestore),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(l.backupPreview(preview.profileName, preview.totalRows)),
          const SizedBox(height: Space.x1),
          Text(l.backupAsNewNote, style: Theme.of(ctx).textTheme.bodySmall),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l.cancel)),
          TextButton(
              onPressed: () => Navigator.pop(ctx, 'replace'),
              child: Text(l.backupReplace)),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, 'new'),
              child: Text(l.backupAsNew)),
        ],
      ),
    );
    if (choice == null) return;

    if (choice == 'replace') {
      if (!context.mounted) return;
      final sure = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l.backupReplace),
          content: Text(l.backupReplaceWarn),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel)),
            FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l.backupReplace)),
          ],
        ),
      );
      if (sure != true) return;
    }

    try {
      if (choice == 'new') {
        final id = await service.restoreAsNewProfile(source);
        await ref.read(activeProfileIdProvider.notifier).set(id);
      } else {
        await service.restoreReplacingProfile(source, profileId);
      }
      messenger.showSnackBar(SnackBar(content: Text(l.backupDone)));
    } on BackupException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(backupErrorText(l, e))));
    }
  }
}
