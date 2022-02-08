import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pido/src/controllers/api_controllers/orders_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/sub_models/order.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/empty_component.dart';
import 'package:pido/src/views/components/error_component.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pido/src/views/components/shimmer_components/shimmer_order_component.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {

  late Future<MyOrderData>_future;
  late OrdersController _orderController;
  MyOrderData? _myOrderData;


  Future<MyOrderData>getMyOrders()async{

    try{
      BaseResponse baseResponse=await _orderController.getMyOrders(
        status:selectedStatus
      );
      // if(baseResponse.status!){
      _myOrderData= MyOrderData.fromJson(baseResponse.mapData!);
      // }


    }on Exception catch(e){
      print(e);
      throw e;
    }
    return _myOrderData!;

  }
  final PagingController<int, Order> _pagingController =
  PagingController(firstPageKey: 1);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orderController=OrdersController.instance!;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _future=getMyOrders();
  }
  Future<void>refresh()async{
    _pagingController.refresh();
    setState(() {
     // _future=getMyOrders();

    });
  }
  int selectedStatus=-1;
  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await _orderController.getMyOrders(
          status:selectedStatus,
          page: pageKey);
      _myOrderData= MyOrderData.fromJson(response.mapData!);
      final isLastPage = !_myOrderData!.isMore!;

      if (isLastPage) {
        _pagingController.appendLastPage(_myOrderData!.myOrder!);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(_myOrderData!.myOrder!, nextPageKey);
      }
    }on Exception catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh:refresh ,
      child: Scaffold(
        appBar:   AppBar(
          elevation: 0,
          title:Text(
            'OrderHistory'.tr(),
            style: Theme.of(context).textTheme.headline1!.copyWith(
              color:Colors.black,
              fontSize:AppShared.screenUtil.setSp(24),
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}menu.svg'),
            onPressed: () {
              Scaffold.of(context).openDrawer();

            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Constants.SCREENS_MY_CART_SCREEN,
                        arguments: context);
                  },
                  child: SvgPicture.asset(
                      '${Constants.ASSETS_IMAGES_PATH}cart.svg')),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 60.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: (){
                        if(selectedStatus==-1)return;
                        selectedStatus=-1;
                        refresh();
                      },

                      child: Container(


                        decoration: BoxDecoration(
                            color: selectedStatus==-1 ?Theme.of(context).primaryColor:Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color:  Theme.of(context).primaryColor
                          ),

                        ),
                        constraints: BoxConstraints(
                          minWidth: 90.w,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                        margin:  const EdgeInsets.all(5),
                        child: Center(child: Text('All'.tr(),
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 14.sp
                        ),
                        )),
                      ),
                    ),

                    ...Helpers.getOrderStatuses().map((e) =>  InkWell(
                      onTap: (){
                        if(selectedStatus==Helpers.getOrderStatuses().indexOf(e))return;

                        selectedStatus=Helpers.getOrderStatuses().indexOf(e);
                        refresh();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color:selectedStatus==Helpers.getOrderStatuses().indexOf(e)? Theme.of(context).primaryColor:Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:  Theme.of(context).primaryColor
                            ),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 90.w,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                        margin:  const EdgeInsets.all(5),

                        child: Center(child: Text(e??'',style:Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 14.sp
                        ),),),
                      ),
                    )),

                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                child:
                // FutureBuilder<MyOrderData>(
                //     future: _future,
                //     builder: (context, snapshot) {
                //       if(snapshot.connectionState==ConnectionState.waiting){
                //         return Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       }
                //       else if(snapshot.hasError){
                //         print(snapshot.error);
                //         print(snapshot.stackTrace);
                //         return ErrorComponent(onTryAgainTap: (){});
                //       }
                //       else if(snapshot.data!.myOrder!.isEmpty){
                //         return EmptyComponent(text: 'NoOrdersFound'.tr(),);
                //       }
                //     return
    PagedListView<int, Order>(

    pagingController: _pagingController,
    builderDelegate: PagedChildBuilderDelegate<Order>(
    //firstPageProgressIndicatorBuilder:(_)=> ShimmerOrderComponent(),
    noItemsFoundIndicatorBuilder: (_)=>EmptyComponent(text: 'NoOrdersFound'.tr(),),
    itemBuilder: (context, item, index) =>  InkWell(
                          onTap: (){
Navigator.of(context).pushNamed(Constants.SCREENS_ORDER_DETAILS_SCREEN,
arguments:item.id );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,

                              )
                            ),
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(text: TextSpan(
                                      text: '${'OrderId'.tr()} : ',
                                      style: Theme.of(context).textTheme.headline4!.copyWith(
                                        fontSize: 14.sp,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: '${item.id}',
                                            style: Theme.of(context).textTheme.headline3!.copyWith(
                                              fontSize: 14.sp,
                                            ),

                                        )
                                      ]
                                    )),

                                    Text(' ${item.statusName}',
                                    style: Theme.of(context).textTheme.headline3!.copyWith(
                                      fontSize: 14.sp,

                                      color:Helpers.getOrderStatusColor()[item.status!],
                                    ),
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: AppShared.screenUtil.setHeight(10),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}dollar.svg'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('${item.total} KWD', style: textStyleMedium.copyWith(
                                        fontSize: 14.sp,
                                        ),),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}date.svg'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(Helpers.formatDate(item.createdAt!), style: textStyleMedium.copyWith(
                        fontSize: 14.sp,
                        ),),
                                      ],
                                    ),
                                    Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(
                                          Directionality.of(context) == TextDirection.rtl ? pi : 0,
                                        ),child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}go.svg')),

                                  ],
                                )

                              ],
                            ),
                          ),
                        )

                      ,
                        // separatorBuilder:  (_,index){
                        //   return SizedBox(
                        //     height: AppShared.screenUtil.setHeight(10),
                        //   );
                        // },
                      ),


                //     ;
                //   }
                // ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
