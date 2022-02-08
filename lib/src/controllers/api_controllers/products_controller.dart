import 'dart:developer';
import 'dart:io';

import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/api_models/responses/category_products_response.dart';
import 'package:pido/src/models/api_models/responses/nav_categories_response.dart';
import 'package:pido/src/models/api_models/responses/product_details_response.dart';
import 'package:pido/src/models/api_models/responses/subcategories_response.dart';
import 'package:pido/src/models/sub_models/exception.dart';
import 'package:pido/src/services/dio_service.dart';
import 'package:dio/dio.dart' as dio;
import '../../models/api_models/responses/categories_response.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';

class ProductsController {
  static ProductsController? _instance;

  // ||.. private constructor ..||
  ProductsController._();

  // ||.. singleton pattern ..||
  static ProductsController? get instance {
    if (_instance != null) return _instance;
    return _instance = ProductsController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

//   ||.. get categories ..||

  Future<BaseResponse> getProductAttributesByCategoryId({int? categoryId,}) async {

    print('attributes before22 $categoryId');
    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =

    await ApiProvider.instance!.post('seller/product/product-attributes', {
      'category_id':categoryId,
    });
    print('attributes controler $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
    print('attributes response ${baseResponse.toString()}');

    return baseResponse;
  }
  Future<BaseResponse> uploadImages(int productId,List<dio.MultipartFile> images,) async {
    print(images.toString());

    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =

    await ApiProvider.instance!.post('seller/product/photo-add', {
      'files[]':images.toList(),
      'product_id':productId,
    });
    print('attributes controler $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
    print('attributes response ${baseResponse.toString()}');

    return baseResponse;
  }

  Future<BaseResponse> getProductsByCategoryId({int? categoryId,Map<String,dynamic>?attributes}) async {

            print('getProductsByCategoryId before22');
           late BaseResponse categoryProductsResponse;
            Map<String,dynamic>?data={
              'category_id':categoryId,
            };
            if(attributes!=null&&attributes.isNotEmpty){
              data.addAll(attributes);
            }
            final Map<String, dynamic> jsonResponse =


            await ApiProvider.instance!.post('secure/products-list',data );
            print('getProductsByCategoryId controler $jsonResponse');
            categoryProductsResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
            print('getProductsByCategoryId response ${categoryProductsResponse.toString()}');

  return categoryProductsResponse;
  }
  Future<BaseResponse> getProducts({int categoryId=0,page=1}) async {

    print('getProducts before22');
    late BaseResponse response;

    String url=categoryId==0?'getProducts':'getProducts?category_id=$categoryId&page=$page';
print('controller $url');
    final Map<String, dynamic> jsonResponse =

    await ApiProvider.instance!.get(url);
    print('getProducts controler $jsonResponse');
    response=BaseResponse.fromJson(jsonResponse,dataKey: categoryId==0?'items': null,
    data:categoryId==0?null: {
      "is_more": jsonResponse['is_more'],
      "items": jsonResponse['items'],
    }
    );
    print('getProducts response ${response.toString()}');

    return response;
  }
  Future<BaseResponse> getFilteredProducts(
  {
  int? categoryId,
    int? ageId,
    int? gender,
    String? search,
    int? page=1,
}
      ) async {

    print('getFilteredProducts before22');
    late BaseResponse response;


    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('filter?page=$page&age=${ageId??''}&category=${categoryId??''}&gender=${gender??''}&search=${search??''}' );
    print('getFilteredProducts controler $jsonResponse');
    response=BaseResponse.fromJson(jsonResponse,dataKey: 'items',
    data: {
      'items':jsonResponse['items'],
      'is_more':jsonResponse['is_more'],
    }
    );
    print('getFilteredProducts response ${response.toString()}');

    return response;
  }

  Future<BaseResponse> createProduct({
   required   int productId,
    required   String title,
    required   String subTitle,
    required   String description,
    required   int regionId,
    required   int zoneId,
    required   int estimateRevenue,
    required   int buyPrice,
    required   int isBuyRequired,
    required   int isAuction,
    required   double latitude,
    required   double longitude,
    required   String address,
    required   String startDate,
    required   String endDate,
    required   String startTime,
    required   String endTime,
    required   int isPickupRequired,
    required   int isShipmentPromo,
    required   int isFreeHomeCountry,
    required   int isZoneFreeRestOfCountry,
    required   String homeCountry,
    required   int zonePrice,
    required    Map<String,dynamic>items,


  }
      ) async {

    Map<String,dynamic>data={
      'product_id':productId,
      'title':title,
      'subtitle':title,
      'description':description,
      'region_id':regionId,
      'country_zone_id':zoneId,
      'estimate_revenue':estimateRevenue,
      'buy_price':buyPrice,
      'is_buy_required':isBuyRequired==1?'yes':'no',
      'is_auction_status':isAuction==1?'yes':'no',
      'latitude':latitude,
      'longitude':longitude,
      'address_1':address,
      'bid_start_date':startDate,
      'bid_end_date':endDate,
      'bid_start_time':startTime,
      'bid_end_time':endTime,
      'is_pickup_required':isPickupRequired==1?'yes':'no',
      'is_shipping_promo':isShipmentPromo==1?'yes':'no',
      'is_free_home_country':isFreeHomeCountry==1?'yes':'no',
      'is_zone_free_rest_of_country':isZoneFreeRestOfCountry==1?'yes':'no',
      'home_country':homeCountry,
      'zone_price':zonePrice,


    };
    if(items.isNotEmpty){
      data.addAll(items);
    }
    late BaseResponse baseResponse;
    print(data);

    final Map<String, dynamic> jsonResponse =

    await ApiProvider.instance!.post('seller/product/product-add-step-1',data);
    print('attributes controler $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
    print('attributes response ${baseResponse.toString()}');

    return baseResponse;
  }

  Future<BaseResponse> submitProduct({
    required   int productId,

  }
      ) async {

    late BaseResponse baseResponse;


    final Map<String, dynamic> jsonResponse =

    await ApiProvider.instance!.post('seller/product/product-add-final',{
      'product_id':productId,
    });
    print('attributes controler $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
    print('attributes response ${baseResponse.toString()}');

    return baseResponse;
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

  Future<BaseResponse> getProductDetailsById({int? productId,}) async {

    print('getProductDetailsById before22');
    late BaseResponse productDetailsResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('getProductDetails/$productId', );
    print('getProductDetailsById  $jsonResponse');
    productDetailsResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'item');
    print('getProductDetailsById response ${productDetailsResponse.toString()}');

    return productDetailsResponse;
  }
  Future<BaseResponse> addAndRemoveFromFavorite({int? productId,}) async {

    print('getProductDetailsById before22');
    late BaseResponse productDetailsResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('addAndRemoveFromFavorite/$productId?fcm_token=${AppShared.firebaseToken}',
    );
    print('getProductDetailsById  $jsonResponse');
    productDetailsResponse=BaseResponse.fromJson(jsonResponse,);
    print('getProductDetailsById response ${productDetailsResponse.toString()}');

    return productDetailsResponse;
  }

  Future<BaseResponse> changeProductQuantity({int? productId,int? type}) async {

    print('getProductDetailsById before22');
    late BaseResponse productDetailsResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('changeQuantity/$productId', {
      'type':type,
      'fcm_token':AppShared.firebaseToken,
    });
    print('getProductDetailsById  $jsonResponse');
    productDetailsResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
    print('getProductDetailsById response ${productDetailsResponse.toString()}');

    return productDetailsResponse;
  }
  Future<BaseResponse> deleteCartItem({int? productId,int? type}) async {

    print('getProductDetailsById before22');
    late BaseResponse productDetailsResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('deleteProductCart/$productId', );
    print('getProductDetailsById  $jsonResponse');
    productDetailsResponse=BaseResponse.fromJson(jsonResponse);
    print('getProductDetailsById response ${productDetailsResponse.toString()}');

    return productDetailsResponse;
  }


}
