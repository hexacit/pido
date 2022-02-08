
class Settings {
  Settings({
    this.id,
    this.url,
    this.logo,
    this.taxAmount,
    this.appPercent,
    this.pointsInMony,
    this.monyInPoints,
    this.appStoreUrl,
    this.playStoreUrl,
    this.infoEmail,
    this.mobile,
    this.phone,
    this.paginate,
    this.facebook,
    this.twitter,
    this.linkedIn,
    this.instagram,
    this.tikTok,
    this.minOrder,
    this.fromHour,
    this.toHour,
    this.address,
    this.latitude,
    this.longitude,
    this.youtube,
    this.image,
    this.isMaintenanceMode,
    this.isAlowedLogin,
    this.isAlowedRegister,
    this.isAlowedBuying,
    this.isAlowedCart,
    this.cancelOrderTime,
    this.deliveryCostPerKm,
    this.productDistance,
    this.createdAt,
    this.updatedAt,
    this.seoInBody,
    this.seoInHeader,
    this.title,
    this.description,
  });

  int? id;
  String? url;
  String? logo;
  int? taxAmount;
  int? appPercent;
  int? pointsInMony;
  int? monyInPoints;
  String? appStoreUrl;
  String? playStoreUrl;
  String? infoEmail;
  String? mobile;
  String? phone;
  int? paginate;
  String? facebook;
  String? twitter;
  String? linkedIn;
  String? instagram;
  String? tikTok;
  int? minOrder;
  String? fromHour;
  String? toHour;
  String? address;
  String? latitude;
  String? longitude;
  String? youtube;
  String? image;
  int? isMaintenanceMode;
  int? isAlowedLogin;
  int? isAlowedRegister;
  int? isAlowedBuying;
  int? isAlowedCart;
  int? cancelOrderTime;
  int? deliveryCostPerKm;
  int? productDistance;
  dynamic createdAt;
  DateTime? updatedAt;
  String? seoInBody;
  String? seoInHeader;
  String? title;
  String? description;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    id: json["id"],
    url: json["url"],
    logo: json["logo"],
    taxAmount: json["tax_amount"],
    appPercent: json["app_percent"],
    pointsInMony: json["points_in_mony"],
    monyInPoints: json["mony_in_points"],
    appStoreUrl: json["app_store_url"],
    playStoreUrl: json["play_store_url"],
    infoEmail: json["info_email"],
    mobile: json["mobile"],
    phone: json["phone"],
    paginate: json["paginate"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    linkedIn: json["linked_in"],
    instagram: json["instagram"],
    tikTok: json["tik_tok"],
    minOrder: json["min_order"],
    fromHour: json["from_hour"],
    toHour: json["to_hour"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    youtube: json["youtube"],
    image: json["image"],
    isMaintenanceMode: json["is_maintenance_mode"],
    isAlowedLogin: json["is_alowed_login"],
    isAlowedRegister: json["is_alowed_register"],
    isAlowedBuying: json["is_alowed_buying"],
    isAlowedCart: json["is_alowed_cart"],
    cancelOrderTime: json["cancel_order_time"],
    deliveryCostPerKm: json["delivery_cost_per_km"],
    productDistance: json["product_distance"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    seoInBody: json["seo_in_body"],
    seoInHeader: json["seo_in_header"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "logo": logo,
    "tax_amount": taxAmount,
    "app_percent": appPercent,
    "points_in_mony": pointsInMony,
    "mony_in_points": monyInPoints,
    "app_store_url": appStoreUrl,
    "play_store_url": playStoreUrl,
    "info_email": infoEmail,
    "mobile": mobile,
    "phone": phone,
    "paginate": paginate,
    "facebook": facebook,
    "twitter": twitter,
    "linked_in": linkedIn,
    "instagram": instagram,
    "tik_tok": tikTok,
    "min_order": minOrder,
    "from_hour": fromHour,
    "to_hour": toHour,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "youtube": youtube,
    "image": image,
    "is_maintenance_mode": isMaintenanceMode,
    "is_alowed_login": isAlowedLogin,
    "is_alowed_register": isAlowedRegister,
    "is_alowed_buying": isAlowedBuying,
    "is_alowed_cart": isAlowedCart,
    "cancel_order_time": cancelOrderTime,
    "delivery_cost_per_km": deliveryCostPerKm,
    "product_distance": productDistance,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
    "seo_in_body": seoInBody,
    "seo_in_header": seoInHeader,
    "title": title,
    "description": description,
  };
}