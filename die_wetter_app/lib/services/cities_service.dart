import 'package:die_wetter_app/models/city.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final citiesProvider = Provider((ref) => CitiesService());

class CitiesService {
  List<City>? cities;

  Map<String, dynamic>? data;

  Future<List<City>> autocomplete(String searchString) async {
    return [];
  }
}
