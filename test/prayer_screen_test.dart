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
  testWidgets('prayer: choose city, see times, record without marking others',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final id = await tester.runAsync(
        () => ProfileRepository(db).createProfile(const NewProfile(displayName: 'Amina')));
    await prefs.setString('active_profile_id', id!);

    await tester.pumpWidget(ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
        databaseProvider.overrideWithValue(db),
      ],
      child: const NuvoraApp(),
    ));
    await tester.pumpAndSettle();

    await tapNav(tester, 'Prayer');
    await tester.pumpAndSettle();
    expect(find.text('Choose your location'), findsOneWidget);

    await tester.tap(find.text('Set location'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('City'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Karachi').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // All five rows start as not recorded (never silently "missed").
    expect(find.text('Fajr'), findsOneWidget);
    expect(find.textContaining('Not recorded'), findsNWidgets(5));
    expect(find.textContaining('Missed'), findsNothing);

    await tester.tap(find.byTooltip('Record Fajr'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('On time').last);
    await tester.pumpAndSettle();

    expect(find.textContaining('Not recorded'), findsNWidgets(4));
    expect(find.textContaining('On time'), findsOneWidget);

    final rows = await tester.runAsync(() => db.select(db.prayerRecords).get());
    expect(rows, hasLength(1));
    expect(rows!.single.prayer, 'fajr');
    expect(rows.single.status, 'onTime');

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
