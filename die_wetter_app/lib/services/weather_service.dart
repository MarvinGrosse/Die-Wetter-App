import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:weather/weather.dart';
import 'package:die_wetter_app/services/database_helper.dart';
import '../models/locations.dart';
import '../models/weather_data.dart';

const String _apiKey = '7e12052d9bea3a2d6045ce0bec3bb6d8';

final weatherProvider = StateNotifierProvider<WeatherProviderNotifier,
    AsyncValue<List<WeatherData>>>((ref) => WeatherProviderNotifier(ref));

final weatherServiceProvider = Provider((ref) => WeatherService());
final weatherFactoryProvider = Provider((ref) => WeatherFactory(_apiKey));

class WeatherProviderNotifier
    extends StateNotifier<AsyncValue<List<WeatherData>>> {
  WeatherProviderNotifier(this.ref) : super(const AsyncLoading()) {
    init();
  }

  Ref ref;
  //WeatherFactory wf = WeatherFactory(_apiKey);
  //WeatherService ws = WeatherService();

  void init() async {
    state = const AsyncLoading();
    List<WeatherData> data = await getWeatherByName(
        await ref.read(databaseProvider).getAllLocations());
    state = AsyncData(data);
  }

  Future<List<WeatherData>> getWeatherByName(List<Location> nameList) async {
    List<WeatherData> weatherList = [];

    for (var element in nameList) {
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
        log(e.toString());
      }
    }
    return weatherList;
  }

  // returns the Icon for the Weather API
  getWeatherIcon(String url) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Text('😢');
      },
    );
  }
}

class WeatherService {
  static const int STATUS_OK = 200;
  static const String FIVE_DAY_FORECAST = 'daily';
  static const String HOURLY_FORECAST = 'hourly';
  late http.Client _httpClient;
  WeatherFactory wf = WeatherFactory('7e12052d9bea3a2d6045ce0bec3bb6d8');

  WeatherService() {
    _httpClient = http.Client();
  }

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
}
