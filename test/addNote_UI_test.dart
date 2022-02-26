import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:countries_interview_application/view/addNote.dart';

void main() {
  testWidgets("Add a note", (WidgetTester tester) async {
    // find the widget fields needed to perform the test
    final titleField = find.byKey(ValueKey("title"));
    final contentField = find.byKey(ValueKey("content"));
    final saveButton = find.byKey(ValueKey("save"));
    // execute the actual test
    await tester.pumpWidget(MaterialApp(home: AddNotesScreen()));
    await tester.enterText(titleField, "My First Note");
    await tester.enterText(contentField, "This is a test note");
    await tester.tap(saveButton);
    await tester.pump(); // rebuilds the widget
    // check result
    expect(find.text("My First Note"), findsOneWidget);
  });
}
