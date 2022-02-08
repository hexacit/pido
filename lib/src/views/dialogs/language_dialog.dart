
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pido/src/controllers/api_controllers/user_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/notifiers/app_notifiers.dart';
import 'package:pido/src/styles/app_styles.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/custom_btn_component.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {

  String? local;
  int? localIndex;
  late AppNotifiers _appNotifiers;
  late UserController _userController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userController=UserController.instance!;
    local=AppShared
        .sharedPreferencesController
        .getAppLang();
    _appNotifiers=Provider.of<AppNotifiers>(context,listen: false);
  }

  Future<void>switchLang()async{
    setState(() {
      isLoading=true;
    });
    try{
      BaseResponse response=await _userController.changeLanguage(lang: '$local');
      if(response.status!){
        AppShared
            .sharedPreferencesController
            .setAppLang(
            local!);
        context.locale = Locale( local!,Constants.localesCountries[localIndex!] );
        Helpers.changeAppFont();

        // print('here change lang');
       // _appNotifiers.refresh=!_appNotifiers.refresh;
        Navigator.of(context).pop();

      }else{
        Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);

      }
      setState(() {
        isLoading=false;
      });

    }on Exception catch(e){
      Helpers.showMessage('SomethingWentWrong'.tr(), MessageType.MESSAGE_FAILED);
      setState(() {
        isLoading=false;
      });

    }

  }
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height*0.5,
        padding: EdgeInsets.symmetric(vertical: 20),

        child: Column(
          children: [
            Padding(
              padding: AppStyles.defaultPadding3,
              child: Text('ChooseLanguage'.tr(),
                style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: AppShared.screenUtil.setSp(20),
                ),
              ),
            ),
            SizedBox(
              height: AppShared.screenUtil.setHeight(15),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: Constants.locales.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    local= Constants.locales[index];
                    localIndex=index;
                    setState(() {

                    });

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color:  Constants.locales[index]==
                        local
                        ?Theme.of(context).primaryColor.withOpacity(0.16):Colors.transparent,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('${Constants.ASSETS_IMAGES_PATH}${Constants.localesFlags[index]}',
                            width: 35.w,
                            height: 30.h,
                            fit: BoxFit.fill,

                          ),
                        ),
                        Expanded(child: Text(
                          Constants.localesNames[index],
                        ),),

                      ],


                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
              child: isLoading?
              Center(child: CircularProgressIndicator(),)
                  : Row(
                children: [
                  Expanded(child: CustomBtnComponent(

                    text: 'Close'.tr(), onTap: (){
                    Navigator.of(context).pop();
                  }
                    ,color: Color(0xffB9B9B9),
                    hasBorder: false,
                  ),

                  ),
                  SizedBox(
                    width: 10,
                  ),


                  Expanded(
                    child: CustomBtnComponent(
                        text: 'Ok'.tr(), onTap: ()async{


                      if (AppShared
                          .sharedPreferencesController
                          .getAppLang() ==
                          local)
                        return;
                      await switchLang();
                      //_appNotifiers.refresh=!_appNotifiers.refresh;


                    }),
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}