import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Taps a bottom-navigation destination by its label.
Future<void> tapNav(WidgetTester tester, String label) async {
  await tester.tap(find.descendant(
      of: find.byType(NavigationBar), matching: find.text(label)));
  await tester.pumpAndSettle();
}

Finder navLabel(String label) => find.descendant(
    of: find.byType(NavigationBar), matching: find.text(label));
