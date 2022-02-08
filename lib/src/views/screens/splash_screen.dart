import 'package:pido/src/services/start_up_service.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../notifiers/app_notifiers.dart';
import '../../notifiers/screens_notifiers/splash_screen_notifiers.dart';
import '../../utils/app_shared.dart';
import '../components/loading_component.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashScreenNotifiers(context),
      child: SplashScreenBody(),
    );
  }
}

class SplashScreenBody extends StatefulWidget {
  @override
  _SplashScreenBodyState createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  late SplashScreenNotifiers _splashScreenNotifiers;
  AppNotifiers? _appNotifiers;
  

  @override
  void initState() {
    super.initState();
    _splashScreenNotifiers =
        Provider.of<SplashScreenNotifiers>(context, listen: false);
    _appNotifiers = Provider.of<AppNotifiers>(context, listen: false);
    _splashScreenNotifiers.init();
    
  }

  @override
  Widget build(BuildContext context) {
   StartUpService.instance!.initAfterBuild(_appNotifiers, context);
    ScreenUtil.init(BoxConstraints (maxHeight: 812,maxWidth: 375),designSize: Size(414,896));
    AppShared.screenUtil = ScreenUtil();
    return Scaffold(
      backgroundColor: Color(0xffF0F3F8),
      body: Center(child: LoadingComponent())

      // Image.asset('${Constants.ASSETS_IMAGES_PATH}splash.png',
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      // fit: BoxFit.fill,
      // )
    );
  }
}
