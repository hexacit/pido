import 'dart:convert';

import 'package:pido/src/models/sub_models/category.dart';

import '../../../models/api_models/base_response.dart';
//
// CountriesResponse categoriesResponseFromJson(String str) =>
//     CountriesResponse.fromJson(json.decode(str));
//
// String categoriesResponseToJson(CountriesResponse data) =>
//     json.encode(data.toJson());
//
// class CountriesResponse extends BaseResponse {
//   CountriesResponse({
//     status,
//     code,
//     message,
//     this.data,
//   }) : super(status: status==1, code: code, message: message);
//   Data? data;
//
//   factory CountriesResponse.fromJson(Map<String, dynamic> json) =>
//       CountriesResponse(
//         status: json["status"],
//         code: json["code"],
//         message: json["message"],
//        data:Data.fromJson(json["data"]),
//       );
//
//
// }


class CountriesData {
  CountriesData({
    this.countriesMenu,
  });

  List<Country>? countriesMenu;

  factory CountriesData.fromJson(Map<String, dynamic> json) => CountriesData(
    countriesMenu: List<Country>.from(json["countries_menu"].map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "countries_menu": List<dynamic>.from(countriesMenu!.map((x) => x.toJson())),
  };
}

class Country {
  Country({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}


