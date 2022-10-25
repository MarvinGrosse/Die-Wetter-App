import 'package:die_wetter_app/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class DayWeatherWidget extends ConsumerWidget {
  const DayWeatherWidget({super.key, required this.data});

  final Weather data;

  String getDirection(double value) {
    if (value > 337.5 && value <= 360 || value >= 0 && value <= 22.5) {
      return 'North';
    }
    if (value > 22.5 && value <= 67.5) {
      return 'North-East';
    }
    if (value > 67.5 && value <= 112.5) {
      return 'East';
    }
    if (value > 112.5 && value <= 157.5) {
      return 'South-East';
    }
    if (value > 157.5 && value <= 202.5) {
      return 'South';
    }
    if (value > 202.5 && value <= 247.5) {
      return 'South-West';
    }
    if (value > 247.5 && value <= 292.5) {
      return 'West';
    }
    if (value > 292.5 && value <= 337.5) {
      return 'North-West';
    }

    return '-';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherController = ref.read(weatherProvider.notifier);

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.date == null
                          ? '-'
                          : DateFormat('EEEE').format(data.date!),
                    ),
                    Text(
                      DateFormat('kk:mm').format(DateTime.now()),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Text(
                  '${data.temperature!.celsius!.toStringAsFixed(0)}°c',
                  style: const TextStyle(fontSize: 50),
                ),
                SizedBox(
                  width: 80,
                  child: weatherController.getWeatherIcon(
                    'http://openweathermap.org/img/wn/${data.weatherIcon!}@2x.png',
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Wind Direct: ${getDirection(data.windDegree ?? 500)}'),
                      Text(
                          'Wind Speed: ${(data.windSpeed ?? 0 * (60 * 60) / 1000)}km/h')
                    ],
                  ),
                  Column(
                    children: [
                      Text(data.weatherDescription ?? '-'),
                      Text(
                        'Max: ${data.tempMax?.celsius?.toStringAsFixed(0) ?? '-'}°c',
                      ),
                      Text(
                        'Min: ${data.tempMin?.celsius?.toStringAsFixed(0) ?? '-'}°c',
                      )
                    ],
                  )
                ],
              ),
            )
          ]),
        ));
  }
}