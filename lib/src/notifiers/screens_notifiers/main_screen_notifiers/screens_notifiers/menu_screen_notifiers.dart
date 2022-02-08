import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controllers/api_controllers/auth_controller.dart';
import '../../../../models/api_models/base_response.dart';
import '../../../../notifiers/app_notifiers.dart';
import '../../../../themes/light_theme.dart';
import '../../../../utils/app_shared.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/helpers.dart';

class MenuScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  AuthController? authController;

  // ||... constructor ...||
  MenuScreenNotifiers(this.context) {
    authController = AuthController.instance;
  }

// ||...................... logic methods ............................||

// logout.
  Future<void> logout() async {
    try {
      isLoading = true;
      BaseResponse baseResponse = await authController!.logout();
      isLoading = false;
      if (baseResponse.status!) {
        AppNotifiers appNotifiers =
            Provider.of<AppNotifiers>(context, listen: false);
        AppShared.appTheme = lightTheme;
        appNotifiers.refresh = !appNotifiers.refresh;
        Navigator.pushNamedAndRemoveUntil(
            context, Constants.SCREENS_SPLASH_SCREEN, (route) => false);
      } else {
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
      }
    } catch (error) {
      isLoading = false;
      print(error);
      Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
    }
  }

// ||...................... logic methods ............................||

}
