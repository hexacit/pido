
import 'dart:async';

import 'package:pido/src/controllers/api_controllers/checkout_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/sub_models/place.dart';
import 'package:pido/src/models/sub_models/user.dart';
import 'package:pido/src/notifiers/app_notifiers.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pido/src/views/dialogs/order_success_dialog.dart';
import 'package:pido/src/views/screens/webview_screen.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class CheckOutScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _refresh = false;

  bool get refresh => _refresh;

  set refresh(bool value) {
    _refresh = value;
    notifyListeners();
  }
  bool _isBtnLoading = false;

  bool get isBtnLoading => _isBtnLoading;

  set isBtnLoading(bool value) {
    _isBtnLoading = value;
    notifyListeners();
  }

  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

 
  late AppNotifiers _appNotifiers;
late TextEditingController locationTextController;
  late GlobalKey<FormState>addressFormKey;
  late CheckOutController _checkOutController;
String? addressName;
String? addressStreet;
String? code;
int? selectedAreaId;
int? selectedAddressId;
int? selectedPayment;
String? date;
String? time;
  String? name;
  String? email;
  String? password;
  LatLng? guestLocation;

  BuildContext context;

  // ||... constructor ...||
  CheckOutScreenNotifiers(this. context) {
    addressFormKey= GlobalKey<FormState>();

    locationTextController=TextEditingController();
  _appNotifiers=Provider.of<AppNotifiers>(context);
    _checkOutController=CheckOutController.instance!;

  }



Future<void>checkOut()async{

      if(!addressFormKey.currentState!.validate()||selectedPayment==null
          ||(AppShared.sharedPreferencesController.getIsLogin()&&selectedAddressId==null)
          ||(!AppShared.sharedPreferencesController.getIsLogin()&&guestLocation==null)
      ){
        if((!AppShared.sharedPreferencesController.getIsLogin()&&guestLocation==null)){
          Helpers.showMessage('chooseAddress'.tr(), MessageType.MESSAGE_FAILED);
          return;
        }
        if((AppShared.sharedPreferencesController.getIsLogin()&&selectedAddressId==null)){
          Helpers.showMessage('chooseAddress'.tr(), MessageType.MESSAGE_FAILED);
          return;
        }
        if(selectedPayment==null){
          Helpers.showMessage('SelectPaymentMethod'.tr(), MessageType.MESSAGE_FAILED);
          return;
        }
        return;
      }
      addressFormKey.currentState!.save();



    try{
      isBtnLoading=true;
      BaseResponse response =await _checkOutController.checkOut(data:
      {
        'code':code,
        'address_id':selectedAddressId,
        'area_id':selectedAreaId,
        'fcm_token':AppShared.firebaseToken,
        'type_mobile':AppShared.deviceType,
        'lang':AppShared.sharedPreferencesController.getAppLang(),
        'name':name,
        'email':email,
        'password':password,
        'latitude':guestLocation?.latitude,
        'longitude':guestLocation?.latitude,
        'street':addressStreet,
        'address_name':addressName,
        'availabile_time':time,
        'availabile_date':date,
        'payment_method':selectedPayment,

      }
      );
      if(response.status!){
        if((!AppShared.sharedPreferencesController.getIsLogin())){
          print('new user');
          await AppShared.sharedPreferencesController.setIsLogin(true);
          User? user = User.fromJson(response.data);
          await AppShared.sharedPreferencesController
              .setUserData(user);
          AppShared.currentUser=user;
        }
        String url=response.urlData as String;
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WebViewScreen( url: url,)));
        // showDialog(context: context, builder: (context){
        //   return OrderSuccessDialog();
        // });


      }
      else{
        Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);

      }
      isBtnLoading=false;

    }
    on Exception catch(e){
      print(e);
      isBtnLoading=false;

      Helpers.showMessage('SomethingWentWrong'.tr(), MessageType.MESSAGE_FAILED);

    }


}




// ||...................... logic methods ............................||


}
