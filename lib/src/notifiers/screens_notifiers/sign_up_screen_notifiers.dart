import 'package:pido/src/controllers/api_controllers/user_controller.dart';
import 'package:pido/src/models/api_models/responses/user_profile_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/api_controllers/auth_controller.dart';
import '../../controllers/api_controllers/configs_controller.dart';
import '../../models/api_models/base_response.dart';
import '../../models/api_models/responses/cities_response.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart';

class SignUpScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isAgree = false;
  bool _isLoading = false;
  bool _isBtnLoading = false;
 
 

  bool get isAgree => _isAgree;

  set isAgree(bool value) {
    _isAgree = value;
    notifyListeners();
  }

  bool get isBtnLoading => _isBtnLoading;

  set isBtnLoading(bool value) {
    _isBtnLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String? get mobile => _mobile;

  set mobile(String? value) {
    _mobile = value;
    notifyListeners();
  }






  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  late AuthController authController;
  late ConfigsController configsController;
  late GlobalKey<FormState> signUpFormState;

  // ||... form fields ...|
  String? name;
  String? email;
  String? _mobile;
  String? password;


  // ||... focus nodes ...||
  late FocusNode emailFocusNode;
  late FocusNode mobileFocusNode;
  late FocusNode passwordFocusNode;
  UserProfileData? userProfileData;
  UserController? userController;

late TextEditingController phoneController;
  // ||... constructor ...||
  SignUpScreenNotifiers(this.context) {
    phoneController=TextEditingController();
    signUpFormState = GlobalKey();
    passwordFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    mobileFocusNode = FocusNode();
    authController=AuthController.instance!;
    userController = UserController.instance;

  }

  // ||...................... logic methods ............................||

  // init.
  void init() async {
    try {
    
      isLoading = false;
    } catch (error) {
      isLoading = false;
      print(error);
    
    }
  }

  // get districts by city id.
  
  // sign in method
  void signUp() async {
    // if (!isAgree) {
    //   Helpers.showMessage(AppShared.appLang['YouMustAgreeToTheTerms'],
    //       MessageType.MESSAGE_FAILED);
    //   return;
    // }
    if (!signUpFormState.currentState!.validate()) return;
    signUpFormState.currentState!.save();
    try {
      isBtnLoading = true;
      BaseResponse baseResponse = await authController.signUp(
        mobile: mobile,
        password: password,
       
        email: email,
        name: name,
      );
      isBtnLoading = false;
      if (baseResponse.status!) {
        Helpers.showMessage(
            baseResponse.message, MessageType.MESSAGE_SUCCESS);
        getMyProfile();
      } else {
        print('error signup');
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
      }
    }on Exception catch (error) {
      isBtnLoading = false;
      print(error);
      Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
    }
  }
  Future<void> getMyProfile({bool isInit = true}) async {

    BaseResponse baseResponse;
    UserProfileData? userProfileData;

    try {

      baseResponse= await userController!.getProfile();
      userProfileData=UserProfileData.fromJson( baseResponse.data);
      isBtnLoading = false;


      if (!baseResponse.status!) {


        Helpers.showMessage(
            baseResponse.message, MessageType.MESSAGE_FAILED);
      }else{
        AppShared.sharedPreferencesController.setIsLogin(true);
        AppShared.sharedPreferencesController.setUserData(userProfileData.user);
        AppShared.sharedPreferencesController.setAccessToken(AppShared.accessToken!);

        AppShared.currentUser=userProfileData.user;

        Navigator.pushNamed(
          context,
          Constants.SCREENS_VERIFY_MOBILE_SCREEN,

          arguments: mobile,
        );




      }
    }on Exception catch (error) {

      print(error);
      Helpers.showMessage(AppShared.appLang['SomethingWentWrong'],
          MessageType.MESSAGE_FAILED);
    }
  }
  // skip
  void skip() {
    Navigator.pushNamedAndRemoveUntil(
        context, Constants.SCREENS_MAIN_SCREEN, (route) => false);
  }


// ||...................... logic methods ............................||

}
