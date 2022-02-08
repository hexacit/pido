import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ParentComponent extends StatelessWidget {
  Widget? child;

  ParentComponent({this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: child!,
    );
  }
}
