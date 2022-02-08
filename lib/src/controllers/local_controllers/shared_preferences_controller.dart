//||... Controller for controlling the shared preferences ...||
import 'dart:async';

import 'package:pido/src/models/api_models/responses/my_addresses_response.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/sub_models/user.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class SharedPreferencesController {
  static Future<SharedPreferencesController>? _instance;
  static late SharedPreferences _sharedPreferences;
  static late Completer<SharedPreferencesController> _completer;

  // ||.. private constructor ..||
  SharedPreferencesController._();

  // ||.. singleton pattern ..||
  static Future<SharedPreferencesController>? get instance async {
    if (_instance != null) return _instance!;
    _completer = Completer<SharedPreferencesController>();
    await _init();
    _completer.complete(SharedPreferencesController._());
    return _instance = _completer.future;
  }

  // ||. init the shared preferences object .||
  static Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //       ------------------ || .. usable  methods ..|| ----------------------

  //------------- ||. app lang .||
  // get the current app lang
  String? getAppLang() {
    return _sharedPreferences.getString(Constants.SHARED_APP_LANG);
//        ??
//        Constants.SHARED_APP_LANG_DEFAULT_VALUE;
  }

  // set the current app lang
  Future<void> setAppLang(String lang) async {
    await _sharedPreferences.setString(Constants.SHARED_APP_LANG, lang);
    Helpers.changeAppLang(lang);
  }

  //------------- ||. is login .||

  // get the current user login status.
  bool getIsLogin() {
    return _sharedPreferences.getBool(Constants.SHARED_IS_LOGIN) ??
        Constants.SHARED_IS_LOGIN_DEFAULT_VALUE;
  }

  // set the current user login status.
  Future<void> setIsLogin(bool isLogin) async {
    await _sharedPreferences.setBool(Constants.SHARED_IS_LOGIN, isLogin);
  }



  //------------- ||. user data .||

//   get the current user data.
  User getUserData() {
    return userFromJson(
      _sharedPreferences.getString(Constants.SHARED_USER_DATA),
    );
  }

//   set the current user data.
  Future<void> setUserData(User? user) async {
    await _sharedPreferences.setString(
      Constants.SHARED_USER_DATA,
       userToJson(user),
    );
  }




//   get the current user address.
  MyAddressesResponse? getUserAddressData() {
    return myAddressesResponseFromJson(
      _sharedPreferences.getString(Constants.USER_ADDRESS)??null,
    )??null;
  }

//   set the current user address.
  Future<void> setUserAddressData(MyAddressesResponse? address) async {
    await _sharedPreferences.setString(
      Constants.USER_ADDRESS,
       myAddressesResponseToJson(address!),
    );
  }

  //------------- ||. is dark mode enabled .||

  // method for setting the dark mode is enabled or not  >>>
  Future<bool> setIsDarkModeEnabled(bool value) async {
    return _sharedPreferences.setBool(
        Constants.SHARED_IS_DARK_MODE_ENABLED, value);
  }

// method for getting the dark mode is enabled or not  >>>
  bool isDarkModeEnabled() {
    return _sharedPreferences.getBool(Constants.SHARED_IS_DARK_MODE_ENABLED) ??
        Constants.SHARED_IS_DARK_MODE_ENABLED_DEFAULT_VALUE;
  }

  //------------- ||. intro ads .||

  // method for setting the intro ads can appear or not  >>>
  Future<bool> setIntroAds(bool value) async {
    return _sharedPreferences.setBool(Constants.SHARED_INTRO_ADS, value);
  }

//method for setting the intro ads can appear or not  >>>
  bool getIntroAds() {
    return _sharedPreferences.getBool(Constants.SHARED_INTRO_ADS) ??
        Constants.SHARED_INTRO_ADS_DEFAULT_VALUE;
  }

  //------------- ||. is remember me .||

  // method for setting the user status is remembered or not  >>>
  Future<bool> setRememberedUser(bool value) async {
    return _sharedPreferences.setBool(Constants.SHARED_IS_REMEMBER_ME, value);
  }

