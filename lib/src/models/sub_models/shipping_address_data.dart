
import 'package:pido/src/models/sub_models/address.dart';

class ShippingAddressData {
  ShippingAddressData({
    this.results,
    this.isMore,
  });


List<Address>? results;
bool? isMore;

  factory ShippingAddressData.fromJson(Map<String, dynamic> json) => ShippingAddressData(
    results: List<Address>.from(json["items"].map((x) => Address.fromJson(x))),
    isMore: json["is_more"],
  );

}
