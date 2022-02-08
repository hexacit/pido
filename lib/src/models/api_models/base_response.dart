import 'dart:convert';

BaseResponse baseResponseFromJson(String str) =>
    BaseResponse.fromJson(json.decode(str));

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse {
  BaseResponse({
    this.status,
    this.code,
    this.message,
    this.data,
    this.mapData,
    this.urlData
  });

  bool? status;
  int? code;
  String? message;
  dynamic data;
  dynamic urlData;
  Map<String,dynamic>? mapData;
  factory BaseResponse.fromJson(Map<String, dynamic> json,{String? dataKey, Map<String,dynamic>?data,dynamic urlData, } ) => BaseResponse(
        status: json["status"],
       code: json["code"],
        message:json["message"]==null?'': json["message"].toString(),

    data:dataKey==null?null: json['$dataKey'],
    mapData:data==null?null: data,
    urlData:urlData==null?null: urlData,

  );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}
