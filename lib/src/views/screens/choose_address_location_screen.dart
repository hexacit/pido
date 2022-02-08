import 'dart:async';

import 'package:pido/src/controllers/api_controllers/user_controller.dart';
import 'package:pido/src/models/api_models/responses/location_response.dart';
import 'package:pido/src/models/sub_models/place.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/custom_btn_component.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pido/src/notifiers/screens_notifiers/choose_address_screen_notifiers.dart';
import 'package:location/location.dart';
import 'package:pido/src/views/dialogs/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class ChooseAddressLocationScreen extends StatelessWidget {
  //LocationData? userLocation;
  @override
  Widget build(BuildContext context) {
    // var userLocation =
    //     ModalRoute.of(context)!.settings.arguments as LocationData?;

    return ChooseAddressLocationScreenBody(
    );
  }
}

class ChooseAddressLocationScreenBody extends StatefulWidget {
  @override
  State<ChooseAddressLocationScreenBody> createState() =>
      ChooseAddressLocationScreenBodyState();
}

class ChooseAddressLocationScreenBodyState
    extends State<ChooseAddressLocationScreenBody> {
  late CameraPosition _userLocation;
  late Completer<GoogleMapController> controller;

  LatLng? selectedLocation;
   List<Marker> markers=[];
late UserController _userController;
  @override
  void initState() {
    super.initState();
    _userController=UserController.instance!;
    init();
  }
Future<void>init()async{
  controller = Completer();

  PermissionStatus permissionStatus = await
  Location.instance.requestPermission();
  if(permissionStatus==PermissionStatus.granted||permissionStatus==PermissionStatus.grantedLimited){
  var location=await  Location.instance.getLocation();
  _userLocation = CameraPosition(
    target: LatLng(location.latitude!,location.longitude!),
    zoom: 16,
  );
  markers = [
    // Marker(
    //   markerId: MarkerId('user'),
    //   position: LatLng(location.latitude!,location.longitude!),
    // )
  ];
  (await controller.future).animateCamera(CameraUpdate.newCameraPosition(_userLocation));
setState(() {

});
  }




}
  @override
  void dispose() {
    super.dispose();
  }

  LatLng? userPosition;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
            GoogleMap(
              onTap: (position) {
                print(position);
                markers.add(
                    Marker(
                      markerId: MarkerId('position'),
                      position: LatLng(position.latitude,position.longitude),
                    )
                );
                selectedLocation=position;
                setState(() {

                });


              },
              mapType: MapType.terrain,
              initialCameraPosition:CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 14.4746,
              ) ,
              markers: Set.from(markers),
              onMapCreated: (GoogleMapController controller) {
            this. controller.complete(controller);
              },
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,


      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        if(selectedLocation==null)return;
        getAddress(selectedLocation!);
// Navigator.of(context).pop(
//   selectedLocation
// )  ;
}, label: Text('SaveLocation'.tr())),

    );
  }
  Future<void>getAddress(LatLng position)async{
    try{
      showDialog(context: context, builder: (context)=>LoadingDialog());
      LocationResponse response= await

      _userController.getLocationDataFromLatAndLong(position.latitude, position.longitude);
      Navigator.of(context).pop();
      Navigator.of(context).pop(
          response
      )  ;
    }

    on Exception catch(e){
      Navigator.of(context).pop();

      print(e);
      Helpers.showMessage('SomethingWentWrong'.tr(), MessageType.MESSAGE_FAILED);

    }




  }
}
