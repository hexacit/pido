
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/views/components/custom_btn_component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class LoginDialog extends StatelessWidget {
  const LoginDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(25),
        height: MediaQuery.of(context).size.height*0.5,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                '${Constants.ASSETS_IMAGES_PATH}logo.svg',
              ),
              decoration: BoxDecoration(
                color:Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            Text('YouWantToContinueWithThePaymentAs'.tr(),
              style: textStyleMedium.copyWith(fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
            CustomBtnComponent(text: 'Guest'.tr(), onTap: (){
           Navigator.of(context).pop(1);
            },
              color: Colors.white,
              textColor: Colors.black,
            ),
            Text('Or'.tr()),
            CustomBtnComponent(text: 'Enter'.tr(), onTap: (){
              Navigator.of(context).pop(2);
            },
              textColor: Colors.black,
            ),

          ],
        ),
      ),
    );
  }
}