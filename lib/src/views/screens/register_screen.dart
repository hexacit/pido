import 'package:flutter/material.dart';

import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/views/components/custom_btn_component.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppShared.screenUtil.setHeight(60),
              ),
              InkWell(
                onTap: (){

                   Navigator.pushNamedAndRemoveUntil(
        context, Constants.SCREENS_MAIN_SCREEN, (route) => false);
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.centerRight,
                  child: Text('Skip'.tr(),
                  textAlign: TextAlign.end,

                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color:Theme.of(context).primaryColor,
                  ),
                  
                  ),
                ),
              ),
              Image.asset(
                '${Constants.ASSETS_IMAGES_PATH}logo.png',
                height: AppShared.screenUtil.setHeight(70),
                width: AppShared.screenUtil.setWidth(70),
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: AppShared.screenUtil.setHeight(15.5),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
               'AppName'.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'NeoSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
               SizedBox(
                height: AppShared.screenUtil.setHeight(15.5),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
               'LoginOrSignUp'.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'NeoSans',
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
               SizedBox(
                height: AppShared.screenUtil.setHeight(15.5),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  
                  children: [

                  Image.asset('${Constants.ASSETS_IMAGES_PATH}high-quality.png'),
                  Image.asset('${Constants.ASSETS_IMAGES_PATH}sale.png'),
                  Image.asset('${Constants.ASSETS_IMAGES_PATH}best-price.png'),
                  Image.asset('${Constants.ASSETS_IMAGES_PATH}best-value.png'),
                ],)
              ),
                  SizedBox(
                height: AppShared.screenUtil.setHeight(80),
              ),
             SignUpBtnComponent(
               title: 'SignUpWithGoogle'.tr(),
               iconName: 'gmail',
                              onTap: (){},

             ),
               SizedBox(
                height: AppShared.screenUtil.setHeight(10),
              ),
             SignUpBtnComponent(
               title: 'SignUpWithFacebook'.tr(),
               iconName: 'facebook',
               onTap: (){},
             ),
               SizedBox(
                height: AppShared.screenUtil.setHeight(10),
              ),
              SignUpBtnComponent(
               title: 'SignUpWithEmail'.tr(),
               iconName: 'email',
                              onTap: (){

                                Navigator.of(context).pushNamed(Constants.SCREENS_SIGN_UP_SCREEN);
                              },

             ),
               SizedBox(
                height: AppShared.screenUtil.setHeight(90),
              ),

              InkWell(
                onTap: (){

                  Navigator.of(context).pushNamed(Constants.SCREENS_SIGN_IN_SCREEN);
                },

                child: RichText(text: TextSpan(

text: 'IfYouHaveAnAccount'.tr(),
style: TextStyle(
color: Color(0xff404040),


),
children: [
  TextSpan(
    text: 'Login'.tr(),
    style: TextStyle(
color: Theme.of(context).primaryColor,


),
  )
]

                )),
              )
            ],
          )),
    );
  }
}

class SignUpBtnComponent extends StatelessWidget {

  String iconName;
  String title;
  Function onTap;

   SignUpBtnComponent({
   required this.title,
   required this.iconName,
   required this.onTap,
  }) ;

  @override
  Widget build(BuildContext context) {
    return     Padding(
    
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
    
      child:   Container(
    
      
    
        decoration: BoxDecoration(
    
      
    
          borderRadius: BorderRadius.circular(25),
    
      
    
          border: Border.all(
    
      
    
            color: Color(0xffDDDDDD)
    
      
    
          )
    
      
    
        ),
    
      
    
        child: ListTile(
    
          onTap: (){
    
            this.onTap();
    
          },
    
      
    
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
    
      
    
      leading: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}$iconName.svg'),
    
      horizontalTitleGap:0,
    
      
    
      title: Text(title,
    
      
    
      style: TextStyle(color: Colors.black),
    
      
    
      textAlign: TextAlign.center,
    
      
    
      ),
    
      
    
      
    
      
    
      ),),
    
    );
  }
}
