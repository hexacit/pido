
import 'dart:async';

import 'package:pido/src/models/sub_models/place.dart';
import 'package:pido/src/notifiers/app_notifiers.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class ChooseAddressScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _refresh = false;

  bool get refresh => _refresh;

  set refresh(bool value) {
    _refresh = value;
    notifyListeners();
  }

  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

 
  LatLng? userLocation;
  LatLng? driverLocation;
  BitmapDescriptor? icon;
  late List<Marker> markers;
  late AppNotifiers _appNotifiers;
late TextEditingController locationTextController;
List<Place>? places;
Place? selectedPlace;
  late Completer<GoogleMapController> controller;

  // ||... constructor ...||
  ChooseAddressScreenNotifiers(BuildContext context) {
     controller = Completer();
    locationTextController=TextEditingController();
  _appNotifiers=Provider.of<AppNotifiers>(context);
  userLocation=Provider.of<AppNotifiers>(context).userLocation;
    markers = [
      Marker(
        markerId: MarkerId('2'),
        position: LatLng(userLocation!.latitude, userLocation!.longitude),
      )
    ];
  }

 Future<void> setLocation(LatLng position)async{
  userLocation = position;
              markers.removeWhere(
                  (element) => element.markerId == MarkerId('2'),
                );
              markers.add(
                  Marker(
                    markerId: MarkerId('2'),
                    position: position,
                  ),
                );
                final GoogleMapController gController = await controller.future;
    gController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: position,zoom: 16)));
  
              refresh =! refresh;

 }




// ||...................... logic methods ............................||


}
