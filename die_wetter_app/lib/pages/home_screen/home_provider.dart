import 'package:die_wetter_app/models/weather_models/forecast_weather.dart';
import 'package:die_wetter_app/models/weather_models/today_weather.dart';
import 'package:die_wetter_app/services/database_helper.dart';
import 'package:die_wetter_app/services/weather_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/city.dart';
import '../../models/locations.dart';
import '../../models/weather_models/weather_data.dart';

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
      state = AsyncError(
          Error,
          StackTrace.fromString(
              'There are no locations. \nTry adding a location'));
    } else {
      // loopen über die Locations der Datenbank und fetchen des Wetters der Api.
      for (var element in locationNames) {
        try {
          TodayWeather w =
              await ref.read(weatherServiceProvider).getTodaysWeather(element);

          ForecastWeather f =
              await ref.read(weatherServiceProvider).getForcastWeather(element);

          weatherList.add(WeatherData(w, f, element));
        } catch (e, s) {
          state = AsyncError(Error(), StackTrace.fromString(e.toString()));
          //print(e.toString());
        }
      }
      state = AsyncData(weatherList);
    }
  }

  void deleteLocation(WeatherData weatherData) async {
    try {
      await ref.read(databaseProvider).deleteLocation(weatherData.location.id);
      locationNames.remove(weatherData.location);
      weatherList.remove(weatherData);
      if (weatherList.isEmpty) {
        state = AsyncError(
            Error,
            StackTrace.fromString(
                'There are no locations. \nTry adding a location'));
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

  void addLocation(City city) async {
    try {
      Location location = Location(
          id: const Uuid().v4().toString(),
          name: city.name!,
          lat: city.lat!,
          lng: city.lng!);
      await ref.read(weatherServiceProvider).getTodaysWeather(location);
      await ref.read(databaseProvider).insertLocation(location);
      getWeather();
    } catch (e) {
      state = AsyncError(
          Error,
          StackTrace.fromString(
              'could not add location. \nLocation does not exist'));
    }
  }
}
