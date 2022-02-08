

import 'package:pido/src/models/sub_models/product.dart';

class CategoriesProducts {
  CategoriesProducts({
    this.id,
    this.parentId,
    this.status,
    this.image,
    this.createdAt,
    this.name,
    this.products,
    this.translations,
  });

  int? id;
  int? parentId;
  String? status;
  String? image;
  DateTime? createdAt;
  String? name;
  List<Product>? products;
  List<Translation>? translations;

  factory CategoriesProducts.fromJson(Map<String, dynamic> json,) => CategoriesProducts(
    id: json["id"],
    parentId: json["parent_id"],
    status: json["status"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    name: json["name"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "status": status,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "name": name,
  };
}
