// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import '../../../models/api_models/base_response.dart';
import '../../../models/sub_models/user.dart';

class UserResponse extends BaseResponse {
  UserResponse({
    status,
    code,
    message,
    this.user,
  }) : super(status: status, code: code, message: message);

  User? user;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        status: json["status"],
        code: json["code"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "user": user!.toJson(),
        "message": message,
      };
}
