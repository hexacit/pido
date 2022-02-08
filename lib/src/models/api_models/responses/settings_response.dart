// // To parse this JSON data, do
// //
// //     final setting = settingFromJson(jsonString);
//
// import 'dart:convert';
//
// SettingsResponse settingFromJson(String str) => SettingsResponse.fromJson(json.decode(str));
//
// String settingToJson(SettingsResponse data) => json.encode(data.toJson());
//
// class SettingsResponse {
//   SettingsResponse({
//     this.status,
//     this.code,
//     this.message,
//     this.settings,
//   });
//
//   bool? status;
//   int? code;
//   String? message;
//   Settings? settings;
//
//   factory SettingsResponse.fromJson(Map<String, dynamic> json) => SettingsResponse(
//     status: json["status"],
//     code: json["code"],
//     message: json["message"],
//     settings: Settings.fromJson(json["settings"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "code": code,
//     "message": message,
//     "settings": settings?.toJson(),
//   };
// }
//
