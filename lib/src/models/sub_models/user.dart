import 'dart:convert';

import 'package:pido/src/models/sub_models/address.dart';
import 'package:pido/src/utils/helpers.dart';

User userFromJson(String? str) => User.fromJson(json.decode(str!));

String userToJson(User? user) => json.encode(user?.toJson());




class User {
  User({
    this.id,
    this.typeMobile,
    this.receiveNotification,
    this.name,
    this.email,
    this.mobile,
    this.image,
    this.rememberToken,
    this.status,
    this.verified,
    this.socialToken,
    this.socialType,
    this.avatar,
    this.accessToken,
    this.defaultAddress,
  });

  int? id;
  int? typeMobile;
  int? receiveNotification;
  String? name;
  String? email;
  String? mobile;
  String? image;
  String? rememberToken;
  String? status;
  int? verified;
  String? socialToken;
  String? socialType;
  String? avatar;
  String? accessToken;
  Address? defaultAddress;

  User copyWith({
    int? id,
    int? typeMobile,
    int? receiveNotification,
    String? name,
    String? email,
    String? mobile,
    String? image,
    String? rememberToken,
    String? status,
    int? verified,
    String? socialToken,
    String? socialType,
    String? avatar,
    String? accessToken,
    Address? defaultAddress,
}){
    return User(
      id: id??this.id,
      name: name??this.name,
      status: status??this.status,
      typeMobile: typeMobile??this.typeMobile,
      email: email??this.email,
      image: image??this.image,
      mobile: mobile??this.mobile,
      accessToken: accessToken??this.accessToken,
      avatar: avatar??this.avatar,
      defaultAddress: defaultAddress??this.defaultAddress,
      receiveNotification: receiveNotification??this.receiveNotification,
      rememberToken: rememberToken??this.rememberToken,
      socialToken: socialToken??this.socialToken,
      socialType: socialType??this.socialType,
      verified: verified??this.verified,
    );
  }
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    typeMobile: json["type_mobile"],
    receiveNotification: json["receive_notification"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    image: json["image"],
    rememberToken: json["remember_token"],
    status: json["status"],
    verified: json["verified"],
    socialToken: json["social_token"],
    socialType: json["social_type"],
    avatar: json["avatar"],
    accessToken: json["access_token"],
    defaultAddress: json["defult_address"]==null?null:Address.fromJson(json["defult_address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type_mobile": typeMobile,
    "receive_notification": receiveNotification,
    "name": name,
    "email": email,
    "mobile": mobile,
    "image": image,
    "remember_token": rememberToken,
    "status": status,
    "verified": verified,
    "social_token": socialToken,
    "social_type": socialType,
    "avatar": avatar,
    "access_token": accessToken,
    "defult_address": defaultAddress,
  };
}
