import 'dart:async';

import 'package:adhan_dart/adhan_dart.dart' show CalculationMethod;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import 'cities.dart';
import 'prayer_service.dart';
import 'prayer_streaks.dart';

String prayerLabel(AppLocalizations l, PrayerName p) => switch (p) {
      PrayerName.fajr => l.prayerFajr,
      PrayerName.dhuhr => l.prayerDhuhr,
      PrayerName.asr => l.prayerAsr,
      PrayerName.maghrib => l.prayerMaghrib,
      PrayerName.isha => l.prayerIsha,
    };

String statusLabel(AppLocalizations l, PrayerStatus? s) => switch (s) {
      PrayerStatus.onTime => l.prayerStatusOnTime,
      PrayerStatus.late => l.prayerStatusLate,
      PrayerStatus.missed => l.prayerStatusMissed,
      null => l.prayerStatusNone,
    };

IconData statusIcon(PrayerStatus? s) => switch (s) {
      PrayerStatus.onTime => Icons.check_circle,
      PrayerStatus.late => Icons.schedule,
      PrayerStatus.missed => Icons.cancel_outlined,
      null => Icons.radio_button_unchecked,
    };

class PrayerScreen extends ConsumerStatefulWidget {
  const PrayerScreen({super.key});

  @override
  ConsumerState<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends ConsumerState<PrayerScreen> {
  Timer? _ticker;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Display-only tick; all times are recomputed from the clock, so a
    // paused or throttled timer cannot drift the countdown.
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final settings = ref.watch(prayerSettingsProvider);
    final log = ref.watch(prayerLogProvider).value ?? const {};
    final profileId = ref.watch(activeProfileIdProvider);
    final accent = NuvoraSection.soul.accent(Theme.of(context).brightness);
    final s = settings.value;
    final hasLocation = s?.latitude != null && s?.longitude != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.navPrayer),
        actions: [
          IconButton(
            tooltip: l.prayerSettings,
            icon: const Icon(Icons.tune),
            onPressed: profileId == null
                ? null
                : () => showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      showDragHandle: true,
                      builder: (_) => const PrayerSettingsSheet(),
                    ),
          ),
        ],
      ),
      body: settings.isLoading
          ? const Center(child: CircularProgressIndicator())
          : !hasLocation
              ? _NeedLocation(accent: accent)
              : _Content(
                  now: _now,
                  config: PrayerConfig(
                    method: s!.method,
                    asrMethod: s.asrMethod,
                    latitude: s.latitude!,
                    longitude: s.longitude!,
                  ),
                  locationLabel: s.locationLabel,
                  log: log,
                  profileId: profileId!,
                  accent: accent,
                ),
    );
  }
}

