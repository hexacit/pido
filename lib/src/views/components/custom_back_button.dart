
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomBackButton extends StatelessWidget {
  Color? color;
  Function()? onTap;
   CustomBackButton({
    Key? key,
     this.color,
     this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:this.onTap?? (){
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(
                Directionality.of(context) == TextDirection.rtl ? pi : 0,
              ),
          child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}back.svg',
            color: color??Colors.black,
            width: 35.w,
            height: 35.h,
          ),
        ),
      ),
    );
  }
}
