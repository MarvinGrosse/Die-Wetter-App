import 'package:die_wetter_app/models/city.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

final citiesProvider = Provider((ref) => CitiesService());

class CitiesService {
  CitiesService() {
    if (cities.isEmpty) {
      loadJsonData();
    }
  }
  List<City> cities = [];

  void loadJsonData() async {
    final jsonText =
        await rootBundle.loadString('assets/json_data/cities.json');
    final List data = json.decode(jsonText);
    for (var item in data) {
      cities.add(City.fromJson(item));
    }
  }

  List<City> getSuggestions(String searchText) {
    List<City>? filtered = [];
    filtered.addAll(cities);

    if (searchText.isEmpty || searchText == '') {
      return [];
    } else {
      filtered.retainWhere((element) {
        return element.name!.toLowerCase().contains(searchText.toLowerCase());
      });
      if (filtered.length < 10) {
        return filtered.getRange(0, filtered.length).toList();
      } else {
        return filtered.getRange(0, 10).toList();
      }
    }
  }
}