class _NeedLocation extends StatelessWidget {
  const _NeedLocation({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Space.x4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: accent.withValues(alpha: 0.16),
              child: Icon(Icons.location_on_outlined, size: 36, color: accent),
            ),
            const SizedBox(height: Space.x3),
            Text(l.prayerNeedLocationTitle,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center),
            const SizedBox(height: Space.x1),
            Text(l.prayerNeedLocationBody, textAlign: TextAlign.center),
            const SizedBox(height: Space.x3),
            FilledButton(
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                showDragHandle: true,
                builder: (_) => const PrayerSettingsSheet(),
              ),
              child: Text(l.prayerSetLocation),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({
    required this.now,
    required this.config,
    required this.locationLabel,
    required this.log,
    required this.profileId,
    required this.accent,
  });

  final DateTime now;
  final PrayerConfig config;
  final String? locationLabel;
  final PrayerLog log;
  final String profileId;
  final Color accent;

  static String _countdown(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    return h > 0 ? '${h}h ${m}m' : '${m}m ${s.toString().padLeft(2, '0')}s';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final day = DateTime(now.year, now.month, now.day);
    final times = const PrayerService().forDay(config, day);
    final next = times.next(now);
    final today = log[dayKey(day)] ?? const {};
    final timeFmt = DateFormat.jm(l.localeName);
    final nextName = next.prayer == null ? null : prayerLabel(l, next.prayer!);
    final remaining = next.time.difference(now);
    final week = summarize(log, day, 7);

    return ListView(
      padding: const EdgeInsets.all(Space.x2),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Space.x3),
            child: Semantics(
              container: true,
              label:
                  '${nextName != null ? l.prayerNext(nextName) : l.prayerNextFajrTomorrow}, ${timeFmt.format(next.time)}',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nextName != null
                        ? l.prayerNext(nextName)
                        : l.prayerNextFajrTomorrow,
                    style: t.titleMedium?.copyWith(color: accent),
                  ),
                  const SizedBox(height: Space.x1),
                  Text(timeFmt.format(next.time), style: t.displaySmall),
                  Text(l.prayerIn(_countdown(remaining)), style: t.bodyLarge),
                  if (locationLabel != null) ...[
                    const SizedBox(height: Space.x1),
                    Row(children: [
                      const Icon(Icons.location_on_outlined, size: 16),
                      const SizedBox(width: 4),
                      Flexible(child: Text(locationLabel!, style: t.bodySmall)),
                    ]),
                  ],
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: Space.x2),
        Text(l.prayerToday, style: t.titleMedium),
        const SizedBox(height: Space.x1),
        for (final p in PrayerName.values)
          Padding(
            padding: const EdgeInsets.only(bottom: Space.x1),
            child: Card(
              child: ListTile(
                minVerticalPadding: Space.x1,
                leading: Icon(statusIcon(today[p]),
                    color: today[p] == null
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : accent),
                title: Text(prayerLabel(l, p)),
                subtitle: Text(
                    '${timeFmt.format(times.times[p]!)} · ${statusLabel(l, today[p])}'),
                trailing: PopupMenuButton<PrayerStatus?>(
                  tooltip: l.prayerRecordFor(prayerLabel(l, p)),
                  icon: const Icon(Icons.more_vert),
                  onSelected: (v) => ref
                      .read(prayerRepositoryProvider)
                      .setStatus(profileId, day, p, v),
                  itemBuilder: (_) => [
                    for (final s in PrayerStatus.values)
                      PopupMenuItem(
                        value: s,
                        child: Row(children: [
                          Icon(statusIcon(s), size: 20),
                          const SizedBox(width: Space.x1),
                          Text(statusLabel(l, s)),
                        ]),
                      ),
                    if (today[p] != null)
                      PopupMenuItem(
                        value: null,
                        child: Text(l.prayerStatusClear),
                      ),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: Space.x2),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Space.x2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.prayerStreak(currentStreak(log, day)),
                    style: t.titleMedium),
                Text(l.prayerLongest(longestStreak(log))),
                const SizedBox(height: Space.x1),
                Text(l.prayerWeek, style: t.titleSmall),
                Text(l.prayerWeekSummary(
                    week.completed, week.missed, week.unrecorded)),
                const SizedBox(height: Space.x1),
                Text(l.prayerStreakNote, style: t.bodySmall),
              ],
            ),
          ),
        ),
        const SizedBox(height: Space.x2),
        Text(l.prayerDisclaimer, style: t.bodySmall),
      ],
    );
  }
}

class PrayerSettingsSheet extends ConsumerStatefulWidget {
  const PrayerSettingsSheet({super.key});

  @override
  ConsumerState<PrayerSettingsSheet> createState() =>
      _PrayerSettingsSheetState();
}

class _PrayerSettingsSheetState extends ConsumerState<PrayerSettingsSheet> {
  final _formKey = GlobalKey<FormState>();
  final _lat = TextEditingController();
  final _lon = TextEditingController();
  late String _method;
  late String _asr;
  String? _label;
  bool _customLocation = false;

