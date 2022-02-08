import 'dart:developer';

import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/api_models/responses/nav_categories_response.dart';
import 'package:pido/src/models/api_models/responses/subcategories_response.dart';
import 'package:pido/src/models/sub_models/exception.dart';
import 'package:pido/src/services/dio_service.dart';
import 'package:dio/dio.dart';
import '../../models/api_models/responses/categories_response.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';

class CategoriesController {
  static CategoriesController? _instance;

  // ||.. private constructor ..||
  CategoriesController._();

  // ||.. singleton pattern ..||
  static CategoriesController? get instance {
    if (_instance != null) return _instance;
    return _instance = CategoriesController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

//   ||.. get categories ..||
  Future<BaseResponse> getCategories() async {

            print('before22');
           late BaseResponse categoriesResponse;

            final Map<String, dynamic> jsonResponse =


            await ApiProvider.instance!.get('getCategories', );
            print('category controler $jsonResponse');
            categoriesResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'items');
            print('category response ${categoriesResponse.toString()}');

  return categoriesResponse;
  }



  Future<NavCategoriesResponse> getNavCategories({int? page,String?text}) async {

    print('getNavCategories');
    late NavCategoriesResponse categoriesResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('header-categories', );
    print('getNavCategories controler $jsonResponse');
    categoriesResponse=NavCategoriesResponse.fromJson(jsonResponse);
    print('category response ${categoriesResponse.toString()}');

    return categoriesResponse;
  }



  





}
