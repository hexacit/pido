import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/local_controllers/shared_preferences_controller.dart';
import '../notifiers/app_notifiers.dart';
import './connectivity_service.dart';
import './local_notifications_service.dart';
import './navigation_service.dart';
import '../themes/dark_theme.dart';
import '../themes/light_theme.dart';
import '../utils/app_shared.dart';
import '../utils/helpers.dart';

import 'firebase_messaging_service.dart' ;

class StartUpService {
  static StartUpService? _instance;
  LocalNotificationsService? _localNotificationsService;
  ConnectivityService? _connectivityService;
  NavigationService? _navigationService;
 FirebaseMessagingService? _firebaseMessagingService;

  // ||.. private constructor ..||
  StartUpService._() {
    AppShared.dio = Dio();
    _localNotificationsService = LocalNotificationsService.instance;
    _connectivityService = ConnectivityService.instance;
    _firebaseMessagingService = FirebaseMessagingService.instance;
    _navigationService = NavigationService.instance;
  }

  // ||.. singleton pattern ..||
  static StartUpService? get instance {
    if (_instance != null) return _instance;
    return _instance = StartUpService._();
  }

  // init.
  Future<void> init() async {

    AppShared.sharedPreferencesController =
        await SharedPreferencesController.instance!;
    Helpers.changeAppLang(AppShared.sharedPreferencesController.getAppLang());
    if (AppShared.sharedPreferencesController.isDarkModeEnabled())
      AppShared.appTheme = darkTheme;
    else
      AppShared.appTheme = lightTheme;
//    await _connectivityService.checkConnection();
  }

  // init after build.
  void initAfterBuild(AppNotifiers? appNotifiers, BuildContext context) async {
    await _firebaseMessagingService!.init(appNotifiers);
    await _localNotificationsService!.init(context, appNotifiers);
    _navigationService!.init(appNotifiers);
//    _connectivityService.listenToConnection(appNotifiers);
  }
}
