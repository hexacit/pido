import 'package:google_maps_flutter/google_maps_flutter.dart';
class ServicItem    {
  int? id;
  int? userId;
  int? categoryId;
  int? subCategoryId;
  int? time;
  int? educationEnvironment;
  int? gender;
  String? address;
  int? cityId;
  double? latitude;
  double? longitude;
  int? ageCategoryId;
  String? phone;
  String? mobile;
  String? email;
  double? rate;
  int? status;
  String? createdAt;
  double? distance;
  String? statusName;
  String? name;
  String? description;
  Category? category;
  Category? subCategory;
  List<Images>? images;
  City? city;

  ServicItem(
      {this.id,
      this.userId,
      this.categoryId,
      this.subCategoryId,
      this.time,
      this.educationEnvironment,
      this.gender,
      this.address,
      this.cityId,
      this.latitude,
      this.longitude,
      this.ageCategoryId,
      this.phone,
      this.mobile,
      this.email,
      this.rate,
      this.status,
      this.createdAt,
      this.distance,
      this.statusName,
      this.name,
      this.description,
      this.category,
      this.subCategory,
      this.images,
      this.city,
     
      });

  ServicItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    time = json['time'];
    educationEnvironment = json['education_environment'];
    gender = json['gender'];
    address = json['address'];
    cityId = json['city_id'];
    latitude = double.parse( json['latitude']);
    longitude =double.parse( json['longitude']);
    ageCategoryId = json['age_category_id'];
    phone = json['phone'];
    mobile = json['mobile'];
    email = json['email'];
    rate = json['rate']==null?0:json['rate']*1.0;
    status = json['status'];
    createdAt = json['created_at'];
    distance = json['distance'];
    statusName = json['status_name'];
    name = json['name'];
    description = json['description'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subCategory = json['sub_category'] != null
        ? new Category.fromJson(json['sub_category'])
        : null;
    if (json['images'] != null) {
      images =[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['time'] = this.time;
    data['education_environment'] = this.educationEnvironment;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['city_id'] = this.cityId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['age_category_id'] = this.ageCategoryId;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['rate'] = this.rate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['distance'] = this.distance;
    data['status_name'] = this.statusName;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
     }
    return data;
  }

  @override
  // TODO: implement location
  LatLng get location => LatLng(this.latitude!,this.longitude!);
}

class Category {
  int? id;
  int? parentId;
  String? image;
  String? status;
  String? createdAt;
  String? name;

  Category(
      {this.id,
      this.parentId,
      this.image,
      this.status,
      this.createdAt,
      this.name});

  Category.fromJson(Map<String, dynamic> json) {
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

class Images {
  int? id;
  int? serviceId;
  String? image;
  String? createdAt;

  Images({this.id, this.serviceId, this.image, this.createdAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_id'] = this.serviceId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class City {
  int? id;
  String? status;
  String? createdAt;
  String? name;

  City({this.id, this.status, this.createdAt, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    return data;
  }
}
