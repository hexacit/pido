import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import '../notifiers/app_notifiers.dart';
import '../utils/app_shared.dart';
import '../utils/constants.dart';

import 'local_notifications_service.dart';

class FirebaseMessagingService {
  AppNotifiers? appNotifiers;
  static FirebaseMessagingService? _instance;
  late FirebaseMessaging _fcm;
  LocalNotificationsService? _localNotificationsService;

  FirebaseMessagingService._() {
    _fcm = FirebaseMessaging.instance;
    _localNotificationsService = LocalNotificationsService.instance;
  }

  // ||.. singleton pattern ..||
  static FirebaseMessagingService? get instance {
    if (_instance != null) return _instance;
    return _instance = FirebaseMessagingService._();
  }

  Future<String?> getToken() async {
    return _fcm.getToken();
  }

  Future<void> init(AppNotifiers? appNotifiers) async {
    this.appNotifiers = appNotifiers;
    _fcm.requestPermission();
    _fcm.subscribeToTopic(Constants.FIREBASE_MESSAGING_TOPIC);
    AppShared.firebaseToken = await getToken();
    print(AppShared.firebaseToken);

    FirebaseMessaging.onMessage.listen((event) {
          print('here');

      print(
          "onMessage: ${event.notification!.title} ${event.notification!.body}");
      // appNotifiers.notificationsCount = ++appNotifiers.notificationsCount;
      //  AppShared.sharedPreferencesController
      //      .setNotificationsCount(appNotifiers.notificationsCount);
      appNotifiers!.notification = event;
      if (appNotifiers.notification.data == null) {
        if (appNotifiers.notification.messageType == null) {
          if (AppShared.sharedPreferencesController.isNotificationsEnabled())
            _localNotificationsService!.showNotification(
              event.notification!.title!,
              event.notification!.body!,
               payload: jsonEncode(appNotifiers.notification.toString()),
            );
          return;
        }
        if (appNotifiers.notification.messageType == '2') {
          if (appNotifiers.isInsideChatScreen) {
            appNotifiers.canRefreshChat = true;
            appNotifiers.chatRefresh = !appNotifiers.chatRefresh;
          } else {
            if (AppShared.sharedPreferencesController.isChatNotificationsEnabled())
              _localNotificationsService!.showNotification(
                event.notification!.title!,
                event.notification!.body!,
                  payload: jsonEncode(appNotifiers.notification.toString()),
              );
          }
        }
      } else {
        if (event.data.isEmpty) {
          if (AppShared.sharedPreferencesController.isNotificationsEnabled())
            _localNotificationsService!.showNotification(
              event.notification!.title!,
              event.notification!.body!,
               payload: jsonEncode(appNotifiers.notification.toString()),
            );
        } else {


 if (appNotifiers.notification.data['msgType'] == '1') {
          
              if (AppShared.sharedPreferencesController.isServicesRecommendNotificationsEnabled()) {
                 print(jsonEncode(appNotifiers.notification.data));
                _localNotificationsService!.showNotification(
                  event.data['title'],
                  event.data['body'],
                   payload: jsonEncode(appNotifiers.notification.data),
                );
                  appNotifiers.canRefreshServicePage = !appNotifiers.canRefreshServicePage;
              
            }
          } 

else if (appNotifiers.notification.data['msgType'] == '3') {
          
              if (AppShared.sharedPreferencesController.isAppAdsNotificationsEnabled()) {
                 print(jsonEncode(appNotifiers.notification.data));
                _localNotificationsService!.showNotification(
                  event.data['title'],
                  event.data['body'],
                   payload: jsonEncode(appNotifiers.notification.data),
                );
              
            }
          } 

        else  if (appNotifiers.notification.data['msgType'] == '2') {
            appNotifiers.canRefreshWallet = true;
print('chatmessage');
            if (appNotifiers.isInsideChatScreen) {
              print('chatmessage33');

              appNotifiers.canRefreshChat = true;
                            print('chatmessage3344');

              appNotifiers.chatRefresh = !appNotifiers.chatRefresh;
                            print('chatmessage3355');

            } else {
              if (AppShared.sharedPreferencesController.isChatNotificationsEnabled()) {
                 print(jsonEncode(appNotifiers.notification.data));
                _localNotificationsService!.showNotification(
                  event.data['title'],
                  event.data['body'],
                   payload: jsonEncode(appNotifiers.notification.data),
                );
              }
            }
          } else {
            appNotifiers.canRefreshWallet =  !appNotifiers.canRefreshWallet;
          print('refresh wallet');
          print( appNotifiers.canRefreshWallet);
            if (AppShared.sharedPreferencesController
                .isNotificationsEnabled()) {
                 
              _localNotificationsService!.showNotification(
                event.data['title'],
                event.data['body'],
               payload: jsonEncode(appNotifiers.notification.toString()),
              );
            }
          }
        }
      }
      // //////////
      // /////////////
      // //////////
//        else if (appNotifiers.notification['data']['msgType'] == '1') {
//          if (appNotifiers.isInsideOrderScreen) {
//            appNotifiers.canLoadNewOffers = true;
//            appNotifiers.offersRefresh = !appNotifiers.offersRefresh;
//          } else if (AppShared.sharedPreferencesController
//              .isNotificationsAvailable())
//            _localNotificationsService.showNotification(
//              message['notification']['title'],
//              message['notification']['body'],
//              payload: jsonEncode(appNotifiers.notification),
//            );
//        }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("onLaunch: $event");
      appNotifiers!.notification = event;
    });
    // FirebaseMessaging.onBackgroundMessage((message) {
    //   print("onBackgroundMessage: $message");
    // } as Future<void> Function(RemoteMessage));
  }
}
