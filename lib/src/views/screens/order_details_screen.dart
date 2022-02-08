import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:pido/src/controllers/api_controllers/orders_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/api_models/responses/countries_response.dart';
import 'package:pido/src/models/sub_models/Zone.dart';
import 'package:pido/src/models/sub_models/order_details.dart';
import 'package:pido/src/models/sub_models/region.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/custom_back_button.dart';
import 'package:pido/src/views/components/image_placeholder_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import '../components/error_component.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int orderId=ModalRoute.of(context)!.settings.arguments as int ;
    return OrderDetailsScreenBody(orderId);
  }
}


class OrderDetailsScreenBody extends StatefulWidget {
final int orderId;

  const OrderDetailsScreenBody(
this.orderId
  );
  @override
  _OrderDetailsScreenBodyState createState() =>
      _OrderDetailsScreenBodyState();
}

class _OrderDetailsScreenBodyState extends State<OrderDetailsScreenBody> {
  @override
  void initState() {
    super.initState();
    _orderController=OrdersController.instance!;
    _future=getOrderDetails();




  }
  int _current = 0;
  bool isLoading=false;


  double? cost;
  double? deliveryCost;
  double? totalAmount;
  Country?country;
  Region?region;
  Zone?zone;



int groupValue=1;

  late Future<OrderDetails>_future;
  late OrdersController _orderController;
  OrderDetails? _myOrderData;
  Future<OrderDetails>getOrderDetails()async{

    try{
      BaseResponse baseResponse=await _orderController.getOrderDetails(widget.orderId);
      // if(baseResponse.status!){
      _myOrderData= OrderDetails.fromJson(baseResponse.data!);
      setState(() {

      });
      // }


    }on Exception catch(e){
      print(e);
      throw e;
    }
    return _myOrderData!;

  }
  @override
  Widget build(BuildContext context) {
    //print(AppShared.currentUser.type);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
         'OrderDetails'.tr(),
          style: textStyleMedium.copyWith(
              fontSize: 17.sp),
        ),
        elevation: 0,
        leadingWidth: 35.w,
        // backgroundColor: Colors.white,
        leading: CustomBackButton(),
        actions: [
          if(_myOrderData!=null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  Printing.layoutPdf(onLayout: (PdfPageFormat format) => generatePdf(order: _myOrderData!));
                  // showDialog(context: context, builder: (context)=>OrderInvoiceDialog(
                  //   myOrderData:_myOrderData! ,
                  // ));

                },
                child: SvgPicture.asset(
                    '${Constants.ASSETS_IMAGES_PATH}order-bill.svg')),
          ),
        ],
        
      ),
      body: SafeArea(
        child: FutureBuilder<OrderDetails>(
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
              return ErrorComponent(onTryAgainTap: (){},);

            }
            return ListView(
              children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,

                        )
                    ),
                    padding: EdgeInsets.all(20),
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
                                    text: '${widget.orderId}',
                                    style: Theme.of(context).textTheme.headline3!.copyWith(
                                      fontSize: 14.sp,
                                    ),

                                  )
                                ]
                            )),

                            Text(snapshot.data?.statusName??'',
                              style: Theme.of(context).textTheme.headline3!.copyWith(
                                fontSize: 14.sp,
                                color:Helpers.getOrderStatusColor()[snapshot.data!.status!],
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
                                Text('${snapshot.data?.total} KWD', style: Theme.of(context).textTheme.headline3!.copyWith(
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
                                Text('${Helpers.formatDate(snapshot.data!.createdAt!)}', style: Theme.of(context).textTheme.headline3!.copyWith(
                                  fontSize: 14.sp,
                                ),),
                              ],
                            ),


                          ],
                        )

                      ],
                    ),
                  ),  SizedBox(
                    height: AppShared.screenUtil.setHeight(10),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
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
                        Text('Products'.tr(), style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 16.sp,
                        ),),
                        Text('${snapshot.data?.countItems??''} ${'items'.tr()}',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),


                      ],
                    ),

                    SizedBox(
                    height: AppShared.screenUtil.setHeight(10),
                    ),
                    Container(
                    child: ListView.separated(
                      itemCount: snapshot.data!.products!.length,
                      shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                    return Container(
                    height: AppShared.screenUtil.setHeight(100),

                    child: Row(

                    children: [
                      ClipRRect(

                        child:  CachedNetworkImage(
                          imageUrl: snapshot.data!.products![index].product!.image!,
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

                    '${snapshot.data!.products?[index].product?.name??''}',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 14.sp,
                    color: Colors.black,
                    ),
                    ),
                      RichText(text: TextSpan(
                          text:  '${snapshot.data!.products?[index].product?.price??''} KWD ',
                          style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: AppShared.screenUtil.setSp(16),
                            color: Colors.black,

                          ),
                          children: [
                            TextSpan(
                              text:  'X${Helpers.formatCount(snapshot.data!.products![index].quantity!)}  ',
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
            Container(
            padding: const EdgeInsets.all(12),
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

      fontSize: 14.sp,

    ),),


  ],
),
                      SizedBox(
                        height: AppShared.screenUtil.setHeight(15),
                      ),

    // if(snapshot.data!.address!=null)
    // InkWell(onTap: (){}, child: Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}locate.svg'),
    // )),

                      Row(
                        children: [
                          Text('${'Area'.tr()} : ',style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 14.sp,
                          ),),
                          Text(snapshot.data!.address!=null?snapshot.data!.address!.area?.name??'':snapshot.data!.areaId?.toString()??''
                            ,style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 14.sp,
                          ),),


                        ],
                      ),
                      SizedBox(
                        height: AppShared.screenUtil.setHeight(15),
                      ),
                      Row(
                        children: [
                          Text('${'Street'.tr()} : ',style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 14.sp,
                          ),),
                          Text(snapshot.data!.address!=null?snapshot.data!.address!.street??'':snapshot.data!.street?.toString()??''  ,style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 14.sp,
                          ),),


                        ],
                      ),
                      SizedBox(
                        height: AppShared.screenUtil.setHeight(15),
                      ),
                      Row(
                        children: [
                          Text('${'Name'.tr()} : ',style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 14.sp,
                          ),),
                          Text(snapshot.data!.address!=null?snapshot.data!.address!.addressName??'':snapshot.data!.addressName?.toString()??''  ,style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 14.sp,
                          ),),


                        ],
                      ),
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
                                Row(
                                  children: [
                                    SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}date.svg'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('DateOfReceipt'.tr(),style:  Theme.of(context).textTheme.headline4!.copyWith(
                                      fontSize: 14.sp,
                                    ),),
                                  ],
                                ),
                                Text(Helpers.formatDate(snapshot.data!.availabileDate!)  ,style:  Theme.of(context).textTheme.headline2!.copyWith(
                                  fontSize: 14.sp,
                                ),),





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
                                    SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}clock.svg'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('TimeOfReceipt'.tr(),style:  Theme.of(context).textTheme.headline4!.copyWith(
                                      fontSize: 14.sp,
                                    ),),
                                  ],
                                ),
                                Text(snapshot.data!.availabileTime??''  ,style:  Theme.of(context).textTheme.headline2!.copyWith(
                                  fontSize: 14.sp,
                                ),),





                              ],
                            ),


                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppShared.screenUtil.setHeight(10),
                      ),

                ],
              ),
            ),
                SizedBox(
                  height: AppShared.screenUtil.setHeight(10),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),


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
                                Text('${'Subtotal'.tr()} :',style:  Theme.of(context).textTheme.headline2!.copyWith(
                                  fontSize: 16.sp,
                                ),),
                                Text('${snapshot.data?.subTotal??''} KWD',style:  Theme.of(context).textTheme.headline2!.copyWith(
                                  fontSize: 16.sp,
                                ),),

                              ],
                            ), SizedBox(
                              height: AppShared.screenUtil.setHeight(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${'Tax'.tr()} : ',style:  Theme.of(context).textTheme.headline2!.copyWith(
                                  fontSize: 16.sp,
                                ),),
                                Text('${snapshot.data?.vatAmount??''} KWD',style:  Theme.of(context).textTheme.headline2!.copyWith(
                                  fontSize: 16.sp,
                                ),),

                              ],
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${'Discount'.tr()} :',style:  Theme.of(context).textTheme.headline2!.copyWith(
                                  fontSize: 16.sp,
                                ),),
                                Text('${snapshot.data?.discount==0?'----':'${snapshot.data?.discount??''}%'} ',style: Theme.of(context).textTheme.headline2!.copyWith(
                                  fontSize: 16.sp,
                                ),),

                              ],
                            ),
                            SizedBox(
                              height: AppShared.screenUtil.setHeight(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${'DeliveryCost'.tr()} :',style: Theme.of(context).textTheme.headline2!.copyWith(
                                  fontSize: 16.sp,
                                ),),
                                Text('${snapshot.data?.deliveryCost==0?'----':snapshot.data?.deliveryCost??''}',style: Theme.of(context).textTheme.headline2!.copyWith(
                                  fontSize: 16.sp,
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
                            Text('${'TotalAmount'.tr()} :',style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: 18.sp,
                            ),),
                            Text('${snapshot.data?.total??''} KWD',style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontSize: 16.sp,
                            ),),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),


              ],
            );
          }
        ),
      ),
    );
  }

  Future<Uint8List> generatePdf({
    required OrderDetails order,
  }) async {
    bool isAr =  AppShared
        .sharedPreferencesController
        .getAppLang() ==
        'ar' ;
    final pdf = pw.Document();
    pdf.addPage(
        pw.Page(
          //textDirection: pw.TextDirection.rtl,
            pageTheme: pw.PageTheme(
              pageFormat: PdfPageFormat.roll80,
              textDirection:isAr? pw.TextDirection.rtl:pw.TextDirection.ltr,

              theme: pw.ThemeData.withFont(
                base: pw.Font.ttf(await rootBundle.load("assets/fonts/ArbFONTS-Hacen-Tunisia.ttf")),
              ),
            ),
            build: (pw.Context context) {
              return !isAr? pw.Center(
                child: pw.Column(
                  mainAxisAlignment:isAr? pw.MainAxisAlignment.end :pw.MainAxisAlignment.start,
                  crossAxisAlignment:isAr? pw.CrossAxisAlignment.end:pw.CrossAxisAlignment.start,
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    // pw.Text('${'Name'.tr} : ${order.customerName}'),
                    // pw.Text('${'Mobile'.tr} : ${order.mobile} '),
                    pw.Text('${'OrderId'.tr()} : ${order.id} '),
                    //pw.Text('${'Notes'.tr} : ${order.nots} '),
                    pw.Text('---------------------------------'),
                    ...order.products!
                        .map((e) => pw.Column(
                      crossAxisAlignment: isAr? pw.CrossAxisAlignment.end :pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(

                            mainAxisSize: pw.MainAxisSize.min,
                            children: [
                              pw.Text('${e.product!.name} :',textDirection:isAr? pw.TextDirection.rtl:pw.TextDirection.ltr,),
                              pw.Text(' ${e.product!.discountPercent == 0 ? e.product!.price : e.product!.discountPrice} KWD '  ),
                            ]
                        ),




                    // pw.Text('---------------------------------------'),
                    // pw.Row(children: [
                    //   pw.Text('${'SubTotal'.tr()}',textDirection: pw.TextDirection.rtl,),
                    //   pw.Text(':  ${(order.subTotal)!.toStringAsFixed(2)}',),
                    //   pw.Text(' ${'Sar'.tr()}',textDirection: pw.TextDirection.rtl,),
                    // ]) ,
                    //
                    // pw.Text('${'Discount'.tr()} : ${order.discount} ${'KWD'.tr()}'),
                    // pw.Text('${'DeliveryPrice'.tr()} : ${order.deliveryCost!.toStringAsFixed(2)} ${'KWD'.tr()}'),
                    // pw.Text('${'Total'.tr()} : ${(order.total)!.toStringAsFixed(2)} ${'KWD'.tr()}'),
                  ],
                ),
              ),
              //ar



                    pw.Text('---------------------------------------'),

                    getTextPdf(title:'${'SubTotal'.tr()} ',price:'${(order.subTotal)!.toStringAsFixed(2)}'),
                    getTextPdf(title:'${'Discount'.tr()} ',price:'${order.discount}'),
                    getTextPdf(title:'${'DeliveryPrice'.tr()} ',price:'${order.deliveryCost!.toStringAsFixed(2)}'),
                    getTextPdf(title:'${'Total'.tr()} ',price:'${(order.total )!.toStringAsFixed(2)}'),
                  ],
                ),
              ):
              pw.Center(
                child: pw.Column(
                  mainAxisAlignment:isAr? pw.MainAxisAlignment.end :pw.MainAxisAlignment.start,
                  crossAxisAlignment:isAr? pw.CrossAxisAlignment.end:pw.CrossAxisAlignment.start,
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    // pw.Text('${'Name'.tr} : ${order.customerName}'),
                    // pw.Text('${'Mobile'.tr} : ${order.mobile} '),
                    pw.Text('${'OrderId'.tr()} : ${order.id} '),
                    //pw.Text('${'Notes'.tr} : ${order.nots} '),
                    pw.Text('---------------------------------'),
                    ...order.products!
                        .map((e) => pw.Column(
                      crossAxisAlignment: isAr? pw.CrossAxisAlignment.end :pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(

                            mainAxisSize: pw.MainAxisSize.min,
                            children: [
                              pw.Text('${e.product!.name} :',textDirection:isAr? pw.TextDirection.rtl:pw.TextDirection.ltr,),
                              pw.Text(' ${e.product!.discountPercent == 0 ? e.product!.price : e.product!.discountPrice} KWD '  ),
                            ]
                        ),




                        // pw.Text('---------------------------------------'),
                        // pw.Row(children: [
                        //   pw.Text('${'SubTotal'.tr()}',textDirection: pw.TextDirection.rtl,),
                        //   pw.Text(':  ${(order.subTotal)!.toStringAsFixed(2)}',),
                        //   pw.Text(' ${'Sar'.tr()}',textDirection: pw.TextDirection.rtl,),
                        // ]) ,
                        //
                        // pw.Text('${'Discount'.tr()} : ${order.discount} ${'KWD'.tr()}'),
                        // pw.Text('${'DeliveryPrice'.tr()} : ${order.deliveryCost!.toStringAsFixed(2)} ${'KWD'.tr()}'),
                        // pw.Text('${'Total'.tr()} : ${(order.total)!.toStringAsFixed(2)} ${'KWD'.tr()}'),
                      ],
                    ),
                    ),
                    //ar



                    pw.Text('---------------------------------------'),

                    getTextPdf(title:'${'SubTotal'.tr()} ',price:'${(order.subTotal)!.toStringAsFixed(2)}'),
                    getTextPdf(title:'${'Discount'.tr()} ',price:'${order.discount}'),
                    getTextPdf(title:'${'DeliveryPrice'.tr()} ',price:'${order.deliveryCost!.toStringAsFixed(2)}'),
                    getTextPdf(title:'${'Total'.tr()} ',price:'${(order.total )!.toStringAsFixed(2)}'),
                  ],
                ),
              )

              ; // Center
            }));
    return pdf.save();
  }



  getTextPdf({String? title,String? subtitle, String? price}){
    return pw.RichText(
      text: pw.TextSpan(
        text: title,
        children:  <pw.TextSpan>[
          if(subtitle!=null)
            pw.TextSpan(text: subtitle, ),
          pw.TextSpan(text: ' : ', ),
          pw.TextSpan(text: price, ),
          pw.TextSpan(text: ' ${'Sar'.tr()} '),
        ],
      ),
    );
  }
  getTextPdfForName({String? title, String? value}){
    return pw.RichText(
      text: pw.TextSpan(
        text: title,
        children:  <pw.TextSpan>[
          pw.TextSpan(text: ' : ', ),
          pw.TextSpan(text: value, ),
        ],
      ),
    );
  }
}


