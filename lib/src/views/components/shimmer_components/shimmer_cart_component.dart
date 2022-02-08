import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../styles/app_styles.dart';
import '../../../utils/app_shared.dart';
import '../../../utils/constants.dart';

class ShimmerCartComponent extends StatelessWidget {
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
          itemBuilder: (_, index) => Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: AppStyles.defaultPadding3,
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 120,
                              height: 5,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Total : ---${AppShared.currency}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 0.5,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    '${Constants.ASSETS_IMAGES_PATH}minus.svg',
                                    width: 2,
                                    height: 2,
                                  ),
                                  Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    '${Constants.ASSETS_IMAGES_PATH}plus.svg',
                                    width: 12,
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              PositionedDirectional(
                end: 0,
                top: 25,
                child: Container(
                  padding: AppStyles.defaultPadding2,
                  margin: const EdgeInsetsDirectional.only(end: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    '${Constants.ASSETS_IMAGES_PATH}close.svg',
                    width: 15,
                    height: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
