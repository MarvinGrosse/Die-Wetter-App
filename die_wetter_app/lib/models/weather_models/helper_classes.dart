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
  double? get celsius => kelvin != null ? kelvin - 273.15 : null;

  /// Convert temperature to Fahrenheit
  double? get fahrenheit => kelvin != null ? kelvin * (9 / 5) - 459.67 : null;

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
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
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

  static _tempFromJson(double temp) => Temperature(temp);
  static _tempToJson(Temperature temp) => temp.kelvin.toDouble();

  static _feels_likeFromJson(double feels_like) => Temperature(feels_like);
  static _feels_likeToJson(Temperature feels_like) =>
      feels_like.kelvin.toDouble();

  static _temp_minFromJson(double temp_min) => Temperature(temp_min);
  static _temp_minToJson(Temperature temp_min) => temp_min.kelvin.toDouble();

  static _temp_maxFromJson(double temp_max) => Temperature(temp_max);
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

  static DateTime _fromJson(int dt) => DateTime.fromMillisecondsSinceEpoch(dt);
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

  static _dayFromJson(double day) => Temperature(day);
  static _dayToJson(Temperature day) => day.kelvin.toDouble();

  static _minFromJson(double min) => Temperature(min);
  static _minToJson(Temperature min) => min.kelvin.toDouble();

  static _maxFromJson(double max) => Temperature(max);
  static _maxToJson(Temperature max) => max.kelvin.toDouble();
}