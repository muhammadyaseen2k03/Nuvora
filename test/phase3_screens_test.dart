import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/app/app.dart';
import 'package:nuvora/app/providers.dart';
import 'package:nuvora/data/database.dart';
import 'package:nuvora/features/auth/profile_repository.dart';
import 'package:nuvora/features/prayer/prayer_repository.dart';
import 'package:nuvora/features/study/study_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  testWidgets('journal, planner, calendar and progress work end to end',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final db = AppDatabase(NativeDatabase.memory());
    final real = DateTime.now();
    final fixedNow = DateTime(real.year, real.month, real.day, 8, 0);

    final id = await tester.runAsync(() async {
      final pid = await ProfileRepository(db)
          .createProfile(const NewProfile(displayName: 'Amina'));
      await PrayerRepository(db).saveSettings(pid,
          method: 'karachi',
          asrMethod: 'shafi',
          latitude: 24.8607,
          longitude: 67.0011,
          locationLabel: 'Karachi');
      final study = StudyRepository(db);
      await study.addExam(pid, 'Calculus midterm',
          fixedNow.add(const Duration(days: 2)));
      final math = await study.addSubject(pid, 'Math');
      await study.addTopic(pid, math, 'Limits', priority: 1);
      await study.addCard(pid, 'Q', 'A');
      return pid;
    });
    await prefs.setString('active_profile_id', id!);

    await tester.pumpWidget(ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
        databaseProvider.overrideWithValue(db),
        clockProvider.overrideWithValue(() => fixedNow),
      ],
      child: const NuvoraApp(),
    ));
    await tester.pumpAndSettle();

    Future<void> openFromHome(String label) async {
      final tile = find.text(label);
      await tester.scrollUntilVisible(tile, 200,
          scrollable: find.byType(Scrollable).first);
      await tester.tap(tile);
      await tester.pumpAndSettle();
    }

    // Planner: suggestions come from stored data.
    await openFromHome('Daily plan');
    expect(find.text('Suggest a plan'), findsOneWidget);
    await tester.tap(find.text('Suggest a plan'));
    for (var i = 0; i < 20; i++) {
      await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 50)));
      await tester.pump();
    }
    await tester.pumpAndSettle();
    expect(find.text('Calculus midterm'), findsOneWidget);
    expect(find.text('Review cards'), findsOneWidget);
    expect(find.text('Suggested because an exam is coming up.'), findsOneWidget);
    final rows = await tester.runAsync(() => db.select(db.plannedActivities).get());
    expect(rows!.length, greaterThanOrEqualTo(3));
    // No overlapping stored activities.
    final sorted = [...rows]..sort((a, b) => a.startAt.compareTo(b.startAt));
    for (var i = 1; i < sorted.length; i++) {
      expect(sorted[i].startAt.isBefore(sorted[i - 1].endAt), isFalse);
    }
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Journal: write, see it, search, delete.
    await openFromHome('Reflection');
    expect(find.text('No entries yet.'), findsOneWidget);
    await tester.tap(find.text("Today's reflection"));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.descendant(of: find.byType(BottomSheet), matching: find.byType(TextField)).first,
        'Finished chapter three');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Finished chapter three'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, 'nomatch');
    await tester.pumpAndSettle();
    expect(find.text('Finished chapter three'), findsNothing);
    await tester.enterText(find.byType(TextField).first, 'CHAPTER');
    await tester.pumpAndSettle();
    expect(find.text('Finished chapter three'), findsOneWidget);
    await tester.tap(find.byTooltip('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();
    expect(find.text('Finished chapter three'), findsNothing);
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Calendar: legend explains unrecorded vs missed.
    await openFromHome('Habit calendar');
    expect(find.textContaining('not the same as missed'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Progress: level and unearned badges are shown from real data.
    await openFromHome('Progress');
    await tester.pumpAndSettle();
    expect(find.text('Level 1'), findsOneWidget);
    expect(find.text('Ten workouts'), findsOneWidget);
    expect(find.text('Earned'), findsNothing);
    final awards = await tester.runAsync(() => db.select(db.achievementAwards).get());
    expect(awards, isEmpty);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await tester.runAsync(db.close);
  });
}
