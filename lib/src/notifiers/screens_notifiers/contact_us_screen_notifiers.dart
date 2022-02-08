import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../controllers/api_controllers/user_controller.dart';
import '../../models/api_models/responses/contact_response.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart';
import '../../views/dialogs/info_dialog.dart';

class ContactUsScreenNotifiers with ChangeNotifier {
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
  UserController? userController;
  GlobalKey<FormState>? contactUsFormState;

  // ||.. Focus nodes ..||
  FocusNode? messageFocusNode;
  late FocusNode emailFocusNode;
  FocusNode? mobileFocusNode;

  // ||.. Fields ..||
  String? title;
 
  String? message;

  // ||... constructor ...||
  ContactUsScreenNotifiers(this.context) {
    userController = UserController.instance;
    messageFocusNode = FocusNode();
    mobileFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    contactUsFormState = GlobalKey();
  }

// ||...................... logic methods ............................||

// send contact.

// ||...................... logic methods ............................||

}
