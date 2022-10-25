import 'package:die_wetter_app/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:die_wetter_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //DBHandler db = DBHandler();
  //db.resetDB();

  group('end-to-end test', () {
    testWidgets(
        'Change screens, add Location, change back, go Details, delete Location, go back and Check',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final firstTitle = find.text('Die Wetter App');
      expect(firstTitle, findsOneWidget);

      await Future.delayed(const Duration(seconds: 5), () {});

      expect(find.byType(IconButton), findsOneWidget);
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
      final secondTitle = find.text('Add Location');
      expect(secondTitle, findsOneWidget);

      const String text = 'Stuttgart';
      await tester.enterText(find.byType(TextFormField), text);
      final checkForTextEntered = find.text(text);
      expect(checkForTextEntered, findsOneWidget);

      await Future.delayed(const Duration(seconds: 5), () {});

      await tester.tap(find.byKey(const Key('AddScreenAddButton')));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 5), () {});

      final firstTitle2 = find.text('Die Wetter App');
      expect(firstTitle2, findsOneWidget);
      final weatherWidget = find.text('Stuttgart');
      expect(weatherWidget, findsOneWidget);

      expect(find.byType(Card), findsOneWidget);
      await tester.tap(find.byType(Card));
      await tester.pumpAndSettle();
      final detailScreenTitle = find.text('Stuttgart');
      expect(detailScreenTitle, findsOneWidget);

      await Future.delayed(const Duration(seconds: 5), () {});

      await tester.tap(find.byKey(const Key('DeleteButton')));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 5), () {});

      final weatherWidget2 = find.text('Stuttgart');
      expect(weatherWidget2, findsNothing);
    });
  });
}
