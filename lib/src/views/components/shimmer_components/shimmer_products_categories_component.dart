import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../styles/app_styles.dart';
import '../../../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ShimmerProductsCategoriesComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child:      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (_,index){
          return Container(

            height: 190.h,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),


                        child: Container(
                          width: 100,
                          height: 5,
                          color: Colors.grey,
                        )),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),


                        child: Container(
                          width: 100,
                          height: 5,
                          color: Colors.grey,
                        )),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 3,
                    //   crossAxisSpacing: 10,
                    //   mainAxisSpacing: 10,
                    //     mainAxisExtent:170.h
                    // ),
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (_, index) => Container(
                      padding: AppStyles.defaultPadding2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[


                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey,

                            ),
                            width: 90.w,
                            height: 90.h,
                          //  color: Colors.grey,
                          ),
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
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
