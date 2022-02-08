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

class CheckOutController {
  static CheckOutController? _instance;

  // ||.. private constructor ..||
  CheckOutController._();

  // ||.. singleton pattern ..||
  static CheckOutController? get instance {
    if (_instance != null) return _instance;
    return _instance = CheckOutController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

//   ||.. get categories ..||





  Future<BaseResponse> checkOut({ required Map<String,dynamic>data}) async {

    print('buyNow before22');
    late BaseResponse response;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('checkOut',data );
    print('buyNow  $jsonResponse');
    response=BaseResponse.fromJson(jsonResponse,dataKey:!AppShared.sharedPreferencesController.getIsLogin()?'user':null,
        urlData:jsonResponse['url'],
    );
    print('buyNow response ${response.toString()}');

    return response;
  }
  Future<BaseResponse> checkCode(String code) async {

    print('buyNow before22');
    late BaseResponse response;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('checkCode',{
      'code':code
    } );
    print('buyNow  $jsonResponse');
    response=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
    print('buyNow response ${response.toString()}');

    return response;
  }


}
