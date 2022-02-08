// import 'package:allemo/src/notifiers/screens_notifiers/seller_screens_notifiers/store_screen_notifiers.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:provider/provider.dart';
// import '../screens_notifiers/main_screen_notifiers/screens_notifiers/home_screen_notifiers.dart';

// class FilterStoreProductsDialogNotifiers with ChangeNotifier {
//   // ||....................... notifiable ..................................||
//   int? _selectedSortType;
//   bool _refreshCategoriesList = false;
//   num _minPrice = 1.0;
//   num _maxPrice = 200.0;

//   int? get selectedSortType => _selectedSortType;

//   set selectedSortType(int? value) {
//     _selectedSortType = value;
//     notifyListeners();
//   }

//   bool get refreshCategoriesList => _refreshCategoriesList;

//   set refreshCategoriesList(bool value) {
//     _refreshCategoriesList = value;
//     notifyListeners();
//   }

//   num get minPrice => _minPrice;

//   set minPrice(num value) {
//     _minPrice = value;
//     notifyListeners();
//   }

//   num get maxPrice => _maxPrice;

//   set maxPrice(num value) {
//     _maxPrice = value;
//     notifyListeners();
//   }

//   // ||....................... notifiable ..................................||

//   //--------------------------------------------------------------------------------------------------//
//   BuildContext context;
//   late StoreScreenNotifiers homeScreenNotifiers;

//   List<int?>? selectedCategories;

//   FilterStoreProductsDialogNotifiers(this.context) {
//     homeScreenNotifiers =
//         Provider.of<StoreScreenNotifiers>(context, listen: false);
//     _minPrice = homeScreenNotifiers.minPrice;
//     _maxPrice = homeScreenNotifiers.maxPrice;
//     _selectedSortType = homeScreenNotifiers.sorting;
//     selectedCategories = homeScreenNotifiers.selectedCategories;
//   }

// // ||...................... logic methods ............................||

//   // ||...................... logic methods ............................||

// }
