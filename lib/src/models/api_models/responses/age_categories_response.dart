// To parse this JSON data, do
//
//     final citiesResponse = citiesResponseFromJson(jsonString);

import 'dart:convert';

import '../../../models/api_models/base_response.dart';

AgeCategoriesResponse citiesResponseFromJson(String str) =>
    AgeCategoriesResponse.fromJson(json.decode(str));

String citiesResponseToJson(AgeCategoriesResponse data) => json.encode(data.toJson());

class AgeCategoriesResponse extends BaseResponse {
  AgeCategoriesResponse({
    status,
    code,
    message,
    this.items,
  }) : super(status: status, code: code, message: message);

  List<Items>? items;

  AgeCategoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];

    items=List<Items>.from(json['items'].map((v)=>Items.fromJson(v)));
   
  }

}
class Items {
  int? id;
  String? status;
  String? name;

  Items({this.id, this.status, this.name});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['name'] = this.name;
    return data;
  }
}