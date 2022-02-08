import 'package:pido/src/controllers/api_controllers/user_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/api_models/responses/countries_response.dart';
import 'package:pido/src/models/sub_models/address.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/views/dialogs/loading_dialog.dart';
import '../../utils/app_shared.dart';
import '../../views/components/empty_component.dart';
import '../../views/components/error_component.dart';
import 'package:easy_localization/easy_localization.dart';



class UserAddressesScreen extends StatefulWidget {
  @override
  _UserAddressesScreenState createState() => _UserAddressesScreenState();
}

class _UserAddressesScreenState extends State<UserAddressesScreen> {
  late UserController _userController;
  @override
  void initState() {
    super.initState();
    _userController=UserController.instance!;
    _future=getMyAddresses();
  }
  late Future<List<Address>>_future;
  List<Address>? items;
  Future<List<Address>>getMyAddresses()async{

    try{
      BaseResponse baseResponse=await _userController.getMyAddresses();
      // if(baseResponse.status!){
      items= List<Address>.from(baseResponse.data.map((x) => Address.fromJson(x)));
      // }


    }on Exception catch(e){
      print(e);
      throw e;
    }
    return items!;

  }

  Future<void>refresh()async{
    setState(() {
      _future=getMyAddresses();
    });
  }
  Address? selectedAddress;
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
                'ShippingAddresses'.tr(),
                style: textStyleRegular.copyWith(
                    fontSize: 18, color: Colors.black),
              ),



            ),
            Expanded(
              child: FutureBuilder<List<Address>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else if(snapshot.hasError){
                      return ErrorComponent(onTryAgainTap: (){});
                    }
                    else if(snapshot.data!.isEmpty){
                      return EmptyComponent(text: '',);
                    }
                    return Container(
                        child: ListView.separated(
                          itemCount:snapshot.data!.length,
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: (){
                                selectedAddress=snapshot.data![index];
                                Navigator.of(context).pop(selectedAddress);

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,

                                ),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(onPressed: (){}, icon: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}locate.svg')),

                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
                                        Row(
                                          children: [
                                            Text('${'Area'.tr()} :'),
                                            Text(snapshot.data?[index].area?.name??''),


                                          ],
                                        ),
                                        if(  snapshot.data![index].defult==1 )
                                          Text('Default'.tr()),
                                      ],
                                    ),
                                    SizedBox(
                                      height: AppShared.screenUtil.setHeight(15),
                                    ),
                                    Row(
                                      children: [
                                        Text('${'Street'.tr()} : '),
                                        Text(snapshot.data?[index].street??''),


                                      ],
                                    ),
                                    SizedBox(
                                      height: AppShared.screenUtil.setHeight(15),
                                    ),
                                    Row(
                                      children: [

                                        Text(snapshot.data?[index].addressName??''),


                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, index) =>
                              SizedBox(
                                height: AppShared.screenUtil
                                    .setHeight(15),
                              ),
                        ));
                  }
              ),
            ),
          ],
        )),


      ),
    );
  }
}

class CountryItem extends StatefulWidget {
  late  bool isSelected;
  final Country country;
  CountryItem({
    this.isSelected=false,
    required this.country,
  }) ;

  @override
  State<CountryItem> createState() => _CountryItemState();
}

class _CountryItemState extends State<CountryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          // Image.asset('${Constants.ASSETS_IMAGES_PATH}sa.png',
          // width: AppShared.screenUtil.setWidth(40),
          //   height: AppShared.screenUtil.setWidth(30),
          // ),
          // SizedBox(
          //   width: AppShared.screenUtil.setWidth(15),
          // ),
          Expanded(child: Text(widget.country.name??'')),
          if(widget.isSelected)
            Icon(Icons.done)


        ],
      ),
    );
  }
}
