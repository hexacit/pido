

class NotificationItem {
  NotificationItem({
    this.id,
    this.userId,
    this.adminId,
    this.orderId,
    this.status,
    this.seen,
    this.createdAt,
    this.imageUser,
    this.nameUser,
    this.message,
    this.translations,
  });

  int? id;
  int? userId;
  int? adminId;
  int? orderId;
  String? status;
  int? seen;
  DateTime? createdAt;
  String? imageUser;
  String? nameUser;
  String? message;
  List<Translation>? translations;

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
    id: json["id"],
    userId: json["user_id"],
    adminId: json["admin_id"],
    orderId: json["order_id"],
    status: json["status"],
    seen: json["seen"],
    createdAt: DateTime.parse(json["created_at"]),
    imageUser: json["image_user"],
    nameUser: json["name_user"],
    message: json["message"],
    translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "admin_id": adminId,
    "order_id": orderId,
    "status": status,
    "seen": seen,
    "image_user": imageUser,
    "name_user": nameUser,
    "message": message,
  };
}

class Translation {
  Translation({
    this.id,
    this.notifiyId,
    this.locale,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  int? notifiyId;
  String? locale;
  String? message;
  DateTime? createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    id: json["id"],
    notifiyId: json["notifiy_id"],
    locale: json["locale"],
    message: json["message"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "notifiy_id": notifiyId,
    "locale": locale,
    "message": message,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}
