import 'package:audio_plus_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AudioPlayerScreen renders correctly',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MyApp());

    // Check if 'Now Playing' text appears
    expect(find.text('Now Playing'), findsOneWidget);

    // Check if play button is initially visible
    expect(find.byIcon(Icons.play_circle_filled), findsOneWidget);

    // Check if volume text is present
    expect(find.text('Volume'), findsOneWidget);
  });
}
