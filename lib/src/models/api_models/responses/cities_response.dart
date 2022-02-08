// To parse this JSON data, do
//
//     final citiesResponse = citiesResponseFromJson(jsonString);

import 'dart:convert';

import '../../../models/api_models/base_response.dart';

CitiesResponse citiesResponseFromJson(String str) =>
    CitiesResponse.fromJson(json.decode(str));

String citiesResponseToJson(CitiesResponse data) => json.encode(data.toJson());

class CitiesResponse extends BaseResponse {
  CitiesResponse({
    status,
    code,
    message,
    this.items,
  }) : super(status: status, code: code, message: message);

  List<Items>? items;

   CitiesResponse.fromJson(Map<String, dynamic> json) {
   
        status= json["status"];
        code= json["code"];
        message= json["message"];
                 items=List<Items>.from(json['items'].map((v)=>Items.fromJson(v)));

     
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      
      };
}
class Items {
  int? id;
  String? status;
  String? createdAt;
  String? name;

  Items({this.id, this.status, this.createdAt, this.name});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    return data;
  }
}
