import 'dart:io';

import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/app_drawer.dart';
import 'package:pido/src/views/screens/contact_us_screen.dart';
import 'package:pido/src/views/screens/faq_screen.dart';
import 'package:pido/src/views/screens/main_screen/screens/notifications_screen.dart';
import 'package:pido/src/views/screens/my_favorite_screen.dart';
import 'package:pido/src/views/screens/order_history_screen.dart';
import 'package:pido/src/views/screens/profile_screen.dart';
import 'package:pido/src/views/screens/require_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pido/src/views/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import '../../../notifiers/screens_notifiers/main_screen_notifiers/main_screen_notifiers.dart';
import '../../../utils/app_shared.dart';
import '../../../utils/constants.dart';
import '../../components/parent_component.dart';
import './screens/home_screen.dart';
import './screens/menu_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<MainScreenNotifiers>(
        create: (_) => MainScreenNotifiers(context),
        child: MainScreenBody(),
      ),
    );
  }
}

class MainScreenBody extends StatefulWidget {
  static GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  _MainScreenBodyState createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> {
  late MainScreenNotifiers _mainScreenNotifiers;

  @override
  void initState() {
    super.initState();

    _mainScreenNotifiers =
        Provider.of<MainScreenNotifiers>(context, listen: false);
  }

  bool _isDoubleClickToExit = false;

  Future<bool> _onWillPop() async {
    MainScreenBody.  scaffoldState.currentState!.hideCurrentSnackBar();
    if (!_isDoubleClickToExit) {
      MainScreenBody.  scaffoldState.currentState!.showSnackBar(SnackBar(
          content: Text(
        AppShared.appLang['ExitApp']!,
        style: TextStyle(color: Colors.white),
      )));
      _isDoubleClickToExit = true;
      return false;
    } else {
      exit(0);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: MainScreenBody.scaffoldState,
        drawer: AppDrawer(
          context: context,
        ),
//         bottomNavigationBar: Card(
//           elevation: 20,
//           margin: EdgeInsets.all(0),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 6),
//             height: AppShared.screenUtil.setHeight(50),
//             child: Selector<MainScreenNotifiers, int>(
//               selector: (_, value) => value.selectedPage,
//               builder: (_, selectedPage, __) => Row(
//                 children: <Widget>[
//                   Flexible(
//                     flex: 2,
//                     fit: FlexFit.tight,
//                     child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             // if(AppShared.selectedCategory==null){
//                             //   Navigator.of(context).pushNamed(Constants.SCREENS_CATEGORY_SCREEN).then((value) {
//                             //
//                             //     setState(() {
//                             //
//                             //     });
//                             //   });
//                             //   return;
//                             // }
//                             _mainScreenNotifiers.selectedPage = 0;
//                             _mainScreenNotifiers.pageController!.jumpToPage(0);
//                           },
//                           child: Container(
//                             height: double.infinity,
//                             //  padding: EdgeInsets.all(selectedPage == 0 ? 18 : 20),
//
//                             child: Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   SvgPicture.asset(
//                                     '${Constants.ASSETS_IMAGES_PATH}home-nav.svg',
//                                     color: selectedPage == 0
//                                         ? Theme.of(context).primaryColor
//                                         : AppShared.appTheme['icons'],
//                                   ),
// //                               Text(
// // 'Home'.tr(),
// //                                 style: textStyleNeoSansRegular.copyWith(
// //                                   fontSize:AppShared.screenUtil.setSp(10) ,
// //                                   color: selectedPage == 0
// //                                       ? Theme.of(context).primaryColor
// //                                       : AppShared.appTheme['icons'],
// //                                 ),
// //                               ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                          InkWell(
//                       onTap: () {
//                         _mainScreenNotifiers.selectedPage = 1;
//                         _mainScreenNotifiers.pageController!.jumpToPage(1);
//                       },
//                       child: Container(
//                         height: double.infinity,
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               SvgPicture.asset(
//                                 '${Constants.ASSETS_IMAGES_PATH}chat.svg',
//                                 color: selectedPage == 1
//                                     ? Theme.of(context).primaryColor
//                                     : AppShared.appTheme['icons'],
//                               ),
//                               // Text(
//                               //   'notification'.tr(),
//                               //   style: textStyleNeoSansRegular.copyWith(
//                               //     fontSize:AppShared.screenUtil.setSp(10) ,
//                               //     color: selectedPage == 1
//                               //         ? Theme.of(context).primaryColor
//                               //         : AppShared.appTheme['icons'],
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                       ],
//                     ),
//                   ),
//
//                   Flexible(
//                     fit: FlexFit.tight,
//                     child: InkWell(
//                       onTap: (){
//
//
//                       },
//                       // child: Stack(
//                       //   clipBehavior: Clip.none,
//                       //   children: [
//                       //     Positioned.fill(
//                       //       top: -50,
//                       //       child: Padding(
//                       //         padding: const EdgeInsets.all(8.0),
//                       //         child: Container(
//                       //           decoration: BoxDecoration(
//                       //             shape: BoxShape.circle,
//                       //             gradient: LinearGradient(colors: [
//                       //               Color(0xff62BFF6),
//                       //               Theme.of(context).primaryColor
//                       //             ],
//                       //             begin: Alignment.topCenter,
//                       //             end: Alignment.bottomCenter,
//                       //
//                       //             )
//                       //           ),
//                       //           child: Container(
//                       //             height: double.infinity,
//                       //             child: Center(
//                       //               child:
//                       //               IconButton(onPressed: (){
//                       //             //      _mainScreenNotifiers.selectedPage = 2;
//                       //             // _mainScreenNotifiers.pageController!.jumpToPage(2);
//                       //               }, icon:Icon(Icons.add,color: Colors.white,
//                       //               size: 35,))
//                       //
//                       //
//                       //
//                       //
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                     ),
//                   ),
//                   Flexible(
//                     fit: FlexFit.tight,
//                     flex: 2,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             _mainScreenNotifiers.selectedPage = 3;
//                             _mainScreenNotifiers.pageController!.jumpToPage(2);
//                           },
//                           child: Container(
//                             height: double.infinity,
//                             child: Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   SvgPicture.asset(
//                                     '${Constants.ASSETS_IMAGES_PATH}notification-nav.svg',
//                                     color: selectedPage == 3
//                                         ? Theme.of(context).primaryColor
//                                         : AppShared.appTheme['icons'],
//                                   ),
//                                   // Text(
//                                   //   'Messages'.tr(),
//                                   //   style: textStyleNeoSansRegular.copyWith(
//                                   //     fontSize:AppShared.screenUtil.setSp(10) ,
//                                   //     color: selectedPage == 3
//                                   //         ? Theme.of(context).primaryColor
//                                   //         : AppShared.appTheme['icons'],
//                                   //   ),
//                                   // ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         InkWell(
//                       onTap: () {
//                         _mainScreenNotifiers.selectedPage = 4;
//                         _mainScreenNotifiers.pageController!.jumpToPage(3);
//                       },
//                       child: Container(
//                         height: double.infinity,
//                         child: Center(
//                           child: Column(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//
//                             children: [
//                               SvgPicture.asset(
//                                 '${Constants.ASSETS_IMAGES_PATH}profile-nav.svg',
//                                 color: selectedPage == 4
//                                     ? Theme.of(context).primaryColor
//                                     : AppShared.appTheme['icons'],
//                               ),
//                               // Text(
//                               //     'Settings'.tr(),
//                               //     style: textStyleNeoSansRegular.copyWith(
//                               //     fontSize:AppShared.screenUtil.setSp(10) ,
//                               //       color: selectedPage == 4
//                               //           ? Theme.of(context).primaryColor
//                               //           : AppShared.appTheme['icons'],
//                               //     ),
//                               //   ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                       ],
//                     ),
//                   ),
//
//                 ],
//               ),
//             ),
//           ),
//         ),
        body:
    Selector<MainScreenNotifiers, int>(
               selector: (_, value) => value.selectedPage,
               builder: (_, selectedPage, __) =>
              PageView(
              controller: _mainScreenNotifiers.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                HomeScreen(),
                OrderHistoryScreen(),
                MyFavoriteScreen(),
                ContactUsScreen(),
                SettingsScreen(),
                // AppShared.sharedPreferencesController.getIsLogin()
                //     ?
              //  ExploreScreen(),
                // MyOrdersScreen(),
                // : SignInScreen(),
                // AppShared.sharedPreferencesController.getIsLogin()
                //     ?
                NotificationsScreen(),
                FaqScreen(),
                ProfileScreen(),
                // :
                // RequireLoginScreen(),
                AppShared.sharedPreferencesController.getIsLogin()
                    ?
                MenuScreen()
                 : RequireLoginScreen(),
              ],
            ),

        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //
        // floatingActionButton:InkWell(
        //   onTap: (){
        //     if( !AppShared.sharedPreferencesController.getIsLogin()){
        //       Helpers.showMessage('LoginRequire'.tr(), MessageType.MESSAGE_FAILED);
        //       return;
        //     }
        //     Navigator.of(context).pushNamed(Constants.SCREENS_CHOOSE_CATEGORY_SCREEN);
        //   },
        //   child: Container(
        //     padding: const EdgeInsets.all(8.0),
        //       decoration: BoxDecoration(
        //                     shape: BoxShape.circle,
        //                     gradient: LinearGradient(colors: [
        //                       Color(0xff62BFF6),
        //                       Theme.of(context).primaryColor
        //                     ],
        //                     begin: Alignment.topCenter,
        //                     end: Alignment.bottomCenter,
        //
        //                     )
        //                   ),
        //     child: Icon(Icons.add,color: Colors.white,
        //       size: 35,),
        //   ),
        // )

        // FloatingActionButton(
        //   onPressed: (){
        //     Navigator.of(context).pushNamed(Constants.SCREENS_CHOOSE_CATEGORY_SCREEN);
        //
        //   },
        //
        //   child: Icon(Icons.add,color: Colors.white,
        //     size: 35,),
        //
        // ),
      ),
    );
  }
}
