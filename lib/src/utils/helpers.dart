//||... Class for all helpers methods ...||

import 'dart:io';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import '../langs/ar_lang.dart';
import '../langs/en_lang.dart';
import '../langs/tr_lang.dart';
import '../utils/constants.dart';

import 'app_shared.dart';
import 'enums.dart';

class Helpers {
  // method for showing an message .
  static void showMessage(String? message, MessageType messageType) {
    if (message == null) return;
    if (messageType == MessageType.MESSAGE_FAILED)
      BotToast.showNotification(
       // textDirection: getDirectionByLang(),
        // trailing: (_) => Icon(
        //   Icons.arrow_forward_ios,
        //   color: Color(0xffF58035),
        // ),
        title: (_) => Text(
          AppShared.appLang['Failed']!,
          style: TextStyle(color: Color(0xffF58035)),
        ),
        subtitle: (_) => Text(
          message,
          style: TextStyle(color: Color(0xffF58035)),
        ),
        leading: (_) => Icon(
          Icons.error,
          color:Color(0xffF58035),
        ),
      );
    else
      BotToast.showNotification(
       // textDirection: getDirectionByLang(),
        // trailing: (_) => Icon(
        //   Icons.arrow_forward_ios,
        //   color: Colors.teal,
        // ),
        title: (_) => Text(
          AppShared.appLang['Success']!,
          style: TextStyle(color: Colors.teal),
        ),
        subtitle: (_) => Text(
          message,
          style: TextStyle(color: Colors.teal),
        ),
        leading: (_) => Icon(
          Icons.done,
          color: Colors.teal,
        ),
      );
  }

  // show notification.
  static void showNotification({
    required String title,
    required String body,
    Function? onTap,
  }) {
    BotToast.showCustomNotification(
      toastBuilder: (_) => Directionality(
        textDirection: TextDirection.ltr,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap as void Function()?,
            child: Platform.isAndroid
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.all(16),
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              '${Constants.ASSETS_IMAGES_PATH}car2.png',
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'NoorDelivery',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Just now',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            body,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.all(16),
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              '${Constants.ASSETS_IMAGES_PATH}car2.png',
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Weenah',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                            Spacer(),
                            Text(
                              'now',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            body,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  // method for setting the app lang.
  static void changeAppLang(String? lang) {
    switch (lang) {
      case Constants.LANG_AR:
        AppShared.appLang = ar;
        break;
      case Constants.LANG_EN:
        AppShared.appLang = en;
        break;
    
    }
  }

  // method for setting the app direction according to app lang.
  static TextDirection getDirectionByLang({String? lang}) {
    if (lang == null) lang = AppShared.sharedPreferencesController.getAppLang();
    switch (lang) {
      case Constants.LANG_AR:
        return TextDirection.rtl;
        break;
      case Constants.LANG_EN:
        return TextDirection.ltr;
        break;
    
      default:
        return TextDirection.rtl;
    }
  }

  // method for setting the app font according to app lang.
  static String changeAppFont({String? lang}) {
    if (lang == null) lang = AppShared.sharedPreferencesController.getAppLang();
    switch (lang) {
      case Constants.LANG_EN:
        return 'Roboto';
        break;
      case Constants.LANG_AR:
        return 'Cairo';
        break;
      default:
        return 'Roboto';
    }
  }
 static String changeFont({String? lang}) {
    if (lang == null) lang = AppShared.sharedPreferencesController.getAppLang();
    switch (lang) {
      case Constants.LANG_EN:
        return 'NeoSans';
        break;
      case Constants.LANG_AR:
        return 'NadiaSofia';
        break;
      default:
        return 'NadiaSofia';
    }
  }
  // format date.
  static String formatDate(DateTime dateTime) {
    return intl.DateFormat('yyyy-MM-dd','en').format(dateTime);
  }
  static DateTime stringToDate(String dateString) {
    return intl.DateFormat('yyyy-MM-dd HH:mm:ss','en').parse(dateString);
  }
  static DateTime shortStringToDate(String dateString) {
    return intl.DateFormat('yyyy-MM-dd','en').parse(dateString);
  }

  // format time.
  static String formatTime(TimeOfDay timeOfDay) {
    return '${timeOfDay.hour < 10 ? '0${timeOfDay.hour}' : timeOfDay.hour}:${timeOfDay.minute < 10 ? '0${timeOfDay.minute}' : timeOfDay.minute}';
  }
  // format count.
  static String formatCount(int count) {
    return '${count < 10 ? '0$count' : '$count'}';
  }

  //ger Order Statuses.
  static List<String?> getOrderStatuses() => [
        'New'.tr(),
       'Preparing'.tr(),
        'OnDelivery'.tr(),
        'OrderCompleted'.tr()
      ];
  static List<Color> getOrderStatusColor() => [
   Color(0xffFF2C2C),
   Color(0xffFF9924),
   Color(0xff00C10D),
   Color(0xff008709),
  ];



  // get Order Types.
  static List<String?> getOrderTypes() => [
        AppShared.appLang['Urgent'],
        AppShared.appLang['Scheduled'],
      ];

  // get price filter Types
  static List<String?> getPriceFilterTypes() => [
        AppShared.appLang['LowToHigh'],
        AppShared.appLang['HighToLow'],
        AppShared.appLang['Recent'],
      ];


  // get order status name.
  static String? getOrderStatusName(int orderStatus) {
    return getOrderStatuses()[orderStatus];
  }





   // get payment type name
  static List<String?> paymentTypesName() => [
        AppShared.appLang['Cash'],
        AppShared.appLang['Online'],
        AppShared.appLang['Wallet'],
      ];

  // get order status name.
  static String? getPaymentTypeNameName(int paymentType) {
    return paymentTypesName()[paymentType];
  }
}
