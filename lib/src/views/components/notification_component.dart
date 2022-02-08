import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../models/sub_models/notification.dart' as not;
import '../../styles/app_styles.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class NotificationComponent extends StatelessWidget {
  final not.NotificationItem notification;

  NotificationComponent(this.notification);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppShared.appTheme['background'],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            child: Text(
              notification.message!,
              style: TextStyle(
                fontSize: 16,
                color: AppShared.appTheme['text'],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                padding: AppStyles.defaultPadding3,
                margin: const EdgeInsetsDirectional.only(end: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                  ),
                ),
                child: SvgPicture.asset(
                  '${Constants.ASSETS_IMAGES_PATH}notifications_selected.svg',
                  color: Colors.white,
                  width: 25,
                  height: 25,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    '${Constants.ASSETS_IMAGES_PATH}time.svg',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    Helpers.formatDate(notification.createdAt!),
                    style: TextStyle(
                      fontSize: 13,
                      color: AppShared.appTheme['text2'],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
