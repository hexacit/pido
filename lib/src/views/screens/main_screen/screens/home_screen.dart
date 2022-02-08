
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pido/src/models/sub_models/category.dart';
import 'package:pido/src/models/sub_models/categories_products.dart';
import 'package:pido/src/notifiers/app_notifiers.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/views/components/empty_component.dart';
import 'package:pido/src/views/components/image_placeholder_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/views/components/shimmer_components/shimmer_category_component.dart';
import 'package:pido/src/views/components/shimmer_components/shimmer_product_component.dart';
import 'package:pido/src/views/components/shimmer_components/shimmer_products_categories_component.dart';
import 'package:provider/provider.dart';
import '../../../../notifiers/screens_notifiers/main_screen_notifiers/screens_notifiers/home_screen_notifiers.dart';
import '../../../../utils/app_shared.dart';
import '../../../../utils/constants.dart';
import '../../../components/error_component.dart';
import '../../../components/loading_component.dart';
import 'package:tuple/tuple.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HomeScreen extends StatelessWidget {
  static GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return
      // ChangeNotifierProvider<HomeScreenNotifiers>(
      // create: (_) => HomeScreenNotifiers(
      //   context,
      //
      // ),
      // child:
      HomeScreenBody();
    //);
  }
}

class HomeScreenBody extends StatefulWidget {
  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  late HomeScreenNotifiers _homeScreenNotifiers;
  ScrollController? _scrollController;
  late AppNotifiers _appNotifiers;
  bool isGrid = true;
  bool showProduct = false;
  @override
  void initState() {
    super.initState();
    _appNotifiers = Provider.of<AppNotifiers>(context, listen: false);

    _homeScreenNotifiers =
        Provider.of<HomeScreenNotifiers>(context, listen: false);
   // _homeScreenNotifiers.init();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return _homeScreenNotifiers.init(isInit: false);
      },
      child: Scaffold(
       // key: HomeScreen.scaffoldState,
       // drawer: AppDrawer(),
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    '${Constants.ASSETS_IMAGES_PATH}logo.svg',

                  ),
                  Text(
                    'Pido',
                    style: TextStyle(
                        color: Color(0xffF4ECCF),
                        fontFamily: 'Caroline',
                        fontSize: 24.sp),
                  ),
                ],
              ),
            ),
            leading:  IconButton(
                  icon: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}menu.svg'),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();

                  },
                ) ,
            actions: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Constants.SCREENS_MY_CART_SCREEN,
                        arguments: context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                        '${Constants.ASSETS_IMAGES_PATH}cart.svg'),
                  )),

              InkWell(
                onTap: (){
                Navigator.of(context).pushNamed(Constants.SCREENS_SEARCH_SCREEN,
                arguments: context);
              },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                    '${Constants.ASSETS_IMAGES_PATH}search.svg'),
              )),
            ],
          ),
          body: Container(
            child:
                    Container(


                      child:

                  Column(
                    children: [
                      SizedBox(
                          height: AppShared.screenUtil.setHeight(20)),
                      CategoriesListWidget(),
                      SizedBox(
                          height: AppShared.screenUtil.setHeight(20)),
    Expanded(
      child: Selector<HomeScreenNotifiers,Tuple5<bool,bool,ProductsMode,int?,bool>>(
      selector: (_,value)=>Tuple5(value.isLoading,value.isError,value.productsMode,value.selectedCategoryId,value.refresh),
      builder: (_,tuple,__ ) {
      return

      tuple.item1?
      tuple.item3==ProductsMode.CATEGORY?ShimmerProductComponent():
      ShimmerProductsCategoriesComponent()
      :
      tuple.item2?
      ErrorComponent(onTryAgainTap: (){
         _homeScreenNotifiers.init(isInit: false);
      }
      ):
                             Container(
                               child:
                               tuple.item3==ProductsMode.CATEGORY?
                               Container(
                               //  height: AppShared.screenUtil.setHeight(160),
                                 child: _homeScreenNotifiers.categoryProducts!.items!.isEmpty?

                                     EmptyComponent(text: 'NoProductsFound'.tr())
                                     : GridView.builder(
                                   controller: _homeScreenNotifiers.productsScrollController,
                                  // shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                   gridDelegate:
                                   SliverGridDelegateWithFixedCrossAxisCount(
                                       crossAxisCount: 3,
                                       mainAxisSpacing: 5,
                                       crossAxisSpacing: 5,
                                       mainAxisExtent:180.h

                                   ),
                                   itemCount: _homeScreenNotifiers.categoryProducts!.items!.length,
                                   itemBuilder: (context,index){
                                     return InkWell(
                                       onTap: (){
                                         Navigator.of(context).pushNamed(Constants.SCREENS_PRODUCT_DETAILS_SCREEN,
                                             arguments: [
                                               _homeScreenNotifiers.categoryProducts!.items![index].id,
                                               _homeScreenNotifiers.categoryProducts!.items![index].name,
                                             ]);
                                       },
                                       child: Container(
                                         margin: EdgeInsetsDirectional.only(start: 10),
                                         //   padding: EdgeInsets.symmetric(horizontal: 20),
                                         width: 100.w,

                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             ClipRRect(

                                               child: Image.network(   _homeScreenNotifiers.categoryProducts!.items![index].image!,
                                                 height: 100.h,
                                                 width: 100.w,
                                                 fit: BoxFit.fill,

                                               ),
                                               borderRadius: BorderRadius.circular(15),
                                             ),
                                             Expanded(
                                               child: Container(

                                                 width: double.infinity,
                                                 child: Column(
                                                   children: [
                                                     SizedBox(
                                                       height: 2,
                                                     ),
                                                     Text(

                                                       _homeScreenNotifiers.categoryProducts!.items![index].name??'',
                                                       style:  Theme.of(context).textTheme.headline1!.copyWith(
                                                        fontSize: AppShared.screenUtil.setSp(13),
                                                       ),


                                                     ),
                                                     SizedBox(
                                                       height: 2,
                                                     ),
                                                     Text(
                                                       'PriceCurrency'.tr(
                                                           args: [
                                                             _homeScreenNotifiers.categoryProducts!.items![index].discountPercent!=0?
                                                             _homeScreenNotifiers.categoryProducts!.items![index].discountPrice?.toString()??''
                                                                 : _homeScreenNotifiers.categoryProducts!.items![index].price?.toString()??''

                                                           ]
                                                       ),

                                                      // _homeScreenNotifiers.categoryProducts!.firstWhere((element) => element.id==_homeScreenNotifiers.selectedCategoryId).products![index].price?.toString()??'',
                                                       style:  Theme.of(context).textTheme.headline3!.copyWith(
                                                         fontSize: AppShared.screenUtil.setSp(12),
                                                       ),

                                                     ),
                                                     if(  _homeScreenNotifiers.categoryProducts!.items![index].discountPercent!=0)
                                                     Column(
                                                       children: [
                                                         SizedBox(
                                                           height: 2,
                                                         ),
                                                         Text(

                                                           _homeScreenNotifiers.categoryProducts!.items![index].discountPrice?.toString()??'',
                                                           style:  Theme.of(context).textTheme.headline2!.copyWith(
                                                               fontSize: AppShared.screenUtil.setSp(12),
                                                               color: Theme.of(context).primaryColor,
                                                               decoration: TextDecoration.lineThrough
                                                           ),


                                                         ),
                                                       ],
                                                     ),
                                                   ],
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                     );
                                   },

                                 ),
                               )
                                   :

                               ListView.separated(
                                // shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                itemCount: _homeScreenNotifiers.categoriesProducts!.length,
                                  itemBuilder: (_,index){
                                  return CategoryProductsComponent(
                                    item: _homeScreenNotifiers.categoriesProducts![index] ,
                                  );
                                  },
                                  separatorBuilder:(_,index){
                                    return SizedBox(
                                     // height: 5,
                                    );
                                  },
                            ),
                             );
                          }
                        ),
    )
                    ],
                      ),


          ),),
        bottomSheet: Selector<HomeScreenNotifiers, bool>(
          selector: (_, value) => value.isPaginationLoading,
          builder: (_, isPaginationLoading, __) => isPaginationLoading
              ? Container(
            height: 100,
            child: Center(
              child: LoadingComponent(),
            ),
          )
              : Container(
            height: 0,
          ),
        ),
      )
    );
  }
}

