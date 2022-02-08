import 'dart:convert';

import '../../../models/api_models/base_response.dart';
import '../../../models/sub_models/address.dart';

MyAddressesResponse? myAddressesResponseFromJson(String? str) {
  if (str==null) return null;
  return MyAddressesResponse.fromJson(json.decode(str));
}

String myAddressesResponseToJson(MyAddressesResponse data) =>
    json.encode(data.toJson());

class MyAddressesResponse extends BaseResponse {
  MyAddressesResponse({
    status,
    code,
    message,
    this.address,
  }) : super(status: status, code: code, message: message);

  Address? address;

  factory MyAddressesResponse.fromJson(Map<String, dynamic> json) =>
      MyAddressesResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        address: Address.fromJson(
            json["item"]),
      );
 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.address != null) {
      data['item'] = this.address!.toJson();
    }
    return data;
  }

}
