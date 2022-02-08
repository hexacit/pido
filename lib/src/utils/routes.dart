//||... File for app routes ...||

import 'package:pido/src/views/screens/chang_password_screen.dart';
import 'package:pido/src/views/screens/checkout_screen.dart';
import 'package:pido/src/views/screens/faq_screen.dart';
import 'package:pido/src/views/screens/main_screen/screens/home_screen.dart';
import 'package:pido/src/views/screens/new_address_screen.dart';
import 'package:pido/src/views/screens/order_details_screen.dart';
import 'package:pido/src/views/screens/order_history_screen.dart';
import 'package:pido/src/views/screens/shipping_addresses_screen.dart';
import 'package:pido/src/views/screens/forget_password_screen.dart';
import 'package:pido/src/views/screens/choose_address_location_screen.dart';
import 'package:pido/src/views/screens/main_screen/screens/notifications_screen.dart';
import 'package:pido/src/views/screens/my_cart_screen.dart';
import 'package:pido/src/views/screens/notifications_settings_screen.dart';
import 'package:pido/src/views/screens/profile_screen.dart';
import 'package:pido/src/views/screens/register_screen.dart';
import 'package:pido/src/views/screens/search_screen.dart';
import 'package:pido/src/views/screens/product_details_screen.dart';
import 'package:pido/src/views/screens/settings_screen.dart';
import 'package:pido/src/views/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:pido/src/views/screens/user_addresses_screen.dart';
import '../utils/constants.dart';
import '../views/screens/html_content_screen.dart';
import '../views/screens/contact_us_screen.dart';
import '../views/screens/google_map_screen.dart';
import '../views/screens/main_screen/main_screen.dart';
import '../views/screens/my_favorite_screen.dart';
import '../views/screens/select_lang_screen.dart';
import '../views/screens/sign_in_screen.dart';
import '../views/screens/splash_screen.dart';

Map<String, Widget Function(BuildContext context)> appRoutes = {
    


  // ||... CUSTOMER SCREENS ...||
  Constants.SCREENS_SPLASH_SCREEN: (_) => SplashScreen(),
  Constants.SCREENS_REGISTER_SCREEN: (_) => RegisterScreen(),
  Constants.SCREENS_SIGN_IN_SCREEN: (_) => SignInScreen(),
  Constants.SCREENS_SELECT_LANG_SCREEN: (_) => SelectLangScreen(),
  Constants.SCREENS_SEARCH_SCREEN: (_) => SearchScreen(),
  Constants.SCREENS_FORGET_PASSWORD_SCREEN: (_) => ForgetPasswordScreen(),
  Constants.SCREENS_NEW_ADDRESS_SCREEN: (_) => NewAddressScreen(),
  Constants.SCREENS_ORDER_HISTORY_SCREEN: (_) => OrderHistoryScreen(),
  Constants.SCREENS_ORDER_DETAILS_SCREEN: (_) => OrderDetailsScreen(),
  Constants.SCREENS_CHANGE_PASSWORD_SCREEN: (_) => ChangePasswordScreen(),
  Constants.SCREENS_PRODUCT_DETAILS_SCREEN: (_) => ProductDetailsScreen(),
  Constants.SCREENS_NOTIFICATIONS_SCREEN: (_) => NotificationsScreen(),
  Constants.SCREENS_MAIN_SCREEN: (_) => MainScreen(),
  Constants.SCREENS_HOME_SCREEN: (_) => HomeScreen(),
  Constants.SCREENS_HTML_CONTENT_SCREEN: (_) => HtmlContentScreen(),
  Constants.SCREENS_MY_FAVORITE_SCREEN: (_) => MyFavoriteScreen(),
  Constants.SCREENS_CONTACT_US_SCREEN: (_) => ContactUsScreen(),
  Constants.SCREENS_GOOGLE_MAP_SCREEN: (_) => GoogleMapScreen(),
  Constants.SCREENS_NOTIFICATIONS_SETTINGS_SCREEN: (_) => NotificationsSettingsScreen(),
  Constants.SCREENS_MY_CART_SCREEN: (_) => MyCartScreen(),
  Constants.SCREENS_CHECKOUT_SCREEN: (_) => CheckoutScreen(),
  Constants.SCREENS_PROFILE_SCREEN: (_) => ProfileScreen(),
  Constants.SCREENS_SHIPPING_ADDRESSES_SCREEN: (_) => ShippingAddressesScreen(),
  Constants.SCREENS_SETTINGS_SCREEN: (_) => SettingsScreen(),
  Constants.SCREENS_USER_ADDRESSES_SCREEN: (_) => UserAddressesScreen(),
  Constants.SCREENS_FAQ_SCREEN: (_) => FaqScreen(),
  Constants.SCREENS_SIGN_UP_SCREEN: (_) => SignUpScreen(),
  Constants.SCREENS_CHOOSE_ADDRESS_LOCATION_SCREEN: (_) =>
      ChooseAddressLocationScreen(),
  

  
};
