// To parse this JSON data, do
//
//     final citiesResponse = citiesResponseFromJson(jsonString);

import 'dart:convert';

import '../../../models/api_models/base_response.dart';

AreasResponse citiesResponseFromJson(String str) =>
    AreasResponse.fromJson(json.decode(str));

String citiesResponseToJson(AreasResponse data) => json.encode(data.toJson());

class AreasResponse extends BaseResponse {
  AreasResponse({
    status,
    code,
    message,
    this.items,
  }) : super(status: status, code: code, message: message);

  List<Items>? items;

   AreasResponse.fromJson(Map<String, dynamic> json) {
   
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
}class Items {
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