class CategoriesListWidget extends StatefulWidget {


  @override
  State<CategoriesListWidget> createState() => _CategoriesListWidgetState();
}

class _CategoriesListWidgetState extends State<CategoriesListWidget> {
  late HomeScreenNotifiers _homeScreenNotifiers;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeScreenNotifiers =
        Provider.of<HomeScreenNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      child:      Selector<HomeScreenNotifiers,Tuple3<bool,bool,int>>(
    selector: (_,value)=>Tuple3(value.isCategoriesLoading,value.isCategoriesError,value.selectedCategoryId),
    builder: (_,tuple,__ ) {
          return
            tuple.item1?Center(child:
            ShimmerCategoryComponent()
            ):
            tuple.item2?
            ErrorComponent(onTryAgainTap: (){}
            ):

            ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:_homeScreenNotifiers.categories!.length+ 1,
                      //  reverse: true,
                        itemBuilder: (context,index){
    return index==0?
      //  _homeScreenNotifiers.categories!.length?
    CategoryComponent(
      isFirst:true,
      category: _homeScreenNotifiers.categories![index],
      isSelected:_homeScreenNotifiers.selectedCategoryId==0 ,

    )
        :

      CategoryComponent(
          isFirst:false,
      category: _homeScreenNotifiers.categories![index-1],
      isSelected:_homeScreenNotifiers.selectedCategoryId==_homeScreenNotifiers.categories![index-1].id ,

    );
                        },

           );
        }
      ),
    );
  }
}

