import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../styles/app_styles.dart';
import '../../../utils/app_shared.dart';

class ShimmerGiftComponent extends StatelessWidget {
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
            padding: AppStyles.defaultPadding3,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.grey,
                )),
            child: Row(
              children: <Widget>[
//                CircleAvatar(
//                  radius: 30,
//                  backgroundColor: Colors.grey,
//                ),
//                SizedBox(
//                  width: 15,
//                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 3,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 3,
                            color: Theme.of(context).primaryColor,
                          ),
                          Spacer(),
                          Container(
                            width: 50,
                            height: 3,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
//                            SvgPicture.asset(
//                              '${Constants.ASSETS_IMAGES_PATH}location.svg',
//                              width: 23,
//                              height: 23,
//                              color: Colors.grey,
//                            ),
//                            SizedBox(
//                              width: 10,
//                            ),
                            Expanded(
                              child: Text(
                                AppShared.appLang['Status']!,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
