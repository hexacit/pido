import 'dart:developer';

import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/api_models/responses/category_products_response.dart';
import 'package:pido/src/models/api_models/responses/nav_categories_response.dart';
import 'package:pido/src/models/api_models/responses/product_details_response.dart';
import 'package:pido/src/models/api_models/responses/subcategories_response.dart';
import 'package:pido/src/models/sub_models/exception.dart';
import 'package:pido/src/services/dio_service.dart';
import 'package:dio/dio.dart';
import '../../models/api_models/responses/categories_response.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';

class CartController {
  static CartController? _instance;

  // ||.. private constructor ..||
  CartController._();

  // ||.. singleton pattern ..||
  static CartController? get instance {
    if (_instance != null) return _instance;
    return _instance = CartController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------


  Future<BaseResponse> addToCart({
    required int productId,
    required   int quantity,

  }) async {

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('addProductToCart',{
      'product_id':productId,
      'quantity':quantity,
      'fcm_token':AppShared.firebaseToken,

    });


    print(jsonResponse);
    BaseResponse baseResponse = BaseResponse.fromJson(jsonResponse);





    return baseResponse;
  }



  Future<BaseResponse> getMyCart({int? areaId,int? addressId,String? code}) async {

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('getMyCart',{
      'fcm_token':AppShared.firebaseToken,
      'address_id':addressId,
      'area_id':areaId,
      'code':code,
    });


    print(jsonResponse);
    BaseResponse baseResponse = BaseResponse.fromJson(jsonResponse,dataKey: 'data');





    return baseResponse;
  }




}
