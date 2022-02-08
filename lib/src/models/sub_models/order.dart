
class MyOrderData {
  MyOrderData({

    this.myOrder,
    this.isMore,
  });


  List<Order>? myOrder;
  bool? isMore;

  factory MyOrderData.fromJson(Map<String, dynamic> json) => MyOrderData(

    myOrder: List<Order>.from(json["myOrder"].map((x) => Order.fromJson(x))),
    isMore: json["is_more"],
  );


}

class Order {
  Order({
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
  });

  int? id;
  int? userId;
  int? total;
  int? vatPercent;
  int? vatAmount;
  dynamic appPercent;
  int? addressId;
  dynamic? appTotal;
  int? discount;
  int? deliveryCost;
  String? discountCode;
  int? subTotal;
  int? countItems;
  dynamic fcmToken;
  String? name;
  String? email;
  int? areaId;
  String? street;
  String? addressName;
  DateTime? availabileDate;
  String? availabileTime;
  dynamic? paymentJson;
  dynamic? paymentMethod;
  int? paymentStatus;
  int? status;
  DateTime? orderedDate;
  DateTime? createdAt;
  String? statusName;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
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
    availabileDate: json["availabile_date"] == null ? null : DateTime.parse(json["availabile_date"]),
    availabileTime: json["availabile_time"] == null ? null : json["availabile_time"],
    paymentJson: json["payment_json"],
    paymentMethod: json["payment_method"],
    paymentStatus: json["payment_status"],
    status: json["status"],
    orderedDate: DateTime.parse(json["ordered_date"]),
    createdAt: DateTime.parse(json["created_at"]),
    statusName: json["status_name"],
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
    "availabile_time": availabileTime == null ? null : availabileTime,
    "payment_json": paymentJson,
    "payment_method": paymentMethod,
    "payment_status": paymentStatus,
    "status": status,
    "status_name": statusName,
  };
}
