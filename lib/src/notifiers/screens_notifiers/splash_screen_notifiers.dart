import 'dart:io';

import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/sub_models/exception.dart';
import 'package:pido/src/models/sub_models/settings.dart';
import 'package:pido/src/utils/appMethods.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/api_controllers/configs_controller.dart';
import '../../notifiers/app_notifiers.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class SplashScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||

  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
 late ConfigsController? configsController;
  AppNotifiers? appNotifiers;

  // ||... constructor ...||
  SplashScreenNotifiers(this.context) {

    configsController = ConfigsController.instance;

    appNotifiers = Provider.of<AppNotifiers>(context, listen: false);

  }

// ||...................... logic methods ............................||

// init.
  void init() async {
     //  context.locale = Locale('ar', 'SA');

    AppShared.dio = Dio();

    AppShared.deviceType = Platform.isAndroid ?Constants. DEVICE_TYPE_ANDROID:Constants. DEVICE_TYPE_IOS;
try {
     BaseResponse response = await configsController!.getSettings();
    AppShared.settingsResponse=Settings.fromJson(response.data);
   } on ApiException catch (e) {
      print('ApiException');
      appNotifiers!.isClosedForMaintainance=true;
    }
    on DioError catch (e) {
      print('DioError');
      print( e.response);
      print( e.message);

    }

  
  // print( AppShared.settingsResponse .settings!.mobile);
 // AppShared.sharedPreferencesController.clearUserData();
    await Future.delayed(Duration(milliseconds: 600));
    //AppShared.sharedPreferencesController.setAppLang('');
    if (AppShared.sharedPreferencesController.getAppLang() == null)
      Navigator.pushNamedAndRemoveUntil(
          context, Constants.SCREENS_SELECT_LANG_SCREEN, (route) => false);
    else if (AppShared.sharedPreferencesController.getIsLogin()) {
      AppShared.accessToken =
          AppShared.sharedPreferencesController.getAccessToken();
      AppShared.currentUser= AppShared.sharedPreferencesController.getUserData();
      print('logged in ${AppShared.accessToken}');

     
      //  if (AppShared.currentUser!.type == Constants.USER_TYPE_DRIVER)
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, Constants.SCREENS_DRIVER_ORDERS_SCREEN, (route) => false);
      //        else 
            //  (AppShared.currentUser.type == Constants.USER_TYPE_CUSTOMER)
        Navigator.pushNamedAndRemoveUntil(
            context, Constants.SCREENS_MAIN_SCREEN, (route) => false);
      // else if (AppShared.currentUser.type == Constants.USER_TYPE_SELLER)
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, Constants.SCREENS_SELLER_HOME_SCREEN, (route) => false);
    } else {
       Navigator.pushNamedAndRemoveUntil(
            context, Constants.SCREENS_SIGN_IN_SCREEN, (route) => false);
      // Navigator.pushNamedAndRemoveUntil(
      //     context, Constants.SCREENS_REGISTER_SCREEN, (route) => false);
    }
  }
// ||...................... logic methods ............................||

}
