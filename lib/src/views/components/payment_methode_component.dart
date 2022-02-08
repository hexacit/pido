
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    Key? key,
    required this.isSelected,
    required this.iconName,
    required this.title
  }) : super(key: key);
  final String title;
  final String iconName;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppShared.screenUtil.setHeight(80),
      width: MediaQuery.of(context).size.width*0.28,
      padding: const EdgeInsets.all(3),
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border:  isSelected?
        Border.all(
          color:

          Theme.of(context).primaryColor,
        ):null,
        boxShadow: [
          BoxShadow(
              offset: Offset(-1,-1),
              color: Colors.black12,
              blurRadius: 10

          ),
          BoxShadow(
              offset: Offset(1,1),
              color: Colors.black12,
              blurRadius: 10
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}$iconName.svg'),
          Text(title,
            style: textStyleRegular.copyWith(
              fontSize: AppShared.screenUtil.setSp(15),
              color: Colors.black,
            ),

          ),
        ],
      ),

    );
  }
}