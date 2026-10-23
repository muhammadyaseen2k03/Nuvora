import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import '../l10n/gen/app_localizations.dart';
import 'providers.dart';
import 'router.dart';

class NuvoraApp extends ConsumerStatefulWidget {
  const NuvoraApp({super.key});

  @override
  ConsumerState<NuvoraApp> createState() => _NuvoraAppState();
}

class _NuvoraAppState extends ConsumerState<NuvoraApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Re-plan reminders at launch (after the first frame, so startup is fast).
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshReminders());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Resuming covers date changes, time-zone changes and edited settings.
    if (state == AppLifecycleState.resumed) _refreshReminders();
  }

  @override
  void didChangeLocales(List<Locale>? locales) => _refreshReminders();

  Future<void> _refreshReminders() async {
    final id = ref.read(activeProfileIdProvider);
    if (id == null) return;
    final lang = ref.read(preferencesProvider).value?.languageCode ?? 'en';
    try {
      await ref
          .read(notificationServiceProvider)
          .reschedule(id, languageCode: lang);
    } catch (_) {
      // Reminders are best effort and must never break the app.
    }
  }

  @override
  Widget build(BuildContext context) {
    // Prayer location or method changes alter reminder times.
    ref.listen(prayerSettingsProvider, (_, _) => _refreshReminders());
    return MaterialApp.router(
      onGenerateTitle: (c) => AppLocalizations.of(c).appName,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ref.watch(themeModeProvider),
      locale: ref.watch(localeProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: ref.watch(routerProvider),
    );
  }
}
