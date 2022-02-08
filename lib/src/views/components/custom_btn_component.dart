
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../styles/app_styles.dart';

class CustomBtnComponent extends StatefulWidget {
  final String? text;
  final Color? color;
  final Color? textColor;
  final double? width;
  final Function onTap;
  final double? height;
  final bool hasBorder;
  String? iconName;
  bool? isLoading;
  EdgeInsets? padding;
  double borderRadius;

  CustomBtnComponent({
    required this.text,
    this.isLoading,
    this.color,
    this.width,
    this.textColor,
    this.height,
    this.iconName,
    required this.onTap,
     this.hasBorder =true,
    this.padding,
    this.borderRadius=25,
  }) {
    this.isLoading = isLoading ?? false;
  }

  @override
  _CustomBtnComponentState createState() => _CustomBtnComponentState();
}

class _CustomBtnComponentState extends State<CustomBtnComponent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isLoading! ? null : widget.onTap as void Function()?,
      child: Container(
        padding:widget.padding==null? AppStyles.defaultPadding1:widget.padding!,
        width: widget.width,
        height:widget.height??AppShared.screenUtil.setHeight(50),
        alignment: Alignment.center,
        decoration: BoxDecoration(
         
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: widget.isLoading!
              ? Colors.grey
              : widget.color ?? Theme.of(context).primaryColor,
              border:widget.hasBorder? Border.all(
                color: Theme.of(context).primaryColor,
              ):null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
           
            widget.isLoading!
                ? Container(
                    width: AppShared.screenUtil.setWidth(20),
                    height: AppShared.screenUtil.setHeight(20),
                    child: CircularProgressIndicator(),
                  )
                : Container(
                  child:widget.iconName==null?Container():SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}${widget.iconName}',
                   width: AppShared.screenUtil.setWidth(20),
                    height: AppShared.screenUtil.setHeight(20),
                  ) ,
                ),
                   if(  widget.isLoading!)
                   SizedBox(
                width: 10,
              ),
            Text(
              widget.text!,
              maxLines: 1,
              overflow:TextOverflow.ellipsis ,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                color: widget.textColor!=null?widget.textColor: Colors.white,
                fontSize:AppShared.screenUtil.setSp(15) ,
              ),
            ),
           
            // Transform(
            //     alignment: Alignment.center,
            //     transform: Matrix4.rotationY(
            //       Directionality.of(context) == TextDirection.rtl ? pi : 0,
            //     ),
            //     child: SvgPicture.asset(
            //         '${Constants.ASSETS_IMAGES_PATH}arraw.svg')),
          ],
        ),
      ),
    );
  }
}
