import 'package:pido/src/notifiers/screens_notifiers/main_screen_notifiers/screens_notifiers/home_screen_notifiers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import './src/notifiers/app_notifiers.dart';
import './src/services/start_up_service.dart';
import './src/themes/app_themes.dart';
import './src/utils/app_shared.dart';
import './src/utils/constants.dart';
import './src/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await StartUpService.instance!.init();

  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
      path:
          'assets/translations', 
      fallbackLocale: Locale('en', 'US'),
      child: MyApp()));
//  runApp(DevicePreview(builder: (_) => MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppNotifiers>(
          create: (_) => AppNotifiers(),

        ),
        ChangeNotifierProvider<HomeScreenNotifiers>(
          create: (_) => HomeScreenNotifiers(context),

        ),

      ],
      child: MyAppBody(),
    );
  }
}

class MyAppBody extends StatefulWidget {
  @override
  _MyAppBodyState createState() => _MyAppBodyState();
}

class _MyAppBodyState extends State<MyAppBody> {
  late AppNotifiers _appNotifiers;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();

    super.initState();
    _appNotifiers = Provider.of<AppNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AppNotifiers, Tuple2<bool, bool>>(
      selector: (_, value) =>
          Tuple2(value.refresh, value.isClosedForMaintainance),
      builder: (_, tuple, __) => tuple.item2
          ? MaterialApp(
              debugShowCheckedModeBanner: false,
              // locale: Locale(
              //     AppShared.sharedPreferencesController.getAppLang() ??
              //         Constants.LANG_AR),
             
              // [
              //   // ... app-specific localization delegate[s] here
              //   GlobalMaterialLocalizations.delegate,
              //   GlobalWidgetsLocalizations.delegate,
              //   GlobalCupertinoLocalizations.delegate,
              // ],

               localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
              theme: getLightTheme(),
              darkTheme: getDarkTheme(),
              themeMode:
                  AppShared.sharedPreferencesController.isDarkModeEnabled()
                      ? ThemeMode.dark
                      : ThemeMode.light,
              // supportedLocales: [
              //   const Locale(Constants.LANG_AR),
              //   const Locale(Constants.LANG_EN),
              //   const Locale(Constants.LANG_TR),
              //   // ... other locales the app supports
              // ],
//        builder: DevicePreview.appBuilder,

              title: Constants.APP_NAME,
              home: Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        '${Constants.ASSETS_IMAGES_PATH}maintenance.svg',
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                      Text(' مغلق من اجل الصيانة'),
                    ],
                  ),
                ),
              ),
            )
          : MaterialApp(
              debugShowCheckedModeBanner: false,
                 localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
              // locale: Locale(
              //     AppShared.sharedPreferencesController.getAppLang() ??
              //         Constants.LANG_AR),
              // localizationsDelegates: [
              //   // ... app-specific localization delegate[s] here
              //   GlobalMaterialLocalizations.delegate,
              //   GlobalWidgetsLocalizations.delegate,
              //   GlobalCupertinoLocalizations.delegate,
              // ],
              theme: getLightTheme(),
              darkTheme: getDarkTheme(),
              themeMode:
                  AppShared.sharedPreferencesController.isDarkModeEnabled()
                      ? ThemeMode.dark
                      : ThemeMode.light,
              // supportedLocales: [
              //   const Locale(Constants.LANG_AR),
              //   const Locale(Constants.LANG_EN),
              //   const Locale(Constants.LANG_TR),
              //   // ... other locales the app supports
              // ],
//        builder: DevicePreview.appBuilder,
              builder: BotToastInit(), //1. call BotToastInit
              navigatorObservers: [BotToastNavigatorObserver()],
              navigatorKey: _appNotifiers.navigationKey,
              title: Constants.APP_NAME,
              routes: appRoutes,
              initialRoute: Constants.SCREENS_SPLASH_SCREEN,
            ),
    );
  }
}
