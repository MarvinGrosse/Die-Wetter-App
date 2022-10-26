import 'package:die_wetter_app/services/database_helper.dart';
import 'package:die_wetter_app/services/weather_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/weather.dart';

import '../../models/locations.dart';
import '../../models/weather_data.dart';

final homeProvider =
    StateNotifierProvider<HomeNotifier, AsyncValue<List<WeatherData>>>(
        (ref) => HomeNotifier(ref));

class HomeNotifier extends StateNotifier<AsyncValue<List<WeatherData>>> {
  HomeNotifier(this.ref) : super(const AsyncLoading()) {
    getWeather();
  }

  Ref ref;

  List<Location> locationNames = [];
  List<WeatherData> weatherList = [];

  final StackTrace noLocationsError =
      StackTrace.fromString('There are no locations. \nTry adding a location');

  void getWeather() async {
    state = const AsyncLoading();
    locationNames = [];
    weatherList = [];

    // laden der gespeicherten Locations aus der lokeln Datenbank.
    try {
      locationNames = await ref.read(databaseProvider).getAllLocations();
    } catch (e) {
      state = AsyncValue.error(
          Error,
          StackTrace.fromString(
              'stored locations could not be loaded. try again'));
    }

    //checken ob locations leer sind, falls ja state setzten.
    if (locationNames.isEmpty) {
      state = AsyncError(Error, noLocationsError);
    } else {
      // loopen über die Locations der Datenbank und fetchen des Wetters der Api.
      for (var element in locationNames) {
        try {
          Weather w = await ref
              .read(weatherFactoryProvider)
              .currentWeatherByCityName(element.name);
          List<MyWeather> f = await ref
              .read(weatherServiceProvider)
              .getDailyForecastFiveDays(element.name);
          List<HourlyWeather> hf =
              []; //await getHourForecast(element.name); Funktioniert nicht weil aki key anscheinend nicht valide für diesen call
          weatherList.add(WeatherData(w, f, hf, element));
        } catch (e) {
          state = AsyncError(Error(), StackTrace.fromString(e.toString()));
          print(e.toString());
        }
      }
      state = AsyncData(weatherList);
    }
  }

  // returns the Icon for the Weather API

  // Function zum pfüfen ob Stadt existiert in der WeatherApi.
  Future<bool> checkForLocation() async {
    return false;
  }

  void deleteLocation(WeatherData weatherData) async {
    try {
      await ref.read(databaseProvider).deleteLocation(weatherData.location.id);
      locationNames.remove(weatherData.location);
      weatherList.remove(weatherData);
      if (weatherList.isEmpty) {
        state = AsyncError(Error, noLocationsError);
      } else {
        state = AsyncData(weatherList);
      }
    } catch (e) {
      state = AsyncError(
          Error,
          StackTrace.fromString(
              'could not delete location. \nPull to refrech and try again'));
    }
  }
}
