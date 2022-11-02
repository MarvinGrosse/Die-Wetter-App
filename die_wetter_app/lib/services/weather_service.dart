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

final weatherServiceProvider = Provider((ref) => WeatherService());
final weatherFactoryProvider = Provider((ref) => WeatherFactory(_apiKey));

final StackTrace noLocationsError =
    StackTrace.fromString('There are no locations. \nTry adding a location');

class WeatherService {
  WeatherService() {
    _httpClient = http.Client();
  }

  late http.Client _httpClient;

  Future<TodayWeather> getTodaysWeather(Location city) async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${city.lat}&lon=${city.lng}&appid=$_apiKey&lang=en";

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

  Future<ForecastWeather> getForcastWeather(Location city) async {
    String url =
        "https://api.openweathermap.org/data/2.5/forecast/daily?lat=${city.lat}&lon=${city.lng}&cnt=14&appid=$_apiKey&lang=en";

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
}
