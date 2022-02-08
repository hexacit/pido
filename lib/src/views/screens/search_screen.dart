import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pido/src/models/sub_models/product.dart';
import 'package:pido/src/notifiers/screens_notifiers/search_screen_notifiers.dart';
import 'package:pido/src/views/components/custom_back_button.dart';
import 'package:pido/src/views/components/error_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/views/components/filter_drawer.dart';
import 'package:pido/src/views/components/image_placeholder_component.dart';
import 'package:provider/provider.dart';
import '../../styles/app_styles.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import '../../views/components/custom_btn_component.dart';
import '../../views/components/custom_fade_animation_component.dart';
import '../../views/components/loading_component.dart';
import '../components/parent_component.dart';
import 'package:tuple/tuple.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<SearchScreenNotifiers>(
        create: (_) => SearchScreenNotifiers(context),
        child: SearchScreenBody(),
      ),
    );
  }
}

class SearchScreenBody extends StatefulWidget {
  @override
  _SearchScreenBodyState createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  late SearchScreenNotifiers _searchScreenNotifiers;

  @override
  void initState() {
    super.initState();
    _searchScreenNotifiers =
        Provider.of<SearchScreenNotifiers>(context, listen: false);

  }

  bool searchTextNotEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        endDrawer: FilterDrawer(),

        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Search'.tr(),
            style: Theme.of(context).textTheme.headline3!.copyWith(
                color: Colors.black,
                fontSize: AppShared.screenUtil.setSp(17)),
          ),
          elevation: 0,
          leadingWidth: 35.w,

          leading: CustomBackButton(),

          actions: [
            Builder(
              builder: (context) {
                return InkWell(
                  onTap: (){
                  Scaffold.of(context).openEndDrawer();
                  },
                    child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child:
                      SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}filter.svg'),
                ));
              }
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Selector<SearchScreenNotifiers,Tuple2<bool,bool>>(
            selector: (_,value)=>Tuple2(value.isLoading, value.isError),
            builder: (_, tuple,__) {
              return
                tuple.item1
                          ? Center(
                              child: CircularProgressIndicator()

                            )
                          :  tuple.item2
                              ? Center(
                                  child: ErrorComponent(
                                    onTryAgainTap: () {

                                    },
                                  ),
                                ):
                Column(
                children: [
                  Container(


                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      )
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                    IconButton(
                      onPressed: () {
//_searchScreenNotifiers.getFilteredProducts();
                        _searchScreenNotifiers.search();

                      },
                      icon: Icon(
                        Icons.search,
                        color: Color(0xff757575),
                      ),
                    ),
                        Expanded(
                          child: TextFormField(
                            textInputAction:TextInputAction.search ,
                            controller: _searchScreenNotifiers.searchTextEditingController,
                            onChanged: (val) {

                            },
                            onFieldSubmitted: (val){
                              print('submitted');
                             // _searchScreenNotifiers.searchTextEditingController.text='';
                              _searchScreenNotifiers.search();
                             //  _searchScreenNotifiers.getFilteredProducts();
                             //  _searchScreenNotifiers.pagingController.refresh();
                              FocusScope.of(context).unfocus();
                            },
                            decoration: InputDecoration(

                                suffix: Container(
                                  margin:const  EdgeInsetsDirectional.only(end: 5),
                                    child: InkWell(
                                            onTap: () {
                                              _searchScreenNotifiers.searchTextEditingController.text='';
                                              //_searchScreenNotifiers.getFilteredProducts();
                                              FocusScope.of(context).unfocus();
                                              _searchScreenNotifiers.search();


                                            },
                                            child: Icon(
                                              Icons.cancel_outlined,
                                            ))
                                        ),
                                border: InputBorder.none,
                                hintText: 'Search'.tr(),
                                hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                                    fontSize: AppShared.screenUtil.setSp(14),
                                    color: Color(0xffBEBEBE)),

                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppShared.screenUtil.setHeight(15),
                  ),
                  Expanded(
                      child: Selector<SearchScreenNotifiers,Tuple3<bool,bool,bool>>(
                          selector: (_,value)=>Tuple3(value.isProductsLoading,
                              value.isProductsError,
                              value.isFilterApplied),
                          builder: (_, tuple,__) {
                            return
                            !tuple.item3?
                                Container()
                                :
                            tuple.item1
                                ? Center(
                                child: CircularProgressIndicator()

                            )
                                :  tuple.item2
                                ? Center(
                              child: ErrorComponent(
                                onTryAgainTap: () {

                                },
                              ),
                            ):
                              Container(
                                  child:

                                PagedListView<int, Product>(
                                pagingController: _searchScreenNotifiers.pagingController,
                                builderDelegate: PagedChildBuilderDelegate<Product>(
                                itemBuilder: (context, item, index) =>

                                InkWell(
                                          onTap: (){
                                            Navigator.of(context).pushNamed(Constants.SCREENS_PRODUCT_DETAILS_SCREEN,
                                                arguments: [
                                                  item.id,
                                                  item.name,
                                                ]);
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

                                                  child:  CachedNetworkImage(
                                                    imageUrl:item.image!,
                                                    height: double.infinity,
                                                    width: 100.w,
                                                    fit: BoxFit.cover,
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
                                                    mainAxisAlignment:MainAxisAlignment.start,


                                                    children: [
                                                      Text(

                                                        item.name??''
                                                            ,
                                                        style: Theme.of(context).textTheme.headline3!.copyWith(
                                                            fontSize: AppShared.screenUtil.setSp(14),
                                                          color: Colors.black,
                                                          ),
                                                      ),
                                                      // SizedBox(
                                                      //   height: 5.h,
                                                      // ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'PriceCurrency'.tr(
                                                                args: [
                                                                  item.discountPercent!=0?
                                                                  item.discountPrice?.toString()??''
                                                                      : item.price?.toString()??''

                                                                ]
                                                            ),
                                                           // _searchScreenNotifiers.products[index].price?.toString()??'',
                                                            style: Theme.of(context).textTheme.headline1!.copyWith(
                                                              fontSize: AppShared.screenUtil.setSp(16),
                                                              color: Colors.black,

                                                            ),
                                                          ),   SizedBox(width: 5,),

                                                          if( item.discountPercent!=0)
                                                            Text(

                                                              item.price?.toString()??'',
                                                              style: Theme.of(context).textTheme.headline2!.copyWith(
                                                                  fontSize: AppShared.screenUtil.setSp(12),
                                                                  color: Theme.of(context).primaryColor,
                                                                  decoration: TextDecoration.lineThrough
                                                              ),


                                                            ),
                                                        ],
                                                      ),
                                                      // SizedBox(
                                                      //   height: 5.h,
                                                      // ),
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(

                                                                item.description??'',
                                                                style: Theme.of(context).textTheme.headline2!.copyWith(
                                                                  fontSize: AppShared.screenUtil.setSp(11),
                                                                  color: Colors.black,

                                                                ),
                                                                maxLines: 2,
                                                                overflow:TextOverflow.ellipsis ,
                                                              ),
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
                                        )

                                      //   ;
                                      // },
                                      // separatorBuilder: (_, index) => SizedBox(
                                      //     height: AppShared.screenUtil.setHeight(5)),
                                  ),
                                )


                         );}))

                ],
              );
            }
          ),
        ));
  }
}
