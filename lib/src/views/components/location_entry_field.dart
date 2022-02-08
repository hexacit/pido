
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pido/src/models/api_models/responses/location_response.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/views/screens/choose_address_location_screen.dart';

class LocationEntryField extends StatefulWidget {

  TextEditingController? controller;
  final Function(String? val) onchange;
  final Function(String? val) onSave;
  final Function(LocationResponse? val) onSelectLocation;
   LocationEntryField({Key? key,
     this.controller,
     required this.onchange,
     required this.onSave,
     required this.onSelectLocation,

   }) : super(key: key);

  @override
  _LocationEntryFieldState createState() => _LocationEntryFieldState();
}

class _LocationEntryFieldState extends State<LocationEntryField> {
  @override
  Widget build(BuildContext context) {

    return     TextFormField(
     readOnly: true,
      controller: widget.controller,
      onSaved: (val){
        widget.onSave(val);
      //  _addProductScreenNotifiers.address=val;


      },
      validator: (val){
        if(val==null||val.isEmpty)
          return'ThisFieldIsRequired'.tr();
        return null;

      },
      decoration: InputDecoration(
        hintText: 'Location'.tr(),


        suffixIcon:
        InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChooseAddressLocationScreen())).then((value) {
              if(value !=null){
                widget.onSelectLocation(value as LocationResponse );
              }
            });
//             Navigator.of(context).pushNamed(Constants.SCREENS_CHOOSE_ADDRESS_LOCATION_SCREEN,
//                 arguments:
//                 LocationMode.API_LOCATION
//
//             ).then((value)  {
//               if(value!=null)
//                 if((value as Place)!=null){
// widget.onSelectLocation(value);
//
//
//                 }
//
//             });
          },
          child:
          Container(
            padding: EdgeInsets.all(10),
            margin:EdgeInsets.all(3) ,
            // decoration: BoxDecoration(
            //     color: Theme.of(context).primaryColor,
            //     borderRadius: BorderRadius.circular(5)
            //
            // ),
            child:

            SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}locate.svg')),
        ),

      ),
    );
  }
}
