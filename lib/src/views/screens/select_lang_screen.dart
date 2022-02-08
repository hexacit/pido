import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../notifiers/screens_notifiers/lang_screen_notifiers.dart';
import '../../styles/app_styles.dart';
import '../../utils/constants.dart';
import '../../views/components/custom_checkbox_component/custom_checkbox_component.dart';
import '../../views/components/custom_fade_animation_component.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class SelectLangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectLangScreenNotifiers>(
      create: (_) => SelectLangScreenNotifiers(context),
      child: SelectLangScreenBody(),
    );
  }
}

class SelectLangScreenBody extends StatefulWidget {
  @override
  _SelectLangScreenBodyState createState() => _SelectLangScreenBodyState();
}

class _SelectLangScreenBodyState extends State<SelectLangScreenBody> {
  late SelectLangScreenNotifiers _langScreenNotifiers;

  @override
  void initState() {
    super.initState();
    _langScreenNotifiers =
        Provider.of<SelectLangScreenNotifiers>(this.context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                "اختر اللغة المفضلة",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff707070),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomFadeAnimationComponent(
              0.5,
              Container(
                child: Text(
                  "Choose\n Your Language",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomFadeAnimationComponent(
              0.7,
              Padding(
                padding: AppStyles.defaultPadding3,
                child: Selector<SelectLangScreenNotifiers, String>(
                  selector: (_, value) => value.selectedLang,
                  builder: (_, selectedLang, __) => Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: CustomCheckboxComponent(
                              lang: Constants.LANG_EN,
                              onTap: () {
                        
                                _langScreenNotifiers.selectedLang =
                                    Constants.LANG_EN;
                              },
                              isSelected: selectedLang == Constants.LANG_EN,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomCheckboxComponent(
                              lang: Constants.LANG_AR,
                              onTap: () {
                             
                                _langScreenNotifiers.selectedLang =
                                    Constants.LANG_AR;
                              },
                              isSelected: selectedLang == Constants.LANG_AR,
                            ),
                          ),
                        ],
                      ),
                     
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            CustomFadeAnimationComponent(
              0.9,
              InkWell(
                onTap: () {
                  _langScreenNotifiers.done();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: SvgPicture.asset(
                        '${Constants.ASSETS_IMAGES_PATH}arraw.svg',
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Selector<SelectLangScreenNotifiers, bool>(
                      selector: (_, value) => value.isLoading,
                      builder: (_, isLoading, __) =>
                          isLoading ? CircularProgressIndicator() : Container(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
