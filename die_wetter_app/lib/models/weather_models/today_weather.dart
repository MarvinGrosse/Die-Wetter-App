import 'package:json_annotation/json_annotation.dart';

import 'helper_classes.dart';

part 'today_weather.g.dart';

@JsonSerializable(explicitToJson: true)
class TodayWeather {
  TodayWeather(this.name, this.weather, this.main, this.wind, this.dt);

  String name;
  List<Weather>? weather;
  MainData main;
  Wind wind;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime dt;

  factory TodayWeather.fromJson(Map<String, dynamic> json) =>
      _$TodayWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$TodayWeatherToJson(this);

  static DateTime _fromJson(int dt) => DateTime.fromMillisecondsSinceEpoch(dt);
  static int _toJson(DateTime time) => time.millisecondsSinceEpoch;
}
