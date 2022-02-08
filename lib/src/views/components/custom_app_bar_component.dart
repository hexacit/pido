
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomAppBarComponent extends StatelessWidget implements PreferredSize{
  final String? title;
  final TextStyle? textStyle;

  CustomAppBarComponent({
    required this.title,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return   AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title:Text(
          title??'',

        style:this.textStyle!=null?this.textStyle:TextStyle(
          color:Colors.black,
          fontWeight: FontWeight.bold,
          fontSize:24.sp,
        ),
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
      leadingWidth: 35.w,

      leading: InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child:
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(
              Directionality.of(context) == TextDirection.rtl ? pi : 0,
            ),
            child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}back.svg',

            ),
          ),
        ),
      ),


    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(80.h);
}
