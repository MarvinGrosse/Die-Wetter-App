// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// Objects to save in sqflite DB
class Location {
  final String id;
  final String name;
  final double lat;
  final double lng;
  Location({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
  });

  Location copyWith({
    String? id,
    String? name,
    double? lat,
    double? lng,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lat': lat,
      'lng': lng,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'] as String,
      name: map['name'] as String,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Location(id: $id, name: $name, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(covariant Location other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ lat.hashCode ^ lng.hashCode;
  }
}
