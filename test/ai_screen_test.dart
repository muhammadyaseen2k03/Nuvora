import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvora/app/app.dart';
import 'package:nuvora/app/providers.dart';
import 'package:nuvora/data/database.dart';
import 'package:nuvora/features/ai/ai_client.dart';
import 'package:nuvora/features/ai/ai_models.dart';
import 'package:nuvora/features/auth/profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeAi implements AiClient {
  final requests = <AiRequest>[];
  @override
  Future<AiReply> send(AiRequest request) async {
    requests.add(request);
    if (request.kind == AiKind.flashcards) {
      return const AiReply(kind: AiKind.flashcards, text: 'Drafts', cards: [
        AiCard('What is ATP?', 'The cell energy currency.'),
        AiCard('Where is it made?', 'Mostly in mitochondria.'),
      ]);
    }
    return AiReply(kind: request.kind, text: 'Try one 25 minute session daily.');
  }
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  testWidgets('AI is opt-in, labelled, reviewable and clearable', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final db = AppDatabase(NativeDatabase.memory());
    final fake = FakeAi();
    final id = await tester.runAsync(() =>
        ProfileRepository(db).createProfile(const NewProfile(displayName: 'Amina')));
    await prefs.setString('active_profile_id', id!);

    await tester.pumpWidget(ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
        databaseProvider.overrideWithValue(db),
        aiClientProvider.overrideWithValue(fake),
      ],
      child: const NuvoraApp(),
    ));
    await tester.pumpAndSettle();

    Future<void> settle() async {
      for (var i = 0; i < 10; i++) {
        await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 30)));
        await tester.pump();
      }
      await tester.pumpAndSettle();
    }

    final tile = find.text('AI assistant (optional)');
    await tester.scrollUntilVisible(tile, 200, scrollable: find.byType(Scrollable).first);
    await tester.tap(tile);
    await tester.pumpAndSettle();

    // Off by default: no tools, the offline suggestion and disclaimer are shown.
    expect(find.text('Offline suggestion'), findsOneWidget);
    expect(find.textContaining('not a doctor'), findsOneWidget);
    expect(find.text('Draft flashcards'), findsNothing);
    expect(fake.requests, isEmpty);

    // Opt in.
    await tester.tap(find.text('Turn on the AI assistant'));
    await settle();
    expect(find.text('Draft flashcards'), findsOneWidget);
    expect(find.text('Share my study summary (minutes per subject)'), findsOneWidget);
    final privacy = await tester.runAsync(() => db.select(db.privacyPreferences).getSingle());
    expect(privacy!.aiConsent, isTrue);
    expect(privacy.aiShareStudy, isFalse, reason: 'categories stay off until chosen');

    // Coach reply is labelled as AI-generated.
    await tester.tap(find.text('Suggest goals for next week'));
    await settle();
    expect(find.text('AI-generated'), findsOneWidget);
    expect(find.text('Try one 25 minute session daily.'), findsWidgets);
    expect(fake.requests.single.kind, AiKind.coach);
    expect(fake.requests.single.context.containsKey('study'), isFalse);

    // Flashcard drafts: nothing is saved until the user confirms.
    await tester.enterText(find.widgetWithText(TextField, 'Your notes'), 'ATP notes');
    // Wait out the client-side request spacing.
    await tester.runAsync(() => Future.delayed(const Duration(seconds: 3, milliseconds: 200)));
    await tester.tap(find.text('Draft flashcards'));
    await settle();
    expect(find.text('Save selected cards (2)'), findsOneWidget);
    final before = await tester.runAsync(() => db.select(db.flashcards).get());
    expect(before, isEmpty);

    // Untick the second draft, then save.
    await tester.tap(find.byType(Checkbox).last);
    await tester.pump();
    expect(find.text('Save selected cards (1)'), findsOneWidget);
    await tester.tap(find.text('Save selected cards (1)'));
    await settle();
    final cards = await tester.runAsync(() => db.select(db.flashcards).get());
    expect(cards, hasLength(1));
    expect(cards!.single.front, 'What is ATP?');
    expect(cards.single.tags, 'ai-assisted');

    // History can be cleared.
    await tester.scrollUntilVisible(find.text('Clear history'), 200,
        scrollable: find.byType(Scrollable).first);
    await tester.tap(find.text('Clear history'));
    await settle();
    final msgs = await tester.runAsync(() => db.select(db.aiMessages).get());
    expect(msgs, isEmpty);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await tester.runAsync(db.close);
  });

  testWidgets('settings shows backup and an honest cloud-not-configured state',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 2400));
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
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Export backup'), 200,
        scrollable: find.byType(Scrollable).first);
    expect(find.text('Export backup'), findsOneWidget);
    expect(find.text('Restore from backup'), findsOneWidget);
    expect(find.textContaining('does not include your recovery question'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Cloud sync (optional)'), 200,
        scrollable: find.byType(Scrollable).first);
    expect(find.textContaining('not set up in this build'), findsOneWidget);
    expect(find.text('Sign in'), findsNothing);
    expect(find.textContaining('not end-to-end encrypted'), findsNothing);
    expect(find.textContaining('does not add its own database encryption'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await tester.runAsync(db.close);
  });
}
