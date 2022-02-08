import 'package:pido/src/controllers/api_controllers/user_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/api_models/responses/user_profile_response.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../controllers/api_controllers/auth_controller.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart';

class SignInScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isBtnLoading = false;

  bool get isBtnLoading => _isBtnLoading;

  set isBtnLoading(bool value) {
    _isBtnLoading = value;
    notifyListeners();
  }

  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  AuthController? authController;
  GlobalKey<FormState>? signInFormState;
  late AnimationController animationController;
  late Animation animation;

  // ||... form fields ...|
  String? email;
  String? password;

  // ||... focus nodes ...||
  late FocusNode passwordFocusNode;
  UserController? userController;
  int? isVerified;

  // ||... constructor ...||
  SignInScreenNotifiers(this.context) {
    authController = AuthController.instance;
    userController = UserController.instance;

    signInFormState = GlobalKey();
    passwordFocusNode = FocusNode();
  }

  // ||...................... logic methods ............................||

  // sign in method
  void signIn() async {
  
    if (!signInFormState!.currentState!.validate()) return;
    signInFormState!.currentState!.save();
    try {
      isBtnLoading = true;
      BaseResponse response = await authController!.signIn(
email: email,
        password: password,
      
      );
      if (response.status!) {

        Navigator.pushNamedAndRemoveUntil(
          context, Constants.SCREENS_MAIN_SCREEN, (route) => false,
        );

          Helpers.showMessage(response.message, MessageType.MESSAGE_SUCCESS);
        //}
      } else {
        Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);
        isBtnLoading = false;

      }
    } catch (error) {
      isBtnLoading = false;
      print(error);
      Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
    }
  }





  //init animation.
  void initAnimation(
      SingleTickerProviderStateMixin singleTickerProviderStateMixin) {
    animationController = AnimationController(
        vsync: singleTickerProviderStateMixin,
        duration: Duration(milliseconds: 500));
    animation = Tween<double>(begin: 0, end: 2000).animate(animationController);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
       
          Navigator.pushNamedAndRemoveUntil(
              context, Constants.SCREENS_MAIN_SCREEN, (route) => false);
        //         else if (AppShared.currentUser.type == Constants.USER_TYPE_SELLER)
        // Navigator.pushNamedAndRemoveUntil(
        //     context, Constants.SCREENS_SELLER_HOME_SCREEN, (route) => false);
      }
    });
  }

  // skip
  void skip() {
    Navigator.pushNamedAndRemoveUntil(
        context, Constants.SCREENS_MAIN_SCREEN, (route) => false);
  }
  // ||...................... logic methods ............................||

}
