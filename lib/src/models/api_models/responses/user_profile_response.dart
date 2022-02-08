// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import '../../../models/api_models/base_response.dart';
import '../../../models/sub_models/user.dart';
//
// class UserProfileResponse extends BaseResponse {
//   UserProfileResponse({
//     status,
//     code,
//     message,
//     this.data,
//   }) : super(status: status==1, code: code, message: message);
//
//   Data? data;
//
//   factory UserProfileResponse.fromJson(Map<String, dynamic> json) => UserProfileResponse(
//         status: json["status"],
//         code: json["code"],
//         data: json["data"]is List?null: Data.fromJson(json["data"]),
//         message: json["message"],
//       );
//
//
// }
class UserProfileData {
  UserProfileData({
    this.user,
  });

User? user;
  factory UserProfileData.fromJson(Map<String, dynamic> json)=>UserProfileData(

    user: User.fromJson(json['user']),
  );
}
