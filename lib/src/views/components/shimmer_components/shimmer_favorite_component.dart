import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../styles/app_styles.dart';
import '../../../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ShimmerFavoriteComponent extends StatelessWidget {
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,

                  ),
                  width: 150.w,
                  height: 100.h,
                //  color: Colors.grey,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 5),


                        child: Container(
                          width: 100,
                          height: 5,
                          color: Colors.grey,
                        )),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          width: 50,
                          height: 5,
                          color: Colors.grey,
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


              ],
            ),
          ),
        ),
      ),
    );
  }
}
