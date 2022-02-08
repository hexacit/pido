import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../utils/app_shared.dart';

class SettingsScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isNotificationEnabled =
      AppShared.sharedPreferencesController.isNotificationsEnabled();

  bool _isDarkModeEnabled =
      AppShared.sharedPreferencesController.isDarkModeEnabled();

  bool get isNotificationEnabled => _isNotificationEnabled;

  set isNotificationEnabled(bool value) {
    _isNotificationEnabled = value;
    notifyListeners();
    AppShared.sharedPreferencesController.setIsNotificationsEnabled(value);
  }

  bool get isDarkModeEnabled => _isDarkModeEnabled;

  set isDarkModeEnabled(bool value) {
    _isDarkModeEnabled = value;
    notifyListeners();
    AppShared.sharedPreferencesController.setIsDarkModeEnabled(value);
  }

// ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  // ||... constructor ...||

// ||...................... logic methods ............................||

// ||...................... logic methods ............................||

}
