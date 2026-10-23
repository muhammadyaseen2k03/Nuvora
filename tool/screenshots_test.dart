// ignore_for_file: invalid_use_of_visible_for_testing_member
// Renders key screens to PNGs using the real widgets and Roboto from the
// Flutter SDK. Run on demand:
//   flutter test tool/screenshots_test.dart --update-goldens
// Output: tool/screenshots/*.png
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/app/app.dart';
import 'package:nuvora/app/providers.dart';
import 'package:nuvora/data/database.dart';
import 'package:nuvora/features/auth/profile_repository.dart';
import 'package:nuvora/features/fitness/fitness_repository.dart';
import 'package:nuvora/features/habits/journal_repository.dart';
import 'package:nuvora/features/prayer/prayer_repository.dart';
import 'package:nuvora/features/study/study_repository.dart';
import 'package:nuvora/features/prayer/prayer_service.dart';
import 'package:nuvora/features/prayer/prayer_streaks.dart';
import '../test/nav_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _fonts = 'C:/src/flutter/bin/cache/artifacts/material_fonts';

Future<void> _font(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final f in files) {
    loader.addFont(File('$_fonts/$f').readAsBytes().then((b) => ByteData.view(b.buffer)));
  }
  await loader.load();
}

void main() {
  setUpAll(() async {
    await _font('Roboto', [
      'roboto-regular.ttf',
      'roboto-medium.ttf',
      'roboto-bold.ttf',
    ]);
    await _font('MaterialIcons', ['materialicons-regular.otf']);
  });

  for (final mode in ['light', 'dark']) {
    testWidgets('screenshots $mode', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      tester.view.devicePixelRatio = 2;
      addTearDown(() {
        tester.binding.setSurfaceSize(null);
        tester.view.resetDevicePixelRatio();
      });

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final db = AppDatabase(NativeDatabase.memory());

      Future<void> pumpApp() async {
        await tester.pumpWidget(ProviderScope(
          key: UniqueKey(),
          overrides: [
            sharedPrefsProvider.overrideWithValue(prefs),
            databaseProvider.overrideWithValue(db),
            clockProvider.overrideWithValue(() {
              final n = DateTime.now();
              return DateTime(n.year, n.month, n.day, 8);
            }),
          ],
          child: const NuvoraApp(),
        ));
        await tester.pumpAndSettle();
      }

      Future<void> shot(String name) => expectLater(
          find.byType(NuvoraApp), matchesGoldenFile('screenshots/${mode}_$name.png'));

      // Onboarding (no profile yet).
      await pumpApp();
      await shot('1_onboarding');

      // Seed a profile with prayer settings and some history.
      await tester.runAsync(() async {
        final id = await ProfileRepository(db).createProfile(
            NewProfile(displayName: 'Amina', themeMode: mode));
        await prefs.setString('active_profile_id', id);
        final repo = PrayerRepository(db);
        await repo.saveSettings(id,
            method: 'karachi',
            asrMethod: 'shafi',
            latitude: 24.8607,
            longitude: 67.0011,
            locationLabel: 'Karachi');
        final now = DateTime.now();
        for (var d = 1; d <= 4; d++) {
          for (final p in PrayerName.values) {
            await repo.setStatus(id, DateTime(now.year, now.month, now.day - d),
                p, PrayerStatus.onTime);
          }
        }
        await repo.setStatus(id, now, PrayerName.fajr, PrayerStatus.onTime);
        await repo.setStatus(id, now, PrayerName.dhuhr, PrayerStatus.late);
        await FitnessRepository(db).addWater(id, 250);
        await FitnessRepository(db).addWater(id, 500);
        await FitnessRepository(db).saveWorkoutSession(id,
            workoutKey: "full_starter",
            workoutName: "Full-Body Starter",
            startedAt: now.subtract(const Duration(hours: 3)),
            endedAt: now.subtract(const Duration(hours: 3, minutes: -12)),
            exercisesCompleted: 5,
            exercisesTotal: 5);
        final study = StudyRepository(db);
        final math = await study.addSubject(id, "Mathematics");
        final t1 = await study.addTopic(id, math, "Limits and continuity", priority: 1);
        await study.addTopic(id, math, "Derivatives");
        await study.setTopicStatus(id, t1, TopicStatus.completed);
        await study.addExam(id, "Calculus midterm", now.add(const Duration(days: 12)), subjectId: math);
        await study.addCard(id, "What is a derivative?", "The rate of change of a function.");
        await JournalRepository(db).save(id, now,
            wentWell: 'Finished the limits chapter before lunch.',
            learned: 'Continuity needs three conditions.',
            grateful: 'A quiet morning to study.');
        await PrayerRepository(db).setStatus(id, DateTime(now.year, now.month, now.day - 6), PrayerName.fajr, PrayerStatus.missed);
      });

      await pumpApp();
      await shot('2_home');

      await tapNav(tester, 'Prayer');
      await tester.pumpAndSettle();
      await shot('3_prayer');

      await tapNav(tester, 'Home');
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Settings'));
      await tester.pumpAndSettle();
      await shot('4_settings');
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tapNav(tester, 'Study');
      await tester.tap(find.text('Subjects'));
      await tester.pumpAndSettle();
      await shot('5_study');
      await tapNav(tester, 'Fitness');
      await shot('6_fitness');
      await tester.tap(find.text('Water'));
      await tester.pumpAndSettle();
      await shot('7_water');

      Future<void> openFromHome(String label) async {
        await tapNav(tester, 'Home');
        final tile = find.text(label);
        await tester.scrollUntilVisible(tile, 200,
            scrollable: find.byType(Scrollable).first);
        await tester.tap(tile);
        await tester.pumpAndSettle();
      }

      await openFromHome('Daily plan');
      await tester.tap(find.text('Suggest a plan'));
      for (var i = 0; i < 20; i++) {
        await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 50)));
        await tester.pump();
      }
      await tester.pumpAndSettle();
      await shot('8_planner');
      await tester.pageBack();
      await tester.pumpAndSettle();

      await openFromHome('Habit calendar');
      await shot('9_calendar');
      await tester.pageBack();
      await tester.pumpAndSettle();

      await openFromHome('Progress');
      await tester.pumpAndSettle();
      await shot('10_progress');
      await tester.pageBack();
      await tester.pumpAndSettle();

      await openFromHome('Reflection');
      await shot('11_journal');

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 1));
      await tester.runAsync(db.close);
    });
  }
}
