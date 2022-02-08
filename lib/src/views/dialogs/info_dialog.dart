import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../styles/app_styles.dart';
import '../../utils/constants.dart';
import '../../views/components/parent_component.dart';

class InfoDialog extends StatelessWidget {
  final String? btnText;
  final String image;
  final String? imageTitle;
  final String? imageDesc;
  final Function onTap;
  final bool isCloseEnabled;

  InfoDialog({
    required this.btnText,
    required this.image,
    required this.imageTitle,
    required this.imageDesc,
    required this.onTap,
    this.isCloseEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ParentComponent(
        child: Container(
      margin: const EdgeInsets.symmetric(
        vertical: 70,
        horizontal: 15,
      ),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: AppStyles.defaultPadding3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      !isCloseEnabled
                          ? Container()
                          : Container(
                              alignment: AlignmentDirectional.centerEnd,
                              margin: const EdgeInsets.only(top: 8),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(
                                  '${Constants.ASSETS_IMAGES_PATH}close.svg',
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                '${Constants.ASSETS_IMAGES_PATH}$image.svg',
                                height: 100,
                                width: 100,
                                
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                imageTitle!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  imageDesc!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: onTap as void Function()?,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(40),
                    ),
                  ),
                  child: Text(
                    btnText!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
