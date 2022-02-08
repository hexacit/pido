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

class OrdersController {
  static OrdersController? _instance;

  // ||.. private constructor ..||
  OrdersController._();

  // ||.. singleton pattern ..||
  static OrdersController? get instance {
    if (_instance != null) return _instance;
    return _instance = OrdersController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  Future<BaseResponse> getMyOrders({int status=-1,int page=1}) async {

    print('getUserBids before22');
    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('getMyOrders?status=$status&page=$page', );
    print('getUserBids $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,data: {
      'myOrder':jsonResponse['myOrder'],
      'is_more':jsonResponse['is_more'],
    });
    print('getUserBids ${baseResponse.toString()}');

    return baseResponse;
  }
  Future<BaseResponse> getOrderDetails(orderId) async {

    print('getUserBids before22');
    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('getOrderDetail/$orderId', );
    print('getUserBids $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'Order_Details');
    print('getUserBids ${baseResponse.toString()}');

    return baseResponse;
  }


}
