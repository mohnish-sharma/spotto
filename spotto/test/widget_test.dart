import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('UI Widget Tests', () {
    testWidgets('should render basic UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: const Text('Test App')),
            body: const Column(
              children: [
                Text('Welcome to Spotto'),
                ElevatedButton(
                  onPressed: null,
                  child: Text('Test Button'),
                ),
              ],
            ),
          ),
        ),
      );

      // check if text renders correctly
      expect(find.text('Welcome to Spotto'), findsOneWidget);
    });

    testWidgets('should handle button taps', (WidgetTester tester) async {
      bool buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElevatedButton(
              onPressed: () {
                buttonPressed = true;
              },
              child: const Text('Tap Me'),
            ),
          ),
        ),
      );

      // when user taps the button
      await tester.tap(find.text('Tap Me'));
      await tester.pump();

      // then make sure button press is registered
      expect(buttonPressed, isTrue);
    });
  });
}