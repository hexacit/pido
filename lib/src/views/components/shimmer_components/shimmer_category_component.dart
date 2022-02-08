import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import '../../../styles/app_styles.dart';

class ShimmerCategoryComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (_, index) => Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                 // padding: AppStyles.defaultPadding2,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                   // color: Color(0xffD1D1D1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xffD1D1D1),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child:  SvgPicture.asset(
                            '${Constants.ASSETS_IMAGES_PATH}all-icon.svg')
                       ,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 35,
                        height: 3,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
