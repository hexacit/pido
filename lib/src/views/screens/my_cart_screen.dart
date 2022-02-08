import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:pido/src/controllers/api_controllers/cart_controller.dart';
import 'package:pido/src/controllers/api_controllers/products_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/sub_models/cart.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/custom_back_button.dart';
import 'package:pido/src/views/components/empty_component.dart';
import 'package:pido/src/views/components/error_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pido/src/views/components/image_placeholder_component.dart';
import 'package:pido/src/views/dialogs/login_dialog.dart';
import 'package:pido/src/views/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import '../../views/components/custom_btn_component.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyCartScreenBody();
  }
}

class MyCartScreenBody extends StatefulWidget {
  @override
  _MyCartScreenBodyState createState() => _MyCartScreenBodyState();
}

class _MyCartScreenBodyState extends State<MyCartScreenBody> {
  late CartController _cartController;

  @override
  void initState() {
    super.initState();
    _cartController=CartController.instance!;

    _future=getMyCart();

  }

  bool searchTextNotEmpty = false;
  Cart? cart;
  late Future<Cart>_future;
  Future<Cart>getMyCart()async{

    try{
      BaseResponse baseResponse=await _cartController.getMyCart();
      // if(baseResponse.status!){
      cart= Cart.fromJson(baseResponse.data);
      // }


    }on Exception catch(e){
      print(e);

    }
    return cart!;

  }
  Future<void>refresh()async{
    setState(() {
      _future=getMyCart();

    });
  }
  @override
  Widget build(BuildContext context) {
    print('${AppShared.currentUser}');
    return RefreshIndicator(
      onRefresh:refresh ,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'MyCart'.tr(),
              style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: Colors.black, fontSize: AppShared.screenUtil.setSp(17)),
            ),
            elevation: 0,
              leadingWidth: 35.w,


              leading: CustomBackButton()

          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder<Cart>(
              future: _future,
              builder: (context, snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(snapshot.hasError){
                  print(snapshot.error);
                  print(snapshot.stackTrace);
                  return ErrorComponent(onTryAgainTap:refresh);
                }

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Products'.tr(),
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Colors.black, fontSize: AppShared.screenUtil.setSp(16)),
          ),
                        Text('${snapshot.data!.countProducts} items',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.black, fontSize: AppShared.screenUtil.setSp(16)),
                        ),


                      ],
                    ),

                    SizedBox(
                      height: AppShared.screenUtil.setHeight(15),
                    ),
                    Expanded(
                        child: Container(
                                child:
                 (snapshot.data!.cartItems!.isEmpty)?
                 EmptyComponent(text: '',):

                                ListView.separated(
                itemCount: snapshot.data!.cartItems!.length,
                                    itemBuilder: (_, index) {
                                      return ChangeNotifierProvider.value(
                                        value: snapshot.data!.cartItems![index] ,
                                        child: CartItemComponent(
                                          onDelete: (id){
                                            snapshot.data!.cartItems!.removeWhere((element) => element.productId==id);
                                            print('delete cart 1');
                                          setState(() {

                                          });
                                            },

                                       //   item: snapshot.data!.cartItems![index] ,
                                        ),
                                      );
                                    },
                                    separatorBuilder: (_, index) => SizedBox(
                                        height: 10.h),
                                   ),
                              )
                           ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(


                              '${snapshot.data!.total} KWD',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: Colors.black,

                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          if( snapshot.data!.cartItems!.isNotEmpty)
                          Expanded(child: CustomBtnComponent(
                              text: 'Checkout'.tr(),
                              textColor: Colors.black,
                              onTap: (){

                                if(AppShared.sharedPreferencesController.getIsLogin()){
                                  Navigator.of(context).pushNamed(Constants.SCREENS_CHECKOUT_SCREEN,
                                      arguments: snapshot.data
                                  );
                                }
                                else{
                                  showDialog(context: context, builder: (context){

                                    return LoginDialog(

                                    );
                                  }).then((value) {
                                    if(value !=null){
                                      if(value ==1){
                                        Navigator.of(context).pushNamed(Constants.SCREENS_CHECKOUT_SCREEN,
                                            arguments: snapshot.data
                                        );
                                      }
                                      else  if(value ==2){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                            SignInScreen(
                                              isNavigateToCart: true,
                                            )
                                        )).then((value) {
                                          if(value !=null){
                                            if(value as bool){
                                              Navigator.of(context).pushNamed(Constants.SCREENS_CHECKOUT_SCREEN,
                                                  arguments: snapshot.data
                                              );
                                            }
                                          }
                                        });

                                      }
                                    }
                                  });
                                }



                          })),

                        ],
                      ),
                    )

                  ],
                );
              }
            ),
          )),
    );
  }
}

class CartItemComponent extends StatefulWidget {
  final Function(int) onDelete;
  const CartItemComponent({
    Key? key,
   required this.onDelete,
  }) : super(key: key);

  @override
  State<CartItemComponent> createState() => _CartItemComponentState();
}

class _CartItemComponentState extends State<CartItemComponent> {

