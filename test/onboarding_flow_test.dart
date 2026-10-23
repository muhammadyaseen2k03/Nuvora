import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/app/app.dart';
import 'package:nuvora/app/providers.dart';
import 'package:nuvora/data/database.dart';
import 'nav_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('onboarding validates name, creates a profile, shows Home',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);

    await tester.pumpWidget(ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
        databaseProvider.overrideWithValue(db),
      ],
      child: const NuvoraApp(),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Nuvora'), findsOneWidget);

    // Empty name is rejected.
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter a name'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Amina');
    for (var i = 0; i < 4; i++) {
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Amina'), findsOneWidget);
    expect(navLabel('Prayer'), findsOneWidget);
    expect(prefs.getString('active_profile_id'), isNotNull);
    expect(await db.select(db.profiles).get(), hasLength(1));

    // Bottom navigation reaches the Fitness workout list.
    await tapNav(tester, 'Fitness');
    await tester.pumpAndSettle();
    expect(find.text('Full-Body Starter'), findsOneWidget);

    // Dispose the tree and let Drift's stream-close timer run.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
