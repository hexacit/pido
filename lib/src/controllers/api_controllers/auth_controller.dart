
import 'package:pido/src/models/api_models/requests/sign_up_request.dart';
import 'package:pido/src/models/sub_models/exception.dart';
import 'package:pido/src/models/sub_models/user.dart';
import 'package:pido/src/services/dio_service.dart';
import 'package:dio/dio.dart' as dio;
import '../../models/api_models/base_response.dart';
import '../../models/api_models/requests/sign_in_request.dart';
import '../../models/api_models/requests/verify_mobile_request.dart';
import '../../models/api_models/responses/user_response.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import 'dart:io';

class AuthController {
  static AuthController? _instance;

  // ||.. private constructor ..||
  AuthController._();

  // ||.. singleton pattern ..||
  static AuthController? get instance {
    if (_instance != null) return _instance;
    return _instance = AuthController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

// ||.. sign in method ..||
  Future<BaseResponse> signIn({
    String? email,
    String? password,

  }) async {

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('login',{
      'email':email,
      'password':password,
      'fcmToken':AppShared.firebaseToken,
      'type_mobile':AppShared.deviceType,

    });


    
    print(jsonResponse);
    BaseResponse baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'user');
    if (baseResponse.status! ) {

       await AppShared.sharedPreferencesController.setIsLogin(true);
       User? user = User.fromJson(baseResponse.data);
       await AppShared.sharedPreferencesController
           .setUserData(user);
       AppShared.currentUser=user;
    }

    // }

    return baseResponse;
  }
  Future<BaseResponse> signUp({
    String? mobile,
    String? password,
    String? email,
    String? name,


  }) async {
    SignUpRequest signUpRequest = SignUpRequest(
      deviceType: AppShared.deviceType,
      mobile: mobile,
      password: password,
      fcmToken: AppShared.firebaseToken,
      email: email,
      name: name,
    );
    print(signUpRequest.toJson());
    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('secure/signup', signUpRequest.toJson());



    print(jsonResponse);
    BaseResponse baseResponse=BaseResponse.fromJson(jsonResponse);
    // UserResponse? userResponse = UserResponse.fromJson(response.data);
    if (baseResponse.status! ) {
      print('access ${AppShared.accessToken}');
      AppShared.accessToken = jsonResponse['access_token'];
      print('access ${AppShared.accessToken}');

      // await AppShared.sharedPreferencesController.setIsLogin(true);
      // await AppShared.sharedPreferencesController
      //     .setAccessToken( AppShared.accessToken!);
    }

    return baseResponse;
  }

  //  forgot password.
  Future<BaseResponse> forgotPassword({
    String? email,
  }) async {
    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('forgotPassword',{
      'email':email,


    });



    print(jsonResponse);
    BaseResponse baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');

    return baseResponse;
  }

  //  logout.
  Future<BaseResponse> logout() async {
    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.get('logout',);



    print(jsonResponse);
    BaseResponse baseResponse=BaseResponse.fromJson(jsonResponse);
    if (baseResponse.status!) {
     await AppShared.sharedPreferencesController.clearUserData();
    }
    return baseResponse;
  }


  //  request new Code .
  Future<BaseResponse> sendCode(
  ) async {



    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('secure/send-mobile-otp', {});



    print(jsonResponse);
    // BaseResponse baseResponse=BaseResponse.fromJson(jsonResponse);
    //     dio.Response response = await AppShared.dio.post(
    //   '${Constants.API_BASE_URL}send-mobile-otp',
    //   options: dio.Options(
    //     headers: {
    //       'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
    //       'Accept':'application/json',
    //       'Authorization': '${AppShared.accessToken}',
    //
    //
    //     },
    //   ),
    // );
        //print(response.data);
   // BaseResponse baseResponse = BaseResponse.fromJson(response.data);




    BaseResponse baseResponse = BaseResponse.fromJson(jsonResponse);
    print(baseResponse);
    return baseResponse;
  }

  // ||.. verify mobile ..||
  Future<BaseResponse> verifyMobile({

    String? code,
  }) async {

    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('secure/verify-mobile', {
      'mobile_otp':code,
    });


    print(jsonResponse);
    BaseResponse baseResponse = BaseResponse.fromJson(jsonResponse);
    print(baseResponse);
    if(baseResponse.status!){
      AppShared.accessToken = jsonResponse['access_token'];
      print('access ${AppShared.accessToken}');

      await AppShared.sharedPreferencesController.setIsLogin(true);
      await AppShared.sharedPreferencesController
          .setAccessToken( AppShared.accessToken!);
    }

    // UserResponse userResponse = UserResponse.fromJson(response.data);
    //  if(userResponse.code==202)
    // throw ApiException(userResponse.message!, 202);
    // if (userResponse.status! && userResponse.user != null) {
    //   AppShared.currentUser = userResponse.user;
    //   await AppShared.sharedPreferencesController.setIsLogin(true);
    //   await AppShared.sharedPreferencesController
    //       .setUserData(userResponse.user);
    // }
    return baseResponse;
  }

  Future<BaseResponse> changePassword({
    String? oldPassword,
    String? newPassword,
    String? confirmNewPassword,
  }) async {
    final Map<String, dynamic> jsonResponse =


    await ApiProvider.instance!.post('changePassword',{
      'old_password':oldPassword,
      'password':newPassword,
      'confirm_password':confirmNewPassword,


    });



    print(jsonResponse);
    BaseResponse baseResponse=BaseResponse.fromJson(jsonResponse,dataKey: 'data');

    return baseResponse;
  }
}
