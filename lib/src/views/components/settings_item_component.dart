import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';

class SettingsItemComponent extends StatelessWidget {
  final String? title;
  final String icon;
  final Function onTap;

  SettingsItemComponent({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppShared.appTheme['background'],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppShared.appTheme['faq'],
                  shape: BoxShape.circle,
                ),
                child:
                    SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}$icon',color: Theme.of(context).primaryColor,)),
            SizedBox(
              width: 10,
            ),
            Text(
              title!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppShared.appTheme['text'].withOpacity(0.6),
              ),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(
                  Directionality.of(context) == TextDirection.rtl ? pi : 0,
                ),
                child: SvgPicture.asset(
                  '${Constants.ASSETS_IMAGES_PATH}arraw2.svg',
                  width: 15,
                  height: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SwitchSettingsItemComponent extends StatelessWidget {
  final String? title;
  final String icon;
  final Widget widget;

  SwitchSettingsItemComponent({
    required this.title,
    required this.icon,
        required this.widget,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppShared.appTheme['background'],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppShared.appTheme['faq'],
                  shape: BoxShape.circle,
                ),
                child:
                    SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}$icon',color: Theme.of(context).primaryColor,)),
            SizedBox(
              width: 10,
            ),
            Text(
              title!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppShared.appTheme['text'].withOpacity(0.6),
              ),
            ),
            Spacer(),
           this.widget,
          ],
        ),
      ),
    );
  }
}
