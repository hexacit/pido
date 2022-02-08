import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pido/src/controllers/api_controllers/cart_controller.dart';
import 'package:pido/src/controllers/api_controllers/checkout_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/api_models/responses/countries_response.dart';
import 'package:pido/src/models/api_models/responses/location_response.dart';
import 'package:pido/src/models/sub_models/Zone.dart';
import 'package:pido/src/models/sub_models/address.dart';
import 'package:pido/src/models/sub_models/area.dart';
import 'package:pido/src/models/sub_models/cart.dart';
import 'package:pido/src/models/sub_models/region.dart';
import 'package:pido/src/notifiers/screens_notifiers/checkout_screen_notifiers.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/custom_back_button.dart';
import 'package:pido/src/views/components/custom_btn_component.dart';
import 'package:pido/src/views/components/entry_field_component.dart';
import 'package:pido/src/views/components/image_placeholder_component.dart';
import 'package:pido/src/views/components/location_entry_field.dart';
import 'package:pido/src/views/dialogs/area_dialog.dart';
import 'package:pido/src/views/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Cart myCart=ModalRoute.of(context)!.settings.arguments as Cart;
    return ChangeNotifierProvider<CheckOutScreenNotifiers>(
        create: (_)=>CheckOutScreenNotifiers(context),
        child: CheckoutScreenBody(myCart));
  }
}

class CheckoutScreenBody extends StatefulWidget {

  Cart myCart;
  CheckoutScreenBody(
this.myCart
  );
  @override
  _CheckoutScreenBodyState createState() =>
      _CheckoutScreenBodyState();
}

class _CheckoutScreenBodyState extends State<CheckoutScreenBody> {
  @override
  void initState() {
    super.initState();
    checkOutController=CheckOutController.instance!;
    _cartController=CartController.instance!;

    _formKey= GlobalKey<FormState>();
    dateTextEditingController=TextEditingController();
    timeTextEditingController=TextEditingController();
    cellTextEditingController=TextEditingController();
    emailTextEditingController=TextEditingController();
    addressTextEditingController=TextEditingController();
    postCodeTextEditingController=TextEditingController();
    countryTextEditingController=TextEditingController();
    regionTextEditingController=TextEditingController();
    zoneTextEditingController=TextEditingController();
    _checkOutScreenNotifiers=Provider.of<CheckOutScreenNotifiers>(context,listen: false);

  }
  late CheckOutController checkOutController;
  late CheckOutScreenNotifiers _checkOutScreenNotifiers;
  late CartController _cartController;

  int _current = 0;
  bool isLoading=false;


 late GlobalKey<FormState>_formKey;
 late TextEditingController dateTextEditingController;
  late TextEditingController timeTextEditingController;
  late TextEditingController cellTextEditingController;
  late TextEditingController emailTextEditingController;
  late TextEditingController addressTextEditingController;
  late TextEditingController postCodeTextEditingController;
  late TextEditingController countryTextEditingController;
  late TextEditingController regionTextEditingController;
  late TextEditingController zoneTextEditingController;
  double? cost;
  double? deliveryCost;
  double? totalAmount;
  Country?country;
  Region?region;
  Zone?zone;



int? groupValue;
  Future<void>getMyCart()async{

    try{
      showDialog(context: context, builder: (context)=>LoadingDialog());

      BaseResponse baseResponse=await _cartController.getMyCart(
        addressId:   _checkOutScreenNotifiers.selectedAddressId,
        areaId: _checkOutScreenNotifiers.selectedAreaId,
        code: _checkOutScreenNotifiers.code,
      );
       if(baseResponse.status!){
      widget.myCart= Cart.fromJson(baseResponse.data);
      setState(() {

      });
       }
      Navigator.of(context).pop();


    }on Exception catch(e){
      Navigator.of(context).pop();

      print(e);

    }


  }
  Future<void>refresh()async{
    getMyCart();
  }

  @override
  Widget build(BuildContext context) {
    //print(AppShared.currentUser.type);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Checkout'.tr(),
          style: Theme.of(context).textTheme.headline3!.copyWith(
              color: Colors.black,
              fontSize: AppShared.screenUtil.setSp(17)),
        ),
        elevation: 0,
          leadingWidth: 35.w,

