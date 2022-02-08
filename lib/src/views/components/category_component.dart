import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/sub_models/category.dart';
import '../../styles/app_styles.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';

class CategoryComponent extends StatelessWidget {
  final MenuCategory category;
  final Function onTap;
  final bool isFirstOne;
  final bool isSelected;

  CategoryComponent({
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
        child: Column(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              padding: isFirstOne ? AppStyles.defaultPadding2 : null,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : AppShared.appTheme['text2'],
                ),
              ),
              child: isFirstOne
                  ? SvgPicture.asset(
                      '${Constants.ASSETS_IMAGES_PATH}all_icon.svg',
                      color: Theme.of(context).primaryColor,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        category.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              category.name!,
              style: TextStyle(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : AppShared.appTheme['text2'],
                fontSize: 13,
              ),
            )
          ],
        ),
      ),
    );
  }
}
