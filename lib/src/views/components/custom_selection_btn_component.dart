import 'package:flutter/material.dart';

class CustomSelectionBtnComponent extends StatelessWidget {
  final bool isSelected;
  final String name;
  final Function onPressed;

  CustomSelectionBtnComponent(
      {required this.isSelected,
      required this.name,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: RaisedButton(
          elevation: 4,
          color: isSelected ? Theme.of(context).primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: Text(
            name,
            style: TextStyle(
              color: isSelected ? Colors.white : Theme.of(context).primaryColor,
              fontSize: 15,
            ),
          ),
          onPressed: onPressed as void Function()?),
    );
  }
}