class CategoryProductsComponent extends StatefulWidget {
 final CategoriesProducts item;
  const CategoryProductsComponent({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<CategoryProductsComponent> createState() => _CategoryProductsComponentState();
}

class _CategoryProductsComponentState extends State<CategoryProductsComponent> {
  late HomeScreenNotifiers _homeScreenNotifiers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeScreenNotifiers=Provider.of<HomeScreenNotifiers>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.item.translations!.firstWhere((element) => element.locale==AppShared.sharedPreferencesController.getAppLang()).name??'',
                style:  Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: AppShared.screenUtil.setSp(14),
                ),
              ),
              InkWell(
                onTap: (){
                  if( _homeScreenNotifiers.selectedCategoryId==this.widget.item.id!){return;}
                  _homeScreenNotifiers.selectedCategoryId=this.widget.item.id!;
                  _homeScreenNotifiers.productsMode=ProductsMode.CATEGORY;
                  _homeScreenNotifiers.getCategoryProducts(isInit: false,reset: true);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'ViewAll'.tr(),
                    style:  Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: AppShared.screenUtil.setSp(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
            height: AppShared.screenUtil.setHeight(5)),
        Container(
          height: 180.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.item.products!.length,
            // shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(Constants.SCREENS_PRODUCT_DETAILS_SCREEN,
                  arguments: [
                    widget.item.products![index].id,
                    widget.item.products![index].name,
                  ]);
                },
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 5),
             //   padding: EdgeInsets.symmetric(horizontal: 20),
                  width:120.h,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     ClipRRect(

                       child:CachedNetworkImage(
                         imageUrl: widget.item.products![index].image!,
                       height:100.h,
                         width: 100.w,
                         fit: BoxFit.fill,
                         placeholder: (context, url) =>ImagePlaceholderComponent(),
                       ),
                       borderRadius: BorderRadius.circular(15),
                     ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: Column(
                           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            children: [
                              AutoSizeText(

                                widget.item.products![index].translations!.firstWhere((element) => element.locale==AppShared.sharedPreferencesController.getAppLang()).name??'',
                                style: Theme.of(context).textTheme.headline1!.copyWith(
                                  fontSize:13.sp,
                                ),
                                maxLines: 2,
                                overflow:TextOverflow.ellipsis ,


                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      'PriceCurrency'.tr(
                                          args: [
                                            widget.item.products![index].discountPercent!=0?
                                            widget.item.products![index].discountPrice?.toString()??''
                                                : widget.item.products![index].price?.toString()??''

                                          ]
                                      ),

                            // ' ${ widget.item.products![index].price?.toString()??''} KWD',
                                      style:  Theme.of(context).textTheme.headline3!.copyWith(
                                        fontSize: AppShared.screenUtil.setSp(12),
                                      ),

                                    ),
                                    if(  widget.item.products![index].discountPercent!=0)
                                      Column(
                                        children: [
                                          // SizedBox(
                                          //   height: 2,
                                          // ),
                                          Text(

                                            widget.item.products![index].price?.toString()??'',
                                            style:  Theme.of(context).textTheme.headline2!.copyWith(
                                                fontSize:12.sp,
                                                color: Theme.of(context).primaryColor,
                                                decoration: TextDecoration.lineThrough
                                            ),


                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),

                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },

          ),
        ),
      ],
    );
  }
}

