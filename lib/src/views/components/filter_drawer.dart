import 'package:pido/src/controllers/api_controllers/auth_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/notifiers/app_notifiers.dart';
import 'package:pido/src/notifiers/screens_notifiers/main_screen_notifiers/main_screen_notifiers.dart';
import 'package:pido/src/notifiers/screens_notifiers/main_screen_notifiers/screens_notifiers/home_screen_notifiers.dart';
import 'package:pido/src/notifiers/screens_notifiers/search_screen_notifiers.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/utils/constants.dart';
import 'package:pido/src/utils/enums.dart';
import 'package:pido/src/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pido/src/views/components/custom_btn_component.dart';
import 'package:provider/provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({Key? key}) : super(key: key);

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  late AppNotifiers _appNotifiers;
  late SearchScreenNotifiers _searchScreenNotifiers;
  late AuthController _authController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appNotifiers = Provider.of<AppNotifiers>(context, listen: false);
    _searchScreenNotifiers =
        Provider.of<SearchScreenNotifiers>(context, listen: false);

    _authController=AuthController.instance!;
    selectedAgeId=_searchScreenNotifiers.selectedAgeCategoryId;
    selectedCategoryId =_searchScreenNotifiers.selectedCategoryId;
    gender =_searchScreenNotifiers.selectedGender;

  }
 int? gender;
 int? selectedAgeId;
 int? selectedCategoryId;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.7,
     color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 40),

            width: double.infinity,



          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                    topLeft: Radius.circular(25)

                )
              ),
              child: Column(

children: [
  Text('Filter'.tr(),
  style: textStyleMedium.copyWith(
    fontSize: 20.sp
  ),),
  SizedBox(
    height: AppShared.screenUtil.setHeight(50),
  ),
  Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text('${'Age'.tr()} :',style: textStyleRegular.copyWith(
      fontSize: 16.sp
      ),)),
  Container(
    margin: EdgeInsetsDirectional.only(start: 20),

        child: Column(
          children: [
            Row(
      children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                controller: _searchScreenNotifiers.ageTextEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ChooseAge'.tr(),
                  hintStyle:  textStyleRegular.copyWith(
                    color:Colors.black,
                    fontSize:AppShared.screenUtil.setSp(18),
                  ),
                ),

                validator: (val){
                  if(val==null||val.isEmpty)
                    return'ThisFieldIsRequired'.tr();

                  return null;

                },
                onTap: (){
    showDialog(context: context, builder:(mcontext)=> SelectAgeDialog(
    context: this.context,
      onSelect: (val){
      print('selectedAgeId before $selectedAgeId');
        selectedAgeId=val;
      print('selectedAgeId after $selectedAgeId');

      },
    ));

                },
                onSaved: (val){

                },
              ),
            ),
            SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}arrow-down.svg') ,

      ],
    ),
            Divider(
              indent: 10,
              color: Colors.black,
            )
          ],
        ),
  ),
  SizedBox(
    height: AppShared.screenUtil.setHeight(50),
  ),
  Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text('${'Category'.tr()} :',style: textStyleRegular.copyWith(
          fontSize: 16.sp
      ),)),
  Container(
    margin: EdgeInsetsDirectional.only(start: 20),

    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                  controller: _searchScreenNotifiers.categoriesTextEditingController,

                  decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ChooseCategory'.tr(),
                  hintStyle:  textStyleRegular.copyWith(
                    color:Colors.black,
                    fontSize:AppShared.screenUtil.setSp(18),
                  ),
                ),

                validator: (val){
                  if(val==null||val.isEmpty)
                    return'ThisFieldIsRequired'.tr();

                  return null;

                },
                onSaved: (val){

                },
                onTap: (){
                  showDialog(context: context, builder: (mcontext)=>SelectCategoryDialog(
                    context:this.context ,
                    onSelect: (val){
                      selectedCategoryId=val;
                    },
                  ));
                }

              ),
            ),
            SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}arrow-down.svg') ,

          ],
        ),
        Divider(
          indent: 10,
          color: Colors.black,
        )
      ],
    ),
  ),
  SizedBox(
    height: AppShared.screenUtil.setHeight(50),
  ),
  Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text('${'Gender'.tr()} :',style: textStyleRegular.copyWith(
          fontSize: 16.sp
      ),)),
  Container(


    child: Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Radio<int>(value: 0, groupValue: gender, onChanged: (val){
                  setState(() {
                    gender=val!;
                  });                  },

                ),
              ),
              Text('Male'.tr()),
            ],
          )
        ),
        Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Radio<int>(
                      value: 1, groupValue: gender, onChanged: (val){
                    setState(() {
                      gender=val!;
                    });

                  }),
                ),
                Text('Female'.tr()),
              ],
            )
        ),
        Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Radio<int>(
                      value: 2, groupValue: gender, onChanged: (val){
                    setState(() {
                      gender=val!;
                    });                    }),
                ),
                Text('Both'.tr()),
              ],
            )
        ),


      ],
    ),
  ),
  SizedBox(
    height: AppShared.screenUtil.setHeight(20),
  ),
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CustomBtnComponent(

          text: 'Filter'.tr(), onTap: (){

        _searchScreenNotifiers.onFilter(selectedCategoryId, selectedAgeId, gender);
        Navigator.of(context).pop();
      },
        padding: EdgeInsets.symmetric(horizontal: 60.w),
      ),
    ],
  ),
  SizedBox(
    height: AppShared.screenUtil.setHeight(10),
  ),
  Row(
    mainAxisAlignment: MainAxisAlignment.center,

    children: [
      CustomBtnComponent(
          padding: EdgeInsets.symmetric(horizontal: 60.w),

          color: Colors.white,
          textColor: Colors.black,
          text: 'Reset'.tr(), onTap: (){
        _searchScreenNotifiers.onResetFilter();
        Navigator.of(context).pop();

      }),
    ],
  ),

],

              ),
            ),
          ),

        ],
      ),
    );
  }}

