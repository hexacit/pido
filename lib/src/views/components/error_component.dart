import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../styles/app_styles.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';

class ErrorComponent extends StatelessWidget {
  final Function onTryAgainTap;

  ErrorComponent({
    required this.onTryAgainTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  '${Constants.ASSETS_IMAGES_PATH}error.svg',
                    color: Theme.of(context).primaryColor,
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                'SomethingWentWrong'.tr(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: onTryAgainTap as void Function()?,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    alignment: Alignment.center,
                    padding: AppStyles.defaultPadding2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                     'TryAgain'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
