import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:pido/src/controllers/api_controllers/auth_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/views/components/custome_circle_btn_component.dart';
import 'package:pido/src/views/components/entry_field_component.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {
  bool? isNavigateToCart;
  SignInScreen({
    this.isNavigateToCart=false,
});
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    {

  @override
  void initState() {
    super.initState();
_key=GlobalKey<FormState>();
    authController = AuthController.instance!;

  }
late GlobalKey<FormState>_key;
 late    AuthController authController;


  String? email;
  String? password;
  bool isBtnLoading = false;

  void signIn() async {

    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    try {
      setState(() {
        isBtnLoading = true;

      });
      BaseResponse response = await authController.signIn(
        email: email,
        password: password,

      );
      if (response.status!) {
        if(widget.isNavigateToCart!){
          Navigator.of(context).pop(true);

        }else{
          Navigator.pushNamedAndRemoveUntil(
            context, Constants.SCREENS_MAIN_SCREEN, (route) => false,
          );
        }



        Helpers.showMessage(response.message, MessageType.MESSAGE_SUCCESS);
        //}
      } else {
        Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);
        setState(() {
          isBtnLoading = false;

        });

      }
    }on Exception catch (error) {
      setState(() {
        isBtnLoading = false;

      });
      print(error);
      Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width:  MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image:
              AssetImage('${Constants.ASSETS_IMAGES_PATH}bg.png'),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
backgroundColor: Colors.transparent,
appBar:       AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title:Text(
    'Enter'.tr(),
    style: textStyleMedium.copyWith(
      color:Colors.black,
      fontSize:AppShared.screenUtil.setSp(17),
    ),
    textAlign: TextAlign.center,
  ),
  centerTitle: true,
  actions: [
    Center(
      child: InkWell(
        onTap: (){
          Navigator.pushNamedAndRemoveUntil(context, Constants.SCREENS_MAIN_SCREEN, (route) => false);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Skip'.tr(),
            style: Theme.of(context).textTheme.headline3!.copyWith(
              color:Colors.black,
              fontSize:AppShared.screenUtil.setSp(17),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  ],
),
        body: Container(

          padding: EdgeInsets.symmetric(horizontal: 15,),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150.h),
              Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
                padding: const EdgeInsets.all(20),
                child: Form(
                  key:_key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                     EntryFieldComponent(
                       keyboardType:TextInputType.emailAddress ,

                       title: '${'Email'.tr()} : ',
                     icon: 'email',
                       validator: (val){
                         if(val==null||val.isEmpty)
                           return'ThisFieldIsRequired'.tr();
                         else if(  !EmailValidator.validate(val))
                           return'ThisIsNotEmailFormat'.tr();
                         return null;

                       },
                       onSaved: (val){
                         email=val;
                       },

                     ),
                      SizedBox(
                        height: AppShared.screenUtil.setHeight(25),
                      ),
                      EntryFieldComponent(title: '${'Password'.tr()} : ',
                        isSecure: true,
                        icon: 'lock',
                        validator: (val){
                          if(val==null||val.isEmpty)
                            return'ThisFieldIsRequired'.tr();

                          return null;

                        },
                        onSaved: (val){
                          password=val;
                        },
                      ),
                      SizedBox(
                        height: AppShared.screenUtil.setHeight(25),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            Constants.SCREENS_FORGET_PASSWORD_SCREEN
                          );
                        },
                        child: Text(
                          'ForgotPassword'.tr(),
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Color(0xff707070),
                                                  fontSize:AppShared.screenUtil.setSp(14),

                            ),
                        ),
                      ),
                      SizedBox(
                        height: AppShared.screenUtil.setHeight(10),
                      ),

                      CustomCircleBtn(
                        onTap:(){
                          print('here');
                          signIn();
                        },
                        isBtnLoading: this.isBtnLoading,
                      ),
                      // InkWell(
                      //   onTap:signIn,
                      //   child: Container(
                      //     padding: const EdgeInsets.all(24),
                      //     child:
                      //         isBtnLoading?
                      //             Center(child: CircularProgressIndicator(),)
                      //             :
                      //     SvgPicture.asset(
                      //       '${Constants.ASSETS_IMAGES_PATH}arrow.svg',
                      //       color: Colors.black,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       color:Theme.of(context).primaryColor,
                      //       shape: BoxShape.circle,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
