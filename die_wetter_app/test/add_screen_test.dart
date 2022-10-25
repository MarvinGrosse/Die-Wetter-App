import 'dart:math';

import 'package:die_wetter_app/models/locations.dart';
import 'package:die_wetter_app/models/weather_data.dart';
import 'package:die_wetter_app/pages/add_screen.dart';
import 'package:die_wetter_app/pages/home_screen.dart';
import 'package:die_wetter_app/services/database_helper.dart';
import 'package:die_wetter_app/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:weather/weather.dart';
import 'package:state_notifier/state_notifier.dart';

void main() {
  testWidgets('Add Location on AddScreen', (tester) async {
    Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
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