class SelectAgeDialog extends StatefulWidget {
 final  BuildContext context;
 final Function(int?)onSelect;
  const SelectAgeDialog({
    Key? key,
    required this.context,
    required this.onSelect
  }) : super(key: key);

  @override
  State<SelectAgeDialog> createState() => _SelectAgeDialogState();
}

class _SelectAgeDialogState extends State<SelectAgeDialog> {

  late SearchScreenNotifiers _searchScreenNotifiers;
@override
  void initState() {
    super.initState();
    _searchScreenNotifiers =
        Provider.of<SearchScreenNotifiers>(widget.context, listen: false);
  }
  int? selectedAgeId;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height*0.5,
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

          Container(
            color: Theme.of(context).primaryColor,
               padding: const EdgeInsets.all(12),
               child: Text(
                'SelectAge'.tr(),
                 textAlign: TextAlign.center,
               
               ),
             ),
            Expanded(child:
            ListView.separated(
              itemCount:_searchScreenNotifiers.ages.length,
              itemBuilder: (_, index) {
                return
                  InkWell(
                    onTap: (){
                      setState(() {
                        selectedAgeId=_searchScreenNotifiers.ages[index].id;
                      });
                      _searchScreenNotifiers.ageTextEditingController.text=_searchScreenNotifiers.ages[index].name??'';
widget.onSelect(selectedAgeId);
                       Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(_searchScreenNotifiers.ages[index].name
                             ??''),
                          ),
                          if(selectedAgeId==_searchScreenNotifiers.ages[index].id)
                            Icon(Icons.done,
                              color: Theme.of(context).primaryColor,
                            )
                        ],
                      ),
                    ),
                  );

              },

              separatorBuilder:
                  (_, index) => SizedBox(
                height: AppShared
                    .screenUtil
                    .setWidth(20),
              ), )            ),

          ],
        ),
      ),
    );
  }
}



class SelectCategoryDialog extends StatefulWidget {
  final  BuildContext context;
  final Function(int?)onSelect;

  const SelectCategoryDialog({
    Key? key,
    required this.context,
    required this.onSelect
  }) : super(key: key);

  @override
  State<SelectCategoryDialog> createState() => _SelectCategoryDialogState();
}

class _SelectCategoryDialogState extends State<SelectCategoryDialog> {

  late SearchScreenNotifiers _searchScreenNotifiers;
  late HomeScreenNotifiers _homeScreenNotifiers;
  @override
  void initState() {
    super.initState();
    _searchScreenNotifiers =
        Provider.of<SearchScreenNotifiers>(widget.context, listen: false);
    _homeScreenNotifiers =
        Provider.of<HomeScreenNotifiers>(context, listen: false);
  }
  int? selectedCategoryId;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height*0.5,
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(12),
              child: Text(
                'SelectCategory'.tr(),
                textAlign: TextAlign.center,

              ),
            ),
            Expanded(child:
            ListView.separated(
              itemCount:_homeScreenNotifiers.categories!.length,
              itemBuilder: (_, index) {
                return
                  InkWell(
                    onTap: (){
                      setState(() {
                        selectedCategoryId=_homeScreenNotifiers.categories![index].id;
                      });
                      _searchScreenNotifiers.categoriesTextEditingController.text=_homeScreenNotifiers.categories![index].name??'';
                      widget.onSelect(selectedCategoryId);

                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(_homeScreenNotifiers.categories![index].name
                                ??''),
                          ),
                          if(selectedCategoryId==_homeScreenNotifiers.categories![index].id)
                            Icon(Icons.done,
                              color: Theme.of(context).primaryColor,
                            )
                        ],
                      ),
                    ),
                  );

              },

              separatorBuilder:
                  (_, index) => SizedBox(
                height: AppShared
                    .screenUtil
                    .setWidth(20),
              ), )            ),

          ],
        ),
      ),
    );
  }
}