import 'package:flutter/material.dart';
import '../../utils/app_shared.dart';

class InternetStatusBarComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 30,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Text(
        AppShared.appLang['NoInternetConnection']!,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
