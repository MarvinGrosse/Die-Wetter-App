import 'package:die_wetter_app/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/weather_data.dart';

class ForecastWidget extends ConsumerWidget {
  const ForecastWidget({super.key, required this.forecast});

  final List<MyWeather> forecast;

  // Function to display one Tile of the Forcast
  // Example Forcast for 5 Days, oneTileForcast() displays Monday
  Widget oneTileForecast(MyWeather weather, WidgetRef ref) {
    String lowToHighTemp = weather.tempMin == null || weather.tempMax == null
        ? '-'
        : '${weather.tempMin!.celsius!.toStringAsFixed(0)}°c/${weather.tempMax!.celsius!.toStringAsFixed(0)}°c';

    final weatherController = ref.read(weatherProvider.notifier);

    return Column(
      children: [
        Text(
          weather.date == null
              ? '-'
              : DateFormat('EEEE')
                  .format(weather.date!)
                  .substring(0, 3)
                  .toUpperCase(),
          style: const TextStyle(fontSize: 10),
        ),
        SizedBox(
            height: 50,
            child: weatherController.getWeatherIcon(
                'http://openweathermap.org/img/wn/${weather.weatherIcon!}@2x.png')),
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
        for (var i in forecast) oneTileForecast(i, ref),
      ],
    );
  }
}
