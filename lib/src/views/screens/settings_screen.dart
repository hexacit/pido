import 'dart:io';
import 'dart:math';
import 'package:pido/src/controllers/api_controllers/user_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/views/dialogs/loading_dialog.dart';
import 'package:share/share.dart';
import '../../utils/app_shared.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    return  SettingsScreenBody
      ();
  }
}

class SettingsScreenBody extends StatefulWidget {
  @override
  _SettingsScreenBodyState createState() => _SettingsScreenBodyState();
}

class _SettingsScreenBodyState extends State<SettingsScreenBody> {
late UserController _userController;
  @override
  void initState() {
    super.initState();
    _userController=UserController.instance!;

  }
  void receiveNotification(bool status) async {

   showDialog(context: context, builder: (context)=>LoadingDialog());
    try {

      BaseResponse response = await _userController.receiveNotification(
       status: status?1:0

      );
      if (response.status!) {



        Helpers.showMessage(response.message, MessageType.MESSAGE_SUCCESS);
        AppShared.sharedPreferencesController.setIsNotificationsEnabled(status);
        //}
      } else {
        Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);


      }
      Navigator.of(context).pop();
    } catch (error) {
      Navigator.of(context).pop();

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
        backgroundColor: Colors.transparent,
appBar:    AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title:Text(
    'Settings'.tr(),
    style: textStyleMedium.copyWith(
      color:Colors.black,
      fontSize:17.sp,
    ),
    textAlign: TextAlign.center,
  ),
  centerTitle: true,
  leading: IconButton(
    icon: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}menu.svg'),
    onPressed: () {
      Scaffold.of(context).openDrawer();

    },

  ),
  actions: [
    Container(
      margin: EdgeInsetsDirectional.only(end: 10),
      child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Constants.SCREENS_MY_CART_SCREEN,
                arguments: context);
          },
          child: SvgPicture.asset(
              '${Constants.ASSETS_IMAGES_PATH}cart.svg')),
    ),
  ],
),

        body: Container(

          padding: EdgeInsets.symmetric(horizontal: 15,),
           child:

                  Column(
      children: [


        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
          ),
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [ SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}notification.svg'),
                  SizedBox(width: 10.w,),
                  Text('Notifications'.tr()
                  ,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                  ),
                ],
              ),
              SwitchComponent(
                value: AppShared.sharedPreferencesController.isNotificationsEnabled(),
                onChanged: (val){

                  receiveNotification(val);

                },
              ),
            ],
          ),
        ),

        if(AppShared.sharedPreferencesController.getIsLogin())
        Column(
          children: [
            SizedBox(height: AppShared.screenUtil.setHeight(10),),
            SettingItem(
              title: 'ChangePassword'.tr(),
              icon: 'lock',
              onTap: (){
                Navigator.of(context).pushNamed(Constants.SCREENS_CHANGE_PASSWORD_SCREEN);
              },
            ),
          ],
        ),
      //  SizedBox(height: AppShared.screenUtil.setHeight(10),),
        // Container(
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(15)
        // ),
        //   padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        //   child: ListTile(
        //     onTap: (){
        //        showDialog(
        //                 context: context,
        //                 builder: (BuildContext context) {
        //                   return LanguageDialog();
        //                 });
        //     },
        //     contentPadding: EdgeInsets.zero,
        //     title: Text('Language'.tr(),
        //       style: textStyleMedium.copyWith(
        //         fontSize: AppShared.screenUtil.setSp(18),
        //         color: Colors.black,
        //       ),
        //
        //
        //     ),
        //     subtitle:Text( Constants.languagesNames[ AppShared .sharedPreferencesController.getAppLang()??'']??'',
        //
        //       style: textStyleRegular.copyWith(
        //         fontSize: AppShared.screenUtil.setSp(12),
        //         color: Colors.black54,
        //       ),
        //
        //
        //     ) ,
        //     trailing: Icon(Icons.arrow_forward_ios,
        //       color: Theme.of(context).primaryColor,
        //     ),
        //   ),
        // ),
        //
        // SizedBox(height: AppShared.screenUtil.setHeight(10),),
        // Container(
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(15)
        // ),
        //   padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        //   child: InkWell(
        //     onTap: (){
        //       Navigator.of(context).pushNamed(Constants.SCREENS_HTML_CONTENT_SCREEN,
        //       arguments: Constants.STATIC_SCREENS_ABOUT_US);
        //
        //     },
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Row(
        //           children: [SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}privacy.svg'),
        //             Text('AboutUs'.tr(),
        //               style: textStyleMedium.copyWith(
        //                 fontSize: AppShared.screenUtil.setSp(18),
        //                 color: Colors.black,
        //               ),
        //
        //
        //             ),
        //           ],
        //         ),SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}go.svg')
        //       ],
        //
        //
        //     ),
        //   ),
        // ),
        SizedBox(height: AppShared.screenUtil.setHeight(10),),
        SettingItem(
          title: 'PrivacyPolicy'.tr(),
          icon: 'privacy',
          onTap: (){
            Navigator.of(context).pushNamed(Constants.SCREENS_HTML_CONTENT_SCREEN,
                arguments: Constants.STATIC_SCREENS_PRIVACY_POLICY);
          },
        ),

        SizedBox(height: AppShared.screenUtil.setHeight(10),),

        // Container( decoration:
        //
        // BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(15)
        // ),
        //   padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        //   child: InkWell(
        //     onTap: (){
        //
        //       Navigator.of(context).pushNamed(Constants.SCREENS_FAQ_SCREEN,);
        //
        //     },
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Row(
        //           children: [ SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}terms.svg'),
        //             Text('FAQs'.tr(),
        //               style: textStyleMedium.copyWith(
        //                 fontSize: AppShared.screenUtil.setSp(18),
        //                 color: Colors.black,
        //               ),
        //
        //
        //             ),
        //           ],
        //         ), SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}go.svg'),
        //       ],
        //
        //
        //     ),
        //   ),
        // ),

        SettingItem(
          title: 'TermsOfUse'.tr(),
          icon: 'terms',
          onTap: (){
            Navigator.of(context).pushNamed(Constants.SCREENS_HTML_CONTENT_SCREEN,
                arguments: Constants.STATIC_SCREENS_TERMS_OF_USE);
          },
        ),
        SizedBox(height: AppShared.screenUtil.setHeight(10),),
        SettingItem(
          title: 'ShareApp'.tr(),
          icon: 'share',
          onTap: (){
            Share.share(Platform.isAndroid
                ? AppShared
                .settingsResponse.playStoreUrl??''
                : AppShared
                .settingsResponse.appStoreUrl??'');
          },
        ),


      ],
      ),)


      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final String icon;
  final Function onTap;
  const SettingItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
    ),
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
      child: InkWell(
        onTap: (){
          this.onTap();


        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}$icon.svg'),
            SizedBox(width: 10.w,),
            Expanded(
              child: Text(title,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: 14.sp,
                  color: Colors.black,
                ),


              ),
            ),
            Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(
                  Directionality.of(context) == TextDirection.rtl ? pi : 0,
                ),
                child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}go.svg'))
          ],


        ),
      ),
    );
  }
}

class SwitchComponent extends StatefulWidget {
  final Function(bool) onChanged;
   bool value;
   SwitchComponent({
    Key? key,
    required this.onChanged,
    this.value=true,
  }) : super(key: key);

  @override
  State<SwitchComponent> createState() => _SwitchComponentState();
}

class _SwitchComponentState extends State<SwitchComponent> {
  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(value: widget.value, onChanged: (val){
      setState(() {
        widget.value = ! widget.value;
      });
      widget.onChanged(val);
    },
    // thumbColor: widget.value?Colors.green: Colors.red,
    //   trackColor:  Colors.grey[300],
      activeColor: Colors.green,

    );
  }
}
