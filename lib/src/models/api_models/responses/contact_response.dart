import 'dart:convert';

import '../../../models/api_models/base_response.dart';

ContactResponse contactResponseFromJson(String str) =>
    ContactResponse.fromJson(json.decode(str));

String contactResponseToJson(ContactResponse data) =>
    json.encode(data.toJson());

class ContactResponse extends BaseResponse {
  ContactResponse({
    status,
    code,
    message,
    this.validator,
  }) : super(status: status, message: message, code: code);

  String? validator;

  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      ContactResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        validator: json["validator"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "validator": validator,
      };
}
