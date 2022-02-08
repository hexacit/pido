import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class EmptyComponent extends StatelessWidget {
  final String? text;
   String? iconName;

  EmptyComponent({required this.text,this.iconName='no_result_found'});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          color: Colors.white12,
          height: MediaQuery.of(context).size.height*0.4,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                '${Constants.ASSETS_IMAGES_PATH}$iconName.svg',
               // color: Theme.of(context).primaryColor,
                width: MediaQuery.of(context).size.width*0.3,
                height: MediaQuery.of(context).size.height*0.3,
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                text??'',
                textAlign: TextAlign.center,
                style: TextStyle(
                  
                  color:Colors.red,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
