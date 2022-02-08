import 'dart:developer';

import 'package:pido/src/services/navigation_service.dart';
import 'package:pido/src/utils/appMethods.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:dio/dio.dart' as diopkg;

class ApiProvider {
  late diopkg.Dio dio;
  static ApiProvider? _instance;


  // ||.. private constructor ..||


  // ||.. singleton pattern ..||
  static ApiProvider? get instance {
    if (_instance != null) return _instance;
    return _instance = ApiProvider._();
  }
  ApiProvider._() {
    dio = diopkg.Dio(
      diopkg.BaseOptions(
        validateStatus: (status) {
          return true;
        },
        followRedirects: false,
        baseUrl: Constants.API_BASE_URL,
        connectTimeout: 30000,
        receiveTimeout: 30000,
      ),
    );
  }

  Future<Map<String, dynamic>> get(String endPoint) async {
   print('get token : ${AppShared.currentUser?.accessToken}');
   print('get user : ${AppShared.currentUser?.name}');
   print('url : $endPoint');
    try {
      final diopkg.Response response = await dio.get(
        endPoint,
        options: diopkg.Options(
          headers: {
            'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
            'Accept':'application/json',
           'Authorization': 'Bearer ${AppShared.currentUser?.accessToken}',
            'fcmToken': AppShared.firebaseToken,
            'type_mobile': '${AppShared.deviceType}',


          },
        ),
      );
      print(response.requestOptions.headers);
      print(response.data);

      final Map<String, dynamic> responseData = classifyResponse(response);
      return responseData;
    } on diopkg.DioError catch (err) {
      print(err.response);
      throw Exception("internetError");
    }
    on Exception catch (e) {
      print(e);
      throw e;
    }
  }

  Future<Map<String, dynamic>> post(String endPoint, Map<String, dynamic> body) async {
    try {
      print('post ');
      print('${AppShared.currentUser?.accessToken}');
      print(body);


      final diopkg.Response response = await dio.post(
        endPoint,
        data:diopkg.FormData.fromMap(body),
        options: diopkg.Options(
          headers: {
            'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
            'Accept':'application/json',
            'Authorization': 'Bearer ${AppShared.currentUser?.accessToken}',
            'fcmToken': '${AppShared.firebaseToken}',
            'type_mobile': '${AppShared.deviceType}',


          },
        ),
      );
      print(response.requestOptions.headers);
      print(response.data);
      final Map<String, dynamic> responseData = classifyResponse(response);
      return responseData;
    } on diopkg.DioError catch (err) {
      print(err);

      throw Exception("internetError");
    }
    on Exception catch (e) {
      print(e);
      throw e;
    }
  }

  Map<String, dynamic> classifyResponse(diopkg.Response response) {
    print('classifyResponse${response.data}');

    final Map<String, dynamic> responseData =response.data is String?
    decodeResponse(response.data)
    : response.data as Map<String, dynamic>;
    switch (response.data['code']) {
      // case 200:
      // case 201:
      // case 400:
      case 401:
        AppShared.sharedPreferencesController.clearUserData();
       // NavigationService.instance!.pushNamedAndRemoveUntil(Constants.SCREENS_SIGN_IN_SCREEN);
        return responseData;

        //throw Exception(responseData["Message"].toString());
     // case 500:
      default:
        return responseData;
        // throw Exception(
        //   'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
        // );
    }
  }
}