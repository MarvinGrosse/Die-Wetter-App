import 'dart:convert';

import 'package:die_wetter_app/models/locations.dart';
import 'package:die_wetter_app/models/weather_data.dart';
import 'package:die_wetter_app/pages/home_screen/home_screen.dart';
import 'package:die_wetter_app/services/database_helper.dart';
import 'package:die_wetter_app/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;
import 'home_screen_test.mocks.dart';

@GenerateMocks([DBHandler, WeatherFactory, WeatherService, http.Client])
void main() {
  final fakeDBHandler = MockDBHandler();
  final fakeWeatherService = MockWeatherService();
  final fakeWeatherFactory = MockWeatherFactory();

  const String fakeResponse5Days =
      '{"city":{"id":2825297,"name":"Stuttgart","coord":{"lon":9.177,"lat":48.7823},"country":"DE","population":589793,"timezone":7200},"cod":"200","message":0.047735,"cnt":5,"list":[{"dt":1666350000,"sunrise":1666331532,"sunset":1666369402,"temp":{"day":290.35,"min":287.31,"max":290.93,"night":288.13,"eve":289.89,"morn":288.52},"feels_like":{"day":290.35,"night":287.96,"eve":289.73,"morn":288.44},"pressure":1013,"humidity":85,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"speed":6.56,"deg":204,"gust":16.72,"clouds":40,"pop":1,"rain":4.71},{"dt":1666436400,"sunrise":1666418026,"sunset":1666455690,"temp":{"day":290.53,"min":285.79,"max":292.48,"night":286.01,"eve":287.98,"morn":285.79},"feels_like":{"day":290.13,"night":285.57,"eve":287.53,"morn":285.49},"pressure":1018,"humidity":69,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"speed":5.44,"deg":221,"gust":12.06,"clouds":77,"pop":1,"rain":6.68},{"dt":1666522800,"sunrise":1666504519,"sunset":1666541980,"temp":{"day":293.5,"min":284.17,"max":293.5,"night":290.07,"eve":289.24,"morn":284.27},"feels_like":{"day":292.9,"night":289.65,"eve":288.73,"morn":283.63},"pressure":1015,"humidity":50,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"speed":5.67,"deg":223,"gust":13.27,"clouds":100,"pop":0.06},{"dt":1666609200,"sunrise":1666591013,"sunset":1666628271,"temp":{"day":287.96,"min":286.09,"max":289.81,"night":286.09,"eve":286.66,"morn":288.49},"feels_like":{"day":287.77,"night":285.84,"eve":286.47,"morn":288.04},"pressure":1016,"humidity":87,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"speed":5.82,"deg":213,"gust":14.56,"clouds":100,"pop":0.69,"rain":2.34},{"dt":1666695600,"sunrise":1666677507,"sunset":1666714563,"temp":{"day":291.9,"min":284.72,"max":291.9,"night":285.9,"eve":287.29,"morn":284.72},"feels_like":{"day":291.29,"night":285.48,"eve":286.82,"morn":284.31},"pressure":1019,"humidity":56,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"speed":2.22,"deg":194,"gust":5.41,"clouds":24,"pop":0.36,"rain":0.17}]}';

  const String fakeResponseCurrentWeather =
      '{"coord":{"lon":9.177,"lat":48.7823},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"base":"stations","main":{"temp":290.68,"feels_like":290.76,"temp_min":289.85,"temp_max":291.78,"pressure":1013,"humidity":87},"visibility":10000,"wind":{"speed":3.09,"deg":210},"rain":{"1h":0.53},"clouds":{"all":0},"dt":1666357939,"sys":{"type":1,"id":1274,"country":"DE","sunrise":1666331532,"sunset":1666369402},"timezone":7200,"id":2825297,"name":"Stuttgart","cod":200}';

  when(fakeDBHandler.getAllLocations()).thenAnswer(
    (value) async {
      //print('Fake DB wurde ausgefürt');
      return [Location(id: 'DAFDSFSF', name: 'Stuttgart')];
    },
  );

  when(fakeWeatherService.getDailyForecastFiveDays('Stuttgart'))
      .thenAnswer((value) async {
    WeatherService service = WeatherService();

    //print('fake WeatherService wurde ausgefürt');

    Map<String, dynamic> jsonBody = json.decode(fakeResponse5Days);
    List<MyWeather> forecast = service.parseForecast(jsonBody);

    return forecast;
  });

  when(fakeWeatherFactory.currentWeatherByCityName('Stuttgart'))
      .thenAnswer((value) async {
    Map<String, dynamic> jsonBody = json.decode(fakeResponseCurrentWeather);

    //print('Fake WeatherFactory wurde ausgefürt');

    return Weather(jsonBody);
  });

  testWidgets('Test Services on Home Screen', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(fakeDBHandler),
            weatherFactoryProvider.overrideWithValue(fakeWeatherFactory),
            weatherServiceProvider.overrideWithValue(fakeWeatherService)
          ],
          child: const HomeScreen(),
        ),
      );
      await tester.pumpAndSettle();

      final weatherWidgetWithKey =
          find.byKey(const Key('LocationTitleHomeScreen'));
      final weatherWidget = find.text('Stuttgart');
      expect(weatherWidget, findsOneWidget);
      expect(weatherWidgetWithKey, findsOneWidget);
    });
  });

  testWidgets('HomeScreen has a title', (tester) async {
    await tester.pumpWidget(ProviderScope(child: const HomeScreen()));
    final title1 = find.text('Die Wetter App1111');
    final title2 = find.text('Die Wetter App');

    expect(title1, findsNothing);
    expect(title2, findsOneWidget);
  });

  testWidgets('Check for new item on Home Screen', (tester) async {
    await tester.pumpWidget(ProviderScope(child: const HomeScreen()));

    final firstTitle = find.text('Die Wetter App');
    expect(firstTitle, findsOneWidget);

    expect(find.byType(IconButton), findsOneWidget);
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    final secondTitle = find.text('Add Location');
    expect(secondTitle, findsOneWidget);

    const String text = 'Stuttgart';
    await tester.enterText(find.byType(TextFormField), text);
    final checkForTextEntered = find.text(text);
    expect(checkForTextEntered, findsOneWidget);

    //Tut immer noch nicht.
    await tester.tap(find.byKey(const Key('AddScreenAddButton')));
    //await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    //final firstTitle2 = find.text('Die Wetter App');
    //expect(firstTitle2, findsOneWidget);
  });
}
