import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_management_app/main.dart';

void main() {
  testWidgets('Notes app loads and shows title', (WidgetTester tester) async {
    await tester.pumpWidget(const NotesApp());
    expect(find.text('My Notes'), findsOneWidget);
  });
}