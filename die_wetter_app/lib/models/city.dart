class City {
  String? country;
  String? name;
  String? lat;
  String? lng;

  City({this.country, this.name, this.lat, this.lng});

  City.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    name = json['name'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
