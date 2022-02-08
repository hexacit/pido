import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import '../../../styles/app_styles.dart';

class ShimmerFaqComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        height: 50,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (_, index) => Container(
            child: Column(
              children: <Widget>[
                Container(
               width: double.infinity,
                  height: 50,
                 // padding: AppStyles.defaultPadding2,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                   color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight : Radius.circular(25),

                    ),
                    border: Border.all(
                      color: Color(0xffD1D1D1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child: Container(
                          height: 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child:Icon(
                          Icons.arrow_drop_down_outlined,
                        )
                        ,
                      ),
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
