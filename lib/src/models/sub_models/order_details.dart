

import 'package:pido/src/models/sub_models/address.dart';
import 'package:pido/src/models/sub_models/product.dart';

class OrderDetails {
  OrderDetails({
    this.id,
    this.userId,
    this.total,
    this.vatPercent,
    this.vatAmount,
    this.appPercent,
    this.addressId,
    this.appTotal,
    this.discount,
    this.deliveryCost,
    this.discountCode,
    this.subTotal,
    this.countItems,
    this.fcmToken,
    this.name,
    this.email,
    this.areaId,
    this.street,
    this.addressName,
    this.availabileDate,
    this.availabileTime,
    this.paymentJson,
    this.paymentMethod,
    this.paymentStatus,
    this.status,
    this.orderedDate,
    this.createdAt,
    this.statusName,
    this.products,
    this.address,
  });

  int? id;
  int? userId;
  int? total;
  int? vatPercent;
  int? vatAmount;
  dynamic appPercent;
  int? addressId;
  dynamic appTotal;
  int? discount;
  int? deliveryCost;
  String? discountCode;
  int? subTotal;
  int? countItems;
  String? fcmToken;
  String? name;
  String? email;
  int? areaId;
  String? street;
  String? addressName;
  DateTime? availabileDate;
  String? availabileTime;
  dynamic paymentJson;
  dynamic paymentMethod;
  int? paymentStatus;
  int? status;
  DateTime? orderedDate;
  DateTime? createdAt;
  String? statusName;
  List<ProductElement>? products;
  Address? address;

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
    id: json["id"],
    userId: json["user_id"],
    total: json["total"],
    vatPercent: json["vat_percent"],
    vatAmount: json["vat_amount"],
    appPercent: json["app_percent"],
    addressId: json["address_id"],
    appTotal: json["app_total"],
    discount: json["discount"],
    deliveryCost: json["delivery_cost"],
    discountCode: json["discount_code"],
    subTotal: json["sub_total"],
    countItems: json["count_items"],
    fcmToken: json["fcm_token"],
    name: json["name"],
    email: json["email"],
    areaId: json["area_id"],
    street: json["street"],
    addressName: json["address_name"],
    availabileDate:json["availabile_date"]==null?null: DateTime.parse(json["availabile_date"]),
    availabileTime: json["availabile_time"],
    paymentJson: json["payment_json"],
    paymentMethod: json["payment_method"],
    paymentStatus: json["payment_status"],
    status: json["status"],
    orderedDate: DateTime.parse(json["ordered_date"]),
    createdAt: DateTime.parse(json["created_at"]),
    statusName: json["status_name"],
    products: List<ProductElement>.from(json["products"].map((x) => ProductElement.fromJson(x))),
    address: json["address"]==null?null:Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "total": total,
    "vat_percent": vatPercent,
    "vat_amount": vatAmount,
    "app_percent": appPercent,
    "address_id": addressId,
    "app_total": appTotal,
    "discount": discount,
    "delivery_cost": deliveryCost,
    "discount_code": discountCode,
    "sub_total": subTotal,
    "count_items": countItems,
    "fcm_token": fcmToken,
    "name": name,
    "email": email,
    "area_id": areaId,
    "street": street,
    "address_name": addressName,
    "availabile_time": availabileTime,
    "payment_json": paymentJson,
    "payment_method": paymentMethod,
    "payment_status": paymentStatus,
    "status": status,
    "status_name": statusName,
  };
}



class ProductElement {
  ProductElement({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.discount,
    this.price,
    this.offerPrice,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.product,
  });

  int? id;
  int? orderId;
  int? productId;
  int? quantity;
  int? discount;
  int? price;
  int? offerPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Product? product;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    discount: json["discount"],
    price: json["price"],
    offerPrice: json["offer_price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "quantity": quantity,
    "discount": discount,
    "price": price,
    "offer_price": offerPrice,
    "deleted_at": deletedAt,
  };
}

