import 'dart:convert';

SignUpRequest signUpRequestFromJson(String str) =>
    SignUpRequest.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  SignUpRequest({
    this.password,
    this.mobile,
    this.deviceType,
    this.fcmToken,
    this.email,this.name,
  });

  String? password;
  String? mobile;
  String? name;
  String? email;

  String? deviceType;
  String? fcmToken;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
        password: json["password"],
        mobile: json["mobile"],
        deviceType: json["device_type"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "cell": mobile,
    "name": name,
    "email": email,
    "agree": 1,


    // "device_type": deviceType,
        // "fcm_token": fcmToken,
      };
}
