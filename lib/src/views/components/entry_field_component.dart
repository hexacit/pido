
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/themes/app_themes.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';

import './custom_fade_animation_component.dart';
import './custom_btn_component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class EntryFieldComponent extends StatefulWidget {
  final String title;
  String? icon;
  bool isReadOnly;
  bool isSecure;
  bool hasHint;
  TextInputType keyboardType;
  String? Function(String?)? validator;
  String? Function(String?)? onSaved;
  EdgeInsets? contentPadding;

  EntryFieldComponent({
   required this.title,
     this.icon,
     this.textEditingController,
  this.isReadOnly=false,
    this.keyboardType=TextInputType.text,
     this.validator,
    this.onSaved,
     this.isSecure=false,
    this.contentPadding,
    this.hasHint=false,

  }) ;

   TextEditingController? textEditingController;

  @override
  State<EntryFieldComponent> createState() => _EntryFieldComponentState();
}

class _EntryFieldComponentState extends State<EntryFieldComponent> {
  bool isShowPassword=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide()
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if(widget.icon!=null)
                SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}${ widget.icon}.svg')
               ,
SizedBox(
  width: AppShared.screenUtil.setWidth(5),
),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                  color:Colors.black,
                  fontSize:14.sp,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextFormField(
                  onSaved: widget.onSaved,
obscureText: widget.isSecure&&!isShowPassword,
                  obscuringCharacter: '*',
                  controller: widget.textEditingController??null,
                  readOnly: widget.isReadOnly,
                  keyboardType: widget.keyboardType,
                  textAlignVertical:TextAlignVertical.bottom ,

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isCollapsed: widget.contentPadding!=null,

                    contentPadding:widget.contentPadding!=null? widget.contentPadding:null,




                    hintText:widget.hasHint? 'EnterValue'.tr(
                      args: [widget.title]
                    ):'',
                    hintStyle:  Theme.of(context).textTheme.headline3!.copyWith(
                      color:Colors.black,
                      fontSize:14.sp,
                    ),
                  ),
                  validator: widget.validator??null,

                ),
              ),
             if( widget.isSecure)
              InkWell(
                onTap: (){

                  setState(() {
                    isShowPassword=!isShowPassword;
                  });
                },
                child: Text(isShowPassword?'hide'.tr():'show'.tr(),
                  textAlign: TextAlign.end,


                  style: TextStyle(
                    decoration: TextDecoration.underline


                  ),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
