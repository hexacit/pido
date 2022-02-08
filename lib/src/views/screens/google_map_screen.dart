import 'dart:async';

import 'package:pido/src/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../notifiers/screens_notifiers/google_map_screen_notifiers.dart';

class GoogleMapScreen extends StatelessWidget {
 
  List<dynamic>? args;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as List<dynamic>?;
    
  var serviceName=args![0] as String?;
  var location=args[1] as LatLng?;
    return ChangeNotifierProvider(
      create: (_) => GoogleMapScreenNotifiers(location),
      child: GoogleMapScreenBody(serviceName: serviceName,),
    );
  }
}

class GoogleMapScreenBody extends StatefulWidget {

  String? serviceName;
GoogleMapScreenBody({this.serviceName});

  @override
  State<GoogleMapScreenBody> createState() => GoogleMapScreenBodyState();
}

class GoogleMapScreenBodyState extends State<GoogleMapScreenBody> {
  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition _userLocation;
  late GoogleMapScreenNotifiers _googleMapScreenNotifiers;
 
  @override
  void initState() {
    super.initState();
    _googleMapScreenNotifiers =
        Provider.of<GoogleMapScreenNotifiers>(context, listen: false);
    _userLocation = CameraPosition(
      target: LatLng(_googleMapScreenNotifiers.customerLocation!.latitude,
          _googleMapScreenNotifiers.customerLocation!.longitude),
      zoom: 18,
    );
    
  }

  @override
  void dispose() {
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.serviceName!,
            style: textStyleNeoSansRegular.copyWith(
              color: Color(0xff222B45),
              fontSize: 17,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
          ),
        
          
        ),
      body: Selector<GoogleMapScreenNotifiers, bool>(
        selector: (_, value) => value.refresh,
        builder: (_, refresh, __) => GoogleMap(
          onTap: (position) {
            _googleMapScreenNotifiers.markers.add(
              Marker(
                markerId: MarkerId('userlocation'),
              ),
            );
          },
          mapType: MapType.normal,
          initialCameraPosition: _userLocation,
          markers: Set.from(_googleMapScreenNotifiers.markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          zoomControlsEnabled: false,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
        ),
      ),
    );
  }
}
