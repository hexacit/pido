import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/controllers/api_controllers/auth_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/custom_back_button.dart';
import 'package:pido/src/views/components/entry_field_component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  late TextEditingController _oldPasswordTextEditingController;
  late TextEditingController _newPasswordTextEditingController;
  late TextEditingController _confirmNewPasswordTextEditingController;
  late GlobalKey<FormState>_key;
  late    AuthController authController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _oldPasswordTextEditingController=TextEditingController();
    _newPasswordTextEditingController=TextEditingController();
    _confirmNewPasswordTextEditingController=TextEditingController();
    _key= GlobalKey<FormState>();
    authController = AuthController.instance!;

  }

  bool isBtnLoading = false;

  void changePassword() async {

    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    try {
      setState(() {
        isBtnLoading = true;

      });
      BaseResponse response = await authController.changePassword(
      oldPassword: _oldPasswordTextEditingController.text,
        newPassword: _newPasswordTextEditingController.text,
        confirmNewPassword: _confirmNewPasswordTextEditingController.text,

      );
      if (response.status!) {

        Navigator.pushNamedAndRemoveUntil(
          context, Constants.SCREENS_MAIN_SCREEN, (route) => false,
        );

        Helpers.showMessage(response.message, MessageType.MESSAGE_SUCCESS);
        //}
      } else {
        Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);
        setState(() {
          isBtnLoading = false;

        });

      }
    } catch (error) {
      setState(() {
        isBtnLoading = false;

      });
      print(error);
      Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
appBar:      AppBar(
  elevation: 0,
  title:Text(
    'ChangePassword'.tr(),
    style: Theme.of(context).textTheme.headline3!.copyWith(
      color:Colors.black,
      fontSize:17.sp,
    ),
    textAlign: TextAlign.center,
  ),
  centerTitle: true,
  leadingWidth: 35.w,
  leading: CustomBackButton(),

),

      body: Container(
        height: MediaQuery.of(context).size.height,

        decoration: BoxDecoration(
            image: DecorationImage(
                image:
                AssetImage('${Constants.ASSETS_IMAGES_PATH}bg.png'),
                fit: BoxFit.cover
            )
        ),
        padding: EdgeInsets.symmetric(horizontal: 15,),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[




                SizedBox(
                  height: AppShared.screenUtil.setHeight(100),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('PasswordFormat'.tr(),
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      EntryFieldComponent(
                        textEditingController:_oldPasswordTextEditingController ,
contentPadding: const EdgeInsets.symmetric(vertical: 5),

                        title: 'OldPassword'.tr()
                        ,
                        icon: 'lock',
                        validator: (val){
                          if(val==null||val.isEmpty)
                            return'ThisFieldIsRequired'.tr();

                          return null;

                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      EntryFieldComponent(
                        textEditingController:_newPasswordTextEditingController ,
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),

                        title: 'NewPassword'.tr()
                        ,
                        icon: 'lock',
                        validator: (val){
                          if(val==null||val.isEmpty)
                            return'ThisFieldIsRequired'.tr();

                          return null;

                        },
                      ),

                      SizedBox(
                        height: 15.h,
                      ),
                      EntryFieldComponent(
                        textEditingController:_confirmNewPasswordTextEditingController ,
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),

                        title: 'ConfirmPassword'.tr()
                        ,
                        icon: 'lock',
                        validator: (val){
                          if(val==null||val.isEmpty)
                            return'ThisFieldIsRequired'.tr();
                          else if(val!=_newPasswordTextEditingController.text)
                            return'ConfirmPasswordDoesNotMatchNewPassword'.tr();

                          return null;

                        },
                      ),


                      SizedBox(
                        height: AppShared.screenUtil.setHeight(70),
                      ),
                      InkWell(
                        onTap: changePassword
                        ,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          child:   isBtnLoading?
                          Center(child: CircularProgressIndicator(),)
                              :SvgPicture.asset(
                            '${Constants.ASSETS_IMAGES_PATH}done.svg',
                            color: Colors.black,
                          ),
                          decoration: BoxDecoration(
                            color:Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
