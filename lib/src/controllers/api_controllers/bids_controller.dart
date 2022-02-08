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

class BidsController {
  static BidsController? _instance;

  // ||.. private constructor ..||
  BidsController._();

  // ||.. singleton pattern ..||
  static BidsController? get instance {
    if (_instance != null) return _instance;
    return _instance = BidsController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

//   ||.. get categories ..||


  Future<BaseResponse> addBid({required int productId,required String bid}) async {

    print('getProductDetailsById before22');
    late BaseResponse response;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('secure/bid-add', {
      'product_id':productId,
      'price':bid,

    });
    print('getProductDetailsById  $jsonResponse');
    response=BaseResponse.fromJson(jsonResponse);
    print('getProductDetailsById response ${response.toString()}');

    return response;
  }
  Future<BaseResponse> updateBid({required int productId}) async {

    print('getProductDetailsById before22');
    late BaseResponse response;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('secure/bids-update', {
      'id':productId,


    });
    print('getProductDetailsById  $jsonResponse');
    response=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
    print('getProductDetailsById response ${response.toString()}');

    return response;
  }


}
