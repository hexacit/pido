import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../controllers/firebase_controllers/order_controller.dart';
import '../../models/firebase_models/order.dart';
import '../../utils/constants.dart';

class GoogleMapScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _refresh = false;

  bool get refresh => _refresh;

  set refresh(bool value) {
    _refresh = value;
    notifyListeners();
  } 

  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  LatLng? customerLocation;
  late BitmapDescriptor icon;
  StreamSubscription? streamSubscription;
  late List<Marker> markers;

  // ||... constructor ...||
  GoogleMapScreenNotifiers( this.customerLocation) {
    markers = [
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(customerLocation!.latitude, customerLocation!.longitude),
      )
    ];
  }

// ||...................... logic methods ............................||

//listen to order.
 
// ||...................... logic methods ............................||

}
