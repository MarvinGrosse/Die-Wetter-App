import 'package:die_wetter_app/pages/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('Add Location on AddScreen', (tester) async {
    Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: AddScreen(),
        ));

    await tester.pumpWidget(ProviderScope(child: testWidget));

    final title = find.text('Add Location');
    expect(title, findsOneWidget);

    const String text = 'Stuttgart';
    await tester.enterText(find.byType(TextFormField), text);
    final checkForTextEntered = find.text(text);
    expect(checkForTextEntered, findsOneWidget);

    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
