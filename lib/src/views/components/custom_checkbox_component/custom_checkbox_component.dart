import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../styles/app_styles.dart';
import '../../../utils/constants.dart';
import '../../../utils/helpers.dart';

import 'custom_checkbox_clipper_component.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class CustomCheckboxComponent extends StatelessWidget {
  final bool isSelected;
  final Function onTap;
  final String lang;

  CustomCheckboxComponent({
    required this.isSelected,
    required this.onTap,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                isSelected ? Theme.of(context).primaryColor : Color(0xffC8C6C6),
          ),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              isSelected
                  ? Align(
                      alignment:context.locale.languageCode=='ar'? AlignmentDirectional.centerStart: AlignmentDirectional.centerEnd,
                      child: ClipPath(
                        clipper: CustomCheckboxClipperComponent(),
                        child: Container(
                          alignment: Alignment.topRight,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsetsDirectional.only(
                              top: 8,
                              end: 5,
                            ),
                            child: SvgPicture.asset(
                                '${Constants.ASSETS_IMAGES_PATH}check.svg'),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 40,
                      height: 40,
                    ),
              Expanded(
                child: Directionality(
                  textDirection: Helpers.getDirectionByLang(lang: lang),
                  child: Container(
                    padding: AppStyles.defaultPadding1,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          lang == Constants.LANG_EN
                              ? 'English'
                             :'عربي',
                          style: TextStyle(
                            fontSize: 20,
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Color(0xffC8C6C6),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Text(
                            lang == Constants.LANG_EN
                                ? 'Welcome'
                                :  'مرحبا بك',
                            style: TextStyle(
                              fontSize: 13,
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Color(0xffC8C6C6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
