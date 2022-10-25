import 'dart:developer';

import 'package:die_wetter_app/models/weather_data.dart';
import 'package:die_wetter_app/pages/add_screen.dart';
import 'package:die_wetter_app/pages/detail_screen.dart';
import 'package:die_wetter_app/services/database_helper.dart';
import 'package:die_wetter_app/services/weather_service.dart';
import 'package:die_wetter_app/widgets/forecast_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/locations.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ref.read(databaseProvider).resetDB();
    final weatherDataProvider = ref.watch(weatherProvider);
    final weatherController = ref.read(weatherProvider.notifier);

    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.lightBlue[50]),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Die Wetter App'),
            centerTitle: true,
            actions: [
              Builder(
                  builder: (context) => IconButton(
                        onPressed: () async {
                          final bool? shouldRefresh =
                              await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddScreen(),
                            ),
                          );
                          if (shouldRefresh ?? false) {
                            ref.read(weatherProvider.notifier).init();
                          }
                        },
                        icon: const Icon(Icons.add_location_rounded),
                        iconSize: 40,
                      ))
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => Future(() => weatherController.init()),
            child: weatherDataProvider.when(
                data: (weather) => Center(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                        itemCount: weather.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 250,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(15.0),
                                  splashColor: Colors.lightBlue[200],
                                  onTap: () async {
                                    final bool? shouldRefresh =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailScreen(data: weather[index]),
                                      ),
                                    );

                                    if (shouldRefresh ?? false) {
                                      ref.read(weatherProvider.notifier).init();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ListTile(
                                            title: Text(
                                              weather[index].weather.areaName!,
                                              key: const Key(
                                                  'LocationTitleHomeScreen'),
                                            ),
                                            subtitle: Text(weather[index]
                                                .weather
                                                .weatherMain!),
                                            leading: SizedBox(
                                              width: 80,
                                              child: weatherController
                                                  .getWeatherIcon(
                                                      'http://openweathermap.org/img/wn/${weather[index].weather.weatherIcon!}@2x.png'),
                                            ),
                                            trailing: Text(
                                              '${weather[index].weather.temperature!.celsius!.toStringAsFixed(0)}°c',
                                              style:
                                                  const TextStyle(fontSize: 30),
                                            ),
                                          ),
                                          ForecastWidget(
                                              forecast: weather[index].forecast)
                                        ]),
                                  )),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                      ),
                    ),
                error: (err, stack) => Text('Error: $err'),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          )),
    );
  }
}

class xHomeScreen extends ConsumerWidget {
  const xHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ref.read(databaseProvider).resetDB();
    final weatherDataProvider = ref.watch(weatherProvider);
    final weatherController = ref.read(weatherProvider.notifier);

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Die Wetter App'),
            centerTitle: true,
            actions: [
              Builder(
                  builder: (context) => IconButton(
                        onPressed: () => _pushAddScreen(context, ref),
                        icon: const Icon(Icons.add_location_rounded),
                        iconSize: 40,
                      ))
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => Future(() => weatherController.init()),
            child: weatherDataProvider.when(
                data: (weather) => Center(
                      child: ListView.separated(
                        itemCount: weather.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 250,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: InkWell(
                                  onTap: () => pushDetailScreen(
                                      context, weather[index], ref),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ListTile(
                                            title: Text(
                                              weather[index].weather.areaName!,
                                              key: const Key(
                                                  'LocationTitleHomeScreen'),
                                            ),
                                            subtitle: Text(weather[index]
                                                .weather
                                                .weatherMain!),
                                            leading: SizedBox(
                                              width: 80,
                                              child: weatherController
                                                  .getWeatherIcon(
                                                      'http://openweathermap.org/img/wn/${weather[index].weather.weatherIcon!}@2x.png'),
                                            ),
                                            trailing: Text(
                                              '${weather[index].weather.temperature!.celsius!.toStringAsFixed(0)}°c',
                                              style:
                                                  const TextStyle(fontSize: 30),
                                            ),
                                          ),
                                          ForecastWidget(
                                              forecast: weather[index].forecast)
                                        ]),
                                  )),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      ),
                    ),
                error: (err, stack) => Text('Error: $err'),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          )),
    );
  }

  void _pushAddScreen(BuildContext context, WidgetRef ref) async {
    final bool? shouldRefresh = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddScreen(),
      ),
    );

    if (shouldRefresh ?? false) {
      const snackBar = SnackBar(
        content: Text('Location added'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      ref.read(weatherProvider.notifier).init();
    }
  }

  void pushDetailScreen(BuildContext context, weather, WidgetRef ref) async {
    final bool? shouldRefresh = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailScreen(data: weather),
      ),
    );

    if (shouldRefresh ?? false) {
      const snackBar = SnackBar(
        content: Text('Location deleted'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      ref.read(weatherProvider.notifier).init();
    }
  }
}
