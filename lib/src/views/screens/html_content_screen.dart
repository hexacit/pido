import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/controllers/api_controllers/configs_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/sub_models/page.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/custom_back_button.dart';
import 'package:pido/src/views/components/error_component.dart';
import '../../utils/app_shared.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HtmlContentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int arg=ModalRoute.of(context)!.settings.arguments as int;
    return HtmlContentScreenBody(
arg
    );
  }
}

class HtmlContentScreenBody extends StatefulWidget {
  int id;
  HtmlContentScreenBody(this.id);

  @override
  _HtmlContentScreenBodyState createState() => _HtmlContentScreenBodyState();
}

class _HtmlContentScreenBodyState extends State<HtmlContentScreenBody> {
  @override
  void initState() {
    super.initState();
    _configsController=ConfigsController.instance!;
    _future=getPage();
  }

  late ConfigsController _configsController;
  late  Future<HtmlPage> _future;
  Future<HtmlPage> getPage() async {
    BaseResponse  baseResponse;
    HtmlPage? page;
    try {
      baseResponse = await _configsController.getPage(
widget.id,
      );
      if(baseResponse.status!){
        page= HtmlPage.fromJson(baseResponse.data);

      }

    } on Exception catch (e) {

      print(e);
      Helpers.showMessage('SomethingWentWrong'.tr(),

          MessageType.MESSAGE_FAILED);

    }
    return page!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          image: DecorationImage(
              image:
              AssetImage('${Constants.ASSETS_IMAGES_PATH}bg.png'),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(

          padding: EdgeInsets.symmetric(horizontal: 15,),
          child: FutureBuilder<HtmlPage>(
              future: _future,
              builder: (context, snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(snapshot.hasError){
                  return ErrorComponent(onTryAgainTap: (){});
                }
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title:Text(
                       snapshot.data?.title??'',
                        style: textStyleMedium.copyWith(
                          color:Colors.black,
                          fontSize:17.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      centerTitle: true,
                       leadingWidth: 35.w,
                       leading:CustomBackButton(),

//                     IconButton(
//                           icon: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}menu.svg'),
//                           onPressed: () {
//                             print('drawer');
// Scaffold.of(context).openDrawer();
//
//                           },
//
//                     ),
                      actions: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(Constants.SCREENS_MY_CART_SCREEN,
                                  arguments: context);
                            },
                            child: SvgPicture.asset(
                                '${Constants.ASSETS_IMAGES_PATH}cart.svg')),
                      ],
                    ),


                    SizedBox(
                      height: AppShared.screenUtil.setHeight(30),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}logo-html.svg',
                          ),
                          Html(data:    snapshot.data?.description??'',

                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
