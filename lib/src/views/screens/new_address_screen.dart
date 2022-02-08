import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pido/src/controllers/api_controllers/configs_controller.dart';
import 'package:pido/src/controllers/api_controllers/user_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/api_models/responses/location_response.dart';
import 'package:pido/src/models/sub_models/address.dart';
import 'package:pido/src/models/sub_models/area.dart';
import 'package:pido/src/models/sub_models/user.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/custom_back_button.dart';
import 'package:pido/src/views/components/error_component.dart';
import 'package:pido/src/views/dialogs/area_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pido/src/views/dialogs/loading_dialog.dart';
class NewAddressScreen extends StatelessWidget {
  const NewAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Address? address=ModalRoute.of(context)!.settings.arguments as Address?;
    return NewAddressScreenBody(address: address,);
  }
}

class NewAddressScreenBody extends StatefulWidget {
  final Address? address;
  const NewAddressScreenBody({Key? key,
    required this.address

  }) : super(key: key);

  @override
  _NewAddressScreenBodyState createState() => _NewAddressScreenBodyState();
}

class _NewAddressScreenBodyState extends State<NewAddressScreenBody> {

 late Completer<GoogleMapController>_completer;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _completer= Completer<GoogleMapController>();
    _key=GlobalKey<FormState>();
    _areaTextEditingController=TextEditingController();
    _streetTextEditingController=TextEditingController();
    _nameTextEditingController=TextEditingController();
    _userController=UserController.instance!;
    if(widget.address!=null)
      setData();

  }
bool _isDefault=false;
 late GlobalKey<FormState>_key;
 late TextEditingController _areaTextEditingController;
 late TextEditingController _streetTextEditingController;
 late TextEditingController _nameTextEditingController;
 late UserController _userController;
 String? addressName;
 String locationName='';
 Area? selectedArea;
 String? streetName;
 LatLng? selectedPosition;
 bool isBtnLoading = false;
void setData(){
  selectedPosition=LatLng(widget.address!.latitude!.toDouble(), widget.address!.latitude!.toDouble()) ;
  selectedArea=widget.address!.area;
  _areaTextEditingController.text=widget.address!.area!.name??'';
  _streetTextEditingController.text=widget.address!.street??'';
  _nameTextEditingController.text=widget.address!.addressName??'';
  _isDefault=widget.address!.defult==1;
setState(() {

});
}
 Future<void>addAddress()async
 {
   if (!_key.currentState!.validate()||selectedPosition==null) {
     if(selectedPosition==null){
       Helpers.showMessage('ChooseLocationInMap'.tr(), MessageType.MESSAGE_FAILED);

     }
     return;
   }
   _key.currentState!.save();
   try {
     setState(() {
       isBtnLoading = true;

     });
     BaseResponse response = await _userController.addAddress(
      addressName: addressName,
       areaId: selectedArea!.id,
       streetName: streetName,
       lat: selectedPosition!.latitude,
       long: selectedPosition!.longitude,
       isDefault: _isDefault,

     );
     if (response.status!) {
       if(_isDefault){
         Address address=Address.fromJson(response.data);
         User user=AppShared.currentUser!.copyWith(
             defaultAddress:address
         );
         AppShared.currentUser=user;
         AppShared.sharedPreferencesController.setUserData(user);
       }

       Navigator.of(context).pop(true);

       Helpers.showMessage(response.message, MessageType.MESSAGE_SUCCESS);
       //}
     } else {
       Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);
       setState(() {
         isBtnLoading = false;

       });

     }
   } catch (error) {
     setState(() {
       isBtnLoading = false;

     });
     print(error);
     Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
   }
 }
 Future<void>editAddress()async
 {
   if (!_key.currentState!.validate()||selectedPosition==null) {
     if(selectedPosition==null){
       Helpers.showMessage('ChooseLocationInMap'.tr(), MessageType.MESSAGE_FAILED);

     }
     return;
   }
   _key.currentState!.save();
   try {
     setState(() {
       isBtnLoading = true;

     });
     BaseResponse response = await _userController.editAddress(
       addressId: widget.address!.id,
       addressName: addressName,
       areaId: selectedArea!.id,
       streetName: streetName,
       lat: selectedPosition!.latitude,
       long: selectedPosition!.longitude,
       isDefault: _isDefault,

     );
     if (response.status!) {
       if(_isDefault){
         Address address=Address.fromJson(response.data);
         User user=AppShared.currentUser!.copyWith(
           defaultAddress:address
         );
         AppShared.currentUser=user;
         AppShared.sharedPreferencesController.setUserData(user);
       }


       Navigator.of(context).pop(true);

       Helpers.showMessage(response.message, MessageType.MESSAGE_SUCCESS);

     } else {
       Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);
       setState(() {
         isBtnLoading = false;

       });

     }
   } catch (error) {
     setState(() {
       isBtnLoading = false;

     });
     print(error);
     Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
   }
 }
 Future<void>getAddress(LatLng position)async{
   try{
     showDialog(context: context, builder: (context)=>LoadingDialog());
     LocationResponse response= await

     _userController.getLocationDataFromLatAndLong(position.latitude, position.longitude);
     locationName=response.locality!;
     setState(() {

     });
     Navigator.of(context).pop();

   }

   on Exception catch(e){

     Navigator.of(context).pop();

     print(e);
     Helpers.showMessage('SomethingWentWrong'.tr(), MessageType.MESSAGE_FAILED);

   }




 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:    AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
            widget.address==null?
          'NewAddress'.tr()
                :
            'EditAddress'.tr()
          ,
          style: textStyleRegular.copyWith(
              fontSize: 18, color: Colors.black),
        ),
        leadingWidth: 35.w,
        leading: CustomBackButton(),



      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.35,
            child: AddressMapWidget(
              onTap: (val){
                selectedPosition=val;
                getAddress(val!);
              },
            )
          ),
          SizedBox(
            height: AppShared.screenUtil.setHeight(10),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Theme.of(context).primaryColor,

                )
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),

              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
