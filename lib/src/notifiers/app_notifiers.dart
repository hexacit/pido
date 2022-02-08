import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './screens_notifiers/main_screen_notifiers/main_screen_notifiers.dart';
import '../utils/constants.dart';

class AppNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  int _connectivity = Constants.INTERNET_STATUS_CONNECTED;
  bool _refresh = false;
  bool _chatRefresh = false;
bool _isClosedForMaintainance=false;


  bool get isClosedForMaintainance => _isClosedForMaintainance;

  set isClosedForMaintainance(bool value) {
    _isClosedForMaintainance = value;
    notifyListeners();
  }

  bool get chatRefresh => _chatRefresh;

  set chatRefresh(bool value) {
    _chatRefresh = value;
    print('_chatRefresh');
    notifyListeners();
  }

  int get connectivity => _connectivity;

  set connectivity(int value) {
    _connectivity = value;
    notifyListeners();
  }

  bool get refresh => _refresh;

  set refresh(bool value) {
    _refresh = value;
    notifyListeners();
  }
  bool get canRefreshWallet => _canRefreshWallet;

  set canRefreshWallet(bool value) {
    _canRefreshWallet = value;
    notifyListeners();
  }
   bool get canRefreshServicePage => _canRefreshServicePage;

  set canRefreshServicePage(bool value) {
    _canRefreshServicePage = value;
    notifyListeners();
  }


// ||....................... notifiable ..................................||

//--------------------------------------------------------------------------------------------------//

  late RemoteMessage  notification;
  GlobalKey<NavigatorState>? navigationKey;
  bool canRefreshChat = false;
  bool _canRefreshWallet = false;

  bool _canRefreshServicePage = true;

  bool isInsideChatScreen = false;
LatLng? userLocation;
  
  late MainScreenNotifiers mainScreenNotifiers;

  AppNotifiers() {
    navigationKey = GlobalKey();
    
  }
}
