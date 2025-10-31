import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter2d/main.dart';

void main() {
  testWidgets('Game menu displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the game title is displayed
    expect(find.text('DODGE IT'), findsOneWidget);
    expect(find.text('PLAY OR DIE'), findsOneWidget);
    expect(find.text('PLAY NOW'), findsOneWidget);
  });

  testWidgets('Navigate to game screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the 'PLAY NOW' button
    await tester.tap(find.text('PLAY NOW'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the game screen
    expect(find.text('TAP TO START'), findsOneWidget);
  });

  testWidgets('Game starts when START button is pressed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Navigate to game screen
    await tester.tap(find.text('PLAY NOW'));
    await tester.pumpAndSettle();

    // Start the game
    await tester.tap(find.text('START'));
    await tester.pump();

    // Verify that the score display appears
    expect(find.textContaining('Score:'), findsOneWidget);
  });
}
