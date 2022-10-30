// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastWeather _$ForecastWeatherFromJson(Map<String, dynamic> json) =>
    ForecastWeather(
      ForecastWeather._namefromJson(json['city'] as Map<String, dynamic>),
      (json['list'] as List<dynamic>)
          .map((e) => ForecastWeatherData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForecastWeatherToJson(ForecastWeather instance) =>
    <String, dynamic>{
      'city': instance.name,
      'list': instance.list.map((e) => e.toJson()).toList(),
    };
