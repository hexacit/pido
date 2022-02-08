class CreateServiceRequest {
  CreateServiceRequest({
    this.categoryId,
    this.subCategoryId,
    this.ageCategoriesId,
    this.gender,
    this.time,
    this.educationEnviroment,
    this.mobile,
    this.phone,
    this.email,
    this.cityId,
    this.latitude,
    this.longetude,
    this.title,
    this.description,
    this.imagesNames,
    this.customCategoryName,
    this.customSubCategoryName,
    this.serviceStatus,
    this.addressName,
  });
  int? categoryId;
  int? subCategoryId;
  List<int>? ageCategoriesId;
  int? gender;
  int? time;
  int? educationEnviroment;
        int? serviceStatus;

  String? email;
  String? mobile;
  String? phone;
  int? cityId;
  double? latitude;
  double? longetude;

  String? title;
  String? description;

  List<String>? imagesNames;
  String? customCategoryName;
  String? customSubCategoryName;
              String? addressName;

  factory CreateServiceRequest.fromJson(Map<String, dynamic> json) =>
      CreateServiceRequest(
        cityId: json["city_id"],
      );
  Map<String, dynamic> toJson() {
    String images = imagesNames!.toList().toString();
    // if (imagesNames!.isNotEmpty) {
    //   images = imagesNames!.map((e) => '$images$e').toList().toString();
    // }
print('imagesNames ${imagesNames!.toList().toString()}');

// print('ageCategoriesIdtoList${ageCategoriesId!.toList().toString()}');
//     Map<String, int> ages = {
//       for (int i = 0; i <= ageCategoriesId!.length - 1; i++)
//         'age_category_id[$i]': ageCategoriesId![i]
//     };
    String ages= ageCategoriesId!.toList().toString();
    print('imgs from request ${images.substring(1,images.length-1).replaceAll(' ', '')}');
    Map<String, dynamic> data = {
      "category_id": categoryId,
      "sub_category_id": subCategoryId,
      "gender": gender,
      "time": time,
      "education_environment": educationEnviroment,
      "mobile": mobile,
      "phone": phone,
      "email": email,
      "city_id": cityId,
      "latitude": latitude,
      "longitude": longetude,
      "address": addressName,
      "name_ar": title,
      "name_en": title,
      "description_ar": description,
      "description_en": description,
      "newCategortyName": customCategoryName,
      "newSubCategortyName": customSubCategoryName,
      "images": images.substring(1,images.length-1).replaceAll(' ', ''),
      "status": serviceStatus,
      "age_category_id": ages.substring(1,ages.length-1),
    };
 

    return data;
  }
}
