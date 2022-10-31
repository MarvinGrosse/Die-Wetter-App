// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Temperature _$TemperatureFromJson(Map<String, dynamic> json) => Temperature(
      (json['kelvin'] as num).toDouble(),
    );

Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{
      'kelvin': instance.kelvin,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      json['id'] as int,
      json['main'] as String,
      json['description'] as String,
      Weather._iconFromJson(json['icon'] as String),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': Weather._iconToJson(instance.icon),
    };

MainData _$MainDataFromJson(Map<String, dynamic> json) => MainData(
      MainData._tempFromJson(json['temp'] as double),
      MainData._feels_likeFromJson(json['feels_like'] as double),
      MainData._temp_minFromJson(json['temp_min'] as double),
      MainData._temp_maxFromJson(json['temp_max'] as double),
    );

Map<String, dynamic> _$MainDataToJson(MainData instance) => <String, dynamic>{
      'temp': MainData._tempToJson(instance.temp),
      'feels_like': MainData._feels_likeToJson(instance.feels_like),
      'temp_min': MainData._temp_minToJson(instance.temp_min),
      'temp_max': MainData._temp_maxToJson(instance.temp_max),
    };

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
      (json['speed'] as num).toDouble(),
      json['deg'] as int,
    );

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
    };

ForecastWeatherData _$ForecastWeatherDataFromJson(Map<String, dynamic> json) =>
    ForecastWeatherData(
      ForecastWeatherData._fromJson(json['dt'] as int),
      ForecastTemperature.fromJson(json['temp'] as Map<String, dynamic>),
      (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForecastWeatherDataToJson(
        ForecastWeatherData instance) =>
    <String, dynamic>{
      'dt': ForecastWeatherData._toJson(instance.dt),
      'temp': instance.temp.toJson(),
      'weather': instance.weather.map((e) => e.toJson()).toList(),
    };

ForecastTemperature _$ForecastTemperatureFromJson(Map<String, dynamic> json) =>
    ForecastTemperature(
      ForecastTemperature._dayFromJson(json['day'] as num),
      ForecastTemperature._minFromJson(json['min'] as num),
      ForecastTemperature._maxFromJson(json['max'] as num),
    );

Map<String, dynamic> _$ForecastTemperatureToJson(
        ForecastTemperature instance) =>
    <String, dynamic>{
      'day': ForecastTemperature._dayToJson(instance.day),
      'min': ForecastTemperature._minToJson(instance.min),
      'max': ForecastTemperature._maxToJson(instance.max),
    };
