import 'package:die_wetter_app/models/weather_models/forecast_weather.dart';
import 'package:die_wetter_app/models/weather_models/helper_classes.dart';
import 'package:die_wetter_app/models/weather_models/today_weather.dart';
//import 'package:weather/weather.dart';
import '../locations.dart';
//import 'today_weather.dart' as Temperature;

//Data to use inside the App
class WeatherData {
  final TodayWeather weather;
  final ForecastWeather forecast;
  //final List<HourlyWeather> hourForecast;
  final Location location;

  WeatherData(this.weather, this.forecast, this.location);
}

//Weather class to use when api request for 5 day forecast
class MyWeather {
  String? _country, _areaName, _weatherMain, _weatherDescription, _weatherIcon;
  Temperature? _temperature, _tempMin, _tempMax, _tempFeelsLike;
  Map<String, dynamic>? _weatherData;

  DateTime? _date, _sunrise, _sunset;
  double? _latitude,
      _longitude,
      _pressure,
      _windSpeed,
      _windDegree,
      _windGust,
      _humidity,
      _cloudiness,
      _rainLastHour,
      _rainLast3Hours,
      _snowLastHour,
      _snowLast3Hours;

  int? _weatherConditionCode;
/**
  MyWeather(Map<String, dynamic> jsonData) {
    Map<String, dynamic>? city = jsonData['city'];
    Map<String, dynamic>? temp = jsonData['temp'];
    Map<String, dynamic>? weather = jsonData['weather'][0];
    Map<String, dynamic>? coords = jsonData['city'];
    Map<String, dynamic>? feelsLike = jsonData['feels_like'];

    _latitude = _unpackDouble(coords, 'lat');
    _longitude = _unpackDouble(coords, 'lon');

    _temperature = _unpackTemperature(temp, 'day');
    _tempMin = _unpackTemperature(temp, 'min');
    _tempMax = _unpackTemperature(temp, 'max');
    _tempFeelsLike = _unpackTemperature(feelsLike, 'day');

    _areaName = _unpackString(city, 'name');
    _date = _unpackDate(jsonData, 'dt');

    _weatherData = jsonData;
    _weatherMain = _unpackString(weather, 'main');
    _weatherDescription = _unpackString(weather, 'description');
    _weatherIcon = _unpackString(weather, 'icon');
    _weatherConditionCode = _unpackInt(weather, 'id');
  }

  /// The original JSON data from the API
  Map<String, dynamic>? toJson() => _weatherData;

  /// A long description of the weather
  String? get weatherDescription => _weatherDescription;

  /// A brief description of the weather
  String? get weatherMain => _weatherMain;

  /// Icon depicting current weather
  String? get weatherIcon => _weatherIcon;

  /// Weather condition codes
  int? get weatherConditionCode => _weatherConditionCode;

  /// The level of cloudiness in Okta (0-9 scale)
  double? get cloudiness => _cloudiness;

  /// Wind direction in degrees
  double? get windDegree => _windDegree;

  /// Wind speed in m/s
  double? get windSpeed => _windSpeed;

  /// Wind gust in m/s
  double? get windGust => _windGust;

  /// Max [Temperature]. Available as Kelvin, Celsius and Fahrenheit.
  Temperature? get tempMax => _tempMax;

  /// Min [Temperature]. Available as Kelvin, Celsius and Fahrenheit.
  Temperature? get tempMin => _tempMin;

  /// Mean [Temperature]. Available as Kelvin, Celsius and Fahrenheit.
  Temperature? get temperature => _temperature;

  /// The 'feels like' [Temperature]. Available as Kelvin, Celsius and Fahrenheit.
  Temperature? get tempFeelsLike => _tempFeelsLike;

  /// Pressure in Pascal
  double? get pressure => _pressure;

  /// Humidity in percent
  double? get humidity => _humidity;

  /// Longitude of the weather observation
  double? get longitude => _longitude;

  /// Latitude of the weather observation
  double? get latitude => _latitude;

  /// Date of the weather observation
  DateTime? get date => _date;

  /// Timestamp of sunset
  DateTime? get sunset => _sunset;

  /// Timestamp of sunrise
  DateTime? get sunrise => _sunrise;

  /// Name of the area, ex Mountain View, or Copenhagen Municipality
  String? get areaName => _areaName;

  /// Country code, ex US or DK
  String? get country => _country;

  /// Rain fall last hour measured in mm
  double? get rainLastHour => _rainLastHour;

  /// Rain fall last 3 hours measured in mm
  double? get rainLast3Hours => _rainLast3Hours;

  /// Snow fall last 3 hours measured in mm
  double? get snowLastHour => _snowLastHour;

  /// Snow fall last 3 hours measured in mm
  double? get snowLast3Hours => _snowLast3Hours;
}

//Weather class to use when api request for hourly forecast
class HourlyWeather {
  String? _weatherMain, _weatherDescription, _weatherIcon;
  Temperature? _temperature, _tempMin, _tempMax, _tempFeelsLike;
  Map<String, dynamic>? _weatherData;

  HourlyWeather(Map<String, dynamic> jsonData) {
    Map<String, dynamic>? main = jsonData['main'];
    Map<String, dynamic>? weather = jsonData['weather'];

    _temperature = _unpackTemperature(main, 'temp');
    _tempMin = _unpackTemperature(main, 'temp_min');
    _tempMax = _unpackTemperature(main, 'temp_max');
    _tempFeelsLike = _unpackTemperature(main, 'feels_like');

    _weatherData = jsonData;

    _weatherMain = _unpackString(weather, 'main');
    _weatherDescription = _unpackString(weather, 'description');
    _weatherIcon = _unpackString(weather, 'icon');
  }

  /// The original JSON data from the API
  Map<String, dynamic>? toJson() => _weatherData;

  /// A long description of the weather
  String? get weatherDescription => _weatherDescription;

  /// A brief description of the weather
  String? get weatherMain => _weatherMain;

  /// Icon depicting current weather
  String? get weatherIcon => _weatherIcon;

  /// Max [Temperature]. Available as Kelvin, Celsius and Fahrenheit.
  Temperature? get tempMax => _tempMax;

  /// Min [Temperature]. Available as Kelvin, Celsius and Fahrenheit.
  Temperature? get tempMin => _tempMin;

  /// Mean [Temperature]. Available as Kelvin, Celsius and Fahrenheit.
  Temperature? get temperature => _temperature;

  /// The 'feels like' [Temperature]. Available as Kelvin, Celsius and Fahrenheit.
  Temperature? get tempFeelsLike => _tempFeelsLike;
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

/// Safely unpack an integer value from a [Map] object.
int? _unpackInt(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      final val = M[k];
      if (val is String) {
        return int.parse(val);
      } else if (val is int) {
        return val;
      }
      return -1;
    }
  }
  return null;
}

/// Safely unpacks a unix timestamp from a [Map] object,
/// i.e. an integer value of milliseconds and converts this to a [DateTime] object.
DateTime? _unpackDate(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      int millis = M[k] * 1000;
      return DateTime.fromMillisecondsSinceEpoch(millis);
    }
  }
  return null;
}

 */
/**
/// Unpacks a [double] value from a [Map] object and converts this to
/// a [Temperature] object.
Temperature _unpackTemperature(Map<String, dynamic>? M, String k) {
  double? kelvin = _unpackDouble(M, k);
  return Temperature(kelvin);
}

 */
}
