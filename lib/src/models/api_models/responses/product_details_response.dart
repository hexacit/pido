
class ProductDetails {
  ProductDetails({
    this.id,
    this.categoryId,
    this.price,
    this.discountPrice,
    this.quantity,
    this.ageId,
    this.gender,
    this.status,
    this.createdAt,
    this.isCart,
    this.description,
    this.name,
    this.images,
    this.translations,
    this.discountPercent,
    this.isFavorite,
    this.urlLink,
  });

  int? id;
  int? categoryId;
  num? price;
  num? discountPercent;
  int? discountPrice;
  int? quantity;
  String? isFavorite;
  int? ageId;
  int? gender;
  String? status;
  String? urlLink;
  DateTime? createdAt;
  int? isCart;
  String? description;
  String? name;
  List<ProductImage>? images;
  List<Translation>? translations;
  bool get isFavoriteValue{
    return int.parse(this.isFavorite!)==1;
  }

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    id: json["id"],
    isFavorite: json["is_favorite"],
    categoryId: json["category_id"],
    urlLink: json["url_link"],
    price: json["price"],
    discountPrice: json["discount_price"],
    quantity: json["quantity"],
    ageId: json["age_id"],
    gender: json["gender"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    isCart: json["is_cart"],
    description: json["description"],
    name: json["name"],
    discountPercent:json["discount_percent"],
    images: List<ProductImage>.from(json["images"].map((x) => ProductImage.fromJson(x))),
    translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "price": price,
    "discount_price": discountPrice,
    "quantity": quantity,
    "age_id": ageId,
    "gender": gender,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "is_cart": isCart,
    "description": description,
    "name": name,
  };
}

class ProductImage {
  ProductImage({
    this.id,
    this.productId,
    this.image,
    this.createdAt,
  });

  int? id;
  int? productId;
  String? image;
  DateTime? createdAt;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    id: json["id"],
    productId: json["product_id"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "image": image,
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
  });

  int? id;
  int? productId;
  String? locale;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    id: json["id"],
    productId: json["product_id"],
    locale: json["locale"],
    name: json["name"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "locale": locale,
    "name": name,
    "description": description,
    "deleted_at": deletedAt,
  };
}
