import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: unused_import
import 'package:flutter_application_8/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    
    await tester.pumpWidget(QuizApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
