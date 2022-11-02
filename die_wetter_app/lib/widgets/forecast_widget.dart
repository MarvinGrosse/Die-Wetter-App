import 'dart:core';
import 'package:die_wetter_app/models/weather_models/forecast_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/weather_models/helper_classes.dart';

class ForecastWidget extends ConsumerWidget {
  ForecastWidget({super.key, required this.forecast});

  final ForecastWeather forecast;
  final ScrollController sc = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MediaQuery(
      data: MediaQuery.of(context).removePadding(removeBottom: true),
      child: Scrollbar(
        controller: sc,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          controller: sc,
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: forecast.list
                .map((e) => (OneTileForecast(weather: e)))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class OneTileForecast extends ConsumerWidget {
  const OneTileForecast({super.key, required this.weather});

  final ForecastWeatherData weather;

  String getLowToHighTemp(weather) {
    String lowToHighTemp =
        weather.temp.min.celsius == null || weather.temp.max.celsius == null
            ? '-'
            : '${weather.temp.min.toString()}/${weather.temp.max.toString()}';

    return lowToHighTemp;
  }

  String getDate(weather) {
    String date = DateTime.now()
                .add(const Duration(days: 6))
                .millisecondsSinceEpoch >
            weather.dt.millisecondsSinceEpoch
        ? DateFormat('EEEE').format(weather.dt).substring(0, 3).toUpperCase()
        : DateFormat('dd.MM').format(weather.dt);
    return date;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          getDate(weather),
          style: const TextStyle(fontSize: 10),
        ),
        SizedBox(height: 50, child: weather.weather[0].icon),
        Text(
          getLowToHighTemp(weather),
          style: const TextStyle(fontSize: 10),
        )
      ],
    );
  }
}
