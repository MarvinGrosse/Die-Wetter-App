import 'package:die_wetter_app/models/weather_models/forcast_weather.dart';
import 'package:die_wetter_app/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/weather_models/weather_data.dart';

class ForecastWidget extends ConsumerWidget {
  const ForecastWidget({super.key, required this.forecast});

  final ForecastWeather forecast;

  // Function to display one Tile of the Forcast
  // Example Forcast for 5 Days, oneTileForcast() displays Monday
  Widget oneTileForecast(Data weather, WidgetRef ref) {
    String lowToHighTemp = weather.temp == null || weather == null
        ? '-'
        : '${weather.temp?.min.toString()}°c/${weather.temp?.max.toString()}°c';

    final weatherController = ref.read(weatherProvider.notifier);

    return Column(
      children: [
        Text(
          weather.dt == null
              ? '-'
              : DateFormat('EEEE')
                  .format(DateTime.fromMillisecondsSinceEpoch(weather.dt!))
                  .substring(0, 3)
                  .toUpperCase(),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i in forecast.list!) (oneTileForecast(i, ref)),
      ],
    );
  }
}