// method for getting the user status is remembered or not  >>>
  bool isRememberedUser() {
    return _sharedPreferences.getBool(Constants.SHARED_IS_REMEMBER_ME) ??
        Constants.SHARED_REMEMBER_ME_DEFAULT_VALUE;
  }

  //------------- ||. is notifications enabled .||


  // method for setting the notifications is enabled or not  >>>
  Future<bool> setIsChatNotificationsEnabled(bool value) async {
    return _sharedPreferences.setBool(
        Constants.SHARED_IS_CHAT_NOTIFICATIONS_ENABLED, value);
  }

// method for getting the notifications is enabled or not  >>>
  bool isChatNotificationsEnabled() {
    return _sharedPreferences
            .getBool(Constants.SHARED_IS_CHAT_NOTIFICATIONS_ENABLED) ??
        Constants.SHARED_IS_CHAT_NOTIFICATIONS_ENABLED_DEFAULT_VALUE;
  }
   // method for setting the notifications is enabled or not  >>>
  Future<bool> setIsAppAdsNotificationsEnabled(bool value) async {
    return _sharedPreferences.setBool(
        Constants.SHARED_IS_APP_ADS_NOTIFICATIONS_ENABLED, value);
  }

// method for getting the notifications is enabled or not  >>>
  bool isAppAdsNotificationsEnabled() {
    return _sharedPreferences
            .getBool(Constants.SHARED_IS_APP_ADS_NOTIFICATIONS_ENABLED) ??
        Constants.SHARED_IS_APP_ADS_NOTIFICATIONS_ENABLED_DEFAULT_VALUE;
  }
   // method for setting the notifications is enabled or not  >>>
  Future<bool> setIsServicesRecommendNotificationsEnabled(bool value) async {
    return _sharedPreferences.setBool(
        Constants.SHARED_IS_SERVICES_RECOMMEND_NOTIFICATIONS_ENABLED, value);
  }

// method for getting the notifications is enabled or not  >>>
  bool isServicesRecommendNotificationsEnabled() {
    return _sharedPreferences
            .getBool(Constants.SHARED_IS_SERVICES_RECOMMEND_NOTIFICATIONS_ENABLED) ??
        Constants.SHARED_IS_SERVICES_RECOMMEND_NOTIFICATIONS_ENABLED_DEFAULT_VALUE;
  }


  // method for setting the notifications is enabled or not  >>>
  Future<bool> setIsNotificationsEnabled(bool value) async {
    return _sharedPreferences.setBool(
        Constants.SHARED_IS_NOTIFICATIONS_ENABLED, value);
  }

// method for getting the notifications is enabled or not  >>>
  bool isNotificationsEnabled() {
    return _sharedPreferences
            .getBool(Constants.SHARED_IS_NOTIFICATIONS_ENABLED) ??
        Constants.SHARED_IS_NOTIFICATIONS_ENABLED_DEFAULT_VALUE;
  }

//------------- ||. clear all shared preferences.||
  Future<void> clear() async {
    await _sharedPreferences.clear();
  }

  //------------- ||. clear all user data.||
  Future<void> clearUserData() async {
    await setIsLogin(Constants.SHARED_IS_LOGIN_DEFAULT_VALUE);
    await setIsDarkModeEnabled(
        Constants.SHARED_IS_DARK_MODE_ENABLED_DEFAULT_VALUE);
    await setUserData(null);
    AppShared.currentUser=null;
  }

  String? getAccessToken() {
    return _sharedPreferences.getString(Constants.SHARED_ACCESS_TOKEN);
//        ??
//        Constants.SHARED_APP_LANG_DEFAULT_VALUE;
  }

  // set the current app lang
  Future<void> setAccessToken(String val) async {
    await _sharedPreferences.setString(Constants.SHARED_ACCESS_TOKEN, val);
  }
}
