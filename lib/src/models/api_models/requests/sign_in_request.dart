import 'dart:convert';

SignInRequest signInRequestFromJson(String str) =>
    SignInRequest.fromJson(json.decode(str));

String signInRequestToJson(SignInRequest data) => json.encode(data.toJson());

class SignInRequest {
  SignInRequest({
    this.password,
    this.mobile,
    this.deviceType,
    this.fcmToken,
  });

  String? password;
  String? mobile;
  String? deviceType;
  String? fcmToken;

  factory SignInRequest.fromJson(Map<String, dynamic> json) => SignInRequest(
        password: json["password"],
        mobile: json["mobile"],
        deviceType: json["device_type"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "email": mobile,
        "device_type": deviceType,
        "fcm_token": fcmToken,
      };
}
