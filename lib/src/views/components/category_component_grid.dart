import 'package:flutter/material.dart';
import '../../models/sub_models/category.dart';

class CategoryComponentGrid extends StatelessWidget {
  final MenuCategory category;
  final Function onTap;
  final bool isFirstOne;
  final bool isSelected;

  CategoryComponentGrid({
    required this.category,
    required this.onTap,
    required this.isFirstOne,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        width: 80,
        height: 120,
        margin: EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            Container(
             width: 80,
              height: 120,
              padding: isFirstOne ? EdgeInsets.symmetric(horizontal: 12) : null,
//              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
//                border: Border.all(
//                  color: isSelected
//                      ? Theme.of(context).primaryColor
//                      : Color(0xffD1D1D1),
//                ),
              ),
              child: isFirstOne
                  ? Container()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        category.image!,
                       // width: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: isSelected
                    ?Border(bottom: BorderSide(color: Colors.white)):null,
              ),
            //  padding: AppStyles.defaultPadding1,
            
              child: Center(
                child: Text(
                  
                  category.name!,
                  textAlign: TextAlign .center,
                  style: TextStyle(
                    color:  Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
