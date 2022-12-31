// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:runningtracker/screens/addRun.dart';

void main() {
  /// Create AddRun screen
  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  /// Test AddRun.dart --> Tests Textfield and Clear Button
  testWidgets('Login Page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const AddRun()));

    var textFields = find.byType(TextField);
    expect(textFields, findsWidgets);

    var durationField = find.byKey(const Key("duration"));
    await tester.enterText(durationField, 'Flutter Devs');
    expect(find.text('Flutter Devs'),
        findsNothing); // Find no textfield becaus duration is number field

    var nameField = find.byKey(const Key("name"));
    await tester.enterText(nameField, 'Flutter Devs');
    expect(find.text('Flutter Devs'), findsOneWidget);

    var button = find.text("Clear Details");
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pump();
    expect(find.text('Flutter Devs'), findsNothing);
  });
}
