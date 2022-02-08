import 'package:pido/src/controllers/api_controllers/user_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pido/src/views/components/app_drawer.dart';
import 'package:pido/src/views/components/entry_field_component.dart';
import 'package:provider/provider.dart';
import '../../notifiers/screens_notifiers/contact_us_screen_notifiers.dart';
import '../../styles/app_styles.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import '../../views/components/custom_btn_component.dart';
import '../../views/components/parent_component.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider(
        create: (_) => ContactUsScreenNotifiers(context),
        child: ContactUsScreenBody(),
      ),
    );
  }
}

class ContactUsScreenBody extends StatefulWidget {
  @override
  _ContactUsScreenBodyState createState() => _ContactUsScreenBodyState();
}

class _ContactUsScreenBodyState extends State<ContactUsScreenBody> {
  late ContactUsScreenNotifiers _contactUsScreenNotifiers;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _key.currentState?.dispose();
  }
  @override
  void initState() {
    super.initState();
    _contactUsScreenNotifiers =
        Provider.of<ContactUsScreenNotifiers>(context, listen: false);
    _userController=UserController.instance!;
    _key=GlobalKey<FormState>();

  }

  Future<void>contactUs()async
  {
    if (!_key.currentState!.validate())
      return;

    _key.currentState!.save();
    try {
      setState(() {
        isBtnLoading = true;

      });
      BaseResponse response = await _userController.sendContact(
      name: name,
        email: email,
        message: message,

      );
      if (response.status!) {

        Navigator.of(context).pop();

        Helpers.showMessage(response.message, MessageType.MESSAGE_SUCCESS);
        //}
      } else {
        Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);
        setState(() {
          isBtnLoading = false;

        });

      }
    } catch (error) {
      setState(() {
        isBtnLoading = false;

      });
      print(error);
      Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
    }
  }
  bool isBtnLoading = false;
  late GlobalKey<FormState>_key;
  late UserController _userController;
  String? name;
  String? email;
  String? message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,

        decoration: BoxDecoration(
            image: DecorationImage(
                image:
                AssetImage('${Constants.ASSETS_IMAGES_PATH}bg.png'),
                fit: BoxFit.cover
            )
        ),
        padding: EdgeInsets.symmetric(horizontal: 15,),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title:Text(
                  'ContactUs'.tr(),
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



              SizedBox(
                height: AppShared.screenUtil.setHeight(100),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      Text(
                        'ContactForm'.tr(),
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                  color:Colors.black,
                  fontSize:20.sp,
                ),
                      ),
                      SizedBox(
                        height: AppShared.screenUtil.setHeight(50),
                      ),
                      EntryFieldComponent(

                        title: 'FullName'.tr()
                        ,
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        icon: 'user',
                        validator: (val){
                          if(val==null||val.isEmpty)
                            return'ThisFieldIsRequired'.tr();

                          return null;

                        },
                        onSaved: (val){
                          name=val;
                        },
                      ),
                      SizedBox(
                        height: AppShared.screenUtil.setHeight(10),
                      ),
                      EntryFieldComponent(
                        title: 'Email'.tr()
                        ,
                        contentPadding: EdgeInsets.symmetric(vertical: 5),

                        keyboardType:TextInputType.emailAddress ,
                        icon: 'email',
                        validator: (val){
                          if(val==null||val.isEmpty)
                            return'ThisFieldIsRequired'.tr();
                          else if(  !EmailValidator.validate(val))
                            return'ThisIsNotEmailFormat'.tr();
                          return null;

                        },
                        onSaved: (val){
                          email=val;
                        },
                      ),   SizedBox(
                        height: AppShared.screenUtil.setHeight(10),
                      ),
                     TextFormField(
                       decoration: InputDecoration(
                         hintText: 'EnterMessageHere'.tr()
                       ),
                       validator: (val){
                         if(val==null||val.isEmpty)
                           return'ThisFieldIsRequired'.tr();

                         return null;

                       },
                       onSaved: (val){
                         message=val;
                       },
                     ),

                      SizedBox(
                        height: AppShared.screenUtil.setHeight(70),
                      ),
                      InkWell(
                        onTap:contactUs
                        ,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                         child:  isBtnLoading?
                            Center(child: CircularProgressIndicator(
                              color: Colors.white,
                            ),)
                      : SvgPicture.asset(
                            '${Constants.ASSETS_IMAGES_PATH}done.svg',
                            color: Colors.black,
                          ),
                          decoration: BoxDecoration(
                            color:Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppShared.screenUtil.setHeight(10),
                      ),
                      Directionality(
                        textDirection:TextDirection.ltr ,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}email.svg'),

                            Text('support@pidoteam.com'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
