import 'package:cached_network_image/cached_network_image.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pido/src/controllers/api_controllers/user_controller.dart';
import 'package:pido/src/models/sub_models/favorite_products.dart';
import 'package:pido/src/models/sub_models/user_favorite_data.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/views/components/custom_back_button.dart';
import 'package:pido/src/views/components/image_placeholder_component.dart';
import 'package:flutter/material.dart';
import 'package:pido/src/views/components/shimmer_components/shimmer_favorite_component.dart';
import '../../utils/app_shared.dart';
import '../../views/components/empty_component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MyFavoriteScreen extends StatefulWidget {
  @override
  _MyFavoriteScreenState createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return  MyFavoriteScreenBody
      ();
  }
}

class MyFavoriteScreenBody extends StatefulWidget {
  @override
  _MyFavoriteScreenBodyState createState() => _MyFavoriteScreenBodyState();
}

class _MyFavoriteScreenBodyState extends State<MyFavoriteScreenBody> {
  late UserController _userController;

  @override
  void initState() {
    super.initState();
    _userController=UserController.instance!;
   // _future=getMyFavorite();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }
  final PagingController<int, FavoriteItem> _pagingController =
  PagingController(firstPageKey: 1);

 // late Future<List<FavoriteItem>>_future;
  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await _userController.getUserFavorites(

          page: pageKey);
      FavoriteProducts data= FavoriteProducts.fromJson(response.mapData!);
      final isLastPage = !data.isMore!;

      if (isLastPage) {
        _pagingController.appendLastPage(data.results!);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(data.results!, nextPageKey);
      }
    }on Exception catch (error) {
      _pagingController.error = error;
    }
  }
  // Future<List<FavoriteItem>>getMyFavorite()async{
  //   List<FavoriteItem>? userFavoriteData;
  //   try{
  //     BaseResponse baseResponse=await _userController.getUserFavorites();
  //     // if(baseResponse.status!){
  //     userFavoriteData=  List<FavoriteItem>.from(baseResponse.data.map((x) => FavoriteItem.fromJson(x)));
  //     // }
  //
  //
  //   }on Exception catch(e){
  //     print(e);
  //     throw e;
  //   }
  //   return userFavoriteData;
  //
  // }
  Future<void>refresh()async{
    _pagingController.refresh();
    setState(() {
     // _future=getMyFavorite();

    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:refresh ,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'FavoriteList'.tr(),
            style: Theme.of(context).textTheme.headline3!.copyWith(
                fontSize: 24.sp,
          ),),
          leading: CustomBackButton(),
          leadingWidth: 35.w,
          actions: [],
        ),
        body:

              ListView(
                children: [
                  Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                   child:
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                                 child:
                            // snapshot.data!.isEmpty?
                                //     EmptyComponent(text: 'Empty'.tr())
                                //     :

                            PagedListView<int, FavoriteItem>(
    pagingController: _pagingController,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    builderDelegate: PagedChildBuilderDelegate<FavoriteItem>(
      noItemsFoundIndicatorBuilder: (_)=> Center(child: EmptyComponent(text: 'FavoriteIsEmpty'.tr())),
firstPageProgressIndicatorBuilder: (_)=>ShimmerFavoriteComponent(),
    itemBuilder: (context, item, index) => ProductListItem(
                  favoriteItem: item,
            )
    // ;
    //         //  ProductListItem();
    //         },
                    // separatorBuilder: (_, index) =>
                    //     SizedBox(
                    //       height: AppShared.screenUtil
                    //           .setHeight(10),
                    //     ),
                  )),

                            ),
                          ),
                  ),
                ],
              )
        //
        //     ;
        //   }
        // ),


      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
  final FavoriteItem favoriteItem;
  const ProductListItem({
    Key? key,
    required this.favoriteItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return favoriteItem.product==null?Container(): InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(Constants.SCREENS_PRODUCT_DETAILS_SCREEN,arguments: [
          favoriteItem.productId!,
          favoriteItem.product?.name??''
        ]);
        //  Navigator.of(context).pushNamed(Constants.SCREENS_HOW_OFFER_WORK_SCREEN,arguments: [
        //   0,
        //   'Product Details'
        // ]);
      },
      child: Container(
        height: AppShared.screenUtil.setHeight(120),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Theme.of(context).primaryColor,
            )
        ),
        child: Row(

          children: [
            ClipRRect(

              child: CachedNetworkImage(
                imageUrl:favoriteItem.product!.image!,
                height:double.infinity,
                width: 100.w,
                fit: BoxFit.fill,
                placeholder: (context, url) =>ImagePlaceholderComponent(),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            SizedBox(
              width: AppShared.screenUtil.setWidth(5),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                mainAxisAlignment:MainAxisAlignment.spaceBetween,


                children: [
                  Text(

                    favoriteItem.product?.name??''
                    ,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: AppShared.screenUtil.setSp(14),
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Text( 'PriceCurrency'.tr(
                          args: [
                            favoriteItem.product?.discountPercent!=0?
                            favoriteItem.product?.discountPrice?.toString()??''
                                : favoriteItem.product?.price?.toString()??''

                          ]
                      ),

                       // favoriteItem.product?.price?.toString()??'',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: AppShared.screenUtil.setSp(16),
                          color: Colors.black,

                        ),
                      ),
                      SizedBox(width: 5,),
                      if( favoriteItem.product?.discountPercent!=0)
                        Text(

                          favoriteItem.product?.price?.toString()??'',
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontSize: AppShared.screenUtil.setSp(12),
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.lineThrough
                          ),


                        ),
                    ],
                  ), Text(

                    favoriteItem.product?.description??'',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: AppShared.screenUtil.setSp(11),
                      color: Colors.black,

                    ),
                    maxLines: 2,
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