  late CartItem item;
  late ProductsController _productsController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    item=Provider.of<CartItem>(context,listen: false);
    _productsController=ProductsController.instance!;
  }
  Future<void>changeQuantity(int type)async{
    if(type==0){
      if(item.quantity==1)return;
      item.itemQuantity= item.itemQuantity!-1;
    }
    else{
      print('here1');
      print('item.itemQuantity ${item.itemQuantity}  item.product!.quantity: ${item.product!.quantity}');
      if(item.itemQuantity==item.product!.quantity)return;
      print('here2');

      item.itemQuantity= item.itemQuantity!+1;
      print('here3');

    }
    try{
      print('here4');

      BaseResponse baseResponse=await _productsController.changeProductQuantity(productId: item.productId!,type: type);
      if(baseResponse.status!){
    // Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_SUCCESS);
      }else{
      //  Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);

      }


    }on Exception catch(e){
      print(e);
      Helpers.showMessage('SomethingWentWrong'.tr(), MessageType.MESSAGE_FAILED);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.productId.toString()),
      secondaryBackground:
      null,
      direction:
      DismissDirection
          .endToStart,
      background:
      Container(
        padding:
        EdgeInsets
            .symmetric(
          horizontal:
          20,
          vertical:
          15,
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment
              .end,
          children: [
            Icon(
              Icons
                  .delete_outline_outlined,
              color: Colors
                  .white,
            ),
          ],
        ),
        color: Color(
            0xffFC564E),
      ),
      confirmDismiss:
          (DismissDirection
      direction) async {
        var t =
        await showDialog(
          context:
          context,
          builder:
              (BuildContext
          mcontext) {
            return DeleteCartItemDialog(

                  id:  item.productId!,
              onDelete: (id){
widget.onDelete(id);
              },

                   );
          },
        );
        return t;
      },
      onDismissed:
          (DismissDirection
      direction) {
        return;
      },
      child: Container(
        height: 120.h,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Theme.of(context).primaryColor,
            )
        ),
        child: Row(

          children: [
            ClipRRect(

              child:  CachedNetworkImage(
                imageUrl:item.product!.image!,
                height:double.infinity,
                width: 100.w,
                fit: BoxFit.fill,
                placeholder: (context, url) =>ImagePlaceholderComponent(),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                mainAxisAlignment:MainAxisAlignment.spaceBetween,


                children: [
                  Text(

                    '${item.product!.name}',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 14.sp,
                      ),
                  ),
                  Text(

                   '${item.product!.price}',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16.sp,

                    ),
                  ),
                  Selector<CartItem,int?>(
                    selector: (_,value)=>value.itemQuantity,
                    builder: (_, itemQuantity,__) {
                      return Row(
                        children: [
                          InkWell(
                            onTap:(){
                              changeQuantity(0);
                      },
                            child: Container(
                              height: AppShared.screenUtil.setHeight(35)
                              ,
                              width: AppShared.screenUtil.setWidth(35),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  '${Constants.ASSETS_IMAGES_PATH}minus-icon.svg',

                                ),
                              ),
                              decoration: BoxDecoration(
                                color:Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(Helpers.formatCount(item.itemQuantity!)
                              , style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 20.sp,
                      ),)),
                          InkWell(
                            onTap:(){
                              changeQuantity(1);
                            },
                            child: Container(
                              height: AppShared.screenUtil.setHeight(35)
                              ,
                              width: AppShared.screenUtil.setWidth(35),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  '${Constants.ASSETS_IMAGES_PATH}plus-icon.svg',


                                ),
                              ),
                              decoration: BoxDecoration(
                                color:Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class DeleteCartItemDialog extends StatefulWidget {
  final int id;
  final Function(int)onDelete;

 const DeleteCartItemDialog(
  {required this.id,
  required   this.onDelete}
     );

  @override
  _DeleteCartItemDialogState createState() =>
      _DeleteCartItemDialogState();
}

class _DeleteCartItemDialogState extends State<DeleteCartItemDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productsController=ProductsController.instance!;

  }
  late ProductsController _productsController;

  bool isDeleting=false;
  Future<void>deleteCartItem()async{
setState(() {
  isDeleting=true;
});
    try{
      print('here4');

      BaseResponse baseResponse=await _productsController.deleteCartItem(productId:widget.id);
      if(baseResponse.status!){
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_SUCCESS);
        widget.onDelete(widget.id);
        Navigator.of(context).pop();
      }else{
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);

      }
      setState(() {
        isDeleting=false;
      });

    }on Exception catch(e){
      print(e);
      setState(() {
        isDeleting=false;
      });
      Helpers.showMessage('SomethingWentWrong'.tr(), MessageType.MESSAGE_FAILED);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ) ,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 40),
        height: MediaQuery.of(context).size.height*0.4,
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
                
              ),
              child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}question.svg'),
            ),
            Expanded(child: Container(child:
            isDeleting
                ? Container(
                height: 20,
                width: 20,
                child: Center(child: CircularProgressIndicator()))
                : Center(
                  child: Text(
                  'ConfirmDeleteCartItem'.tr(),
                  textAlign: TextAlign.center,
                  ),
                )
              ,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomBtnComponent(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    onTap: () async {
                      deleteCartItem();
                    },
                    text:'Yes'.tr(),
                  color: Colors.transparent,
                  textColor: Colors.black,
                ),
                CustomBtnComponent(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),

                  onTap:() => Navigator.of(context).pop(false),
    text:'No'.tr(),
                  textColor: Colors.black,

                ),
              ],
            ),

          ],
        ),
      ),

    );
  }
}
