class Product {
  Product({
    this.id,
    this.image,
    this.sku,
    this.categoryId,
    this.price,
    this.discountPrice,
    this.offerEndDate,
    this.quantity,
    this.ageId,
    this.gender,
    this.status,
    this.createdAt,
    this.isCart,
    this.discountPercent,
    this.isFavorite,
    this.description,
    this.name,
    this.images,
    this.translations,
  });

  int? id;
  String ?image;
  String? sku;
  int? categoryId;
  num? price;
  int? discountPrice;
  DateTime? offerEndDate;
  int? quantity;
  int? ageId;
  int? gender;
  String? status;
  DateTime? createdAt;
  int? isCart;
  num? discountPercent;
  String? isFavorite;
  String? description;

  String? name;
  List<CategoryImage>? images;
  List<Translation>? translations;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    image: json["image"],
    sku: json["sku"],
    categoryId: json["category_id"],
    discountPercent:json["discount_percent"],
    price: json["price"],
    discountPrice: json["discount_price"] == null ? null : json["discount_price"],
    offerEndDate: DateTime.parse(json["offer_end_date"]),
    quantity: json["quantity"],
    ageId: json["age_id"],
    gender: json["gender"] == null ? null : json["gender"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    isCart: json["is_cart"],
    isFavorite: json["is_favorite"],
    description: json["description"],
    name: json["name"],
    images: List<CategoryImage>.from(json["images"].map((x) => CategoryImage.fromJson(x))),
    translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "sku": sku,
    "category_id": categoryId,
    "price": price,
    "discount_price": discountPrice == null ? null : discountPrice,
    "quantity": quantity,
    "age_id": ageId,
    "gender": gender == null ? null : gender,
    "is_cart": isCart,
    "discount_percent": discountPercent,
    "is_favorite": isFavorite,
    "description": description,
    "name": name,
  };
}


class CategoryImage {
  CategoryImage({
    this.id,
    this.productId,
    this.image,
    this.createdAt,
  });

  int? id;
  int? productId;
  String? image;
  DateTime? createdAt;

  factory CategoryImage.fromJson(Map<String, dynamic> json) => CategoryImage(
    id: json["id"],
    productId: json["product_id"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
  };
}

class Translation {
  Translation({
    this.id,
    this.productId,
    this.locale,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.categoryId,
  });

  int? id;
  int? productId;
  String? locale;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? categoryId;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    id: json["id"],
    productId: json["product_id"] == null ? null : json["product_id"],
    locale: json["locale"],
    name: json["name"],
    description: json["description"] == null ? null : json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
  );


}
