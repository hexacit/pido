
import 'package:pido/src/notifiers/screens_notifiers/product_details_screen_notifiers.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/custom_back_button.dart';
import 'package:pido/src/views/components/custom_btn_component.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/views/components/image_slider_component.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import '../components/error_component.dart';
import '../components/loading_component.dart';
import 'package:tuple/tuple.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ProductDetailsScreen extends StatelessWidget {
  late List<dynamic> args;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    return ChangeNotifierProvider<ProductDetailsScreenNotifiers>(
        create: (_) => ProductDetailsScreenNotifiers(
              context,
              (args[0] as int),
            ),
        child: ProductDetailsScreenBody((args[0] as int), (args[1] as String)));
  }
}

class ProductDetailsScreenBody extends StatefulWidget {
  int? productId;
  String? productName;
  ProductDetailsScreenBody(
    this.productId,
    this.productName,
  );
  @override
  _ProductDetailsScreenBodyState createState() =>
      _ProductDetailsScreenBodyState();
}

class _ProductDetailsScreenBodyState extends State<ProductDetailsScreenBody> {
  late ProductDetailsScreenNotifiers _productDetailsScreenNotifiers;
  ScrollController? _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _productDetailsScreenNotifiers =
        Provider.of<ProductDetailsScreenNotifiers>(context, listen: false);

    //_homeScreenNotifiers.init();
  }
  @override
  void dispose() {
    super.dispose();
  }
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    //print(AppShared.currentUser.type);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text(
          widget.productName!,
          style: textStyleMedium.copyWith(
              color: Colors.black, fontSize: AppShared.screenUtil.setSp(17)),
        ),
        elevation: 0,
        leadingWidth: 35.w,

leading: CustomBackButton(),
        actions: [

          Padding(
            padding: const EdgeInsetsDirectional.only(end: 8.0),            child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Constants.SCREENS_MY_CART_SCREEN,
                      arguments: context);
                },
                child: SvgPicture.asset(
                    '${Constants.ASSETS_IMAGES_PATH}cart.svg')),
          ),
        ],
      ),
      body: SafeArea(
        child: Selector<ProductDetailsScreenNotifiers,Tuple3<bool,bool,bool>>(
          selector: (_,value)=>Tuple3(value.isLoading,value.isError,value.refresh),
          builder: (_, tuple,__) {
            return
            tuple.item1?
                Center(child:CircularProgressIndicator())
                :
            tuple.item2?
           ErrorComponent(onTryAgainTap: (){})
                :
              Column(
                children: [
                  Expanded(
                    child: ListView(
                    children: [
                      SizedBox(
                        height: AppShared.screenUtil.setHeight(15),
                      ),
                      Container(
                        height: AppShared.screenUtil.setHeight(230),
                        width: MediaQuery.of(context).size.width,
                        child: ImageSliderComponent(
                          items: _productDetailsScreenNotifiers.productDetailsData!.images!.map((e) => e.image).toList(),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [

                                    Text(
                                      'PriceCurrency'.tr(
                                        args: [
                                          _productDetailsScreenNotifiers.productDetailsData?.discountPercent!=0?
                                          _productDetailsScreenNotifiers.productDetailsData?.discountPrice?.toString()??''
                                              :  _productDetailsScreenNotifiers.productDetailsData?.price?.toString()??''

                                        ]
                                      ),

                                    style: Theme.of(context).textTheme.headline2!.copyWith(
                                      fontSize: AppShared.screenUtil.setSp(20)
                                    ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    if( _productDetailsScreenNotifiers.productDetailsData?.discountPercent!=0)
                                    Text(

                                      _productDetailsScreenNotifiers.productDetailsData?.price?.toString()??'',
                                      style: Theme.of(context).textTheme.headline3!.copyWith(
                                          fontSize: AppShared.screenUtil.setSp(14),
                                          decoration: TextDecoration.lineThrough
                                      ),

                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Share.share('${_productDetailsScreenNotifiers.productDetailsData?.urlLink}');


                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                            '${Constants.ASSETS_IMAGES_PATH}share.svg'),
                                      ),
                                    ),
                                  SizedBox(width: 5.w,),
                                    InkWell(
                                      onTap: (){
_productDetailsScreenNotifiers.addAndRemoveFromFavorite();

                                      },
                                      child:

                                      Selector<ProductDetailsScreenNotifiers,bool>(
                                          selector: (_,value)=>value.isFavorite,
                                          builder: (_, isFavorite,__) {
                                          return Icon(
                                            isFavorite?Icons.favorite_outlined:Icons.favorite_border_outlined
                                             ,color: isFavorite?Colors.red:Colors.black,

                                          );
                                        }
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(35),
                            ),
                            Text('Description'.tr(),
                              style: Theme.of(context).textTheme.headline3!.copyWith(
                                  fontSize: AppShared.screenUtil.setSp(16),
                              ),
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(15),
                            ),
                            Text(_productDetailsScreenNotifiers.productDetailsData?.description??'',
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                fontSize: AppShared.screenUtil.setSp(14),
                              ),
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(15),
                            ),



                          ],
                        ),
                      )
                    ],
            ),
                  ),
                  Container(
                    child:
                    _productDetailsScreenNotifiers.productDetailsData!.quantity==0?
                        Container()
                        :
                    Selector<ProductDetailsScreenNotifiers,int>(
                      selector: (_,value)=>value.cartQuantity,
                      builder: (_, cartQuantity,__) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if(_productDetailsScreenNotifiers.productDetailsData!.isCart!=0)
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    InkWell(
                                      onTap:(){
                                        _productDetailsScreenNotifiers.changeQuantity(0);
                                        // if( _productDetailsScreenNotifiers.cartQuantity==1)return;
                                        //
                                        // _productDetailsScreenNotifiers.cartQuantity--;
                                      },
                                      child: Container(
                                        height: AppShared.screenUtil.setHeight(50)
                                        ,
                                        width: AppShared.screenUtil.setWidth(50),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
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
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(Helpers.formatCount(cartQuantity)
                                        ,style: Theme.of(context).textTheme.headline1!.copyWith(
                                            fontSize: 20.sp,
                                          ),
                                        ),

                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    InkWell(
                                      onTap:(){
                                        _productDetailsScreenNotifiers.changeQuantity(1);
                                        print('add ${_productDetailsScreenNotifiers.cartQuantity} ${_productDetailsScreenNotifiers.productDetailsData!.quantity}');
                                        // if( _productDetailsScreenNotifiers.cartQuantity>=_productDetailsScreenNotifiers.productDetailsData!.quantity!)return;
                                        //
                                        //
                                        // _productDetailsScreenNotifiers.cartQuantity++;
                        },
                                      child: Container(
                                        height: AppShared.screenUtil.setHeight(50)
                                        ,
                                        width: AppShared.screenUtil.setWidth(50),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
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
                                ),
                              ),
                              if(_productDetailsScreenNotifiers.productDetailsData!.isCart==0)
                              Expanded(
                                child: Selector<ProductDetailsScreenNotifiers,bool>(
                                  selector: (_,value)=>value.isBtnLoading,
                                  builder: (_, isBtnLoading,__) {
                                    return CustomBtnComponent(
                                      isLoading:isBtnLoading ,
                                      text: 'AddToCart'.tr(), onTap: _productDetailsScreenNotifiers.addToCart,
                                    textColor: Colors.black,
                                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                                    );
                                  }
                                ),
                              ),

                            ],
                          ),
                        );
                      }
                    ),
                  )

                ],
              );
          }
        ),
      ),
    );
  }
}


