import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import '../../utils/app_shared.dart';

class LoadingComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppShared.screenUtil.setHeight(400) ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LoadingBouncingGrid.square(
            borderColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: AppShared.screenUtil.setHeight(20) ,
          ),
          // Text(
          //   //'loading'
          //   AppShared.appLang['Loading']
          //   ),
        ],
      ),
    );
  }
}
