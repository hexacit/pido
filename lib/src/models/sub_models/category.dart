

class MenuCategory {
  MenuCategory({
    this.id,
    this.parentId,
    this.status,
    this.image,
    this.createdAt,
    this.name,
    this.translations,
  });

  int? id;
  int? parentId;
  String? status;
  String? image;
  DateTime? createdAt;
  String? name;
  List<Translation>? translations;

  factory MenuCategory.fromJson(Map<String, dynamic> json) => MenuCategory(
    id: json["id"],
    parentId: json["parent_id"],
    status: json["status"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    name: json["name"],
    translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
  );


}

class Translation {
  Translation({
    this.id,
    this.name,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.locale,
  });

  int? id;
  String? name;
  int? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? locale;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    id: json["id"],
    name: json["name"],
    categoryId: json["category_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    locale: json["locale"],
  );





}
