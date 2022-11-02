class City {
  String? country;
  String? name;
  double? lat;
  double? lng;

  City({this.country, this.name, this.lat, this.lng});

  City.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    name = json['name'];
    lat = double.parse(json['lat']);
    lng = double.parse(json['lng']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['name'] = this.name;
    data['lat'] = this.lat as double;
    data['lng'] = this.lng as double;
    return data;
  }
}