          leading:
        CustomBackButton()

      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _checkOutScreenNotifiers.addressFormKey,
              child: Column(
                    children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              )
                          ),
                          child: Column(
                          children: [
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Products'.tr(),
                              style: Theme.of(context).textTheme.headline3!.copyWith(
                                fontSize: AppShared.screenUtil.setSp(16)
                              ),
                              ),
                              Text('${widget.myCart.countProducts} ${'items'.tr()}', style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: AppShared.screenUtil.setSp(16)
                  ),),


                            ],
                          ),

                          SizedBox(
                          height: AppShared.screenUtil.setHeight(10),
                          ),
                          Container(
                          child: ListView.separated(
                            itemCount: widget.myCart.cartItems!.length,
                            shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                          return Container(
                          height: 100.h,

                          child: Row(

                          children: [
                            ClipRRect(

                              child:   CachedNetworkImage(
                                imageUrl:widget.myCart.cartItems![index].product!.image!,
                                height:double.infinity,
                                width: 100.w,
                                fit: BoxFit.fill,
                                placeholder: (context, url) =>ImagePlaceholderComponent(),
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          SizedBox(
                          width: AppShared.screenUtil.setWidth(15),
                          ),
                          Expanded(
                          child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          mainAxisAlignment:MainAxisAlignment.spaceEvenly,


                          children: [
                          Text(

                          '${widget.myCart.cartItems![index].product?.name??''}',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: AppShared.screenUtil.setSp(14),
                          color: Colors.black,
                          ),
                          ),
                         RichText(text: TextSpan(
                           text:  '${widget.myCart.cartItems![index].product?.price??''} KWD ',
                             style: Theme.of(context).textTheme.headline1!.copyWith(
                               fontSize: AppShared.screenUtil.setSp(16),
                               color: Colors.black,

                             ),
                           children: [
                             TextSpan(
                                 text:  'X${Helpers.formatCount( widget.myCart.cartItems![index].quantity!)}  ',
                               style: Theme.of(context).textTheme.headline2!.copyWith(
                                 fontSize: 14.sp,
                                 color: Colors.black,

                               ),
                             )
                           ]
                         )),



                          ],
                          ),
                          ),
                          ],
                          ),
                          );
                          },
                          separatorBuilder: (_, index) => SizedBox(
                          height: AppShared.screenUtil.setHeight(5)),
                 ),
                          ),]),
                        ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(10),
                            ),
                        if(!AppShared.sharedPreferencesController.getIsLogin())
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Text('YourInformation'.tr(),
                                    style: Theme.of(context).textTheme.headline3!.copyWith(
                                      fontSize:14.sp,
                                      color: Colors.black,

                                    ),),




                                ],
                              ),
                              SizedBox(
                                height: AppShared.screenUtil.setHeight(10),
                              ),
                              EntryFieldComponent(
                                title: 'FullName'.tr(),
                                icon: 'user',
                                onSaved: (val){
                                  _checkOutScreenNotifiers.name=val;

                                },
                                validator:(val){
                                  if(val==null||val.isEmpty)
                                    return'ThisFieldIsRequired'.tr();

                                  return null;
                                } ,
                                contentPadding:const EdgeInsets.symmetric(vertical: 5),


                              ),
                              SizedBox(
                                height: AppShared.screenUtil.setHeight(10),
                              ),
                              EntryFieldComponent(
                                title: 'Email'.tr(),
                                contentPadding:const EdgeInsets.symmetric(vertical: 5),

                                icon: 'email',
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (val){
                                  _checkOutScreenNotifiers.email=val;

                                },
                                validator:(val){
                                  if(val==null||val.isEmpty)
                                    return'ThisFieldIsRequired'.tr();
                                  else if(  !EmailValidator.validate(val))
                                    return'ThisIsNotEmailFormat'.tr();
                                  return null;
                                } ,


                              ),
                              SizedBox(
                                height: AppShared.screenUtil.setHeight(10),
                              ),
                              EntryFieldComponent(
                                title: 'Password'.tr(),
                                icon: 'lock',
                                isSecure: true,
                                contentPadding:const EdgeInsets.symmetric(vertical: 5),

                                onSaved: (val){
                                  _checkOutScreenNotifiers.password=val;

                                },
                                validator:(val){
                                  if(val==null||val.isEmpty)
                                    return'ThisFieldIsRequired'.tr();

                                  return null;
                                } ,


                              ),


                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppShared.screenUtil.setHeight(10),
                        ),
                        Container(child:
                        AppShared.sharedPreferencesController.getIsLogin()?
                        userAddressesWidget(
                          onChange: (){
                            getMyCart();
                          },
                        )
                            :
                        checkoutAddressWidget(
                          onChange: (){
                            getMyCart();
                          },
                        )),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(10),
                            ),
                            PromoCodeWidget(
                              onSuccess: (val){
                                _checkOutScreenNotifiers.code=val;
                                getMyCart();
                              },
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(10),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [
                                      Text('SelectPaymentMethod'.tr(),style: Theme.of(context).textTheme.headline3!.copyWith(
                                        fontSize: AppShared.screenUtil.setSp(14),
                                        color: Colors.black,

                                      ),),
                                      Text('${widget.myCart.finalTotal} KWD',style: Theme.of(context).textTheme.headline1!.copyWith(
                                        fontSize: AppShared.screenUtil.setSp(18),
                                        color: Colors.black,

                                      ),),





                                    ],
                                  ),
                                  SizedBox(
                                    height: AppShared.screenUtil.setHeight(10),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RadioListTile<int>(
                                          contentPadding:EdgeInsets.zero ,
                                            title: Text('Knet'),
                                            value: 0, groupValue: groupValue, onChanged: (val){
                                          setState(() {
                                            groupValue=val!;
                                            _checkOutScreenNotifiers.selectedPayment=groupValue;
                                          });
                                        }),
                                      ),
                                      Expanded(
                                        child: RadioListTile<int>(
                                            contentPadding:EdgeInsets.zero ,

                                            title: Text('Credit Cart'),
                                            value: 1, groupValue: groupValue, onChanged: (val){
                                          setState(() {
                                            groupValue=val!;
                                            _checkOutScreenNotifiers.selectedPayment=groupValue;

                                          });
                                        }),
                                      )
                                    ],
                                  )


                                ],
                              ),
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(10),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [
                                      Text('SelectDateAndTime'.tr(),style: Theme.of(context).textTheme.headline3!.copyWith(
                                        fontSize: AppShared.screenUtil.setSp(14),
                                        color: Colors.black,

                                      ),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: AppShared.screenUtil.setHeight(10),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5.0),

                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.black,
                                        )
                                      )
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}calendar - icon.svg'),
                                            ),

                                            Text(
                                              '${'Date'.tr()} :',
                                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                                color:Colors.black,
                                                fontSize:14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                readOnly: true,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                controller: dateTextEditingController,
                                                keyboardType: TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                  isCollapsed: true,

                                                  border: InputBorder.none,

                                                  hintStyle:  Theme.of(context).textTheme.headline2!.copyWith(
                                                    color:Colors.black,
                                                    fontSize:AppShared.screenUtil.setSp(18),
                                                  ),
                                                ),
                                                onTap: (){
                                                  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(
                                                    DateTime.now().year+2
                                                  )).then((value){
                                                    if(value!=null){
                                                      dateTextEditingController.text=Helpers.formatDate(value);
                                                        _checkOutScreenNotifiers.date=  value.toString();
                                                    }
                                                  });
                                                },
                                                validator: (val){
                                                  if(val==null||val.isEmpty)
                                                    return'ThisFieldIsRequired'.tr();

                                                  return null;

                                                },
                                                onSaved: (val){

                                                },
                                              ),
                                            ),
                                         SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}arrow-down.svg') ,


                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.all(5.0),

                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                            )
                                        )
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}clock.svg'),
                                            ),

                                            Text(
                                              '${'Time'.tr()} :',
                                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                                color:Colors.black,
                                                fontSize:14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                readOnly: true,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,

                                                controller: timeTextEditingController,
                                                keyboardType: TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                  isCollapsed: true,
                                                  border: InputBorder.none,

                                                  hintStyle:  Theme.of(context).textTheme.headline2!.copyWith(
                                                    color:Colors.black,
                                                    fontSize:AppShared.screenUtil.setSp(18),
                                                  ),
                                                ),
                                                onTap: (){

                                                  showTimePicker(context: context,   initialTime: TimeOfDay.now()).then((value){
                                                    if(value!=null){
                                                      timeTextEditingController.text=Helpers.formatTime(value);
                                                       _checkOutScreenNotifiers.time= value.toString();

                                                    }
                                                  });
                                                },
                                                validator: (val){
                                                  if(val==null||val.isEmpty)
                                                    return'ThisFieldIsRequired'.tr();

                                                  return null;

                                                },
                                                onSaved: (val){

                                                },
                                              ),
                                            ),
                                            SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}arrow-down.svg') ,

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  ),
                      SizedBox(
                        height: AppShared.screenUtil.setHeight(10),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                        vertical: 15),

                        decoration: BoxDecoration(

                            border: Border.symmetric(
horizontal: BorderSide(
  color: Colors.black,
)
                            )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${'Subtotal'.tr()} :', style: Theme.of(context).textTheme.headline2!.copyWith(
                  color:Colors.black,
                  fontSize:AppShared.screenUtil.setSp(16),
                  ),),
                                      Text('${widget.myCart.total} KWD', style: Theme.of(context).textTheme.headline2!.copyWith(
                                        color:Colors.black,
                                        fontSize:AppShared.screenUtil.setSp(16),
                                      ),),

                                    ],
                                  ), SizedBox(
                                    height: AppShared.screenUtil.setHeight(10),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${'Tax'.tr()} : ', style: Theme.of(context).textTheme.headline2!.copyWith(
                                        color:Colors.black,
                                        fontSize:AppShared.screenUtil.setSp(16),
                                      ),),
                                      Text('${widget.myCart.tax} KWD', style: Theme.of(context).textTheme.headline2!.copyWith(
                                        color:Colors.black,
                                        fontSize:AppShared.screenUtil.setSp(16),
                                      ),),

                                    ],
                                  ),  SizedBox(
                                    height: AppShared.screenUtil.setHeight(10),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${'Discount'.tr()} :', style: Theme.of(context).textTheme.headline2!.copyWith(
                                        color:Colors.black,
                                        fontSize:AppShared.screenUtil.setSp(16),
                                      ),),
                                      Text('${widget.myCart.discount} %', style: Theme.of(context).textTheme.headline1!.copyWith(
                                        color:Colors.black,
                                        fontSize:AppShared.screenUtil.setSp(16),
                                      ),),

                                    ],
                                  ),
                                  SizedBox(
                                    height: AppShared.screenUtil.setHeight(10),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${'DeliveryCost'.tr()} :', style: Theme.of(context).textTheme.headline2!.copyWith(
                                        color:Colors.black,
                                        fontSize:AppShared.screenUtil.setSp(16),
                                      ),),
                                      Text('${widget.myCart.deliveryCharge==0?'-----':widget.myCart.deliveryCharge} ',
                                        style: Theme.of(context).textTheme.headline2!.copyWith(
                                        color:Colors.black,
                                        fontSize:AppShared.screenUtil.setSp(16),
                                      ),),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${'TotalAmount'.tr()} :', style: Theme.of(context).textTheme.headline3!.copyWith(
                                    color:Colors.black,
                                    fontSize:AppShared.screenUtil.setSp(18),
                                  ),),
                                  Text('${widget.myCart.finalTotal} KWD', style: Theme.of(context).textTheme.headline1!.copyWith(
                                    color:Colors.black,
                                    fontSize:AppShared.screenUtil.setSp(18),
                                  ),),

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Selector<CheckOutScreenNotifiers,bool>(
                              selector: (_,value)=>value.isBtnLoading,
                              builder: (context,isBtnLoading ,__) {
                                return CustomBtnComponent(
isLoading:isBtnLoading ,
                                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                                    text: 'OrderNow'.tr(),
                                    textColor: Colors.black,
                                    onTap: (){
_checkOutScreenNotifiers.checkOut();
                                  // showDialog(context: context, builder: (context){
                                  //   return OrderSuccessDialog();
                                  // });
                                });
                              }
                            ),
                          ],
                        ),
                      )

                    ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PromoCodeWidget extends StatefulWidget {
  final Function(String) onSuccess;
  const PromoCodeWidget({
    Key? key,
    required this.onSuccess,
  }) : super(key: key);

  @override
  State<PromoCodeWidget> createState() => _PromoCodeWidgetState();
}

