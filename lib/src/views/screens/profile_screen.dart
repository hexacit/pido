import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart'as dio;
import 'package:flutter/painting.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pido/src/controllers/api_controllers/user_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/sub_models/user.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/views/components/entry_field_component.dart';
import 'package:provider/provider.dart';
import '../../notifiers/screens_notifiers/sign_in_screen_notifiers.dart';
import '../../utils/app_shared.dart';
import '../../utils/constants.dart';
import '../components/custom_btn_component.dart';
import '../components/custom_fade_animation_component.dart';
import '../components/parent_component.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
   {

  @override
  void initState() {
    super.initState();
    _userController=UserController.instance!;
    _key=GlobalKey<FormState>();
    nameTextEditingController=TextEditingController();
    emailTextEditingController=TextEditingController();
    mobileTextEditingController=TextEditingController();
    nameTextEditingController.text=AppShared.currentUser?.name??'';
    emailTextEditingController.text=AppShared.currentUser?.email??'';
    mobileTextEditingController.text=AppShared.currentUser?.mobile??'';

  }
late GlobalKey<FormState>_key;
 late  TextEditingController nameTextEditingController;
 late  TextEditingController emailTextEditingController;
 late  TextEditingController mobileTextEditingController;
 late UserController _userController;
  bool isEditMode=false;
  bool isBtnLoading=false;
  File? imgProfile;

  Future<void>editProfile()async {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    try {
      setState(() {
        isBtnLoading = true;

      });
      BaseResponse response = await _userController.editProfile(
        email: emailTextEditingController.text,
        name: nameTextEditingController.text,
        mobile: mobileTextEditingController.text,
        image: imgProfile==null?null:await dio.MultipartFile.fromFile(imgProfile!.path),

      );
      if (response.status!) {



        Helpers.showMessage(response.message, MessageType.MESSAGE_SUCCESS);

        if (response.status! ) {

          User? user = User.fromJson(response.data);
          await AppShared.sharedPreferencesController
              .setUserData(user);
          AppShared.currentUser=user;
          setState(() {

          });

        }
        //}
      } else {
        Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);


      }
      setState(() {
        isBtnLoading = false;

      });
    } catch (error) {
      setState(() {
        isBtnLoading = false;
        isEditMode=false;

      });
      print(error);
      Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
    }
  }
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
          child: Form(
           key:_key,
            child: Column(
              children: <Widget>[

                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title:Text(
                    'Profile'.tr(),
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                      color:Colors.black,
                      fontSize:17.sp,
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
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(Constants.SCREENS_MY_CART_SCREEN,
                              arguments: context);
                        },
                        child: SvgPicture.asset(
                            '${Constants.ASSETS_IMAGES_PATH}cart.svg')),
                  ],
                ),

                ProfileImageComponent(
                  isEditMode:this.isEditMode ,
                  onTap: (file){
                    this.imgProfile=file;
                  },
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
                    children: [
                      EntryFieldComponent(
                        isReadOnly: !isEditMode,
                        keyboardType:TextInputType.emailAddress ,
                        contentPadding:const EdgeInsets.symmetric(vertical: 5),

                        title: 'FullName'.tr()
                        ,
                        icon: 'user',
                        textEditingController: nameTextEditingController,
                        validator: (val){
                          if(val==null||val.isEmpty)
                            return'ThisFieldIsRequired'.tr();

                          return null;

                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                     EntryFieldComponent(
                       contentPadding:const EdgeInsets.symmetric(vertical: 5),

                       isReadOnly: !isEditMode,                        keyboardType:TextInputType.emailAddress ,

                       title: 'Email'.tr()
                             ,
                       icon: 'email',
                       textEditingController: emailTextEditingController,
                       validator: (val){
                         if(val==null||val.isEmpty)
                           return'ThisFieldIsRequired'.tr();
                         else if(  !EmailValidator.validate(val))
                           return'ThisIsNotEmailFormat'.tr();
                         return null;

                       },

                     ),
                      SizedBox(
                        height: 15.h,
                      ),
                      EntryFieldComponent(
                        contentPadding:const EdgeInsets.symmetric(vertical: 5),

                        isReadOnly: !isEditMode,
                        keyboardType:TextInputType.phone ,

                        title: 'Mobile'.tr()
                        ,

                        icon: 'mobile',
                        textEditingController: mobileTextEditingController,
                        validator: (val){
                          if(val==null||val.isEmpty)
                            return'ThisFieldIsRequired'.tr();

                          return null;

                        },

                      ),

                      SizedBox(
                        height: 40.h,
                      ),
                      InkWell(
                        onTap: ()async{
                         if(isEditMode){
                          await  editProfile();


                         }else{
                           setState(() {
                             isEditMode=!isEditMode;
                           });
                         }

                        }
                        ,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          child:isEditMode?
                              isBtnLoading?
                                  Center(child: CircularProgressIndicator(),)

                                  :
                              SvgPicture.asset(
                                '${Constants.ASSETS_IMAGES_PATH}done.svg',
                                color: Colors.black,
                              )

                              :

                          SvgPicture.asset(
                            '${Constants.ASSETS_IMAGES_PATH}edit.svg',
                            color: Colors.black,
                          ),
                          decoration: BoxDecoration(
                            color:Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ProfileImageComponent extends StatefulWidget {
  final bool isEditMode;
  final Function(File)onTap;
  const ProfileImageComponent({Key? key,required this.isEditMode,required this.onTap}) : super(key: key);

  @override
  _ProfileImageComponentState createState() => _ProfileImageComponentState();
}

class _ProfileImageComponentState extends State<ProfileImageComponent> {

  File? image;
  final picker = ImagePicker();

  Future getImage() async {
    ImageSource source;
    showModalBottomSheet(context: context,

        backgroundColor: Colors.transparent,

        builder: (context){


          return BottomSheet(
            backgroundColor: Colors.transparent,
            elevation: 0,

            builder: (context){
              return Container(
                height: 200,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),

                      ),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: (){
                              Navigator.of(context).pop(
                                  ImageSource.camera
                              );
                            },
                            leading: CircleAvatar(
                              backgroundColor: Color(0xff007AFF).withOpacity(0.09),

                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}camera.svg')
                              ),
                            ),
                            title: Text('كاميرا'),
                            subtitle: Text('افتح الكاميرا لالتقاط صورة'),
                          ),
                          ListTile(
                            onTap: (){
                              Navigator.of(context).pop(
                                  ImageSource.gallery
                              );
                            },
                            leading: CircleAvatar(
                              backgroundColor: Color(0xff007AFF).withOpacity(0.09),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}gallery.svg')
                              ),
                            ),
                            title: Text('الصور'),
                            subtitle: Text('تصفح الصور من المعرض'),
                          )
                        ],
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop(

                        );
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),

                          ),
                          child:Center(child: Text('الغاء'),)),
                    ),
                  ],
                ),
              );
            }, onClosing: () {  },

          );
        }).then((value)async{


      if(value!=null){
        source=(value as ImageSource);

        final pickedFile = await picker.getImage(
            source: source, maxHeight: 150, maxWidth: 150, imageQuality: 50);


        if (pickedFile != null) {
          File rotatedImage =
          await FlutterExifRotation.rotateImage(path: pickedFile.path);
          setState(() {
            image = File(rotatedImage.path);
            widget.onTap(image!);
          });
        } else {
          print('No image selected.');
        }

      }

    });





  }
  @override
  Widget build(BuildContext context) {
    return       InkWell(
      onTap: getImage,
      child: Stack(
        clipBehavior:Clip.none ,
        children: [
          Container(
            child:
      this.image==null?
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(AppShared.currentUser!.image!)

            ):
    CircleAvatar(
    radius: 60,
    backgroundColor: Colors.white,
    backgroundImage:
    FileImage(image!)
    ,

    )

    ,
          ),
          if(widget.isEditMode)
          Positioned(
            bottom: -17,
            right: 40,

            child:  Container(
              height: AppShared.screenUtil.setHeight(35)
              ,
              width: AppShared.screenUtil.setWidth(35),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  '${Constants.ASSETS_IMAGES_PATH}camera.svg',

                ),
              ),
              decoration: BoxDecoration(
                color:Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),),
        ],
      ),
    );
  }
}
