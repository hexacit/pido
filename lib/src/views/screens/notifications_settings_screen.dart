import 'package:pido/src/controllers/api_controllers/user_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationsSettingsScreen extends StatelessWidget {
  UserController? userController = UserController.instance;

  Future<void> changeChatNotificationStatus() async {
    AppShared.sharedPreferencesController.setIsChatNotificationsEnabled(
        !AppShared.sharedPreferencesController.isChatNotificationsEnabled());
//       BaseResponse? response;

//     try {
//                         print('here2');

//         response = await userController!.receiveNotification(
//           AppShared.sharedPreferencesController.isChatNotificationsEnabled()
//               ? 0
//               : 1);
//                   print('here3');

//               if(!response.status!){
//                                   print('here4');

// Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);
// return false;
//               }

//     } catch (e) {
//                   print('here5');

//       Helpers.showMessage('SomethingWentWrong'.tr(), MessageType.MESSAGE_FAILED);

//     }
//     Helpers.showMessage(response!.message, MessageType.MESSAGE_SUCCESS);

//     return true;
  }

  Future<void> changeAppAdsNotificationStatus() async {
    AppShared.sharedPreferencesController.setIsAppAdsNotificationsEnabled(
        !AppShared.sharedPreferencesController.isAppAdsNotificationsEnabled());

//       BaseResponse? response;

//     try {
//         response = await userController!.receiveNotificationApp(
//           AppShared.sharedPreferencesController.isAppAdsNotificationsEnabled()
//               ? 0
//               : 1);

//               if(!response.status!){
// Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);
// return false;
//               }

//     } catch (e) {

//       Helpers.showMessage('SomethingWentWrong'.tr(), MessageType.MESSAGE_FAILED);

//     }
//      Helpers.showMessage(response!.message, MessageType.MESSAGE_SUCCESS);

//     return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F3F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Notifications'.tr(),
          style: textStyleNeoSansRegular.copyWith(
              fontSize: 17, color: Color(0xff222B45)),
        ),
        leading: BackButton(
          color: Color(0xff222B45),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: ListView(
            //physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              CustomSwitch(
                val: AppShared.sharedPreferencesController
                    .isChatNotificationsEnabled(),
                title: 'ChatsAndMessages'.tr(),
                onTap: (val) {
                  changeChatNotificationStatus();
                },
              ),
              Divider(
                indent: 15,
              ),
              CustomSwitch(
                val: AppShared.sharedPreferencesController
                    .isAppAdsNotificationsEnabled(),
                title: 'AppAdvertisement'.tr(),
                onTap: (val) {
                  changeAppAdsNotificationStatus();
                  print(val);
                },
              ),
              Divider(
                indent: 15,
              ),
              CustomSwitch(
                val: true,
                title: 'ServicesRecommendation'.tr(),
                onTap: (val) async {
                  print(val);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  late bool val;
  String? title;
  Function(bool val)? onTap;
  CustomSwitch({
    this.val = false,
    this.title,
    this.onTap,
  });

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: (){

      // },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(
                child: Text(
              widget.title!,
              style: TextStyle(
                fontFamily:
                    Helpers.changeFont(lang: context.locale.languageCode),
                fontSize: 15,
                color: Color(0xff222B45),
              ),
            )),
            CupertinoSwitch(
              value: widget.val,
              onChanged: (val) {
                print('here7');

                widget.onTap!(widget.val);
                print('here8');

                setState(() {
                  widget.val = val;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
