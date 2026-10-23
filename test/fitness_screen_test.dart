import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/app/app.dart';
import 'package:nuvora/app/providers.dart';
import 'package:nuvora/data/database.dart';
import 'package:nuvora/features/auth/profile_repository.dart';
import 'nav_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('fitness: log water, run a workout, history is saved',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final db = AppDatabase(NativeDatabase.memory());
    final id = await tester.runAsync(() =>
        ProfileRepository(db).createProfile(const NewProfile(displayName: 'Amina')));
    await prefs.setString('active_profile_id', id!);

    await tester.pumpWidget(ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
        databaseProvider.overrideWithValue(db),
      ],
      child: const NuvoraApp(),
    ));
    await tester.pumpAndSettle();

    await tapNav(tester, 'Fitness');
    await tester.pumpAndSettle();
    expect(find.text('Busy Day Mini'), findsOneWidget);

    // Water.
    await tester.tap(find.text('Water'));
    await tester.pumpAndSettle();
    expect(find.text('0 of 2000 ml'), findsOneWidget);
    await tester.tap(find.text('Add 250 ml'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add 500 ml'));
    await tester.pumpAndSettle();
    expect(find.text('750 of 2000 ml'), findsOneWidget);
    await tester.tap(find.text('Undo last'));
    await tester.pumpAndSettle();
    expect(find.text('250 of 2000 ml'), findsOneWidget);

    // Workout: open, start, skip the timed step and its rest, finish the
    // rep-based squats, then end early.
    await tester.tap(find.text('Workouts'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Busy Day Mini'));
    await tester.pumpAndSettle();
    expect(find.text('Start workout'), findsOneWidget);
    await tester.tap(find.text('Start workout'));
    await tester.pumpAndSettle();
    expect(find.text('Step jacks'), findsOneWidget);
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Rest'), findsWidgets);
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Bodyweight squat'), findsOneWidget);
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('End workout'));
    await tester.pumpAndSettle();
    expect(find.text('Workout complete'), findsOneWidget);
    expect(find.textContaining('1 of 4 exercises'), findsOneWidget);

    final rows = await tester.runAsync(() => db.select(db.workoutSessions).get());
    expect(rows, hasLength(1));
    expect(rows!.single.exercisesCompleted, 1);
    final water = await tester.runAsync(() => db.select(db.waterLogs).get());
    expect(water!.single.amountMl, 250);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await tester.runAsync(db.close);
  });
}
