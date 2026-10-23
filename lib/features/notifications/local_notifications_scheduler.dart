import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'notification_service.dart';

/// Android implementation using `flutter_local_notifications`.
///
/// * Reminders are scheduled locally; no server is involved.
/// * A fixed set of ids is replaced on every re-plan, so there are no
///   duplicates.
/// * The plugin's boot receiver (declared in AndroidManifest.xml) restores
///   scheduled reminders after a device restart or app update.
/// * Exact alarms are used only when the user has allowed them; otherwise
///   reminders are scheduled as inexact and may arrive a few minutes late.
///
/// This class talks to platform code and is verified on a device, not by
/// the unit tests (which use a fake [NotificationScheduler]).
class LocalNotificationsScheduler implements NotificationScheduler {
  LocalNotificationsScheduler([FlutterLocalNotificationsPlugin? plugin])
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _ready = false;

  static const _channels = {
    'prayer': ('Prayer reminders', 'Reminders for prayer times'),
    'study': ('Study reminders', 'Focus sessions and flashcard reviews'),
    'health': ('Movement and water', 'Workout and hydration reminders'),
    'reflection': ('Reflection and reports', 'Daily reflection and weekly summary'),
  };

  Future<void> _init() async {
    if (_ready) return;
    tzdata.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (_) {
      // Fall back to UTC rather than failing; reminders are re-planned on
      // every launch so a later successful lookup corrects this.
      tz.setLocalLocation(tz.UTC);
    }
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    _ready = true;
  }

  AndroidFlutterLocalNotificationsPlugin? get _android => _plugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

  @override
  Future<bool> hasPermission() async {
    if (defaultTargetPlatform != TargetPlatform.android) return false;
    await _init();
    return await _android?.areNotificationsEnabled() ?? false;
  }

  @override
  Future<bool> requestPermission() async {
    if (defaultTargetPlatform != TargetPlatform.android) return false;
    await _init();
    return await _android?.requestNotificationsPermission() ?? false;
  }

  @override
  Future<void> cancelAll() async {
    if (defaultTargetPlatform != TargetPlatform.android) return;
    await _init();
    await _plugin.cancelAll();
  }

  @override
  Future<void> replaceAll(List<ScheduledReminder> reminders) async {
    if (defaultTargetPlatform != TargetPlatform.android) return;
    await _init();
    await _plugin.cancelAll();
    final exact = await _android?.canScheduleExactNotifications() ?? false;
    for (final r in reminders) {
      final (name, description) = _channels[r.channel] ?? _channels['reflection']!;
      await _plugin.zonedSchedule(
        id: r.id,
        title: r.title,
        body: r.body,
        scheduledDate: tz.TZDateTime.from(r.at, tz.local),
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'nuvora_${r.channel}',
            name,
            channelDescription: description,
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
            // Keep text off the lock screen's expanded view by default.
            visibility: NotificationVisibility.private,
          ),
        ),
        androidScheduleMode: exact
            ? AndroidScheduleMode.exactAllowWhileIdle
            : AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
  }
}
