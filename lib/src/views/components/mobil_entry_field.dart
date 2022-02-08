import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class MobileEntryField extends StatefulWidget {
  FocusNode? focusNode;
  TextEditingController? controller;
 final Function(String? val) onchange;
   MobileEntryField({
    this.focusNode,
     this.controller,
     required this.onchange,

});

  @override
  State<MobileEntryField> createState() => _MobileEntryFieldState();
}

class _MobileEntryFieldState extends State<MobileEntryField> {
  String? mobile;


  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mobile'.tr(),
            style: textStyleRegular.copyWith(
              color:Colors.black54,
              fontSize:AppShared.screenUtil.setSp(12),
            ),
          ),

          TextFormField(
            focusNode:widget.focusNode??null ,
            controller:widget.controller??null,
            textInputAction:TextInputAction.done ,
            validator: (val){
              if(val==null||val.isEmpty)
                return'ThisFieldIsRequired'.tr();
              // if(val.length!=12)
              //   return'MobileMaxCount'.tr();
              return null;
            },
            onSaved: (val){
              print(' save $val');

              //_signUpScreenNotifiers.mobile=val;
            },
            onChanged: (val){

              widget.onchange(val);

              print(val);
            },
            //maxLength: 12,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'EnterMobileNumber'.tr(),
              hintStyle:  textStyleRegular.copyWith(
                color:Colors.black,
                fontSize:AppShared.screenUtil.setSp(18),
              ),
            ),
          ),
        Text(
                mobile.toString(),
                  style: textStyleRegular.copyWith(
                    color:Colors.black54,
                    fontSize:AppShared.screenUtil.setSp(12),
                  ),

          ),

        ],
      ),
    );
  }
}
