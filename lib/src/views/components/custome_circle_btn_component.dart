import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomCircleBtn extends StatefulWidget {
  final bool isBtnLoading;
  final Function onTap;
  final String icon;
  const CustomCircleBtn({Key? key,
    this.isBtnLoading=false,
    this.icon='arrow',
    required this.onTap

  }) : super(key: key);

  @override
  _CustomCircleBtnState createState() => _CustomCircleBtnState();
}

class _CustomCircleBtnState extends State<CustomCircleBtn> {
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap:        widget. isBtnLoading?
      null:(){
        widget.onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        child:
        widget. isBtnLoading?
        Container(
          height: 15.h,
          width: 15.w,
          child: Center(child: CircularProgressIndicator(


          ),),
        )
            :
        SvgPicture.asset(
          '${Constants.ASSETS_IMAGES_PATH}${widget.icon}.svg',
          color: Colors.black,
          height: 15.h,
          width: 15.w,

        ),
        decoration: BoxDecoration(
          color:  widget. isBtnLoading?Colors.grey:Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
      ),
    );

  }
}
