// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:runningtracker/models/run.dart';
import 'package:runningtracker/screens/editRun.dart';

void main() {
  /// Create EditRun screen
  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  /// Test EditRun.dart --> Tests Textfield validation
  testWidgets('Login Page smoke test', (WidgetTester tester) async {
    /// Create run to show some data
    Run run = Run();
    run.durationminutes = 30;
    run.distance = 3.2;

    /// Create widget EditRun
    await tester.pumpWidget(createWidgetForTesting(
        child: EditRun(
      run: run,
    )));

    /// Check if some textfields are shown (view built correctly)
    var textFields = find.byType(TextField);
    expect(textFields, findsWidgets);

    /// Get duration field and check if the value is equal to the specified above
    var durationField =
        tester.widget<TextField>(find.byKey(const Key("duration")));
    expect(durationField.controller?.text, '30');

    /// Get "Update Details" button and execute "click"
    var button = find.text("Update Details");
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pump();

    /// Check if validation is shown on name field (because it should be empty)
    final nameErrorFinder = find.text('Name value can\'t be empty');
    expect(nameErrorFinder, findsOneWidget);
  });
}
