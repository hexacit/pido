
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/controllers/api_controllers/auth_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/custom_btn_component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class LogoutDialog extends StatefulWidget {
  final Function onSuccess;
  const LogoutDialog({
    Key? key,
    required this.onSuccess,
  }) : super(key: key);

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  late AuthController _authController;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authController=AuthController.instance!;

}
bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context)
            .size
            .height *
            0.2,
        width: MediaQuery.of(context)
            .size
            .width *
            0.6,
        child:isLoading?
            Center(
              child: CircularProgressIndicator(),
            )
            : Column(
          mainAxisAlignment:
          MainAxisAlignment.spaceAround,
          children: [
            Text(
              'ConfirmLogOut'.tr(),
              style: textStyleNeoSansRegular
                  .copyWith(
                  color: Colors.black,
                  fontSize: 12),
            ),
            Text(
              'AreYouSureYouWantToLogOut'
                  .tr(),
              style: textStyleNeoSansRegular
                  .copyWith(
                  color: Colors.black,
                  fontSize: 12),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading=true;
                      });
                      // Navigator.pop(
                      //     context);
                      try {
                        BaseResponse baseResponse=
                        await _authController.logout();
                        if(baseResponse.status!){
                          Helpers.showMessage('done'.tr(), MessageType.MESSAGE_SUCCESS);
                          AppShared.sharedPreferencesController.clearUserData();
                          print('after logout  ${AppShared.currentUser?.name}');
                          widget.onSuccess();

                          Navigator.of(context).pop();
                          //Navigator.of(context).pop();



                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, Constants.SCREENS_MAIN_SCREEN, (route) => false);
                        }else{
                          Navigator.of(context).pop();
                          Helpers.showMessage('SomethingWentWrong'.tr(), MessageType.MESSAGE_FAILED);
                        }
                        setState(() {
                          isLoading=false;
                        });

                      } on Exception catch(e){
                        setState(() {
                          isLoading=false;
                        });
                      }
                    },
                    child: Text(
                      'Yes'.tr(),
                      textAlign:
                      TextAlign.center,
                      style: textStyleNeoSansRegular
                          .copyWith(
                          color: Colors
                              .black,
                          fontSize: 12),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(
                          context);
                    },
                    child: Text(
                      'No'.tr(),
                      textAlign:
                      TextAlign.center,
                      style: textStyleNeoSansRegular
                          .copyWith(
                          color: Colors
                              .black,
                          fontSize: 12),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}