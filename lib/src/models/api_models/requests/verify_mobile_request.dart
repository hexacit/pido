import 'dart:convert';

import 'package:pido/src/utils/app_shared.dart';

VerifyMobileRequest signInRequestFromJson(String str) =>
    VerifyMobileRequest.fromJson(json.decode(str));

String signInRequestToJson(VerifyMobileRequest data) =>
    json.encode(data.toJson());

class VerifyMobileRequest {
  VerifyMobileRequest({
    this.mobile,
    this.code,
  });

  String? mobile;
  String? code;

  factory VerifyMobileRequest.fromJson(Map<String, dynamic> json) =>
      VerifyMobileRequest(
        mobile: json["mobile"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "code": code,
        "fcm_token": AppShared.firebaseToken,
        "device_type": AppShared.deviceType,
      };
}
