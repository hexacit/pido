import 'dart:async';

import 'package:pido/src/controllers/api_controllers/bids_controller.dart';
import 'package:pido/src/controllers/api_controllers/cart_controller.dart';
import 'package:pido/src/controllers/api_controllers/products_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/api_models/responses/product_details_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../utils/app_shared.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductDetailsScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||

  bool _isError = false;
  bool _isLoading = true;
  bool _isBtnLoading = false;
  bool _refresh = false;
  int _cartQuantity = 0;

  bool _isSendingRequest = false;

  bool _isFavorite=false;


  int get cartQuantity => _cartQuantity;
  set cartQuantity(int value) {
    _cartQuantity = value;
    notifyListeners();
  }
  bool get refresh => _refresh;

  set refresh(bool value) {
    _refresh = value;
    notifyListeners();
  }


  bool get isBtnLoading => _isBtnLoading;

  set isBtnLoading(bool value) {
    _isBtnLoading = value;
    notifyListeners();
  }

  bool get isSendingRequest => _isSendingRequest;

  set isSendingRequest(bool value) {
    _isSendingRequest = value;
    notifyListeners();
  }

  bool get isFavorite => _isFavorite;

  set isFavorite(bool value) {
    _isFavorite = value;
    notifyListeners();
  }

  bool get isError => _isError;

  set isError(bool value) {
    _isError = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;

  int? productId;
  late ProductsController productsController;
  late CartController cartController;
  late BidsController bidsController;
  ProductDetails? productDetailsData;




  // ||... constructor ...||
  ProductDetailsScreenNotifiers(this.context, this.productId) {
    productsController = ProductsController.instance!;
    cartController = CartController.instance!;


    init();

  }

// ||...................... logic methods ............................||

  // init.
  Future<void> init({isInit: true}) async {
   
    await getProductDetails(isInit: isInit);
  }


  Future<void> getProductDetails({bool isInit = true}) async {

    if(!isInit){

       isError = false;
      isLoading = true;
    }
    BaseResponse baseResponse;
    try {

      baseResponse= await productsController.getProductDetailsById(productId:
      productId
      );


      if (baseResponse.status!) {
        productDetailsData= ProductDetails.fromJson( baseResponse.data);
        cartQuantity=productDetailsData!.isCart!;
        isFavorite=productDetailsData!.isFavoriteValue;
       // isFavorite=productDetailsData!.product!.isUserFavouriteProduct!;

      }
      else{
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
        isError = true;

      }
      isLoading = false;
    }on Exception catch (error) {
      isError = true;
      isLoading = false;
      print(error);
      Helpers.showMessage(
          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
    }
  }


  Future<void> addToCart() async {
    // if(cartQuantity==0){
    //   Helpers.showMessage('EnterQuantityFirst'.tr(), MessageType.MESSAGE_FAILED);
    //   return;
    // }
    try {
      isBtnLoading=true;
      BaseResponse response = await cartController.addToCart(
          productId: productId!,
      quantity: 1
      );

      if (response.status!) {
        Helpers.showMessage(response.message, MessageType.MESSAGE_SUCCESS);
       // isFavorite = !isFavorite;
        cartQuantity++;
       productDetailsData!.isCart =cartQuantity;
       refresh=!refresh;
      }
      else{
        Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);

      }
      isBtnLoading=false;

    }on Exception catch (error) {
      print(error);
      Helpers.showMessage(
        'SomethingWentWrong'.tr(), MessageType.MESSAGE_FAILED);
      isBtnLoading=false;

    }
  }

  Future<void> addAndRemoveFromFavorite() async {
    try {
      BaseResponse response = await productsController.addAndRemoveFromFavorite(
          productId: productId);

      if (response.status!) {
      //  Helpers.showMessage(response.message, MessageType.MESSAGE_SUCCESS);
        isFavorite = !isFavorite;
      }
    }on Exception catch (error) {
      print(error);
      Helpers.showMessage(
         'SomethingWentWrong'.tr(), MessageType.MESSAGE_FAILED);
    }
  }
  Future<void>changeQuantity(int type)async{
    if(type==0){
      if(cartQuantity==1)return;
      cartQuantity--;
      if(productDetailsData!.isCart==0)return;
    }
    else{
      print('here1');
      print('item.itemQuantity   item.product!.quantity: ');
      if(cartQuantity==productDetailsData!.quantity)return;
      print('here2');

      cartQuantity++;
      if(productDetailsData!.isCart==0)return;

      print('here3');

    }
    try{
      print('here4');

      BaseResponse baseResponse=await productsController.changeProductQuantity(productId: productId!,type: type);
      if(baseResponse.status!){
        //Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_SUCCESS);
      }else{
       // Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);

      }


    }on Exception catch(e){
      print(e);
      Helpers.showMessage('SomethingWentWrong'.tr(), MessageType.MESSAGE_FAILED);
    }

  }

//
// // ||...................... logic methods ............................||

}
