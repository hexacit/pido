
import 'package:pido/src/models/sub_models/area.dart';

class Address {
  Address({
    this.id,
    this.addressName,
    this.areaId,
    this.street,
    this.userId,
    this.defult,
    this.longitude,
    this.latitude,
    this.createdAt,
    this.area,
  });

  int? id;
  String? addressName;
  int? areaId;
  String? street;
  int? userId;
  int? defult;
  num? longitude;
  num? latitude;
  DateTime? createdAt;
  Area? area;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    addressName: json["address_name"],
    areaId: json["area_id"],
    street: json["street"],
    userId: json["user_id"],
    defult: json["defult"],
    longitude:json["longitude"]==null?null:(json["longitude"] is String)?num.parse( json["longitude"]):json["longitude"],
    latitude: json["latitude"]==null?null:(json["longitude"] is String)?num.parse( json["latitude"]):json["latitude"],
    createdAt: DateTime.parse(json["created_at"]),
    area: Area.fromJson(json["area"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address_name": addressName,
    "area_id": areaId,
    "street": street,
    "user_id": userId,
    "defult": defult,
    "longitude": longitude,
    "latitude": latitude,
    "created_at": createdAt!.toIso8601String(),
    "area": area!.toJson(),
  };
}

