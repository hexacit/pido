import 'dart:convert';

import 'package:pido/src/models/sub_models/service_item.dart';

import '../../../models/api_models/base_response.dart';

ServicesResponse categoriesResponseFromJson(String str) =>
    ServicesResponse.fromJson(json.decode(str));

String categoriesResponseToJson(ServicesResponse data) =>
    json.encode(data.toJson());

class ServicesResponse extends BaseResponse {
  ServicesResponse({
    status,
    code,
    message,
    this.items,
  }) : super(status: status, code: code, message: message);
Items? items;

   ServicesResponse.fromJson(Map<String, dynamic> json) {
     status = json['status'];
    code = json['code'];
    message = json['message'];
    items = json['items'] != null ? new Items.fromJson(json['items']) : null;
   }
     

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        //"items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
class Items {
  int? currentPage;
  List<ServicItem>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Items(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Items.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data=json['data'] == null?null:List<ServicItem>.from( json['data'].map((v)=> ServicItem.fromJson(v)).toList()) ;
    // if (json['data'] != null) {
    //   data =[];
    //   json['data'].forEach((v) {
    //     data!.add(new ServicItem.fromJson(v));
    //   });
    // }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    // if (json['links'] != null) {
    //   links = [];
    //   json['links'].forEach((v) {
    //     links!.add(new Links.fromJson(v));
    //   });
    // }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

   
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
   
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
