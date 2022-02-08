// To parse this JSON data, do
//
//     final locationResponse = locationResponseFromJson(jsonString);

import 'dart:convert';

LocationResponse locationResponseFromJson(String str) =>
    LocationResponse.fromJson(json.decode(str));

String locationResponseToJson(LocationResponse data) =>
    json.encode(data.toJson());

class LocationResponse {
  LocationResponse({
    this.latitude,
    this.longitude,
    this.plusCode,
    this.localityLanguageRequested,
    this.continent,
    this.continentCode,
    this.countryName,
    this.countryCode,
    this.principalSubdivision,
    this.principalSubdivisionCode,
    this.city,
    this.locality,
    this.postcode,
    this.localityInfo,
  });

  double? latitude;
  double? longitude;
  String? plusCode;
  String? localityLanguageRequested;
  String? continent;
  String? continentCode;
  String? countryName;
  String? countryCode;
  String? principalSubdivision;
  String? principalSubdivisionCode;
  String? city;
  String? locality;
  String? postcode;
  LocalityInfo? localityInfo;

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      LocationResponse(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        plusCode: json["plusCode"],
        localityLanguageRequested: json["localityLanguageRequested"],
        continent: json["continent"],
        continentCode: json["continentCode"],
        countryName: json["countryName"],
        countryCode: json["countryCode"],
        principalSubdivision: json["principalSubdivision"],
        principalSubdivisionCode: json["principalSubdivisionCode"],
        city: json["city"],
        locality: json["locality"],
        postcode: json["postcode"],
        localityInfo: LocalityInfo.fromJson(json["localityInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "plusCode": plusCode,
        "localityLanguageRequested": localityLanguageRequested,
        "continent": continent,
        "continentCode": continentCode,
        "countryName": countryName,
        "countryCode": countryCode,
        "principalSubdivision": principalSubdivision,
        "principalSubdivisionCode": principalSubdivisionCode,
        "city": city,
        "locality": locality,
        "postcode": postcode,
      };
}

class LocalityInfo {
  LocalityInfo({
    this.administrative,
    this.informative,
  });

  List<Ative>? administrative;
  List<Ative>? informative;

  factory LocalityInfo.fromJson(Map<String, dynamic> json) => LocalityInfo(
        administrative: List<Ative>.from(
            json["administrative"].map((x) => Ative.fromJson(x))),
        informative:
            List<Ative>.from(json["informative"].map((x) => Ative.fromJson(x))),
      );


}

class Ative {
  Ative({
    this.order,
    this.adminLevel,
    this.name,
    this.description,
    this.wikidataId,
    this.geonameId,
    this.isoName,
    this.isoCode,
  });

  int? order;
  int? adminLevel;
  String? name;
  String? description;
  String? wikidataId;
  int? geonameId;
  String? isoName;
  String? isoCode;

  factory Ative.fromJson(Map<String, dynamic> json) => Ative(
        order: json["order"],
        adminLevel: json["adminLevel"] == null ? null : json["adminLevel"],
        name: json["name"],
        description: json["description"],
        wikidataId: json["wikidataId"],
        geonameId: json["geonameId"],
        isoName: json["isoName"] == null ? null : json["isoName"],
        isoCode: json["isoCode"] == null ? null : json["isoCode"],
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "adminLevel": adminLevel == null ? null : adminLevel,
        "name": name,
        "description": description,
        "wikidataId": wikidataId,
        "geonameId": geonameId,
        "isoName": isoName == null ? null : isoName,
        "isoCode": isoCode == null ? null : isoCode,
      };
}
