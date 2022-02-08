class AddAddressRequest {
  AddAddressRequest({
    this.cityId,
    this.address,
    this.latitude,
    this.longitude,
    this.areaId,
    this.code,
    this.homeNumber,
    this.searchScope,
  });

  int? cityId;
  String? homeNumber;
  int? areaId;
  String? code;
  String? latitude;
  String? longitude;
  double? searchScope;
  String? address;

  factory AddAddressRequest.fromJson(Map<String, dynamic> json) =>
      AddAddressRequest(
        cityId: json["city_id"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "home_number": homeNumber,
        "area_id": areaId,
        "code": code,
        "search_scope": searchScope,
        "latitude": latitude,
        "longitude": longitude,
        "address": address ?? '',
      };
}
