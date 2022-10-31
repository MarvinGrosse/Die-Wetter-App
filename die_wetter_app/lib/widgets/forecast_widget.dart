import 'package:die_wetter_app/models/weather_models/forecast_weather.dart';
import 'package:die_wetter_app/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/weather_models/helper_classes.dart';

class ForecastWidget extends ConsumerWidget {
  const ForecastWidget({super.key, required this.forecast});

  final ForecastWeather forecast;

  // Function to display one Tile of the Forcast
  Widget oneTileForecast(ForecastWeatherData weather, WidgetRef ref) {
    String lowToHighTemp =
        weather.temp.min.celsius == null || weather.temp.max.celsius == null
            ? '-'
            : '${weather.temp.min.toString()}/${weather.temp.max.toString()}';

    final weatherController = ref.read(weatherProvider.notifier);

    String date = DateTime.now()
                .add(const Duration(days: 6))
                .millisecondsSinceEpoch >
            weather.dt.millisecondsSinceEpoch
        ? DateFormat('EEEE').format(weather.dt).substring(0, 3).toUpperCase()
        : DateFormat('dd.MM').format(weather.dt);

    return Column(
      children: [
        Text(
          date,
          style: const TextStyle(fontSize: 10),
        ),
        SizedBox(height: 50, child: weatherController.getWeatherIcon('10d')),
        Text(
          lowToHighTemp,
          style: const TextStyle(fontSize: 10),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i in forecast.list) (oneTileForecast(i, ref)),
          ],
        ),
      ),
    );
  }
}
