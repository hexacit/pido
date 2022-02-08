
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/views/components/custom_btn_component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class OrderSuccessDialog extends StatelessWidget {
  const OrderSuccessDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(25),
        height: MediaQuery.of(context).size.height*0.6,
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
            Text('YourOrderHasBeenAccepted'.tr(),

              textAlign: TextAlign.center,
              style: textStyleMedium.copyWith(
                fontSize: 18.sp,

              ),
            ),

            Text('YourItemsHasBeenPlacedAndItIsOnItsWayToBeingProcessed'.tr(),
              textAlign: TextAlign.center,
              style: textStyleRegular.copyWith(
                fontSize: 14.sp,

              ),
            ),
            CustomBtnComponent(text: 'BackToHome'.tr(), onTap: (){
              Navigator.pushNamedAndRemoveUntil(
                  context, Constants.SCREENS_MAIN_SCREEN, (route) => false);
            },
              textColor: Colors.black,
            ),

          ],
        ),
      ),
    );
  }
}