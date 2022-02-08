import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../styles/app_styles.dart';
import '../../../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerNotificationComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        child: ListView.builder(
          // shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (_, index) => Container(

          //  width: double.infinity,
         padding:   const EdgeInsets.symmetric(
                horizontal: 10.0,vertical: 15),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Row(
              children: <Widget>[

                Row(
                  children: <Widget>[
                    Container(
                      padding:EdgeInsets.symmetric(horizontal: 20),
                      child: SvgPicture.asset(
                        '${Constants.ASSETS_IMAGES_PATH}notification.svg',
                        height: 30.h,
                        width:30.w,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 100,
                      height: 3,
                      color: Colors.grey,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
