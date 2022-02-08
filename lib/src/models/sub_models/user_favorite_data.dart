

import 'package:pido/src/models/sub_models/product.dart';

class FavoriteItem {
  FavoriteItem({
    this.id,
    this.userId,
    this.productId,
    this.fcmToken,
    this.createdAt,
    this.product,
  });

  int? id;
  int? userId;
  int? productId;
  dynamic fcmToken;
  DateTime? createdAt;
  Product? product;

  factory FavoriteItem.fromJson(Map<String, dynamic> json) => FavoriteItem(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    fcmToken: json["fcm_token"],
    createdAt: DateTime.parse(json["created_at"]),
    product:json["product"]==null?null: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "fcm_token": fcmToken,
  };
}
