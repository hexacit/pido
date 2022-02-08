import 'package:pido/src/controllers/api_controllers/auth_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/notifiers/app_notifiers.dart';
import 'package:pido/src/notifiers/screens_notifiers/main_screen_notifiers/main_screen_notifiers.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/views/components/custom_app_bar_component.dart';
import 'package:pido/src/views/dialogs/language_dialog.dart';
import 'package:pido/src/views/dialogs/logout_dialog.dart';
import 'package:pido/src/views/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';


class AppDrawer extends StatefulWidget {
 final  BuildContext context;
  const AppDrawer({
    Key? key,
  required  this.context,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late AppNotifiers _appNotifiers;
  late MainScreenNotifiers _mainScreenNotifiers;
  late AuthController _authController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appNotifiers = Provider.of<AppNotifiers>(context, listen: false);
    _mainScreenNotifiers = Provider.of<MainScreenNotifiers>(context, listen: false);

    _authController=AuthController.instance!;

  }
  void changePage(int index){
    Navigator.of(context).pop();
    _mainScreenNotifiers.selectedPage=index;
    _mainScreenNotifiers.pageController!.jumpToPage(index,
        // curve: Curves.bounceIn,
        // duration: Duration(milliseconds: 300)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.7,
      decoration: BoxDecoration(

        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(20),
            bottomEnd: Radius.circular(20)

        ),
          image: DecorationImage(
              image:
              AssetImage('${Constants.ASSETS_IMAGES_PATH}bg.png'),
              fit: BoxFit.cover
          )
      ),
      child: Container(
        color: Colors.white38,
        child: Column(
          children: [
            CustomAppBarComponent(title: 'Menu'.tr()),
           SizedBox(
             height: 20.h,
           ),

            Expanded(
              child: Column(
                children: [
                  GestureDetector(
                    onTap:!AppShared.sharedPreferencesController.getIsLogin ()?
                        null
                        :(){
                      changePage(7);
                    },
                    child: Container(


                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10),

                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor,
                                border: Border.all(
                                  color: Colors.black,
                                )
                            ),
                            child:SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}logo.svg') ,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(AppShared.sharedPreferencesController.getIsLogin()?AppShared.currentUser?.name??'': '',
                            style: textStyleBold.copyWith(
                              fontSize: AppShared.screenUtil.setSp(18)
                            ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  DrawerItem(
                    onTap: (){
                      // Navigator.of(context).pop();
                      changePage(0);

                    },
                    icon: 'home-drawer',
                    title: 'Home'.tr(),
                  ),
                  DrawerItem(
                    onTap: (){
                      // Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(Constants.SCREENS_MY_FAVORITE_SCREEN);

                    },
                    icon: 'favorite',
                    title: 'MyFavorite'.tr(),
                  ),
                  if(AppShared.sharedPreferencesController.getIsLogin())
                  DrawerItem(
                    onTap: (){
                      // Navigator.of(context).pop();
                      changePage(1);

                    },
                    icon: 'order-drawer',
                    title: 'OrdersHistory'.tr(),
                  ),
                  // if(AppShared.sharedPreferencesController.getIsLogin())
                  //   DrawerItem(
                  //   onTap: (){
                  //     // Navigator.of(context).pop();
                  //     Navigator.of(context).pushNamed(Constants.SCREENS_SHIPPING_ADDRESSES_SCREEN);
                  //
                  //
                  //   },
                  //   icon: 'vehicle',
                  //   title: 'ShippingAddresses'.tr(),
                  // ),
                  if(AppShared.sharedPreferencesController.getIsLogin())
                    DrawerItem(
                    onTap: (){
                      // Navigator.of(context).pop();
                      changePage(5);

                    },
                    icon: 'notification-drawer',
                    title: 'Notifications'.tr(),
                  ),
                  DrawerItem(
                    onTap: (){
                      // Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return LanguageDialog();
                          });

                    },
                    icon: 'languags-drawer',
                    title: 'language'.tr(),
                    trailing: AppShared.sharedPreferencesController.getAppLang(),
                  ),
                  DrawerItem(
                    onTap: (){
                      // Navigator.of(context).pop();
                      changePage(4);

                    },
                    icon: 'settings-drawer',
                    title: 'Settings'.tr(),
                  ),
                  DrawerItem(
                    onTap: (){
                      // Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(Constants.SCREENS_HTML_CONTENT_SCREEN,
                          arguments: Constants.STATIC_SCREENS_ABOUT_US);

                    },
                    icon: 'aboutus-drawer',
                    title: 'AboutUs'.tr(),
                  ),
                  DrawerItem(
                    onTap: (){
                      // Navigator.of(context).pop();
                      changePage(6);

                    },
                    icon: 'faq-drawer',
                    title: 'FAQ'.tr(),
                  ),
                  DrawerItem(
                    onTap: (){
                      // Navigator.of(context).pop();
                      changePage(3);

                    },
                    icon: 'contact-drawer',
                    title: 'ContactUs'.tr(),
                  ),
                  if(AppShared.sharedPreferencesController.getIsLogin())
                    DrawerItem(
                      onTap: (){
                        // Navigator.of(context).pop();
                        logout();

                      },
                      icon: 'signout-drawer',
                      title: 'Logout'.tr(),
                    ),

                  if(!AppShared.sharedPreferencesController.getIsLogin())
                    DrawerItem(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                            SignInScreen(
                              isNavigateToCart: true,
                            )));
                      

                      },
                      icon: 'user',
                      title: 'Login'.tr(),
                    ),
                ],
              ),
            ),


            Container(
              alignment: Alignment.bottomCenter,
              padding:  EdgeInsets.only(left: 20.0.w,right: 20.0.w,bottom: 50.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      launch(AppShared.settingsResponse.facebook!);
                    },
                    child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}face-drawer.svg',
                    ),


                  ),
                  InkWell(
                    onTap: (){
                      launch(AppShared.settingsResponse.instagram!);
                    },
                    child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}instagram-drawer.svg',
                    ),

                  ),
                  InkWell(
                    onTap: (){
                      launch(AppShared.settingsResponse.twitter!);
                    },
                    child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}twetter-drawer.svg',
                    ),

                  ),
                  InkWell(
                    onTap: (){
                      launch(AppShared.settingsResponse.tikTok!);
                    },
                    child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}tiktok-drawer.svg',
                    ),

                  ),
                ],
              ),
            ),









          ],
        ),
      ),
    );
  }

  Future<void>logout()async{
    showDialog(
        context: context,
        builder: (_) {
          return LogoutDialog(
            onSuccess: (){
              changePage(0);
            },
          );
        });
    // showDialog(context: context, builder: (context){
    //   return Dialog(
    //     child: Container(
    //       height: MediaQuery.of(context).size.height*0.3,
    //       child: Center(
    //         child: CircularProgressIndicator(),
    //       ),
    //     ),
    //   );
    // });
    // try {
    //   BaseResponse baseResponse=
    //   await _authController.logout();
    //   if(baseResponse.status!){
    //     Helpers.showMessage('done'.tr(), MessageType.MESSAGE_SUCCESS);
    //     AppShared.sharedPreferencesController.clearUserData();
    //     print('after logout  ${AppShared.currentUser?.name}');
    //     changePage(0);
    //     Navigator.of(context).pop();
    //     //Navigator.of(context).pop();
    //
    //
    //
    //     // Navigator.pushNamedAndRemoveUntil(
    //     //     context, Constants.SCREENS_MAIN_SCREEN, (route) => false);
    //   }else{
    //     Navigator.of(context).pop();
    //     Helpers.showMessage('SomethingWentWrong'.tr(), MessageType.MESSAGE_FAILED);
    //   }
    //
    // } on Exception catch(e){
    //
    // }


  }
}

class DrawerItem extends StatelessWidget {
  final Function onTap;
  final String icon;
  final String title;
  final String? trailing;
  const DrawerItem({Key? key,
  required this.onTap,
    required this.icon,
    required this.title,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        child: Row(
          children: [
        Expanded(
          child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}$icon.svg',
           // color: this.iconColor,
          ),
        ),

            SizedBox(
              width: 15.w,
            ),
            Expanded(
              flex: 5,
              child: Text(this.title,
                style:  Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: AppShared.screenUtil.setSp(14)
                ),
              ),
            ),
            if(this.trailing !=null)
            Text(this.trailing??'',
              style:  Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: AppShared.screenUtil.setSp(14)
              ),
            ),
          ],
        ),
      ),

    );
  }
}
