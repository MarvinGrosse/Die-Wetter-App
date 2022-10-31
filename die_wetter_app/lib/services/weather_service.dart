import 'dart:convert';
import 'package:die_wetter_app/models/weather_models/today_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:weather/weather.dart';
import 'package:die_wetter_app/services/database_helper.dart';
import '../models/locations.dart';
import '../models/weather_models/forecast_weather.dart';
import '../models/weather_models/weather_data.dart';

const String _apiKey = '7e12052d9bea3a2d6045ce0bec3bb6d8';

final weatherProvider = StateNotifierProvider<WeatherProviderNotifier,
    AsyncValue<List<WeatherData>>>((ref) => WeatherProviderNotifier(ref));

final weatherServiceProvider = Provider((ref) => WeatherService());
final weatherFactoryProvider = Provider((ref) => WeatherFactory(_apiKey));

final StackTrace noLocationsError =
    StackTrace.fromString('There are no locations. \nTry adding a location');

class WeatherProviderNotifier
    extends StateNotifier<AsyncValue<List<WeatherData>>> {
  WeatherProviderNotifier(this.ref) : super(const AsyncLoading());

  Ref ref;

  List<Location> locationNames = [];
  List<WeatherData> weatherList = [];

  // returns the Icon for the Weather API
  getWeatherIcon(String data) {
    String url = 'http://openweathermap.org/img/wn/$data@2x.png';
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Text('no Image');
      },
    );
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

class WeatherService {
  Future<TodayWeather> getTodaysWeather(String cityName) async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$_apiKey&lang=en";

    /// Send HTTP get response with the url
    http.Response response = await _httpClient.get(Uri.parse(url));

    /// Perform error checking on response:
    if (response.statusCode < 400) {
      //log(response.body.toString());
      Map<String, dynamic> jsonBody = json.decode(response.body);
      return TodayWeather.fromJson(jsonBody);
    } else {
      throw OpenWeatherAPIException("API Error: ${response.body}");
    }
  }

  //static const int STATUS_OK = 200;
  //static const String FIVE_DAY_FORECAST = 'daily';
  //static const String HOURLY_FORECAST = 'hourly';
  late http.Client _httpClient;
  //WeatherFactory wf = WeatherFactory('7e12052d9bea3a2d6045ce0bec3bb6d8');

  WeatherService() {
    _httpClient = http.Client();
  }

  Future<ForecastWeather> getForcastWeather(String cityName) async {
    String url =
        "https://api.openweathermap.org/data/2.5/forecast/daily?q=$cityName&cnt=14&appid=$_apiKey&lang=en";

    /// Send HTTP get response with the url
    http.Response response = await _httpClient.get(Uri.parse(url));

    /// Perform error checking on response:
    if (response.statusCode < 400) {
      //log(response.body.toString());
      Map<String, dynamic> jsonBody = json.decode(response.body);
      return ForecastWeather.fromJson(jsonBody);
    } else {
      throw OpenWeatherAPIException("API Error: ${response.body}");
    }
  }
/**
  Future<List<MyWeather>> getDailyForecastFiveDays(String cityName) async {
    Map<String, dynamic>? jsonForecast =
        await _sendAPIRequest(cityName, FIVE_DAY_FORECAST);
    List<MyWeather> forecasts = parseForecast(jsonForecast!);
    return forecasts;
  }

  Future<List<HourlyWeather>> getHourForecast(String cityName) async {
    Map<String, dynamic>? jsonForecast =
        await _sendAPIRequest(cityName, HOURLY_FORECAST);
    List<HourlyWeather> forecast = parseForecastHourly(jsonForecast!);
    return forecast;
  }
   */

/**
  Future<Map<String, dynamic>?> _sendAPIRequest(
      String cityName, String forecastType) async {
    String url =
        "https://api.openweathermap.org/data/2.5/forecast/$forecastType?q=$cityName&cnt=5&appid=$_apiKey&lang=en";

    /// Send HTTP get response with the url
    http.Response response = await _httpClient.get(Uri.parse(url));

    /// Perform error checking on response:
    if (response.statusCode == STATUS_OK) {
      //log(response.body.toString());
      Map<String, dynamic>? jsonBody = json.decode(response.body);
      return jsonBody;
    } else {
      throw OpenWeatherAPIException(
          "The API threw an exception: ${response.body}");
    }
  }


  List<MyWeather> parseForecast(
    Map<String, dynamic> jsonForecast,
  ) {
    List<dynamic> forecastList = jsonForecast['list'];
    Map<String, dynamic> city = jsonForecast['city'];
    Map<String, dynamic>? coord = city['coord'];
    String? country = city['country'];
    String? name = _unpackString(city, 'name');
    double? lat = _unpackDouble(coord, 'lat');
    double? lon = _unpackDouble(coord, 'lon');

    // Convert the json list to a Weather list
    return forecastList.map((w) {
      // Put the general fields inside inside every weather object
      w['name'] = name;
      w['sys'] = {'country': country};
      w['coord'] = {'lat': lat, 'lon': lon};
      return MyWeather(w);
    }).toList();
  }

  List<HourlyWeather> parseForecastHourly(Map<String, dynamic> jsonForecast) {
    List<dynamic> forecastList = jsonForecast['list'];
    Map<String, dynamic> city = jsonForecast['city'];
    Map<String, dynamic>? coord = city['coord'];
    String? country = city['country'];
    String? name = _unpackString(city, 'name');
    double? lat = _unpackDouble(coord, 'lat');
    double? lon = _unpackDouble(coord, 'lon');

    // Convert the json list to a Weather list
    return forecastList.map((w) {
      // Put the general fields inside inside every weather object
      w['name'] = name;
      w['sys'] = {'country': country};
      w['coord'] = {'lat': lat, 'lon': lon};
      return HourlyWeather(w);
    }).toList();
  }

  /// Safely unpack a double value from a [Map] object.
  double? _unpackDouble(Map<String, dynamic>? M, String k) {
    if (M != null) {
      if (M.containsKey(k)) {
        final val = M[k];
        if (val is String) {
          return double.parse(val);
        } else if (val is num) {
          return val.toDouble();
        }
      }
    }
    return null;
  }

  /// Safely unpack a string value from a [Map] object.
  String? _unpackString(Map<String, dynamic>? M, String k) {
    if (M != null) {
      if (M.containsKey(k)) {
        return M[k];
      }
    }
    return null;
  }
   */
}
