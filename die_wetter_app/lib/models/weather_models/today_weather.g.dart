// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayWeather _$TodayWeatherFromJson(Map<String, dynamic> json) => TodayWeather(
      json['name'] as String,
      (json['weather'] as List<dynamic>?)
          ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      MainData.fromJson(json['main'] as Map<String, dynamic>),
      Wind.fromJson(json['wind'] as Map<String, dynamic>),
      TodayWeather._fromJson(json['dt'] as int),
      TodayWeather._countryFromJson(json['sys'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TodayWeatherToJson(TodayWeather instance) =>
    <String, dynamic>{
      'name': instance.name,
      'weather': instance.weather?.map((e) => e.toJson()).toList(),
      'main': instance.main.toJson(),
      'wind': instance.wind.toJson(),
      'dt': TodayWeather._toJson(instance.dt),
      'sys': instance.country,
    };
