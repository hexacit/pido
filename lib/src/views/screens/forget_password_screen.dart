import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:pido/src/controllers/api_controllers/auth_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pido/src/views/components/custom_app_bar_component.dart';
import 'package:pido/src/views/components/custome_circle_btn_component.dart';
import 'package:pido/src/views/components/entry_field_component.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ForgetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ForgetPasswordScreenBody(
    );
  }
}

class ForgetPasswordScreenBody extends StatefulWidget {
  @override
  _ForgetPasswordScreenBodyState createState() => _ForgetPasswordScreenBodyState();
}

class _ForgetPasswordScreenBodyState extends State<ForgetPasswordScreenBody>
      {

  @override
  void initState() {
    super.initState();
    _key= GlobalKey<FormState>();
    _emailTextEditingController=TextEditingController();
    authController=AuthController.instance!;
  }
late GlobalKey<FormState>_key;
 late  TextEditingController _emailTextEditingController;
  bool isBtnLoading = false;
  late    AuthController authController;

  void forgetPassword() async {

    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    try {
      setState(() {
        isBtnLoading = true;

      });
      BaseResponse response = await authController.forgotPassword(
        email: _emailTextEditingController.text,

      );
      if (response.status!) {

        // Navigator.pushNamedAndRemoveUntil(
        //   context, Constants.SCREENS_MAIN_SCREEN, (route) => false,
        // );
Navigator.of(context).pop();
        Helpers.showMessage(response.message, MessageType.MESSAGE_SUCCESS);
        //}
      } else {
        Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);


      }
      setState(() {
        isBtnLoading = false;

      });
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
    return Container(

      decoration: BoxDecoration(
          image: DecorationImage(
              image:
              AssetImage('${Constants.ASSETS_IMAGES_PATH}bg.png'),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        appBar:   CustomAppBarComponent(
          title:   'ForgetPassword'.tr(),
          textStyle:
          TextStyle(
            color:Colors.black,
            fontWeight: FontWeight.w400,
            fontSize:17.sp,
          ),
        ),
backgroundColor: Colors.transparent,

        body: Container(

          padding: EdgeInsets.symmetric(horizontal: 15,),
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[





                // SizedBox(
                //   height: AppShared.screenUtil.setHeight(100),
                // ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'ForgetPasswordMessage'.tr()
                                  ,textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,

                              fontSize: 18.sp
                              )
            ,

                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(30),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  EntryFieldComponent(
textEditingController: _emailTextEditingController,
                                    title: '${'Email'.tr()} : ',
                                    icon: 'email',

                                    // icon: 'email',
                                    validator: (val){
                                      if(val==null||val.isEmpty)
                                        return'ThisFieldIsRequired'.tr();
                                      else if(  !EmailValidator.validate(val))
                                        return'ThisIsNotEmailFormat'.tr();
                                      return null;

                                    },


                                  ),

                                ],
                              ),
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(30),
                            ),
                            CustomCircleBtn(
                              onTap:(){
                                print('here');
                                forgetPassword();
                              },
                              isBtnLoading: this.isBtnLoading,
                              icon: 'done',
                            ),



                          ],
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
