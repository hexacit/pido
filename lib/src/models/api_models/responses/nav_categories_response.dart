import 'dart:convert';

import 'package:pido/src/models/sub_models/category.dart';

import '../../../models/api_models/base_response.dart';

NavCategoriesResponse categoriesResponseFromJson(String str) =>
    NavCategoriesResponse.fromJson(json.decode(str));

String categoriesResponseToJson(NavCategoriesResponse data) =>
    json.encode(data.toJson());

class NavCategoriesResponse extends BaseResponse {
  NavCategoriesResponse({
    status,
    code,
    message,
    this.topNavCategories,
  }) : super(status: status, code: code, message: message);
  List<TopNavCategory>? topNavCategories;

  factory NavCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      NavCategoriesResponse(
        status: json["status"]==1,
        code: json["code"],
        message: json["message"],
        topNavCategories: List<TopNavCategory>.from(json['data']["top_nav_categories"].map((x) => TopNavCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}


class TopNavCategory {
  TopNavCategory({
    this.productCategoryId,
    this.parentId,
    this.routeId,
    this.name,
    this.keywords,
    this.seoLink,
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
  });

  String? productCategoryId;
  String? parentId;
  String? routeId;
  String? name;
  String? keywords;
  String? seoLink;
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
  DateTime? dateModified;
  String? addedById;
  String? addedByName;
  String? addedByIp;
  String? modifiedById;
  String? modifiedByName;
  String? modifiedByIp;
  String? nameTranslated;

  factory TopNavCategory.fromJson(Map<String, dynamic> json) => TopNavCategory(
    productCategoryId: json["product_category_id"],
    parentId: json["parent_id"],
    routeId: json["route_id"],
    name: json["name"],
    keywords: json["keywords"],
    seoLink: json["seo_link"],
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
    dateModified: DateTime.parse(json["date_modified"]),
    addedById: json["added_by_id"],
    addedByName: json["added_by_name"],
    addedByIp: json["added_by_ip"],
    modifiedById: json["modified_by_id"],
    modifiedByName: json["modified_by_name"],
    modifiedByIp: json["modified_by_ip"],
    nameTranslated: json["name_translated"],
  );

  Map<String, dynamic> toJson() => {
    "product_category_id": productCategoryId,
    "parent_id": parentId,
    "route_id": routeId,
    "name": name,
    "keywords": keywords,
    "seo_link": seoLink,
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
    "date_modified": dateModified!.toIso8601String(),
    "added_by_id": addedById,
    "added_by_name": addedByName,
    "added_by_ip": addedByIp,
    "modified_by_id": modifiedById,
    "modified_by_name": modifiedByName,
    "modified_by_ip": modifiedByIp,
    "name_translated": nameTranslated,
  };
}