  @override
  void initState() {
    super.initState();
    final s = ref.read(prayerSettingsProvider).value;
    _method = s?.method ?? 'muslimWorldLeague';
    _asr = s?.asrMethod ?? 'shafi';
    _label = s?.locationLabel;
    if (s?.latitude != null) {
      _lat.text = s!.latitude!.toStringAsFixed(4);
      _lon.text = s.longitude!.toStringAsFixed(4);
      _customLocation = !cities.any((c) => c.name == s.locationLabel);
    }
  }

  @override
  void dispose() {
    _lat.dispose();
    _lon.dispose();
    super.dispose();
  }

  String? _validate(String? v, double min, double max, AppLocalizations l,
      String rangeMsg) {
    final n = double.tryParse((v ?? '').trim());
    if (n == null) return l.prayerInvalidNumber;
    if (n < min || n > max) return rangeMsg;
    return null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final id = ref.read(activeProfileIdProvider);
    if (id == null) return;
    final lat = double.parse(_lat.text.trim());
    final lon = double.parse(_lon.text.trim());
    await ref.read(prayerRepositoryProvider).saveSettings(
          id,
          method: _method,
          asrMethod: _asr,
          latitude: lat,
          longitude: lon,
          locationLabel: _customLocation || _label == null
              ? '${lat.toStringAsFixed(2)}, ${lon.toStringAsFixed(2)}'
              : _label,
        );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(
        left: Space.x3,
        right: Space.x3,
        bottom: MediaQuery.of(context).viewInsets.bottom + Space.x3,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l.prayerSettings, style: t.titleLarge),
              const SizedBox(height: Space.x2),
              DropdownButtonFormField<String>(
                initialValue: _customLocation ? null : _label,
                isExpanded: true,
                decoration: InputDecoration(labelText: l.prayerCity),
                items: [
                  for (final c in cities)
                    DropdownMenuItem(value: c.name, child: Text(c.name)),
                ],
                onChanged: (name) {
                  final c = cities.firstWhere((c) => c.name == name);
                  setState(() {
                    _label = c.name;
                    _customLocation = false;
                    _lat.text = c.latitude.toString();
                    _lon.text = c.longitude.toString();
                  });
                },
              ),
              const SizedBox(height: Space.x2),
              Text(l.prayerCustomLocation, style: t.titleSmall),
              const SizedBox(height: Space.x1),
              Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: _lat,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    decoration: InputDecoration(labelText: l.prayerLatitude),
                    validator: (v) =>
                        _validate(v, -90, 90, l, l.prayerLatRange),
                    onChanged: (_) => _customLocation = true,
                  ),
                ),
                const SizedBox(width: Space.x1),
                Expanded(
                  child: TextFormField(
                    controller: _lon,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    decoration: InputDecoration(labelText: l.prayerLongitude),
                    validator: (v) =>
                        _validate(v, -180, 180, l, l.prayerLonRange),
                    onChanged: (_) => _customLocation = true,
                  ),
                ),
              ]),
              const SizedBox(height: Space.x2),
              DropdownButtonFormField<String>(
                initialValue: _method,
                isExpanded: true,
                decoration: InputDecoration(labelText: l.prayerMethod),
                items: [
                  for (final m in _methods)
                    DropdownMenuItem(value: m.name, child: Text(m.displayName)),
                ],
                onChanged: (v) => setState(() => _method = v!),
              ),
              const SizedBox(height: Space.x2),
              Text(l.prayerAsrMethod, style: t.titleSmall),
              const SizedBox(height: Space.x1),
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(value: 'shafi', label: Text(l.prayerAsrStandard)),
                  ButtonSegment(value: 'hanafi', label: Text(l.prayerAsrHanafi)),
                ],
                selected: {_asr},
                onSelectionChanged: (s) => setState(() => _asr = s.first),
              ),
              const SizedBox(height: Space.x2),
              Text(l.prayerDisclaimer, style: t.bodySmall),
              const SizedBox(height: Space.x2),
              FilledButton(onPressed: _save, child: Text(l.save)),
            ],
          ),
        ),
      ),
    );
  }

  static final List<CalculationMethod> _methods = PrayerService.methods;
}
