import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import '../auth/cloud_auth.dart';
import '../sync/cloud_account.dart';
import '../sync/remote.dart';

String cloudErrorText(AppLocalizations l, String code) => switch (code) {
      'offline' => l.errOffline,
      'unauthorized' => l.errUnauthorized,
      'invalid_credentials' => l.errInvalidCredentials,
      'email_not_verified' => l.errEmailNotVerified,
      'weak_password' => l.errWeakPassword,
      'email_taken' => l.errEmailTaken,
      'rate_limited' => l.errRateLimited,
      'not_configured' => l.errNotConfigured,
      'disabled' => l.errDisabled,
      _ => l.errServer,
    };

/// Optional cloud account and sync controls. Local mode needs none of this.
class CloudSection extends ConsumerStatefulWidget {
  const CloudSection({super.key});

  @override
  ConsumerState<CloudSection> createState() => _CloudSectionState();
}

class _CloudSectionState extends ConsumerState<CloudSection> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  CloudSession? _session;
  bool _loaded = false;
  bool _busy = false;
  String? _message;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _loadSession() async {
    final config = ref.read(cloudConfigProvider);
    CloudSession? s;
    if (config.isConfigured) {
      try {
        s = await ref.read(cloudAuthProvider).currentSession();
      } catch (_) {
        s = null;
      }
    }
    if (mounted) {
      setState(() {
        _session = s;
        _loaded = true;
      });
    }
  }

  Future<void> _run(Future<String?> Function() action) async {
    final l = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _message = null;
    });
    String? msg;
    try {
      msg = await action();
    } on AuthFailure catch (e) {
      msg = cloudErrorText(l, e.code);
    } on SyncException catch (e) {
      msg = cloudErrorText(l, e.code);
    } on AccountDeletionException catch (e) {
      msg = cloudErrorText(l, e.code);
    }
    if (mounted) {
      setState(() {
        _busy = false;
        _message = msg;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final config = ref.watch(cloudConfigProvider);
    final profileId = ref.watch(activeProfileIdProvider);
    final settings = ref.watch(syncSettingsProvider).value;
    final pending = ref.watch(pendingDeletesProvider).value ?? 0;
    final repo = ref.read(syncSettingsRepositoryProvider);

    Widget body;
    if (!config.isConfigured) {
      body = Text(l.cloudNotConfigured);
    } else if (!_loaded) {
      body = const Padding(
          padding: EdgeInsets.all(Space.x2),
          child: Center(child: CircularProgressIndicator()));
    } else if (_session == null) {
      body = Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            decoration: InputDecoration(labelText: l.cloudEmail),
            validator: (v) {
              final s = (v ?? '').trim();
              return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(s)
                  ? null
                  : l.cloudEmailInvalid;
            },
          ),
          const SizedBox(height: Space.x1),
          TextFormField(
            controller: _password,
            obscureText: true,
            autofillHints: const [AutofillHints.password],
            decoration: InputDecoration(labelText: l.cloudPassword),
            validator: (v) => (v ?? '').length < 8 ? l.cloudPasswordShort : null,
          ),
          const SizedBox(height: Space.x2),
          Row(children: [
            Expanded(
              child: FilledButton(
                onPressed: _busy
                    ? null
                    : () {
                        if (!_formKey.currentState!.validate()) return;
                        _run(() async {
                          final s = await ref
                              .read(cloudAuthProvider)
                              .signIn(_email.text.trim(), _password.text);
                          _password.clear();
                          if (mounted) setState(() => _session = s);
                          return null;
                        });
                      },
                child: Text(l.cloudSignIn),
              ),
            ),
            const SizedBox(width: Space.x1),
            Expanded(
              child: OutlinedButton(
                onPressed: _busy
                    ? null
                    : () {
                        if (!_formKey.currentState!.validate()) return;
                        _run(() async {
                          final outcome = await ref
                              .read(cloudAuthProvider)
                              .signUp(_email.text.trim(), _password.text);
                          _password.clear();
                          if (outcome == SignUpOutcome.signedIn) {
                            final s = await ref.read(cloudAuthProvider).currentSession();
                            if (mounted) setState(() => _session = s);
                            return null;
                          }
                          return l.cloudVerify;
                        });
                      },
                child: Text(l.cloudCreate),
              ),
            ),
          ]),
          TextButton(
            onPressed: _busy
                ? null
                : () {
                    final s = _email.text.trim();
                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(s)) {
                      _formKey.currentState!.validate();
                      return;
                    }
                    _run(() async {
                      await ref.read(cloudAuthProvider).requestPasswordReset(s);
                      return l.cloudResetSent;
                    });
                  },
            child: Text(l.cloudForgot),
          ),
        ]),
      );
    } else {
      final enabled = settings?.enabled ?? false;
      Future<void> set({bool? en, bool? prayer, bool? study, bool? fitness, bool? journal}) async {
        if (profileId == null) return;
        await repo.update(profileId,
            enabled: en, prayer: prayer, study: study, fitness: fitness, journal: journal);
        if (en == true) await repo.linkCloudUser(profileId, _session!.userId);
      }

      body = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(l.cloudSignedInAs(_session!.email), style: t.titleSmall),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l.cloudSyncEnable),
          value: enabled,
          onChanged: profileId == null ? null : (v) => set(en: v),
        ),
        if (enabled) ...[
          for (final c in [
            (l.cloudCatStudy, settings?.syncStudy ?? false, (bool v) => set(study: v)),
            (l.cloudCatFitness, settings?.syncFitness ?? false, (bool v) => set(fitness: v)),
            (l.cloudCatPrayer, settings?.syncPrayer ?? false, (bool v) => set(prayer: v)),
            (l.cloudCatJournal, settings?.syncJournal ?? false, (bool v) => set(journal: v)),
          ])
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(c.$1),
              value: c.$2,
              onChanged: (v) => c.$3(v ?? false),
            ),
          Text(l.cloudCatNote, style: t.bodySmall),
          const SizedBox(height: Space.x1),
          Text(settings?.lastSyncAt == null
              ? l.cloudNeverSynced
              : l.cloudLastSync(DateFormat.yMMMd(l.localeName)
                  .add_jm()
                  .format(settings!.lastSyncAt!))),
          if (pending > 0) Text(l.cloudPending(pending)),
          if (settings?.lastError != null)
            Text(l.cloudSyncFailed(cloudErrorText(l, settings!.lastError!)),
                style: t.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error)),
          const SizedBox(height: Space.x1),
          FilledButton.icon(
            onPressed: _busy || profileId == null
                ? null
                : () => _run(() async {
                      await ref.read(syncEngineProvider).sync(profileId);
                      return l.cloudSyncDone;
                    }),
            icon: const Icon(Icons.sync),
            label: Text(_busy ? l.cloudSyncing : l.cloudSyncNow),
          ),
        ],
        const SizedBox(height: Space.x2),
        Wrap(spacing: Space.x1, runSpacing: Space.x1, children: [
          OutlinedButton(
            onPressed: _busy || profileId == null
                ? null
                : () => _run(() async {
                      await ref.read(cloudAuthProvider).signOut();
                      // Stop syncing and forget cursors so a different account
                      // can never receive another account's cursor state.
                      await repo.disableAndReset(profileId);
                      await repo.linkCloudUser(profileId, null);
                      if (mounted) setState(() => _session = null);
                      return null;
                    }),
            child: Text(l.cloudSignOut),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
            onPressed: _busy || profileId == null ? null : () => _confirmDelete(profileId),
            child: Text(l.cloudDelete),
          ),
        ]),
        const SizedBox(height: 4),
        Text(l.cloudSignOutNote, style: t.bodySmall),
      ]);
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l.cloudTitle, style: t.titleMedium),
      const SizedBox(height: Space.x1),
      Text(l.cloudIntro, style: t.bodySmall),
      const SizedBox(height: Space.x1),
      body,
      if (_message != null)
        Padding(
          padding: const EdgeInsets.only(top: Space.x1),
          child: Semantics(liveRegion: true, child: Text(_message!)),
        ),
    ]);
  }

  Future<void> _confirmDelete(String profileId) async {
    final l = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.cloudDelete),
        content: Text(l.cloudDeleteBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel)),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l.delete)),
        ],
      ),
    );
    if (ok != true) return;
    final repo = ref.read(syncSettingsRepositoryProvider);
    await _run(() async {
      await ref.read(cloudAccountServiceProvider).deleteAccount();
      await repo.disableAndReset(profileId);
      await repo.linkCloudUser(profileId, null);
      if (mounted) setState(() => _session = null);
      return l.cloudDeleted;
    });
  }
}
