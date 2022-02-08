
import 'package:flutter/material.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';

import './custom_fade_animation_component.dart';
import './custom_btn_component.dart';

class LoginComponent extends StatelessWidget {
  const LoginComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           CustomFadeAnimationComponent(
                  0.4,
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      '${Constants.ASSETS_IMAGES_PATH}logo.png',
                    ),
                  ),
                ),
                SizedBox(height: 25,),
          Text(AppShared.appLang['mustLogin']!, style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),),
                                          SizedBox(height: 25,),

           CustomBtnComponent(
                            text: AppShared.appLang['SignIn'],
                            onTap: () {
                            Navigator.pushNamed(
                        context, Constants.SCREENS_SIGN_IN_SCREEN,);
                            },
                          ),
        ],
      ),
    );
  }
}