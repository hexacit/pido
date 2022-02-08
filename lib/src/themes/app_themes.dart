import 'package:flutter/material.dart';
import '../utils/app_shared.dart';
import '../utils/helpers.dart';

//\\... light theme ...||
ThemeData getLightTheme() => ThemeData(
      primarySwatch: MaterialColor(0xffE9D5E8, {
        50: Color(0xffE9D5E8),
        100: Color(0xffE9D5E8),
        200: Color(0xffE9D5E8),
        300: Color(0xffE9D5E8),
        400: Color(0xffE9D5E8),
        500: Color(0xffE9D5E8),
        600: Color(0xffE9D5E8),
        700: Color(0xffE9D5E8),
        800: Color(0xffE9D5E8),
        900: Color(0xffE9D5E8),
      }),
      backgroundColor:AppShared.appTheme['background'] ,
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppShared.appTheme['background']),
      primaryColor: Color(0xffE9D5E8),
      fontFamily:
      Helpers.changeAppFont(),
  textTheme: TextTheme(
    // subtitle1: textStyleBold.copyWith(
    //   color:Color(0xff352641),
    //
    // ),
    subtitle2: textStyleMedium.copyWith(
      color:Color(0xff998FA2),

    ),
    headline1: textStyleBold.copyWith(
      color: Colors.black,
    ),
    headline2: textStyleRegular.copyWith(
      color: Colors.black,
    ),
    headline3: textStyleMedium.copyWith(
      color: Colors.black,
    ),headline4: textStyleLight.copyWith(
    color: Colors.black,
  ),
  ),
      //'Roboto'
     // Helpers.changeAppFont(),
    );

//\\... dark theme ...||
ThemeData getDarkTheme() => ThemeData(
      primarySwatch:  MaterialColor(0xffE9D5E8, {
        50: Color(0xffE9D5E8),
        100: Color(0xffE9D5E8),
        200: Color(0xffE9D5E8),
        300: Color(0xffE9D5E8),
        400: Color(0xffE9D5E8),
        500: Color(0xffE9D5E8),
        600: Color(0xffE9D5E8),
        700: Color(0xffE9D5E8),
        800: Color(0xffE9D5E8),
        900: Color(0xffE9D5E8),
      }),
       backgroundColor:AppShared.appTheme['background'] ,
      primaryColor: Color(0xff1FA5F4),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppShared.appTheme['background']),
      brightness: Brightness.dark,
      fontFamily:
      //'Roboto'
      Helpers.changeAppFont(),
  textTheme: TextTheme(
    // subtitle1: textStyleBold.copyWith(
    //   color:Color(0xff352641),
    //
    // ),
    subtitle2: textStyleMedium.copyWith(
      color:Color(0xff998FA2),

    ),
    headline1: textStyleBold.copyWith(
      color: Colors.black,
    ),
    headline2: textStyleRegular.copyWith(
      color: Colors.black,
    ),
    headline3: textStyleMedium.copyWith(
      color: Colors.black,
    ),headline4: textStyleLight.copyWith(
    color: Colors.black,
  ),
  ),
    );
Color customGreen = Color(0xff92C83E);
Color customBrown = Color(0xff5A3D3A);
Color textColor = Color(0xff6E6E6E);
TextStyle textStyleNeoSansRegular = TextStyle(fontFamily: 'NeoSans',color: Colors.white,);
TextStyle textStyleNeoSansBold = TextStyle(fontFamily: 'NeoSans',color: Colors.white,fontWeight: FontWeight.bold);
TextStyle textStyleSFProText = TextStyle(fontFamily: 'SFProText',color: Colors.white,fontWeight: FontWeight.bold);
TextStyle textStyleNadiaSofia = TextStyle(fontFamily: 'NadiaSofia',color: Colors.white,fontWeight: FontWeight.bold);

TextStyle textStyleRegular = TextStyle(color: Colors.black,fontWeight: FontWeight.w400);
TextStyle textStyleBold = TextStyle(color: Colors.black,fontWeight: FontWeight.w700);
TextStyle textStyleLight = TextStyle(color: Colors.black,fontWeight: FontWeight.w300);
TextStyle textStyleMedium = TextStyle(color: Colors.black,fontWeight: FontWeight.w500);