Text('ShippingAddress'.tr()),
Text(locationName),
                    SizedBox(
                      height: AppShared.screenUtil.setHeight(10),
                    ),
                   // Text('Country Kuwait'),
                    TextFormField(
                      controller: _nameTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Name'.tr(),
                      ),
                      validator: (val){
                        if(val==null||val.isEmpty)
                          return'ThisFieldIsRequired'.tr();

                        return null;

                      },
                      onSaved: (val){
                        addressName=val;
                      },
                    ),

                         TextFormField(
                           readOnly: true,
                           controller:_areaTextEditingController ,
                          decoration: InputDecoration(
                            hintText: 'Area'.tr(),
                          ),
                          validator: (val){
                            if(val==null||val.isEmpty)
                              return'ThisFieldIsRequired'.tr();

                            return null;

                          },
                          onTap: (){
                            showDialog(context: context, builder: (context)=>AreasDialog(
                              onSelect: (area){
                                if(area!=null){
                                  selectedArea=area;
                                  _areaTextEditingController.text=selectedArea?.name??'';
                                }

                              },
                            ));
                          },

                    ),
                    TextFormField(
                      controller: _streetTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Street'.tr(),
                      ),
                      validator: (val){
                        if(val==null||val.isEmpty)
                          return'ThisFieldIsRequired'.tr();

                        return null;

                      },
                      onSaved: (val){
                        streetName=val;
                      },
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          _isDefault=!_isDefault;
                        });
                      },
                      child: Row(
                        children: [
                          Checkbox(  onChanged: (val){
                            setState(() {
                              _isDefault=val!;
                            });
                          },
                            value: _isDefault,),
                          Text('Default'.tr()),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppShared.screenUtil.setHeight(10),
                    ),
                    InkWell(
                      onTap: widget.address==null? addAddress:editAddress,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child:  isBtnLoading?
                        Center(child: CircularProgressIndicator(
                          color: Colors.black,
                        ),)
                            :
                        SvgPicture.asset(
                          widget.address==null?
                          '${Constants.ASSETS_IMAGES_PATH}done.svg':
                          '${Constants.ASSETS_IMAGES_PATH}edit.svg'
                          ,
                          color: Colors.black,
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
            ),
          )
        ],
      ),
    );
  }
}

class AddressMapWidget extends StatefulWidget {
  final Function(LatLng?)onTap;
  const AddressMapWidget({Key? key,
  required this.onTap
  }) : super(key: key);

  @override
  _AddressMapWidgetState createState() => _AddressMapWidgetState();
}

class _AddressMapWidgetState extends State<AddressMapWidget> {
  late Completer<GoogleMapController>_completer;
  LatLng? selectedPosition;
  List _markers=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _completer= Completer<GoogleMapController>();
    getUserLocation();


}
  Future<void> getUserLocation({isInit: true}) async {

    Location location = Location.instance;
    bool isGpsEnabled = await location.requestService();
    if (isGpsEnabled ) {
      PermissionStatus permissionStatus = await location.requestPermission();

      if (permissionStatus == PermissionStatus.granted) {

        LocationData data = await location.getLocation();
        _markers = [
          // Marker(
          //   markerId: MarkerId('user'),
          //   position: LatLng(data.latitude!, data.longitude!),
          // )
        ];
        ( await _completer.future).animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(data.latitude!, data.longitude!), zoom: 14.4746)));
setState(() {

});

      }
      else {
        print('permissionStatus disabled. 1 map');

        return;
      }
    } else {
      print('permissionStatus disabled. 2 map');
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        onMapCreated: (controller){
          _completer.complete(controller);
        },
        onTap: (position)async{
          print('position $position');
          _markers = [
            Marker(
              markerId: MarkerId('user'),
              position: LatLng(position.latitude, position.longitude),
            )
          ];
          ( await _completer.future).animateCamera(
              CameraUpdate.newCameraPosition(
                  CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14.4746)));
          setState(() {

          });

          selectedPosition=position;
          widget.onTap(selectedPosition);
        },
        markers: Set<Marker>.from(_markers),

        initialCameraPosition: CameraPosition(
          target: LatLng(31.34445,
              51.556789),
          zoom: 12,
        ),
        zoomControlsEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.terrain,

        gestureRecognizers: Set()
          ..add(
              Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))

    );
  }
}

