import 'dart:convert';

import 'package:pido/src/models/sub_models/category.dart';

import '../../../models/api_models/base_response.dart';
//
// CategoriesResponse categoriesResponseFromJson(String str) =>
//     CategoriesResponse.fromJson(json.decode(str));
//
// String categoriesResponseToJson(CategoriesResponse data) =>
//     json.encode(data.toJson());
//
// class CategoriesResponse extends BaseResponse {
//   CategoriesResponse({
//     status,
//     code,
//     message,
//     this.data,
//   }) : super(status: status==1, code: code, message: message);
//   Data? data;
//
//   factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
//       CategoriesResponse(
//         status: json["status"],
//         code: json["code"],
//         message: json["message"],
//        data:Data.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "code": code,
//         "message": message,
//         //"items": List<dynamic>.from(items!.map((x) => x.toJson())),
//       };
// }
//


class MenuCategoriesData {
  MenuCategoriesData({
    this.menuCategories,
  });

  List<List<MenuCategory>>? menuCategories;

  factory MenuCategoriesData.fromJson(Map<String, dynamic> json) => MenuCategoriesData(
    menuCategories: List<List<MenuCategory>>.from(json["menu_categories"].map((x) => List<MenuCategory>.from(x.map((x) => MenuCategory.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "menu_categories": List<dynamic>.from(menuCategories!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
  };
}

class MenuCategory {
  MenuCategory({
    this.productCategoryId,
    this.parentId,
    this.routeId,
    this.name,
    this.keywords,
    this.description,
    this.shortDescription,
    this.stringCodeName,
    this.stringCodeDescription,
    this.stringCodeShortDescription,
    this.iconClass,
    this.hasAttributes,
    this.hasRoom,
    this.hasRating,
    this.whatOffered,
    this.images,
    this.level,
    this.sortOrder,
    this.isBrandRequired,
    this.isNameTranslated,
    this.suspended,
    this.deleted,
    this.enabled,
    this.dateAdded,
    this.dateModified,
    this.addedById,
    this.addedByName,
    this.addedByIp,
    this.modifiedById,
    this.modifiedByName,
    this.modifiedByIp,
    this.nameTranslated,
    this.children,
  });

  String? productCategoryId;
  String? parentId;
  String? routeId;
  String? name;
  String? keywords;
  String? description;
  String? shortDescription;
  String? stringCodeName;
  String? stringCodeDescription;
  String? stringCodeShortDescription;
  String? iconClass;
  String? hasAttributes;
  String? hasRoom;
  String? hasRating;
  String? whatOffered;
  String? images;
  String? level;
  String? sortOrder;
  String? isBrandRequired;
  String? isNameTranslated;
  String? suspended;
  String? deleted;
  String? enabled;
  DateTime? dateAdded;
  dynamic dateModified;
  String? addedById;
  String? addedByName;
  String? addedByIp;
  String? modifiedById;
  String? modifiedByName;
  String? modifiedByIp;
  String? nameTranslated;
  List<MenuCategory>? children;

  factory MenuCategory.fromJson(Map<String, dynamic> json) => MenuCategory(
    productCategoryId: json["product_category_id"],
    parentId: json["parent_id"],
    routeId: json["route_id"],
    name: json["name"],
    keywords: json["keywords"],
    description: json["description"],
    shortDescription: json["short_description"],
    stringCodeName: json["string_code_name"],
    stringCodeDescription: json["string_code_description"],
    stringCodeShortDescription: json["string_code_short_description"],
    iconClass: json["icon_class"],
    hasAttributes: json["has_attributes"],
    hasRoom: json["has_room"],
    hasRating: json["has_rating"],
    whatOffered: json["what_offered"],
    images: json["images"],
    level: json["level"],
    sortOrder: json["sort_order"],
    isBrandRequired: json["is_brand_required"],
    isNameTranslated: json["is_name_translated"],
    suspended: json["suspended"],
    deleted: json["deleted"],
    enabled: json["enabled"],
    dateAdded: DateTime.parse(json["date_added"]),
    dateModified: json["date_modified"],
    addedById: json["added_by_id"],
    addedByName: json["added_by_name"],
    addedByIp: json["added_by_ip"],
    modifiedById: json["modified_by_id"],
    modifiedByName: json["modified_by_name"],
    modifiedByIp: json["modified_by_ip"],
    nameTranslated: json["name_translated"],
    children: List<MenuCategory>.from(json["children"].map((x) => MenuCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_category_id": productCategoryId,
    "parent_id": parentId,
    "route_id": routeId,
    "name": name,
    "keywords": keywords,
    "description": description,
    "short_description": shortDescription,
    "string_code_name": stringCodeName,
    "string_code_description": stringCodeDescription,
    "string_code_short_description": stringCodeShortDescription,
    "icon_class": iconClass,
    "has_attributes": hasAttributes,
    "has_room": hasRoom,
    "has_rating": hasRating,
    "what_offered": whatOffered,
    "images": images,
    "level": level,
    "sort_order": sortOrder,
    "is_brand_required": isBrandRequired,
    "is_name_translated": isNameTranslated,
    "suspended": suspended,
    "deleted": deleted,
    "enabled": enabled,
    "date_added": dateAdded!.toIso8601String(),
    "date_modified": dateModified,
    "added_by_id": addedById,
    "added_by_name": addedByName,
    "added_by_ip": addedByIp,
    "modified_by_id": modifiedById,
    "modified_by_name": modifiedByName,
    "modified_by_ip": modifiedByIp,
    "name_translated": nameTranslated,
    "children": List<dynamic>.from(children!.map((x) => x.toJson())),
  };
}

