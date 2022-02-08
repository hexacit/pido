import 'dart:convert';

import '../../../models/api_models/base_response.dart';

SubCategoriesResponse categoriesResponseFromJson(String str) =>
    SubCategoriesResponse.fromJson(json.decode(str));

String categoriesResponseToJson(SubCategoriesResponse data) =>
    json.encode(data.toJson());

class SubCategoriesResponse extends BaseResponse {
  SubCategoriesResponse({
    status,
    code,
    message,
    this.items,
  }) : super(status: status, code: code, message: message);
Items? items;

  factory SubCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      SubCategoriesResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        items: Items.fromJson(
            json["items"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        //"items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
class Items {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
 // List<Links> links;
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
     // this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Items.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data =[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    // if (json['links'] != null) {
    //   links = new List<Links>();
    //   json['links'].forEach((v) {
    //     links.add(new Links.fromJson(v));
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
    // if (this.links != null) {
    //   data['links'] = this.links.map((v) => v.toJson()).toList();
    // }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  int? parentId;
  String? image;
  String? status;
  String? createdAt;
  String? name;
  

  Data(
      {this.id,
      this.parentId,
      this.image,
      this.status,
      this.createdAt,
      this.name,
    });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    name = json['name'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
   
    return data;
  }
}

class Parent {
  int? id;
  int? parentId;
  String? image;
  String? status;
  String? createdAt;
  String? name;

  Parent(
      {this.id,
      this.parentId,
      this.image,
      this.status,
      this.createdAt,
      this.name});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    return data;
  }
}


