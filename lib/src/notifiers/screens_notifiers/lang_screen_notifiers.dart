import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/api_controllers/configs_controller.dart';
import '../../notifiers/app_notifiers.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class SelectLangScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  String _selectedLang = Constants.LANG_EN;
  bool _isLoading = false;

  String get selectedLang => _selectedLang;

  set selectedLang(String value) {
    _selectedLang = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  late AppNotifiers _appNotifiers;
  ConfigsController? _configsController;

  // ||... constructor ...||
  SelectLangScreenNotifiers(this.context) {
    _appNotifiers = Provider.of<AppNotifiers>(context, listen: false);
    _configsController = ConfigsController.instance;
  }

// ||...................... logic methods ............................||

// on done selecting app lang.
  void done() async {
    try {
      isLoading = true;
     

      await AppShared.sharedPreferencesController.setAppLang(selectedLang);
      // AppShared.adsResponse = await _configsController!.getAds();
      // AppShared.sharedPreferencesController.setIntroAds(true);
      isLoading = false;
      Navigator.pushNamedAndRemoveUntil(
          context, Constants.SCREENS_SIGN_IN_SCREEN, (route) => false);
           if (selectedLang == Constants.LANG_EN) {
          context.locale = Locale('en', 'US');
      } else {
        context.locale = Locale('ar', 'SA');
      }
    //  _appNotifiers.refresh = !_appNotifiers.refresh;
    } catch (error) {
      isLoading = false;
      print(error);
      Helpers.showMessage('Something went wrong', MessageType.MESSAGE_FAILED);
    }
  }
// ||...................... logic methods ............................||

}
