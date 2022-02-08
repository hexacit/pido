import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../styles/app_styles.dart';
import '../../../utils/app_shared.dart';
import '../../../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class ShimmerOrderComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        child: ListView.builder(

          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (_, index) => Container(
            padding: AppStyles.defaultPadding2,
            height:120.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all()

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

            Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(text: TextSpan(
                                      text: '${'OrderId'.tr()} : ',
                                      style: Theme.of(context).textTheme.headline4!.copyWith(
                                        fontSize: 14.sp,
                                      ),
                                      children: [

                                      ]
                                    )),

                                        Container(
                                            margin: EdgeInsets.symmetric(vertical: 5),
                                            child: Container(
                                              width: 50,
                                              height: 5,
                                              color: Colors.grey,
                                            )),

                                  ],
                                ),
            Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}dollar.svg'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                            margin: EdgeInsets.symmetric(vertical: 5),
                                            child: Container(
                                              width: 50,
                                              height: 5,
                                              color: Colors.grey,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}date.svg'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                            margin: EdgeInsets.symmetric(vertical: 5),
                                            child: Container(
                                              width: 50,
                                              height: 5,
                                              color: Colors.grey,
                                            )),
                                      ],
                                    ),
                                    Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(
                                          Directionality.of(context) == TextDirection.rtl ? pi : 0,
                                        ),child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}go.svg')),

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