class CategoryComponent extends StatefulWidget {
final  bool isFirst;
final  bool isSelected;
final MenuCategory category;
  const CategoryComponent({
    Key? key,
    this.isFirst=false,
   required this.isSelected,
   required this.category,
  }) : super(key: key);

  @override
  State<CategoryComponent> createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {
  late HomeScreenNotifiers _homeScreenNotifiers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeScreenNotifiers =
        Provider.of<HomeScreenNotifiers>(context, listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.isFirst){
          if( _homeScreenNotifiers.selectedCategoryId==0){return;}

          _homeScreenNotifiers.selectedCategoryId=0;
          _homeScreenNotifiers.productsMode=ProductsMode.ALL;
          _homeScreenNotifiers.getProducts(isInit: false);
        }
        else{

          if( _homeScreenNotifiers.selectedCategoryId==this.widget.category.id!){return;}
          _homeScreenNotifiers.selectedCategoryId=this.widget.category.id!;
          _homeScreenNotifiers.productsMode=ProductsMode.CATEGORY;
          _homeScreenNotifiers.getCategoryProducts(isInit: false,reset: true);

        }

      },
      child: Container(
      //  width: 70.w,
constraints: BoxConstraints(
  minWidth: 70.w,
),

        margin: EdgeInsetsDirectional.only(start: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color:  this.widget.isSelected?
          Theme.of(context).primaryColor:Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 30.w,
              width: 30.w,
              child:  this.widget.isFirst? SvgPicture.asset(
                  '${Constants.ASSETS_IMAGES_PATH}all-icon.svg'):
        this.widget.category.image!.endsWith('svg')?
            SvgPicture.network( this.widget.category.image!,
              fit: BoxFit.fill,
            )
            :
              CachedNetworkImage(
                imageUrl:this.widget.category.image!,
                fit: BoxFit.fill,

                placeholder: (context, url) =>ImagePlaceholderComponent(),
              ),
            ),
            Text(
             this.widget.isFirst?
              'All'.tr():this.widget.category.translations!.firstWhere((element) => element.locale==AppShared.sharedPreferencesController.getAppLang()).name??'',
              style:  Theme.of(context).textTheme.headline3!.copyWith(
                fontSize: AppShared.screenUtil.setSp(14),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
