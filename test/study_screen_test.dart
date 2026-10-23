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
  testWidgets('study: add subject and card, review it, queue empties',
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

    await tapNav(tester, 'Study');
    await tester.pumpAndSettle();
    expect(find.text('Start'), findsOneWidget);

    // Subjects tab: add a subject.
    await tester.tap(find.text('Subjects'));
    await tester.pumpAndSettle();
    expect(find.text('No upcoming exams.'), findsOneWidget);
    await tester.tap(find.text('Add subject'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Biology');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Biology'), findsOneWidget);
    expect(find.text('0 of 0 topics completed'), findsOneWidget);

    // Cards tab: empty, add a card, it is due, review it.
    await tester.tap(find.text('Cards'));
    await tester.pumpAndSettle();
    expect(find.text('No cards due'), findsOneWidget);
    await tester.tap(find.text('Add card'));
    await tester.pumpAndSettle();
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Powerhouse of the cell?');
    await tester.enterText(fields.at(1), 'Mitochondria');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('1 card due'), findsOneWidget);

    await tester.tap(find.text('Review cards'));
    await tester.pumpAndSettle();
    expect(find.text('Powerhouse of the cell?'), findsOneWidget);
    expect(find.text('Mitochondria'), findsNothing);
    await tester.tap(find.text('Show answer'));
    await tester.pumpAndSettle();
    expect(find.text('Mitochondria'), findsOneWidget);
    await tester.tap(find.text('Good'));
    await tester.pumpAndSettle();
    expect(find.text('All caught up. No more cards are due.'), findsOneWidget);

    final reviews =
        await tester.runAsync(() => db.select(db.flashcardReviews).get());
    expect(reviews, hasLength(1));
    expect(reviews!.single.rating, 'good');

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await tester.runAsync(db.close);
  });
}
