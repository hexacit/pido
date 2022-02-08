import 'package:flutter/material.dart';

class CustomSwitchComponent extends StatelessWidget {
  final bool isEnabled;

  CustomSwitchComponent({
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return isEnabled
        ? Container(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              padding: const EdgeInsets.all(4),
              width: 40,
              height: 22,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Color(0xff4CD964),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          )
        : Container(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                padding: const EdgeInsets.all(4),
                width: 40,
                height: 22,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: Color(0xffE4E4E4),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          );
  }
}
