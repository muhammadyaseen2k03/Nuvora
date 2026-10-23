import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/gen/app_localizations.dart';
import '../prayer/prayer_service.dart';
import 'notification_planner.dart';
import 'notification_service.dart';

String _clock(BuildContext context, int minuteOfDay) => TimeOfDay(
        hour: minuteOfDay ~/ 60, minute: minuteOfDay % 60)
    .format(context);

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  bool? _permitted;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    bool ok;
    try {
      ok = await ref.read(notificationServiceProvider).hasPermission();
    } catch (_) {
      ok = false;
    }
    if (mounted) setState(() => _permitted = ok);
  }

  Future<void> _apply(Future<void> Function(String id) change) async {
    final id = ref.read(activeProfileIdProvider);
    if (id == null) return;
    final service = ref.read(notificationServiceProvider);
    final lang = ref.read(preferencesProvider).value?.languageCode ?? 'en';
    await change(id);
    try {
      await service.reschedule(id, languageCode: lang);
    } catch (_) {
      // Scheduling problems must never block saving the preference.
    }
  }

  Future<void> _pickTime(int current, void Function(int minute) save) async {
    final picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: current ~/ 60, minute: current % 60));
    if (picked != null) save(picked.hour * 60 + picked.minute);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final prefs = ref.watch(notificationPrefsProvider).value ?? const NotificationPrefs();
    final service = ref.read(notificationServiceProvider);
    final hasLocation = ref.watch(prayerSettingsProvider).value?.latitude != null;
    final anyOn = anyReminderEnabled(prefs);

    Widget section(String title, Widget child) => Padding(
          padding: const EdgeInsets.only(bottom: Space.x1),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(Space.x2),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: t.titleSmall),
                child,
              ]),
            ),
          ),
        );

    Widget timeRow(int minute, void Function(int) save) => ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: Text(l.notifTime),
          trailing: Text(_clock(context, minute)),
          onTap: () => _pickTime(minute, save),
        );

    final dayNames = [
      l.weekdayMon, l.weekdayTue, l.weekdayWed, l.weekdayThu,
      l.weekdayFri, l.weekdaySat, l.weekdaySun,
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l.notifTitle)),
      body: ListView(
        padding: const EdgeInsets.all(Space.x2),
        children: [
          // Explain before asking. Nothing is requested until the button is
          // pressed, and only when a reminder has been turned on.
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Space.x2),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(l.notifWhyTitle, style: t.titleSmall),
                const SizedBox(height: 4),
                Text(l.notifWhyBody, style: t.bodySmall),
                const SizedBox(height: Space.x1),
                if (_permitted == true)
                  Row(children: [
                    const Icon(Icons.check_circle_outline, size: 18),
                    const SizedBox(width: 6),
                    Flexible(child: Text(l.notifSaved)),
                  ])
                else ...[
                  if (_permitted == false && anyOn)
                    Padding(
                      padding: const EdgeInsets.only(bottom: Space.x1),
                      child: Text(l.notifDeniedBody, style: t.bodySmall),
                    ),
                  FilledButton(
                    onPressed: () async {
                      final ok = await service.requestPermission();
                      if (mounted) setState(() => _permitted = ok);
                      if (ok) await _apply((_) async {});
                    },
                    child: Text(l.notifAllow),
                  ),
                ],
              ]),
            ),
          ),
          const SizedBox(height: Space.x1),
          section(
            l.notifPrayer,
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.notifPrayer),
                value: prefs.prayer,
                onChanged: (v) => _apply((id) => service.update(id, prayer: v)),
              ),
              if (!hasLocation) Text(l.notifPrayerNeedsLocation, style: t.bodySmall),
              if (prefs.prayer) ...[
                Wrap(spacing: 6, children: [
                  for (final p in PrayerName.values)
                    FilterChip(
                      label: Text(switch (p) {
                        PrayerName.fajr => l.prayerFajr,
                        PrayerName.dhuhr => l.prayerDhuhr,
                        PrayerName.asr => l.prayerAsr,
                        PrayerName.maghrib => l.prayerMaghrib,
                        PrayerName.isha => l.prayerIsha,
                      }),
                      selected: prefs.prayerEnabledFor(p),
                      onSelected: (on) => _apply((id) => service.update(id,
                          prayerMask: on
                              ? prefs.prayerMask | (1 << p.index)
                              : prefs.prayerMask & ~(1 << p.index))),
                    ),
                ]),
                const SizedBox(height: Space.x1),
                DropdownButtonFormField<int>(
                  initialValue: prefs.prayerOffsetMinutes,
                  decoration: const InputDecoration(),
                  items: [
                    DropdownMenuItem(value: 0, child: Text(l.notifAtTime)),
                    for (final m in const [5, 10, 15, 30])
                      DropdownMenuItem(value: m, child: Text(l.notifOffset(m))),
                  ],
                  onChanged: (v) => _apply((id) => service.update(id, prayerOffsetMinutes: v)),
                ),
              ],
            ]),
          ),
          section(
            l.notifStudy,
            Column(children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.notifStudy),
                value: prefs.study,
                onChanged: (v) => _apply((id) => service.update(id, study: v)),
              ),
              if (prefs.study)
                timeRow(prefs.studyMinuteOfDay,
                    (m) => _apply((id) => service.update(id, studyMinute: m))),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.notifFlashcards),
                value: prefs.flashcards,
                onChanged: (v) => _apply((id) => service.update(id, flashcards: v)),
              ),
              if (prefs.flashcards)
                timeRow(prefs.flashcardsMinuteOfDay,
                    (m) => _apply((id) => service.update(id, flashcardsMinute: m))),
            ]),
          ),
          section(
            l.tileWorkout,
            Column(children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.notifWorkout),
                value: prefs.workout,
                onChanged: (v) => _apply((id) => service.update(id, workout: v)),
              ),
              if (prefs.workout)
                timeRow(prefs.workoutMinuteOfDay,
                    (m) => _apply((id) => service.update(id, workoutMinute: m))),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.notifHydration(prefs.hydrationIntervalMinutes ~/ 60)),
                value: prefs.hydration,
                onChanged: (v) => _apply((id) => service.update(id, hydration: v)),
              ),
              if (prefs.hydration)
                DropdownButtonFormField<int>(
                  initialValue: (prefs.hydrationIntervalMinutes ~/ 60).clamp(1, 6),
                  decoration: const InputDecoration(),
                  items: [
                    for (var h = 1; h <= 6; h++)
                      DropdownMenuItem(value: h, child: Text(l.fastHours(h))),
                  ],
                  onChanged: (h) => _apply((id) =>
                      service.update(id, hydrationIntervalMinutes: (h ?? 2) * 60)),
                ),
            ]),
          ),
          section(
            l.journalTitle,
            Column(children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.notifReflection),
                value: prefs.reflection,
                onChanged: (v) => _apply((id) => service.update(id, reflection: v)),
              ),
              if (prefs.reflection)
                timeRow(prefs.reflectionMinuteOfDay,
                    (m) => _apply((id) => service.update(id, reflectionMinute: m))),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.notifWeekly),
                value: prefs.weeklyReport,
                onChanged: (v) => _apply((id) => service.update(id, weeklyReport: v)),
              ),
              if (prefs.weeklyReport)
                DropdownButtonFormField<int>(
                  initialValue: prefs.weeklyReportDay,
                  decoration: InputDecoration(labelText: l.notifDay),
                  items: [
                    for (var d = 1; d <= 7; d++)
                      DropdownMenuItem(value: d, child: Text(dayNames[d - 1])),
                  ],
                  onChanged: (v) => _apply((id) => service.update(id, weeklyReportDay: v)),
                ),
            ]),
          ),
          section(
            l.notifQuiet,
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(l.notifQuietNote, style: t.bodySmall),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(prefs.quietStartMinute == null
                    ? l.notifQuietOff
                    : l.notifQuietRange(_clock(context, prefs.quietStartMinute!),
                        _clock(context, prefs.quietEndMinute!))),
                value: prefs.quietStartMinute != null,
                onChanged: (v) => _apply((id) => v
                    ? service.update(id, quietStartMinute: 22 * 60, quietEndMinute: 7 * 60)
                    : service.update(id, clearQuietHours: true)),
              ),
              if (prefs.quietStartMinute != null) ...[
                timeRow(prefs.quietStartMinute!,
                    (m) => _apply((id) => service.update(id, quietStartMinute: m))),
                timeRow(prefs.quietEndMinute!,
                    (m) => _apply((id) => service.update(id, quietEndMinute: m))),
              ],
            ]),
          ),
          section(
            l.notifDetails,
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.notifDetails),
                value: prefs.showDetails,
                onChanged: (v) => _apply((id) => service.update(id, showDetails: v)),
              ),
              Text(l.notifDetailsNote, style: t.bodySmall),
            ]),
          ),
          Text(l.notifExactNote, style: t.bodySmall),
        ],
      ),
    );
  }
}
