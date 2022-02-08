// import 'dart:convert';
//
// import 'package:binqassem/src/models/sub_models/service_item.dart';
//
// import '../../../models/api_models/base_response.dart';
//
// ServicesOnMapResponse categoriesResponseFromJson(String str) =>
//     ServicesOnMapResponse.fromJson(json.decode(str));
//
// String categoriesResponseToJson(ServicesOnMapResponse data) =>
//     json.encode(data.toJson());
//
// class ServicesOnMapResponse extends BaseResponse {
//   ServicesOnMapResponse({
//     status,
//     code,
//     message,
//     this.data,
//   }) : super(status: status, code: code, message: message);
// List<ServicItem>? data;
//    ServicesOnMapResponse.fromJson(Map<String, dynamic> json) {
//      status = json['status'];
//     code = json['code'];
//     message = json['message'];
//  data=json['items'] == null?null:List<ServicItem>.from( json['items'].map((v)=> ServicItem.fromJson(v)).toList()) ;   }
//
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "code": code,
//         "message": message,
//         //"items": List<dynamic>.from(items!.map((x) => x.toJson())),
//       };
// }
