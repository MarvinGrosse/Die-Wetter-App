import 'package:die_wetter_app/pages/detail_screen.dart';
import 'package:die_wetter_app/pages/home_screen/home_provider.dart';
import 'package:die_wetter_app/widgets/app_bar_search.dart';
import 'package:die_wetter_app/widgets/forecast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //ref.read(databaseProvider).resetDB();
    final state = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);

    //closes Keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.lightBlue[50]),
      home: Scaffold(
          appBar: const AppBarSearch(),
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
                            height: 220,
                            child: Slidable(
                              key: UniqueKey(),
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
                                      if (mounted) {
                                        FocusScope.of(context).unfocus();
                                        ref
                                            .watch(appSearchProvider.state)
                                            .state = false;
                                      }

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
                                            Expanded(
                                                child: ListTile(
                                                    title: Text(
                                                      weather[index]
                                                          .weather
                                                          .name,
                                                      key: const Key(
                                                          'LocationTitleHomeScreen'),
                                                    ),
                                                    subtitle: Text(
                                                        weather[index]
                                                            .weather
                                                            .weather![0]
                                                            .main),
                                                    leading: SizedBox(
                                                        width: 80,
                                                        child: weather[index]
                                                            .weather
                                                            .weather![0]
                                                            .icon),
                                                    trailing: Column(
                                                      children: [
                                                        Text(
                                                          '${weather[index].weather.main.temp}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 30),
                                                        ),
                                                        Text(weather[index]
                                                            .weather
                                                            .country)
                                                      ],
                                                    ))),
                                            const Divider(thickness: 1),
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
