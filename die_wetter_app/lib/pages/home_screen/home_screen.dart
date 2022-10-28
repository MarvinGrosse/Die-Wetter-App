import 'package:die_wetter_app/pages/add_screen.dart';
import 'package:die_wetter_app/pages/detail_screen.dart';
import 'package:die_wetter_app/pages/home_screen/home_provider.dart';
import 'package:die_wetter_app/services/database_helper.dart';
//import 'package:die_wetter_app/services/text_validator_service.dart';
import 'package:die_wetter_app/services/weather_service.dart';
import 'package:die_wetter_app/widgets/app_bar_search.dart';
import 'package:die_wetter_app/widgets/forecast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<HomeScreen> {
  final _searchTextController = TextEditingController();

  getWeatherIcon(String data) {
    String url = 'http://openweathermap.org/img/wn/$data@2x.png';
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Text('no Image');
      },
    );
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(databaseProvider).resetDB();
    final state = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);

    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.lightBlue[50]),
      home: Scaffold(
          appBar: AppBarSearch(),
          body: RefreshIndicator(
            onRefresh: () => Future(() => homeNotifier.getWeather()),
            child: state.when(
                data: (weather) {
                  return Center(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      itemCount: weather.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            height: 250,
                            child: Slidable(
                              key: ValueKey(index),
                              endActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  dismissible: DismissiblePane(onDismissed: () {
                                    homeNotifier.deleteLocation(weather[index]);
                                  }),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        homeNotifier
                                            .deleteLocation(weather[index]);
                                      },
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                    )
                                  ]),
                              child: Card(
                                margin: const EdgeInsets.all(0),
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
                                          builder: (context) => DetailScreen(
                                              data: weather[index]),
                                        ),
                                      );

                                      if (shouldRefresh ?? false) {
                                        homeNotifier.getWeather();
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
                                                weather[index].weather.name!,
                                                key: const Key(
                                                    'LocationTitleHomeScreen'),
                                              ),
                                              subtitle: Text(weather[index]
                                                  .weather
                                                  .weather![0]
                                                  .main),
                                              leading: SizedBox(
                                                width: 80,
                                                child: getWeatherIcon(
                                                    weather[index]
                                                            .weather
                                                            .weather![0]
                                                            .icon ??
                                                        'noimage'),
                                              ),
                                              trailing: Text(
                                                '${weather[index].weather.main.temp ?? '-'}',
                                                style: const TextStyle(
                                                    fontSize: 30),
                                              ),
                                            ),
                                            /**
                                            ForecastWidget(
                                                forecast:
                                                    weather[index].forecast)
                                                     */
                                          ]),
                                    )),
                              ),
                            ));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 15,
                        );
                      },
                    ),
                  );
                },
                error: (err, stack) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            stack.toString(),
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton.icon(
                              onPressed: () => homeNotifier.getWeather(),
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text('Refresh'))
                        ],
                      ),
                    ),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          )),
    );
  }
}


/**
class xHomeScreen extends ConsumerWidget {
  const xHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ref.read(databaseProvider).resetDB();
    final weatherDataProvider = ref.watch(weatherProvider);
    final weatherController = ref.read(weatherProvider.notifier);
    //final databaseController = ref.read(databaseProvider);

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
                              builder: (context) => const AddScreen(),
                            ),
                          );
                          if (shouldRefresh ?? false) {
                            weatherController.getWeather();
                          }
                        },
                        icon: const Icon(Icons.add_location_rounded),
                        iconSize: 40,
                      ))
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => Future(() => weatherController.getWeather()),
            child: weatherDataProvider.when(
                data: (weather) {
                  return Center(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      itemCount: weather.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            height: 250,
                            child: Slidable(
                              key: ValueKey(index),
                              endActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  dismissible: DismissiblePane(onDismissed: () {
                                    weatherController
                                        .deleteLocation(weather[index]);
                                  }),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        weatherController
                                            .deleteLocation(weather[index]);
                                      },
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                    )
                                  ]),
                              child: Card(
                                margin: const EdgeInsets.all(0),
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
                                          builder: (context) => DetailScreen(
                                              data: weather[index]),
                                        ),
                                      );

                                      if (shouldRefresh ?? false) {
                                        weatherController.getWeather();
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
                                                weather[index].weather.name!,
                                                key: const Key(
                                                    'LocationTitleHomeScreen'),
                                              ),
                                              subtitle: Text(weather[index]
                                                  .weather
                                                  .weather![0]
                                                  .main!),
                                              leading: SizedBox(
                                                width: 80,
                                                child: weatherController
                                                    .getWeatherIcon(
                                                        weather[index]
                                                                .weather
                                                                .weather![0]
                                                                .icon ??
                                                            'noimage'),
                                              ),
                                              trailing: Text(
                                                '${weather[index].weather.main?.temp?.celsius}', //.celsius!.toStringAsFixed(0) //'
                                                style: const TextStyle(
                                                    fontSize: 30),
                                              ),
                                            ),
                                            ForecastWidget(
                                                forecast:
                                                    weather[index].forecast)
                                          ]),
                                    )),
                              ),
                            ));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 15,
                        );
                      },
                    ),
                  );
                },
                error: (err, stack) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            stack.toString(),
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton.icon(
                              onPressed: () => weatherController.getWeather(),
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text('Refrech'))
                        ],
                      ),
                    ),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          )),
    );
  }
}
 */


/**
 * 
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
                              builder: (context) => const AddScreen(),
                            ),
                          );
                          if (shouldRefresh ?? false) {
                            ref.read(weatherProvider.notifier).getWeather();
                          }
                        },
                        icon: const Icon(Icons.add_location_rounded),
                        iconSize: 40,
                      ))
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => Future(() => weatherController.getWeather()),
            child: weatherDataProvider.when(
                data: (weather) {
                  return Center(
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
                                    ref
                                        .read(weatherProvider.notifier)
                                        .getWeather();
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
                                                .getWeatherIcon(weather[index]
                                                        .weather
                                                        .weatherIcon ??
                                                    'noimage'),
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
                  );
                },
                error: (err, stack) => Center(
                      child: Text(stack.toString()),
                    ),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          )),
    );
  }
}


 */