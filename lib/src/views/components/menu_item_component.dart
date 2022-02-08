import 'dart:math';

import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter_svg/svg.dart';
import '../../styles/app_styles.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';

class MenuItemComponent extends StatelessWidget {
  final String? title;
  final String? icon;
  final Function onTap;
  bool isLoading;
  String? isLoadingLabel;
  bool hasLeading;
  bool hasBorder;
Color? leadingColor;
  MenuItemComponent({
    required this.title,
     this.icon,
    required this.onTap,
    this.isLoading = false,
    this.hasLeading=true,
    this.hasBorder=true,
    this.isLoadingLabel,
    this.leadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        width: double.infinity,
        //padding: AppStyles.defaultPadding1,
       // margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        // decoration: BoxDecoration(
        //   color: AppShared.appTheme['background'],
        //   borderRadius: BorderRadius.circular(15),
        // ),
        child: 
        Row(
          children: [
            if(hasLeading)
Container(
              width: 34,
              height: 34,
            //  padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color:leadingColor!=null?leadingColor: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  '${Constants.ASSETS_IMAGES_PATH}$icon',
                  color: Colors.white,
                  width: 12,
                  height: 12,
                  fit: BoxFit.fill,
                ),
              ),
            ),
           
             Expanded(
               child: Container(
                 padding: EdgeInsets.symmetric(
                   vertical: 10
                 ),
                 decoration: BoxDecoration(
                   border: hasBorder?
                   
                   Border(
                     bottom: BorderSide(
                       color: Color(0xffEDF1F7)
                     )
                   ):null
                 ),
                 child: Row(
                   children: [
                      SizedBox(
              width: 10,
            ),
                     Expanded(
                       child: Text(
                              !isLoading ? title! : isLoadingLabel!,
                              style: textStyleMedium.copyWith(
                                fontSize: AppShared.screenUtil.setSp(18),

                                color: Colors.black
                              )
                            ),
                     ),
                          Container(
                      child: !isLoading
                      ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(
                            Directionality.of(context) == TextDirection.rtl
                                ? pi
                                : 0,
                          ),
                          child: SvgPicture.asset(
                            '${Constants.ASSETS_IMAGES_PATH}arraw2.svg',
                            color: Theme.of(context).primaryColor,
                            width: 15,
                            height: 15,
                          ),
                        )
                      : Container(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(),
                        ),
                    )
                   ],
                 ),
               ),
             ),
                  
          ],
          
        ),
        
      ),
    );
  }
}
