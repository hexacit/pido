import 'package:dio/dio.dart';

class EditProfileRequest {
  EditProfileRequest({

    this.image,
    this.day,
    this.month,
    this.year,
    this.postCode,
    this.regionId,
    this.zoneId,
    this.countryId,
    this.lastName,
    this.firstName,
    this.address1,
    this.address2,
    this.lat,
    this.long

  });

  String? firstName;
      String? lastName;
  int?countryId;
      int?regionId;
  int?zoneId;

      String? address1;
  String? address2;
      int?postCode;
  int?year;
      int?month;
  int?day;
      double?lat;
  double?long;
  MultipartFile? image;



  Map<String, dynamic> toJson() {

    Map<String, dynamic> data = {
        "first_name": firstName,
        "last_name": lastName,
        "country_id": countryId,
        "region_id": regionId,
      "zone_id": zoneId,
      "address_1": address1,
      "address_2": address2,
      "post_code": postCode,
      "dob_date": day,
      "dob_month": month,
      "dob_year": year,
      "latitude": lat,
      "longitude": long,


    };

    return data;
    
  }
}
