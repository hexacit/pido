import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../notifiers/app_notifiers.dart';

class MainScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  int _selectedPage = 0;

  int get selectedPage => _selectedPage;

  set selectedPage(int value) {
    _selectedPage = value;
    notifyListeners();
  }
  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  PageController? pageController;
  late AppNotifiers _appNotifiers;

  // ||... constructor ...||
  MainScreenNotifiers(this.context) {
    pageController = PageController(

    );
    _appNotifiers = Provider.of<AppNotifiers>(context, listen: false);
    _appNotifiers.mainScreenNotifiers = this;
  }

  // ||...................... logic methods ............................||

// ||...................... logic methods ............................||

}
