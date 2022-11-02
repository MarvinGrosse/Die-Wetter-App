import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'helper_classes.g.dart';

@JsonSerializable(explicitToJson: true)
class Temperature {
  Temperature(this.kelvin);

  double kelvin;

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);
  Map<String, dynamic> toJson() => _$TemperatureToJson(this);

  /// Convert temperature to Celsius
  double? get celsius => kelvin - 273.15;

  /// Convert temperature to Fahrenheit
  double? get fahrenheit => kelvin * (9 / 5) - 459.67;

  @override
  String toString() =>
      celsius != null ? '${celsius!.toStringAsFixed(0)}°c' : "-";
}

@JsonSerializable(explicitToJson: true)
class Weather {
  Weather(this.id, this.main, this.description, this.icon);

  int id;
  String main;
  String description;
  @JsonKey(fromJson: _iconFromJson, toJson: _iconToJson)
  Image icon;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  static _iconFromJson(String icon) =>
      Image.network('http://openweathermap.org/img/wn/$icon@2x.png',
          fit: BoxFit.cover, errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Text('no Image');
      });
  static _iconToJson(Image icon) => json.encode(icon);
}

@JsonSerializable(explicitToJson: true)
class MainData {
  MainData(this.temp, this.feels_like, this.temp_min, this.temp_max);

  @JsonKey(fromJson: _tempFromJson, toJson: _tempToJson)
  Temperature temp;
  @JsonKey(fromJson: _feels_likeFromJson, toJson: _feels_likeToJson)
  Temperature feels_like;
  @JsonKey(fromJson: _temp_minFromJson, toJson: _temp_minToJson)
  Temperature temp_min;
  @JsonKey(fromJson: _temp_maxFromJson, toJson: _temp_maxToJson)
  Temperature temp_max;

  factory MainData.fromJson(Map<String, dynamic> json) =>
      _$MainDataFromJson(json);
  Map<String, dynamic> toJson() => _$MainDataToJson(this);

  static _tempFromJson(num temp) => Temperature(temp.toDouble());
  static _tempToJson(Temperature temp) => temp.kelvin.toDouble();

  static _feels_likeFromJson(num feels_like) =>
      Temperature(feels_like.toDouble());
  static _feels_likeToJson(Temperature feels_like) =>
      feels_like.kelvin.toDouble();

  static _temp_minFromJson(num temp_min) => Temperature(temp_min.toDouble());
  static _temp_minToJson(Temperature temp_min) => temp_min.kelvin.toDouble();

  static _temp_maxFromJson(num temp_max) => Temperature(temp_max.toDouble());
  static _temp_maxToJson(Temperature temp_max) => temp_max.kelvin.toDouble();
}

@JsonSerializable(explicitToJson: true)
class Wind {
  Wind(this.speed, this.deg);

  double speed;
  int deg;

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ForecastWeatherData {
  ForecastWeatherData(this.dt, this.temp, this.weather);

  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime dt;

  ForecastTemperature temp;

  List<Weather> weather;

  factory ForecastWeatherData.fromJson(Map<String, dynamic> json) =>
      _$ForecastWeatherDataFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastWeatherDataToJson(this);

  static DateTime _fromJson(int dt) =>
      DateTime.fromMillisecondsSinceEpoch(dt * 1000);

  static int _toJson(DateTime time) => time.millisecondsSinceEpoch;
}

@JsonSerializable(explicitToJson: true)
class ForecastTemperature {
  ForecastTemperature(this.day, this.min, this.max);

  @JsonKey(fromJson: _dayFromJson, toJson: _dayToJson)
  Temperature day;
  @JsonKey(fromJson: _minFromJson, toJson: _minToJson)
  Temperature min;
  @JsonKey(fromJson: _maxFromJson, toJson: _maxToJson)
  Temperature max;

  factory ForecastTemperature.fromJson(Map<String, dynamic> json) =>
      _$ForecastTemperatureFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastTemperatureToJson(this);

  static _dayFromJson(num day) => Temperature(day.toDouble());
  static _dayToJson(Temperature day) => day.kelvin.toDouble();

  static _minFromJson(num min) => Temperature(min.toDouble());
  static _minToJson(Temperature min) => min.kelvin.toDouble();

  static _maxFromJson(num max) => Temperature(max.toDouble());
  static _maxToJson(Temperature max) => max.kelvin.toDouble();
}
