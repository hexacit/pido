import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pido/src/controllers/api_controllers/user_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/sub_models/address.dart';
import 'package:pido/src/models/sub_models/shipping_address_data.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/custom_back_button.dart';
import 'package:pido/src/views/components/custom_btn_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/app_shared.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShippingAddressesScreen extends StatefulWidget {
  @override
  _ShippingAddressesScreenState createState() => _ShippingAddressesScreenState();
}

class _ShippingAddressesScreenState extends State<ShippingAddressesScreen> {
  late UserController _userController;
  @override
  void initState() {
    super.initState();
    _userController=UserController.instance!;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    //_future=getMyAddresses();
  }
  final PagingController<int, Address> _pagingController =
  PagingController(firstPageKey: 1);
  late Future<List<Address>>_future;
  // List<Address>? items;
  // Future<List<Address>>getMyAddresses()async{
  //
  //   try{
  //     BaseResponse baseResponse=await _userController.getMyAddresses();
  //     // if(baseResponse.status!){
  //     items= List<Address>.from(baseResponse.data.map((x) => Address.fromJson(x)));
  //     // }
  //
  //
  //   }on Exception catch(e){
  //     print(e);
  //     throw e;
  //   }
  //   return items!;
  //
  // }
  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await _userController.getMyAddresses(

          page: pageKey);
      ShippingAddressData data= ShippingAddressData.fromJson(response.mapData!);
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

  Future<void>refresh()async{
    _pagingController.refresh();
    setState(() {
     // _future=getMyAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                    AssetImage('${Constants.ASSETS_IMAGES_PATH}bg.png'),
                    fit: BoxFit.cover
                )
            ),
            padding: EdgeInsets.symmetric(horizontal: 15,),         child:

                  Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        centerTitle: true,
                        title: Text(
                          'MyShippingAddresses'.tr(),
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontSize: 18, color: Colors.black),
                        ),
                      leadingWidth: 35.w,
                        leading: CustomBackButton(),
                        actions: [
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(Constants.SCREENS_NEW_ADDRESS_SCREEN,
                                   ).then((value)  {
                                  if(value!=null){
                                    if(value as bool){
                                      refresh();
                                    }
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                    '${Constants.ASSETS_IMAGES_PATH}plus-icon.svg'),
                              )),
                        ],


                      ),
                      Expanded(
                        child:
                        // FutureBuilder<List<Address>>(
                        //   future: _future,
                        //   builder: (context, snapshot) {
                        //     if(snapshot.connectionState==ConnectionState.waiting){
                        //       return Center(
                        //         child: CircularProgressIndicator(),
                        //       );
                        //     }
                        //     else if(snapshot.hasError){
                        //       return Center(child: ErrorComponent(onTryAgainTap: (){}));
                        //     }
                        //     else if(snapshot.data!.isEmpty){
                        //       return EmptyComponent(text: 'NoAddresses'.tr(),);
                        //     }
                        //     return
                            Container(
                               child:       PagedListView<int, Address>(
    pagingController: _pagingController,
    // shrinkWrap: true,
    // physics: NeverScrollableScrollPhysics(),
    builderDelegate: PagedChildBuilderDelegate<Address>(
    itemBuilder: (context, item, index) =>  AddressItemComponent(
          item: item,
          onDelete: (id){
            _pagingController.itemList?.removeWhere((element) => element.id==id);
           // snapshot.data!.removeWhere((element) => element.id==id);
            setState(() {

            });

          },
          refresh: refresh,

       // );
    )
    )  )
            // separatorBuilder: (_, index) =>
            //     SizedBox(
            //                 height: AppShared.screenUtil
            //                   .setHeight(15),
            //     ),
           ))
                      //     }
                      //   ),
                      ]),

                  )


      ),
    );
  }
}

class AddressItemComponent extends StatefulWidget {
 final  Address item;
 final Function(int)onDelete;
 final Function refresh;

 const AddressItemComponent({Key? key,
required  this.item,
   required this.onDelete,
   required this.refresh,
  }) : super(key: key);

  @override
  _AddressItemComponentState createState() => _AddressItemComponentState();
}

class _AddressItemComponentState extends State<AddressItemComponent> {
  Address? selectedAddress;
  @override
  Widget build(BuildContext context) {
    return  Dismissible(
      key: Key(widget.item.id.toString()),
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
            return DeleteAddressDialog(

              id: widget.item.id!,
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
      child: InkWell(
        onTap: (){
          selectedAddress=widget.item;
          Navigator.of(context).pop(selectedAddress);

        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,

          ),
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(bottom: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: (){}, child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}locate.svg')),
                  Row(
                    children: [
                      // IconButton(onPressed:(){
                      //
                      //
                      // }, icon: Icon(Icons.delete),color: Colors.red,),

                      IconButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed(Constants.SCREENS_NEW_ADDRESS_SCREEN,
                              arguments: widget.item
                          ).then((value)  {
                            if(value!=null){
                              if(value as bool){
                                widget.refresh();
                              }
                            }
                          });
                        }
                        ,
                        icon: SvgPicture.asset(
                          '${Constants.ASSETS_IMAGES_PATH}edit.svg',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Row(
                    children: [
                      Text('${'Area'.tr()} : ',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 14.sp,
                      ),),
                      Text(widget.item.area?.name??'', style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 14.sp,
                      ),),


                    ],
                  ),
                  if(  widget.item.defult==1 )
                    Text('Default'.tr(),
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 14.sp,
                      color: const Color(0xff286F2D)
                    ),),
                ],
              ),
              SizedBox(
                height: AppShared.screenUtil.setHeight(15),
              ),
              Row(
                children: [
                  Text('${'Street'.tr()} : ', style: Theme.of(context).textTheme.headline4!.copyWith(
        fontSize: 14.sp,
        ),),
                  Text(widget.item.street??'', style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 14.sp,
                  ),),


                ],
              ),
              SizedBox(
                height: AppShared.screenUtil.setHeight(15),
              ),
              Row(
                children: [
                  Text('${'Name'.tr()} : ', style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontSize: 14.sp,
                  ),),

                  Text(widget.item.addressName??'', style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 14.sp,
                  ),),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteAddressDialog extends StatefulWidget {
  final int id;
  final Function(int)onDelete;

  const DeleteAddressDialog(
      {required this.id,
        required   this.onDelete}
      );

  @override
  _DeleteAddressDialogState createState() =>
      _DeleteAddressDialogState();
}

class _DeleteAddressDialogState extends State<DeleteAddressDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userController=UserController.instance!;

  }
  late UserController _userController;

  bool isDeleting=false;
  Future<void>deleteAddress()async
  {
    setState(() {
      isDeleting=true;
    });

    try {

      BaseResponse response = await _userController.deleteAddress(
          addressId: widget.id

      );
      if (response.status!) {



        Helpers.showMessage(response.message, MessageType.MESSAGE_SUCCESS);
        widget.onDelete( widget.id);

        //}
      } else {
        Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);


      }
      setState(() {
        isDeleting=false;
      });
      Navigator.of(context).pop();

    } catch (error) {
      setState(() {
        isDeleting=false;
      });
      Navigator.of(context).pop();
      print(error);
      Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
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
                'ConfirmDeleteAddress'.tr(),
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
                    deleteAddress();
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