class _PromoCodeWidgetState extends State<PromoCodeWidget> {

  late GlobalKey<FormState> _key;
  late CheckOutController _checkOutController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _key=GlobalKey<FormState>();
    _checkOutController=CheckOutController.instance!;

  }
  Future<void>checkCode()async
  {
    if(!_key.currentState!.validate())return;
    _key.currentState!.save();

    try {
      setState(() {
        isLoading=true;
      });

      BaseResponse response = await _checkOutController.checkCode(
          code??''

      );
      if (response.status!) {

      widget.onSuccess(code??'');

        Helpers.showMessage(response.message, MessageType.MESSAGE_SUCCESS);
        //}
      } else {
        Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);


      }
      setState(() {
        isLoading=false;
      });
    } catch (error) {
      print(error);
      setState(() {
        isLoading=false;
      });
      Helpers.showMessage('SomethingWentWrong'.tr(), MessageType.MESSAGE_FAILED);
    }
  }
  String? code;
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          )
      ),
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text('DoYouHavePromoCode'.tr(),
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: AppShared.screenUtil.setSp(14),
                  color: Colors.black,

                ),),




              ],
            ),
            SizedBox(
              height: AppShared.screenUtil.setHeight(10),
            ),
            EntryFieldComponent(
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              hasHint: true,

              title: 'PromoCode'.tr(),
              icon: 'promo',
              onSaved: (val){
                code=val;
              },
              validator:(val){
              if(val==null||val.isEmpty)
                return'ThisFieldIsRequired'.tr();

              return null;
            } ,


            ),
            SizedBox(
              height:10.h,
            ),
            InkWell(
              onTap: checkCode,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(5),

                  child:isLoading?
                      Center(
                        child: CircularProgressIndicator(),
                      )
                      : SvgPicture.asset(
                    '${Constants.ASSETS_IMAGES_PATH}done.svg',
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                    color:Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class checkoutAddressWidget extends StatefulWidget {
  final Function onChange;

  const checkoutAddressWidget({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  State<checkoutAddressWidget> createState() => _checkoutAddressWidgetState();
}

class _checkoutAddressWidgetState extends State<checkoutAddressWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkOutScreenNotifiers=Provider.of<CheckOutScreenNotifiers>(context,listen: false);
    _areaTextEditingController=TextEditingController();
    _locationTextEditingController=TextEditingController();


  }
  late CheckOutScreenNotifiers _checkOutScreenNotifiers;

  Area? selectedArea;
  late TextEditingController _areaTextEditingController;
  late TextEditingController _locationTextEditingController;


  int? selectedAreaId;
  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    border: Border.all(
    color: Theme.of(context).primaryColor,
    )
    ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,

  children: [
    Text('DeliveryAddress'.tr(),
      style: Theme.of(context).textTheme.headline3!.copyWith(
        fontSize: AppShared.screenUtil.setSp(14),
        color: Colors.black,

      ),
    ),
  //  IconButton(onPressed: (){}, icon: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}go.svg')),

  ],
),
              LocationEntryField(onSelectLocation: (LocationResponse? val) {
                _checkOutScreenNotifiers.guestLocation=  LatLng(val!.latitude!,val.longitude!);
                _locationTextEditingController.text=val.locality!;
              },
                controller: _locationTextEditingController,
                onchange: (String? val) {  },
                onSave: (String? val) {  },),
              // IconButton(onPressed: (){
              //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChooseAddressLocationScreen())).then((value) {
              //     if(value !=null){
              //       _checkOutScreenNotifiers.guestLocation=value as LatLng;
              //     }
              //   });
              // }, icon: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}locate.svg')),


              // IconButton(onPressed: (){}, icon: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}locate.svg')),

       TextFormField(
         decoration: InputDecoration(
           hintText: 'Name'.tr(),
         ),
        onSaved: (val){
           _checkOutScreenNotifiers.addressName=val;
        },
        validator:(val){
    if(val==null||val.isEmpty)
    return'ThisFieldIsRequired'.tr();

    return null;
        } ,

       ),
              SizedBox(
                height: AppShared.screenUtil.setHeight(15),
              ),
            TextFormField(
                    readOnly: true,
              controller:_areaTextEditingController ,

              onTap: (){
                      showDialog(context: context, builder: (context)=>AreasDialog(
                        onSelect: (area){
                          if(area!=null){
                            selectedArea=area;
                            _areaTextEditingController.text=selectedArea?.name??'';
                            _checkOutScreenNotifiers.selectedAreaId=selectedArea!.id;

                            widget.onChange();
                          }

                        },
                      ));
                    },
                    decoration: InputDecoration(
                      hintText: 'Area'.tr(),
                    ),
                    validator:(val){
                      if(val==null||val.isEmpty)
                        return'ThisFieldIsRequired'.tr();

                      return null;
                    } ,
              onSaved: (val){
                _checkOutScreenNotifiers.selectedAreaId=selectedArea!.id;
              },


              ),
              SizedBox(
                height: AppShared.screenUtil.setHeight(15),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Street'.tr(),
                ),
                validator:(val){
                  if(val==null||val.isEmpty)
                    return'ThisFieldIsRequired'.tr();

                  return null;
                } ,
                onSaved: (val){
                  _checkOutScreenNotifiers.addressStreet=val;
                },

              ),
            ],
          ),
    );
  }
}


