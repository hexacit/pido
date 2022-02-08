import 'dart:convert';

import 'package:pido/src/models/sub_models/category.dart';
import 'package:pido/src/models/sub_models/product.dart';

import '../../../models/api_models/base_response.dart';
//
// CategoryProductsResponse categoryProductsResponseFromJson(String str) => CategoryProductsResponse.fromJson(json.decode(str));
//
// String categoryProductsResponseToJson(CategoryProductsResponse data) => json.encode(data.toJson());
//
//
// class CategoryProductsResponse extends BaseResponse {
//   CategoryProductsResponse({
//     status,
//     code,
//     message,
//     this.data,
//   }) : super(status: status, code: code, message: message);
//   Data? data;
//
//   factory CategoryProductsResponse.fromJson(Map<String, dynamic> json) =>
//       CategoryProductsResponse(
//         status: json["status"]==1,
//         code: json["code"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "code": code,
//         "message": message,
//       };
// }

class CategoryProductsData {
  CategoryProductsData({
    this.categoryName,
    this.breadcrumb,
    this.category,
    this.categoryFilter,
    this.zones,
    this.productsList,
    this.totalFound,
  });

  String? categoryName;
  List<String>? breadcrumb;
  Category? category;
  CategoryFilter? categoryFilter;
  List<dynamic>? zones;
  List<Product>? productsList;
  int? totalFound;

  factory CategoryProductsData.fromJson(Map<String, dynamic> json) => CategoryProductsData(
    categoryName: json["category_name"],
    breadcrumb: List<String>.from(json["breadcrumb"].map((x) => x)),
    category:!(json["category"]is Map) ?null:Category.fromJson(json["category"]),
    categoryFilter: !(json["category_filter"]is Map) ?null:CategoryFilter.fromJson(json["category_filter"]),
  //  zones: List<dynamic>.from(json["zones"].map((x) => x)),
    productsList: List<Product>.from(json["products_list"].map((x) => Product.fromJson(x))),
    totalFound: json["total_found"],
  );

  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "breadcrumb": List<dynamic>.from(breadcrumb!.map((x) => x)),
    "category": category!.toJson(),
    "category_filter": categoryFilter!.toJson(),
    "zones": List<dynamic>.from(zones!.map((x) => x)),
    "products_list": List<dynamic>.from(productsList!.map((x) => x.toJson())),
    "total_found": totalFound,
  };
}

class Category {
  Category({
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
  String? dateModified;
  String? addedById;
  String? addedByName;
  String? addedByIp;
  String? modifiedById;
  String? modifiedByName;
  String? modifiedByIp;
  String? nameTranslated;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
    dateModified: json["date_modified"],
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
    "date_modified": dateModified,
    "added_by_id": addedById,
    "added_by_name": addedByName,
    "added_by_ip": addedByIp,
    "modified_by_id": modifiedById,
    "modified_by_name": modifiedByName,
    "modified_by_ip": modifiedByIp,
    "name_translated": nameTranslated,
  };
}

class CategoryFilter {
  CategoryFilter({
    this.attributes,
    this.items,
    this.subitems,
  });

  List<Attribute>? attributes;
  Map<String, List<Item>>? items;
  List<dynamic>? subitems;

  factory CategoryFilter.fromJson(Map<String, dynamic> json) => CategoryFilter(
    attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
    items: Map.from(json["items"]).map((k, v) => MapEntry<String, List<Item>>(k, List<Item>.from(v.map((x) => Item.fromJson(x))))),
   // subitems: List<dynamic>.from(json["subitems"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "attributes": List<dynamic>.from(attributes!.map((x) => x.toJson())),
    "items": Map.from(items!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
    "subitems": List<dynamic>.from(subitems!.map((x) => x)),
  };
}

class Attribute {
  Attribute({
    this.attributeCategoryId,
    this.fieldType,
    this.name,
  });

  String? attributeCategoryId;
  String? fieldType;
  String? name;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    attributeCategoryId: json["attribute_category_id"],
    fieldType: json["field_type"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "attribute_category_id": attributeCategoryId,
    "field_type": fieldType,
    "name": name,
  };
}

class Item {
  Item({
    this.value,
    this.name,
    this.count,
  });

  String? value;
  String? name;
  String? count;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    value: json["value"],
    name: json["name"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "name": name,
    "count": count,
  };
}

