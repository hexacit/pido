import 'package:pido/src/models/api_models/responses/location_response.dart';
import 'package:pido/src/services/dio_service.dart';
import 'package:dio/dio.dart';
import '../../models/api_models/base_response.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';

class UserController {
  static UserController? _instance;

  // ||.. private constructor ..||
  UserController._();

  // ||.. singleton pattern ..||
  static UserController? get instance {
    if (_instance != null) return _instance;
    return _instance = UserController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

// ||.. send contact ..||
  Future<BaseResponse> sendContact({
    String? name,
    String? email,
    String? message,
  }) async {
    print('sendContact before22');
    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('contactUs',{
      'name':name,
      'email':email,
      'message':message,

    } );
    print('sendContact $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,);
    print('sendContact ${baseResponse.toString()}');

    return baseResponse;
  }

  Future<BaseResponse> addAddress({
  String? addressName,
  int? areaId,
  String? streetName,
  double? lat,
  double? long,
  bool? isDefault,
}) async {

    print('addAddress before22');
    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('addAddress',{
      'address_name':addressName,
      'area_id':areaId,
      'street':streetName,
      'longitude':long,
      'latitude':lat,
      'defult':isDefault!?1:0,
    } );
    print('getUserBids $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'items');
    print('addAddress ${baseResponse.toString()}');

    return baseResponse;
  }
  Future<BaseResponse> editAddress({
    int? addressId,

    String? addressName,
    int? areaId,
    String? streetName,
    double? lat,
    double? long,
    bool? isDefault,
  }) async {

    print('addAddress before22');
    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('editAddress/$addressId',{
      'address_name':addressName,
      'area_id':areaId,
      'street':streetName,
      'longitude':long,
      'latitude':lat,
      'defult':isDefault!?1:0,
    } );
    print('getUserBids $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'address');
    print('addAddress ${baseResponse.toString()}');

    return baseResponse;
  }
  // ||.. edit profile method ..||
  Future<BaseResponse> deleteAddress({

    int? addressId,

  }) async {

    print('deleteAddress before22');
    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('deleteAddress/$addressId',
    );
    print('deleteAddress $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
    print('deleteAddress ${baseResponse.toString()}');

    return baseResponse;
  }
  Future<BaseResponse> addRemoveFromFavorite({

    int? productId,

  }) async {

    print('deleteAddress before22');
    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('addAndRemoveFromFavorite/$productId',
    );
    print('deleteAddress $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
    print('deleteAddress ${baseResponse.toString()}');

    return baseResponse;
  }

  Future<BaseResponse> changeLanguage({

    String? lang,

  }) async {

    print('deleteAddress before22');
    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('changeLanguge',{
      'lang':lang,
      'fcmToken': '${AppShared.firebaseToken}',
      'type_mobile': '${AppShared.deviceType}',
    }
    );
    print('deleteAddress $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,);
    print('deleteAddress ${baseResponse.toString()}');

    return baseResponse;
  }
  Future<BaseResponse> receiveNotification({

    int? status,

  }) async {

    print('receiveNotification before22');
    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('receiveNotification',{
      'status':status,

    }
    );
    print('receiveNotification $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,);
    print('receiveNotification ${baseResponse.toString()}');

    return baseResponse;
  }


  Future<BaseResponse> editProfile({
    String? name,
    String? email,
    String? mobile,
    MultipartFile? image,
  }) async {

final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('editProfile',{
      'name':name,
      'email':email,
      'mobile':mobile,
      'image_profile':image,
    });


    print(jsonResponse);
    BaseResponse baseResponse = BaseResponse.fromJson(jsonResponse,dataKey: 'user');


  

  
    return baseResponse;
  }



// get my addresses.
  Future<BaseResponse> getMyAddresses({int page=1}) async {
    print('before getMyAddresses');
    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('getMyAddresses?page=$page',);


    print(jsonResponse);
    BaseResponse baseResponse = BaseResponse.fromJson(jsonResponse,
       // dataKey: 'items'
      data: {
        'items':jsonResponse['items'],
        'is_more':jsonResponse['is_more'],
      },
    );


    print('after getMyAddresses');
    print(jsonResponse);



    return baseResponse;
  }
  Future<BaseResponse> getMyNotifications({int page=1}) async {
    print('before myNotifications');
    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('myNotifications?page=$page',);


    print(jsonResponse);
    BaseResponse baseResponse = BaseResponse.fromJson(jsonResponse,
      //  dataKey: 'items'
    data : {

        'items':jsonResponse['items'],
        'is_more':jsonResponse['is_more'],
      },
    );


    print('after myNotifications');
    print(jsonResponse);



    return baseResponse;
  }


  Future<BaseResponse> getProfile({int? categoryId,}) async {

    print('getProductsByCategoryId before22');
    late BaseResponse userProfileResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('secure/user-profile', );
    print('user-profile $jsonResponse');
    userProfileResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
    print('user-profile ${userProfileResponse.toString()}');

    return userProfileResponse;
  }
  Future<BaseResponse> getUserOrders() async {

    print('orders before22');
    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('secure/orders' );
    print('orders  $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
    print('orders response ${baseResponse.toString()}');

    return baseResponse;
  }

  Future<BaseResponse> getUserBids() async {

    print('getUserBids before22');
    late BaseResponse userProfileResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('secure/my-bids', {});
    print('getUserBids $jsonResponse');
    userProfileResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
    print('getUserBids ${userProfileResponse.toString()}');

    return userProfileResponse;
  }
  Future<BaseResponse> getUserOffers() async {

    print('getUserBids before22');
    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('secure/products-offer', );
    print('getUserBids $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
    print('getUserBids ${baseResponse.toString()}');

    return baseResponse;
  }
  Future<BaseResponse> getUserFavorites({int page=1}) async {

    print('getMyFavorite before22');
    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('getMyFavorite?page=$page&fcm_token=${AppShared.firebaseToken}', );
    print('getMyFavorite $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,
      //dataKey: 'items',
    data: {
      'items':jsonResponse['items'],
      'is_more':jsonResponse['is_more'],
    },
    );
    print('getMyFavorite ${baseResponse.toString()}');

    return baseResponse;
  }

  Future<BaseResponse> getUserInvoice() async {

    print('invoices before22');
    late BaseResponse baseResponse;

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('secure/invoices' );
    print('invoices  $jsonResponse');
    baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');
    print('invoices response ${baseResponse.toString()}');

    return baseResponse;
  }

  Future<LocationResponse> getLocationDataFromLatAndLong(
      double lat, double long) async {
    LocationResponse locationResponse;
    try {
      Response response = await AppShared.dio.get(
          '${Constants.API_LAT_AND_LONG_TO_ADDRESS}latitude=$lat&longitude=$long&localityLanguage=${AppShared.sharedPreferencesController.getAppLang()}');
      print(response.data);

      locationResponse = LocationResponse.fromJson(response.data);
      print(locationResponse);
    }on Exception catch (error) {
      throw error;
    }
    return locationResponse;
  }

}
