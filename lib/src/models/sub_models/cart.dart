

import 'package:flutter/material.dart';
import 'package:pido/src/models/sub_models/product.dart';

class Cart {
  Cart({
    this.finalTotal,
    this.countProducts,
    this.discount,
    this.tax,
    this.deliveryCharge,
    this.total,
    this.cartItems,
  });

  double? finalTotal;
  int? countProducts;
  int? discount;
  double? tax;
  int? deliveryCharge;
  int? total;
  List<CartItem>? cartItems;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    finalTotal: json["final_total"].toDouble(),
    countProducts: json["count_products"],
    discount: json["discount"],
    tax: json["Tax"].toDouble(),
    deliveryCharge: json["delivery_charge"],
    total: json["total"],
    cartItems: List<CartItem>.from(json["MyCart"].map((x) => CartItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "final_total": finalTotal,
    "count_products": countProducts,
    "discount": discount,
    "Tax": tax,
    "delivery_charge": deliveryCharge,
    "total": total,
  };
}

class CartItem with ChangeNotifier{
  CartItem({
    this.id,
    this.userId,
    this.productId,
    this.quantity,
    this.fcmToken,
    this.createdAt,
    this.product,
  });

  int? id;
  int? userId;
  int? productId;
  int? quantity;
  String? fcmToken;
  DateTime? createdAt;
  Product? product;

  int? get itemQuantity => quantity;

  set itemQuantity(int? value) {
    quantity = value;
    notifyListeners();
  }

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    fcmToken: json["fcm_token"],
    createdAt: DateTime.parse(json["created_at"]),
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "quantity": quantity,
    "fcm_token": fcmToken,
  };
}


