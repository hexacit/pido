import 'dart:math';
import 'dart:async';

import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/views/components/mobil_entry_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pido/src/services/navigation_service.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:provider/provider.dart';
import '../../notifiers/dialogs_notifiers/select_location_dialog_notifiers.dart';
import '../../notifiers/screens_notifiers/sign_up_screen_notifiers.dart';
import '../../styles/app_styles.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import '../../views/components/custom_btn_component.dart';
import '../../views/components/custom_fade_animation_component.dart';
import '../../views/components/loading_component.dart';
import '../components/parent_component.dart';
import 'package:tuple/tuple.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpScreenNotifiers>(
      create: (_) => SignUpScreenNotifiers(context),
      child: SignUpScreenBody(),
    );
  }
}

class SignUpScreenBody extends StatefulWidget {
  @override
  _SignUpScreenBodyState createState() => _SignUpScreenBodyState();
}

class _SignUpScreenBodyState extends State<SignUpScreenBody> {
  late SignUpScreenNotifiers _signUpScreenNotifiers;

  @override
  void initState() {
    super.initState();
    _signUpScreenNotifiers=Provider.of<SignUpScreenNotifiers>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            InkWell(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _signUpScreenNotifiers.signUpFormState,
                          child: Column(children: <Widget>[
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(70),
                            ),
                            Image.asset(
                              '${Constants.ASSETS_IMAGES_PATH}logo.png',
                              height: AppShared.screenUtil.setHeight(70),
                              width: AppShared.screenUtil.setWidth(70),
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(40),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'SignUp'.tr(),
                                style: textStyleBold.copyWith(
                      color:Colors.black,
                      fontSize:AppShared.screenUtil.setSp(24),
                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(15),
                            ),
                            Padding(
                  padding:  EdgeInsets.symmetric(horizontal: AppShared.screenUtil.setWidth(70)),
                              child: Text(
                                'SignUpToGetStarted'.tr(),
                                  style: textStyleRegular.copyWith(
                      color:Color(0xff474747),
                      fontSize:AppShared.screenUtil.setSp(12),
                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(40),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'FullName'.tr(),
                                     style: textStyleRegular.copyWith(
                      color:Colors.black54,
                      fontSize:AppShared.screenUtil.setSp(12),
                    ),
                                  ),
                                  TextFormField(

                                    decoration: InputDecoration(

                                      hintText: 'EnterFullName'.tr(),
                                    hintStyle:  textStyleRegular.copyWith(
                      color:Colors.black,
                      fontSize:AppShared.screenUtil.setSp(18),

                    ),
                                    ),
                                    validator: (val){
                                      if(val==null||val.isEmpty)
                                        return'ThisFieldIsRequired'.tr();
                                      return null;
                                    },
                                    onSaved: (val){
                                      _signUpScreenNotifiers.name=val;
                                    },
                                    textInputAction:TextInputAction.next ,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(15.5),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Email'.tr(),
                                    style: textStyleRegular.copyWith(
                      color:Colors.black54,
                      fontSize:AppShared.screenUtil.setSp(12),
                    ),
                                  ),
                                  TextFormField(
                                    textInputAction:TextInputAction.next ,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (val){
                                      if(val==null||val.isEmpty)
                                        return'ThisFieldIsRequired'.tr();
                                      else if(!EmailValidator.validate(val))
                                        return 'ThisIsNotEmailFormat'.tr();
                                      return null;
                                    },
                                    onSaved: (val){
                                      _signUpScreenNotifiers.email=val;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'EnterEmail'.tr(),
                                     hintStyle:  textStyleRegular.copyWith(
                      color:Colors.black,
                      fontSize:AppShared.screenUtil.setSp(18),
                    ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(15.5),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Password'.tr(),
                                    style: textStyleRegular.copyWith(
                      color:Colors.black54,
                      fontSize:AppShared.screenUtil.setSp(12),
                    ),
                                  ),
                                  TextFormField(
                                    textInputAction:TextInputAction.next ,
                                    obscureText: true,
                                    validator: (val){
                                      if(val==null||val.isEmpty)
                                        return'ThisFieldIsRequired'.tr();
                                      else if(val.length<6)
                                        return 'PasswordLeastLength'.tr();
                                      return null;
                                    },
                                    onSaved: (val){
                                      _signUpScreenNotifiers.password=val;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'EnterPassword'.tr(),
                                      hintStyle:  textStyleRegular.copyWith(
                      color:Colors.black,
                      fontSize:AppShared.screenUtil.setSp(18),
                    ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(15.5),
                            ),
                            MobileEntryField(
                              focusNode:_signUpScreenNotifiers.mobileFocusNode ,
                              controller: _signUpScreenNotifiers.phoneController,
                              onchange: (val){
                                _signUpScreenNotifiers.mobile=val;

                              },
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(15.5),
                            ),
//                             Container(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Mobile'.tr(),
//                                    style: textStyleRegular.copyWith(
//                       color:Colors.black54,
//                       fontSize:AppShared.screenUtil.setSp(12),
//                     ),
//                                   ),
//
//                                   TextFormField(
//                                     focusNode:_signUpScreenNotifiers.mobileFocusNode ,
//                                     controller: _signUpScreenNotifiers.phoneController,
//                                     textInputAction:TextInputAction.done ,
//                                     validator: (val){
//                                       if(val==null||val.isEmpty)
//                                         return'ThisFieldIsRequired'.tr();
//                                       if(val.length!=12)
//                                         return'MobileMaxCount'.tr();
//                                       return null;
//                                     },
//                                     onSaved: (val){
//                                       print(' save $val');
//
//                                       //_signUpScreenNotifiers.mobile=val;
//                                     },
//                                     onChanged: (val){
//                                       _signUpScreenNotifiers.formatPhone(val);
//
// print(val);
//                                     },
// maxLength: 12,
//                                     keyboardType: TextInputType.phone,
//                                     decoration: InputDecoration(
//                                       hintText: 'EnterMobileNumber'.tr(),
//                                       hintStyle:  textStyleRegular.copyWith(
//                       color:Colors.black,
//                       fontSize:AppShared.screenUtil.setSp(18),
//                     ),
//                                     ),
//                                   ),
//                         Selector<SignUpScreenNotifiers,String?>(
//                           selector:(_,value)=>value.mobile,
//                           builder: (_, phone,__) {
//                             return Text(
//                               _signUpScreenNotifiers.mobile.toString(),
//                               style: textStyleRegular.copyWith(
//                                 color:Colors.black54,
//                                 fontSize:AppShared.screenUtil.setSp(12),
//                               ),);
//                           }
//                         ),
//
//                                 ],
//                               ),
//                             ),
                               SizedBox(
                                    height: AppShared.screenUtil.setHeight(40),
                                  ),
    Selector<SignUpScreenNotifiers, bool>(
    selector: (_, value) => value.isBtnLoading,
    builder: (_, isBtnLoading, __) => CustomBtnComponent(
      isLoading:isBtnLoading ,

                                          text: 'SIGNUP'.tr(), onTap: () {
                                            _signUpScreenNotifiers.signUp();
    })

                                  ),
                                  SizedBox(
                                    height: AppShared.screenUtil.setHeight(15),
                                  ),
                                  CustomBtnComponent(
                                    color: Colors.white,
                                    textColor: Theme.of(context).primaryColor,
                                      text: 'Back'.tr(), onTap: () {

                                        Navigator.of(context).pop();
                                      }),
                          ]),
                        ),
                      )),
            ));
  }
}
