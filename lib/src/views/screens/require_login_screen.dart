import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/views/components/custom_btn_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../styles/app_styles.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import '../../views/components/custom_fade_animation_component.dart';
import '../../views/components/image_placeholder_component.dart';
import '../../views/components/parent_component.dart';

class RequireLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}must-login.svg',

              height: AppShared.screenUtil.setHeight(200),
              width: AppShared.screenUtil.setWidth(250),

            ),
            SizedBox(
              height: AppShared.screenUtil.setHeight(20),
            ),
            Text('LoginRequire'.tr(),
            textAlign: TextAlign.center,
            style: textStyleMedium.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: AppShared.screenUtil.setSp(28)
            ),
            ),
            SizedBox(
              height: AppShared.screenUtil.setHeight(20),
            ),
            CustomBtnComponent(text: 'Login'.tr(), onTap: (){
              Navigator.of(context)
                  .pushNamed(Constants.SCREENS_SIGN_IN_SCREEN);
            }),
          ],
        ),
      ),
    );
  }
}

