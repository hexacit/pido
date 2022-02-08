import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/controllers/api_controllers/configs_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/sub_models/faq_item.dart';
import 'package:pido/src/models/sub_models/page.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:pido/src/views/components/app_drawer.dart';
import 'package:pido/src/views/components/error_component.dart';
import 'package:pido/src/views/components/shimmer_components/shimmer_faq_component.dart';
import 'package:pido/src/views/screens/main_screen/main_screen.dart';
import 'package:pido/src/views/screens/main_screen/screens/home_screen.dart';
import '../../styles/app_styles.dart';
import '../../utils/app_shared.dart';
import '../components/parent_component.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
class FaqScreen extends StatefulWidget {

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    super.initState();
    _configsController=ConfigsController.instance!;
    _future=getFaqItems();
  }

  late ConfigsController _configsController;
  late  Future<List<FaqItem>> _future;
  Future<List<FaqItem>> getFaqItems() async {
    BaseResponse  baseResponse;
    List<FaqItem>? items;
    try {

      baseResponse = await _configsController.getFaq();
      if(baseResponse.status!){
        items= List<FaqItem>.from(baseResponse.data.map((x) => FaqItem.fromJson(x)));


      }

    } on Exception catch (e) {

      print(e);
      Helpers.showMessage('SomethingWentWrong'.tr(),

          MessageType.MESSAGE_FAILED);

    }
    return items!;
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
        appBar:        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:Text(
            'FAQ'.tr(),
            style: Theme.of(context).textTheme.headline3!.copyWith(
              color:Colors.black,
              fontSize:17.sp,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          leading:IconButton(
            icon: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}menu.svg'),
            onPressed: () {
              print('drawer');
              Scaffold.of(context).openDrawer();

            },

          ),
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
        body: Container(

          padding: EdgeInsets.symmetric(horizontal: 15,),
          child:  Column(
                children: <Widget>[




                  SizedBox(
                    height: AppShared.screenUtil.setHeight(30),
                  ),
      Expanded(
        child: FutureBuilder<List<FaqItem>>(
        future: _future,
        builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
        return ShimmerFaqComponent();
        }
        else if(snapshot.hasError){
        return ErrorComponent(onTryAgainTap: (){});
        }
        return
          //ShimmerFaqComponent();
          ListView.separated(
            itemCount:snapshot.data!.length,
          itemBuilder: (_,index){
          return       FaqItemWidget(
            item:snapshot.data![index] ,
          )

            ;

        }, separatorBuilder: (_,index)=>SizedBox(
          height: 15.h,
        ),  );},

                    ),
      ),

                ],
              ),
        ),
      ),
    );
  }
}

class FaqItemWidget extends StatefulWidget {
  final FaqItem item;
  const FaqItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<FaqItemWidget> createState() => _FaqItemWidgetState();
}

class _FaqItemWidgetState extends State<FaqItemWidget> {

  bool _isExpanded=false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(25),
          bottomStart:_isExpanded? Radius.circular(25):Radius.zero,
          topEnd:!_isExpanded? Radius.circular(25):Radius.zero,
          bottomEnd:!_isExpanded? Radius.circular(25):Radius.zero,
        ),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(


          onExpansionChanged: (val){
            setState(() {
              _isExpanded=val;
            });
          },

          title: Text(
           widget. item.question??'',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontSize: AppShared.screenUtil.setSp(16),

            ),
          ),
          collapsedBackgroundColor:Colors.transparent,
          backgroundColor: Colors.transparent,
          childrenPadding: EdgeInsets.symmetric(
              horizontal: AppShared.screenUtil.setWidth(
                20,
              ),
              vertical: AppShared.screenUtil.setHeight(
                10,
              )),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.  item.answer??'',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: AppShared.screenUtil.setSp(16),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
