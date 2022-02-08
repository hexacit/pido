import 'dart:convert';
class CheckOutData {
  CheckOutData({
    this.countryId,
    this.zoneId,
    this.regionId,
    this.productId,
    this.firstName,
    this.lastName,
    this.email,
    this.cell,
    this.address1,
    this.postCode,
    this.countriesMenu,
    this.regionsMenu,
    this.shipping,
    this.shippingCost,
    this.buyPrice,
    this.totalAmount,
    this.currency,
  });

  String? countryId;
  String? zoneId;
  String? regionId;
  String? productId;
  String? firstName;
  String? lastName;
  String? email;
  String? cell;
  String? address1;
  String? postCode;
  List<SMenu>? countriesMenu;
  List<SMenu>? regionsMenu;
  List<Shipping>? shipping;
  String? shippingCost;
  String? buyPrice;
  String? totalAmount;
  String? currency;

  factory CheckOutData.fromJson(Map<String, dynamic> json) => CheckOutData(
    countryId: json["country_id"],
    zoneId: json["zone_id"],
    regionId: json["region_id"],
    productId: json["product_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    cell: json["cell"],
    address1: json["address_1"],
    postCode: json["post_code"],
    countriesMenu: List<SMenu>.from(json["countries_menu"].map((x) => SMenu.fromJson(x))),
    regionsMenu: List<SMenu>.from(json["regions_menu"].map((x) => SMenu.fromJson(x))),
    shipping: List<Shipping>.from(json["shipping"].map((x) => Shipping.fromJson(x))),
    shippingCost: json["shipping_cost"],
    buyPrice: json["buy_price"],
    totalAmount: json["total_amount"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "country_id": countryId,
    "zone_id": zoneId,
    "region_id": regionId,
    "product_id": productId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "cell": cell,
    "address_1": address1,
    "post_code": postCode,
    "countries_menu": List<dynamic>.from(countriesMenu!.map((x) => x.toJson())),
    "regions_menu": List<dynamic>.from(regionsMenu!.map((x) => x.toJson())),
    "shipping": List<dynamic>.from(shipping!.map((x) => x.toJson())),
    "shipping_cost": shippingCost,
    "buy_price": buyPrice,
    "total_amount": totalAmount,
    "currency": currency,
  };
}

class SMenu {
  SMenu({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory SMenu.fromJson(Map<String, dynamic> json) => SMenu(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Shipping {
  Shipping({
    this.clientProductShippingId,
    this.clientUserId,
    this.productId,
    this.countryId,
    this.zoneId,
    this.cityId,
    this.isHomeCountry,
    this.price,
    this.isFree,
    this.zonePrice,
    this.isZoneFree,
  });

  String? clientProductShippingId;
  String? clientUserId;
  String? productId;
  String? countryId;
  String? zoneId;
  String? cityId;
  int? isHomeCountry;
  String? price;
  int? isFree;
  String? zonePrice;
  int? isZoneFree;

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    clientProductShippingId: json["client_product_shipping_id"],
    clientUserId: json["client_user_id"],
    productId: json["product_id"],
    countryId: json["country_id"],
    zoneId: json["zone_id"],
    cityId: json["city_id"],
    isHomeCountry: json["is_home_country"],
    price: json["price"],
    isFree: json["is_free"],
    zonePrice: json["zone_price"],
    isZoneFree: json["is_zone_free"],
  );

  Map<String, dynamic> toJson() => {
    "client_product_shipping_id": clientProductShippingId,
    "client_user_id": clientUserId,
    "product_id": productId,
    "country_id": countryId,
    "zone_id": zoneId,
    "city_id": cityId,
    "is_home_country": isHomeCountry,
    "price": price,
    "is_free": isFree,
    "zone_price": zonePrice,
    "is_zone_free": isZoneFree,
  };
}