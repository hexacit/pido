import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pido/src/controllers/api_controllers/user_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/sub_models/notification.dart';
import 'package:pido/src/models/sub_models/notifications_list.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:provider/provider.dart';
import '../../../../styles/app_styles.dart';
import '../../../../themes/app_themes.dart';
import '../../../../utils/app_shared.dart';
import '../../../../utils/constants.dart';
import '../../../components/custom_fade_animation_component.dart';
import '../../../components/empty_component.dart';
import '../../../components/error_component.dart';
import '../../../components/login_component.dart';
import '../../../components/notification_component.dart';
import '../../../components/parent_component.dart';
import '../../../components/screens_rounded_custom_clipper_component.dart';
import '../../../components/shimmer_components/shimmer_notification_component.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child:
              NotificationsScreenBody()
         
    );
  }
}

class NotificationsScreenBody extends StatefulWidget {
  @override
  _NotificationsScreenBodyState createState() =>
      _NotificationsScreenBodyState();
}

class _NotificationsScreenBodyState extends State<NotificationsScreenBody> {
  late UserController _userController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userController=UserController.instance!;
   // _future=getMyNotifications();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }
  final PagingController<int, NotificationItem> _pagingController =
  PagingController(firstPageKey: 1);
  late Future<List<NotificationItem>>_future;
  // Future<List<NotificationItem>>getMyNotifications()async{
  //   List<NotificationItem>? userNotificationData;
  //   try{
  //
  //     BaseResponse baseResponse=await _userController.getMyNotifications();
  //     // if(baseResponse.status!){
  //     userNotificationData=  List<NotificationItem>.from(baseResponse.data.map((x) => NotificationItem.fromJson(x)));
  //     // }
  //
  //
  //   }on Exception catch(e){
  //     print(e);
  //     throw e;
  //   }
  //   return userNotificationData;
  //
  // }
  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await _userController.getMyNotifications(

          page: pageKey);
      NotificationsList data= NotificationsList.fromJson(response.mapData!);
      final isLastPage = !data.isMore!;

      if (isLastPage) {
        _pagingController.appendLastPage(data.results!);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(data.results!, nextPageKey);
      }
    }on Exception catch (error) {
      _pagingController.error = error;
    }
  }
  Future<void>refresh()async{
    setState(() {
     // _future=getMyNotifications();
      _pagingController.refresh();
    });
  }
  @override
  Widget build(BuildContext context) {
    return

      Container(

        decoration: BoxDecoration(
            image: DecorationImage(
                image:
                AssetImage('${Constants.ASSETS_IMAGES_PATH}bg.png'),
                fit: BoxFit.cover
            )
        ),
        child: RefreshIndicator(
          onRefresh:refresh ,
          child: Scaffold(
backgroundColor: Colors.transparent,
appBar:          AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title:Text(
    'Notifications'.tr(),
    style: Theme.of(context).textTheme.headline1!.copyWith(
      color:Colors.black,
      fontSize:AppShared.screenUtil.setSp(24),
    ),
    textAlign: TextAlign.center,
  ),
  centerTitle: true,
  leading: IconButton(
    icon: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}menu.svg'),
    onPressed: () {
      Scaffold.of(context).openDrawer();

    },
  ),
  actions: [
    Container(
      margin: EdgeInsetsDirectional.only(end: 5),
      child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(Constants.SCREENS_MY_CART_SCREEN,
                  arguments: context);
            },
            child: SvgPicture.asset(
                '${Constants.ASSETS_IMAGES_PATH}cart.svg')),
    ),
  ],
),
          body: Container(
            height: MediaQuery.of(context).size.height,

            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:
            PagedListView<int, NotificationItem>(
              pagingController: _pagingController,
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
            builderDelegate: PagedChildBuilderDelegate<NotificationItem>(
              firstPageErrorIndicatorBuilder: (_)=>ErrorComponent(onTryAgainTap: (){
                refresh();
                    }),
              noItemsFoundIndicatorBuilder: (_)=>Center(child: EmptyComponent(text: 'NoNotificationsFound'.tr())),
              firstPageProgressIndicatorBuilder: (_)=>ShimmerNotificationComponent(),
              itemBuilder: (context, item, index) =>
                          CustomFadeAnimationComponent(
                        index.remainder(20) / 5,
                       InkWell(
                      onTap: () {

                      },
                                                                    child: Container(
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.circular(15)
                                                                      ),
                          padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,vertical: 15),
                          margin: EdgeInsets.only(bottom: 10),
                          child:Row(
                            children: [
                              Container(
                                padding:EdgeInsets.symmetric(horizontal: 20),
                                child: Center(
                                  child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}notification.svg',
                                    height: AppShared.screenUtil.setHeight(30),
                                    width: AppShared.screenUtil.setHeight(30),

                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Text(item.translations!.firstWhere((element) => element.locale==AppShared.sharedPreferencesController.getAppLang()).message??''
                                        ,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: AppShared.screenUtil.setSp(16),
                                          color: Colors.black,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      child: Text(
                                        Helpers.formatDate(item.createdAt!)

                                        ,

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ),
                            ),
                      ),
                    ),),
          ),
    ),
        ),
      );
  }
}
