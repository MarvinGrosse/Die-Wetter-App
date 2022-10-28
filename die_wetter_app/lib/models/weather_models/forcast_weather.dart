import 'package:json_annotation/json_annotation.dart';

import 'helper_classes.dart';

part 'forecast_weather.g.dart';

@JsonSerializable(explicitToJson: true)
class ForecastWeather {
  ForecastWeather(this.name, this.list);

  @JsonKey(name: 'city', fromJson: _namefromJson)
  String name;
  List<ForecastWeatherData>? list;

  factory ForecastWeather.fromJson(Map<String, dynamic> json) =>
      _$ForecastWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastWeatherToJson(this);

  static String _namefromJson(Map<String, dynamic> city) => city['name'];
}
