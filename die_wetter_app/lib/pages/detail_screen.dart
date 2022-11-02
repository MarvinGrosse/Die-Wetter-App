import 'package:die_wetter_app/models/weather_models/weather_data.dart';
import 'package:die_wetter_app/services/database_helper.dart';
import 'package:die_wetter_app/widgets/forecast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/day_weather_widget.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key, required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final databaseController = ref.read(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(data.weather.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          DayWeatherWidget(
            data: data.weather,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: ForecastWidget(forecast: data.forecast),
            ),
          ),
          ElevatedButton(
            key: const Key('DeleteButton'),
            onPressed: () {
              databaseController.deleteLocation(data.location.id);
              const snackBar = SnackBar(
                content: Text('Location deleted'),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.of(context).pop(true);
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 20)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            child: const Text('delete'),
          )
        ]),
      ),
    );
  }
}
