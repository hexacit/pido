import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white70,
      child: Container(
        height: MediaQuery.of(context).size.height*0.2,
        width:  MediaQuery.of(context).size.width*0.3,
        color: Colors.white60,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}