class userAddressesWidget extends StatefulWidget {
  final Function onChange;
  const userAddressesWidget({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  State<userAddressesWidget> createState() => _userAddressesWidgetState();
}

class _userAddressesWidgetState extends State<userAddressesWidget> {
  late CheckOutScreenNotifiers _checkOutScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkOutScreenNotifiers=Provider.of<CheckOutScreenNotifiers>(context,listen: false);
    if(AppShared.currentUser!.defaultAddress!=null){
      selectedAddress=AppShared.currentUser!.defaultAddress;
      area=selectedAddress?.area?.name??'';
      street=selectedAddress?.street??'';
      name=selectedAddress?.addressName??'';

      _checkOutScreenNotifiers.selectedAddressId=selectedAddress!.id;
      _checkOutScreenNotifiers.addressName=selectedAddress!.addressName;
      _checkOutScreenNotifiers.addressStreet=selectedAddress!.street;
      _checkOutScreenNotifiers.selectedAreaId=selectedAddress!.areaId;
     Future.delayed(Duration(seconds: 1),(){widget.onChange();}) ;
    }

  }
  String? area;
  String? street;
  String? name;
  Address? selectedAddress;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text('DeliveryAddress'.tr(),
                style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: AppShared.screenUtil.setSp(14),
                  color: Colors.black,

                ),
              ),
              InkWell(onTap: (){

                Navigator.of(context).pushNamed(Constants.SCREENS_SHIPPING_ADDRESSES_SCREEN).then((value) {
                  if(value  !=null){
                    selectedAddress=(value as Address);
                    area=selectedAddress?.area?.name??'';
                    street=selectedAddress?.street??'';
                    name=selectedAddress?.addressName??'';
                    setState(() {

                    });
                    _checkOutScreenNotifiers.selectedAddressId=selectedAddress!.id;
                    _checkOutScreenNotifiers.addressName=selectedAddress!.addressName;
                    _checkOutScreenNotifiers.addressStreet=selectedAddress!.street;
                    _checkOutScreenNotifiers.selectedAreaId=selectedAddress!.areaId;
                    widget.onChange();
                  }

                });
              }, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}go.svg'),
              )),


            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell(onTap: (){}, child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}locate.svg')),
          ),

          Row(
            children: [
              Text('${'Area'.tr()} : ',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: AppShared.screenUtil.setSp(14),
                  color: Colors.black,

                ),
              ),
              Text(area??'',style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: AppShared.screenUtil.setSp(14),
                color: Colors.black,

              ),),


            ],
          ),
          SizedBox(
            height: AppShared.screenUtil.setHeight(15),
          ),
          Row(
            children: [
              Text('${'Street'.tr()} : ' ,style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: AppShared.screenUtil.setSp(14),
                color: Colors.black,

              ),),
              Text(street??'',style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: AppShared.screenUtil.setSp(14),
                color: Colors.black,

              ),),


            ],
          ),
          SizedBox(
            height: AppShared.screenUtil.setHeight(15),
          ),
          Row(
            children: [
              Text('${'Name'.tr()} : ' ,style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: AppShared.screenUtil.setSp(14),
                color: Colors.black,

              ),),
              Text(name??'',style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: AppShared.screenUtil.setSp(14),
                color: Colors.black,

              ),),


            ],
          ),
        ],
      ),
    );
  }
}