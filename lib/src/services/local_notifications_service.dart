import 'dart:convert';

import 'package:pido/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../notifiers/app_notifiers.dart';

class LocalNotificationsService {
  static LocalNotificationsService? _instance;
  late BuildContext _context;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  AppNotifiers? _appNotifiers;
  int _id = 0;

  // ||.. private constructor ..||
  LocalNotificationsService._() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  // ||.. singleton pattern ..||
  static LocalNotificationsService? get instance {
    if (_instance != null) return _instance;
    return _instance = LocalNotificationsService._();
  }

  //init.
  Future<void> init(BuildContext context, AppNotifiers? appNotifiers) async {
    this._context = context;
    _appNotifiers = appNotifiers;
    await _initLocalNotifications();
  }

  // local notifications init.
  Future<void> _initLocalNotifications() async {
    print('_initLocalNotifications');
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
      android:
        initializationSettingsAndroid,iOS: initializationSettingsIOS
        );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _selectNotification
        );
  }

  Future _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: _context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => SecondScreen(payload),
//                ),
//              );
            },
          )
        ],
      ),
    );
  }

  // select notification.
  Future _selectNotification(String? payload) async {
    print(payload);
   try {
     Map<String, dynamic> notification =
         await jsonDecode(payload!) as Map<String, dynamic>;
     if (notification['msgType'] == '1')
       _appNotifiers!.navigationKey!.currentState!.pushNamed(
         Constants.SCREENS_ORDER_DETAILS_SCREEN,
         arguments: [int.parse(notification['target_id']), false],
       );
     else if (notification['msgType'] == '2') {
       print('clicked');
       _appNotifiers!.navigationKey!.currentState!.pushNamed(
         Constants.SCREENS_TECHNICAL_SUPPORT_SCREEN,
           arguments: {
                                            'user_image':
                                              notification['user_image'],
                                            'user_name':
                                               notification['user_name'],
                                            'user_id': int.parse( notification['user_id'])  ,
                                          }
       );
     }
   } catch (error) {
     print(error.toString());
   }
  }

  // show notification.
  void showNotification(String title, String message, {required String payload}) {
    _flutterLocalNotificationsPlugin.show(
      ++_id,
      title,
      message,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'pidoid',
          'pido',
       //   'this is for app notifications.',
          enableVibration: true,
          importance: Importance.max,
          priority: Priority.max,
        ),
      iOS:  IOSNotificationDetails(),
        
      ),
      payload: payload,
    );
  }
}
