
class Order {
  String? _id;
  num? _lat;
  num? _long;

  Order({
    String? id,
    required num? lat,
    required num? long,
  }) {
    this.id = id;
    this.long = long;
    this.lat = lat;
  }

  factory Order.fromJson(Map<String, dynamic> json) =>
      Order(lat: json['lat'], long: json['long']);

  Map<String, dynamic> toJson() => {
        'lat': this.lat,
        'long': this.long,
      };

  num? get long => _long;

  set long(num? value) {
    _long = value;
  }

  num? get lat => _lat;

  set lat(num? value) {
    _lat = value;
  }

  String? get id => _id;

  set id(String? value) {
    _id = value;
  }
}
