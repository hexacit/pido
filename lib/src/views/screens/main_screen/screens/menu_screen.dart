import 'package:pido/src/styles/app_styles.dart';
import 'package:pido/src/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../notifiers/screens_notifiers/main_screen_notifiers/screens_notifiers/menu_screen_notifiers.dart';
import '../../../../utils/app_shared.dart';
import '../../../../utils/constants.dart';
import '../../../components/menu_item_component.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MenuScreenNotifiers>(
      create: (_) => MenuScreenNotifiers(context),
      child: MenuScreenBody(),
    );
  }
}

class MenuScreenBody extends StatefulWidget {
  @override
  _MenuScreenBodyState createState() => _MenuScreenBodyState();
}

class _MenuScreenBodyState extends State<MenuScreenBody> {
  late MenuScreenNotifiers _menuScreenNotifiers;

  @override
  void initState() {
    super.initState();
    _menuScreenNotifiers =
        Provider.of<MenuScreenNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppShared.appTheme['background'],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
         'Profile'.tr(),
          style: textStyleRegular.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: AppShared.screenUtil.setSp(24),
          ),
        ),
        leading: IconButton(
              icon: SvgPicture.asset('${Constants.ASSETS_IMAGES_PATH}menu.svg'),
              onPressed: () {
                Scaffold.of(context).openDrawer();

              },
            ),
      ),
      body: Container(
          padding:const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
        
          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
        
          ),
          child: ListView(
           //physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: AppShared.screenUtil.setHeight(100),
                  width: AppShared.screenUtil.setWidth(100),
                  child: Image.asset('${Constants.ASSETS_IMAGES_PATH}user-photo.png'),



                ),
              ),
              SizedBox(
                height: AppShared.screenUtil.setHeight(15),
              ),
              Center(
                child: Text('username@gmail.com',
                style: textStyleRegular.copyWith(
                  fontSize: AppShared.screenUtil.setSp(14),
                  color: Colors.black,
                )
                
                ,),
              ),
  SizedBox(
                height: AppShared.screenUtil.setHeight(15),
              ),

             
              MenuItemComponent(
                hasBorder: false,
                hasLeading: false,
              
                  title:'EditPersonalInformation'.tr(),
                 
                  onTap: () {
                    Navigator.pushNamed(
                        context, Constants.SCREENS_EDIT_PROFILE_SCREEN);
                  },
                ),
                  MenuItemComponent(
                                 
        
                  title:'MyWallet'.tr(),
                    hasBorder: false,
                hasLeading: false,
                  onTap: () {
         Navigator.pushNamed(
                        context, Constants.SCREENS_MY_WALLET_SCREEN);
        
                    // Navigator.pushNamed(
                    //     context, Constants.SCREENS_MY_FAVORITE_SCREEN);
                  },
                ),
              //if (AppShared.sharedPreferencesController.getIsLogin())
                MenuItemComponent(
                                  hasBorder: false,
                hasLeading: false,
        
                  title: 'MyDeposite'.tr(),
                 
                  onTap: () {
                   Navigator.pushNamed(
                        context, Constants.SCREENS_MY_DEPOSIT_SCREEN);
                  },
                ),
                  MenuItemComponent(
                                 
           hasBorder: false,
                hasLeading: false,
                  title: 'DepositRefunds'.tr(),
                 
                  onTap: () {
                    Navigator.pushNamed(
                        context, Constants.SCREENS_DEPOSIT_REFUNDS_SCREEN);
                  },
                ),
                  MenuItemComponent(
                                   
           hasBorder: false,
                hasLeading: false,
                  title: 'MyAuction'.tr(),
                 
                  onTap: () {
                    Navigator.pushNamed(
                        context, Constants.SCREENS_AUCTIONS_SCREEN);
                  },
                ),
                  MenuItemComponent(
                                  
        
                  title: 'MyBids'.tr(),
                   hasBorder: false,
                hasLeading: false,
                  onTap: () {
                    Navigator.pushNamed(
                        context, Constants.SCREENS_MY_BIDS_SCREEN);
                  },
                ),
        
        
                  MenuItemComponent(
                                    hasBorder: false,
                hasLeading: false,
        
                  title: 'MyOffers'.tr(),
                 
                  onTap: () {
                    Navigator.pushNamed(
                        context, Constants.SCREENS_MY_OFFERS_SCREEN);

                  },
                ),
             
              MenuItemComponent(
                                  
        
                  title: 'MyPurchases'.tr(),
                   hasBorder: false,
                hasLeading: false,
                  onTap: () {
                    Navigator.pushNamed(
                        context, Constants.SCREENS_MY_PURCHASES_SCREEN);
                  },
                ),
                  MenuItemComponent(
                                  
        
                  title: 'MyFavorite'.tr(),
                   hasBorder: false,
                hasLeading: false,
                  onTap: () {
                    Navigator.pushNamed(
                        context, Constants.SCREENS_MY_FAVORITE_SCREEN);
                  },
                ),
                  MenuItemComponent(
                                  
        
                  title: 'MyAddresses'.tr(),
                   hasBorder: false,
                hasLeading: false,
                  onTap: () {
                    Navigator.pushNamed(
                        context, Constants.SCREENS_MY_ADDRESSES_SCREEN);
                  },
                ),
                  MenuItemComponent(
                                  
        
                  title: 'RecentlyViewed'.tr(),
                   hasBorder: false,
                hasLeading: false,
                  onTap: () {
                    Navigator.pushNamed(
                        context, Constants.SCREENS_APP_SUPPORT_SCREEN);
                  },
                ),
                 
            ],
          ),
        ),
      ),
    );
  }
}
