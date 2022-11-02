import 'package:die_wetter_app/models/weather_models/forecast_weather.dart';
import 'package:die_wetter_app/models/weather_models/helper_classes.dart';
import 'package:die_wetter_app/models/weather_models/today_weather.dart';
import '../locations.dart';

//Data to use inside the App
class WeatherData {
  final TodayWeather weather;
  final ForecastWeather forecast;
  final Location location;

  WeatherData(this.weather, this.forecast, this.location);
}
