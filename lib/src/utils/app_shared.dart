//||... File for app routes ...||
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pido/src/models/sub_models/settings.dart';
import '../controllers/local_controllers/shared_preferences_controller.dart';
import '../models/api_models/responses/settings_response.dart';
import '../models/sub_models/user.dart';

class AppShared {
  // ||... shared var for SharedPreferencesController ...||
  static late SharedPreferencesController sharedPreferencesController;
  // ||... app lang ...||
  static late Map<String, String> appLang;
  // ||... screen_utils ...||
  static late ScreenUtil screenUtil;
  // ||... current_user ...||
  static User? currentUser;
  // ||... dio instance ...||
  static late Dio dio;
  // ||... firebase token ...||
  static String? firebaseToken;
  // ||... firebase messaging ...||
//  static FirebaseMessaging firebaseMessaging;
  // ||... device type ...||
  static String? deviceType;
  // ||... connectivity ...||
  static int? connectivity;
  // ||... setting ...||
  static late Settings settingsResponse;
  static late Duration serverTime;

// ||... ads ...||
  // ||... currency ...||
  static String? currency = "\$";
  static String? categoryName;
  static bool isLocationSetFromMap=false;
  static bool showCategories=false;
  static int? selectedCategory;

  static String? accessToken;

  // ||... app theme ...||
  static late Map appTheme;
}
