import 'package:pido/src/models/api_models/responses/subcategories_response.dart';
import 'package:pido/src/notifiers/app_notifiers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../controllers/api_controllers/categories_controller.dart';
import '../../controllers/api_controllers/configs_controller.dart';
import '../../utils/app_shared.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart';

class CategoryScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isCategoriesLoading = true;
  bool _isCompoundsLoading = true;
  bool _isLoading = true;
  bool _isSearching = false; 
  bool _isSearchVisible = false;
  bool _isError = false;
  bool _refreshHeader = false;
  bool _isFiltered = false;

  bool _isPagingLoading = false;
  bool _refreshProducts = false;

  int _displayMod=0;
int _locationMode=0;
  int _selectedCategory = 0;
  int? _selectedCompoundId = 1;
  bool _refresh = false;
  late List<Marker> markers;
  LatLng userPosition=LatLng(66.6, 33.33);
  bool get refresh => _refresh;

  set refresh(bool value) {
    _refresh = value;
    notifyListeners();
  }

  bool get isCategoriesLoading => _isCategoriesLoading;

  set isCategoriesLoading(bool value) {
    _isCategoriesLoading = value;
    notifyListeners();
  }
int get locationMode => _locationMode;

  set locationMode(int value) {
    _locationMode = value;
    notifyListeners();
  }
  int get displayMod => _displayMod;

  set displayMod(int value) {
    _displayMod = value;
    notifyListeners();
  }

  

  bool get isFiltered => _isFiltered;

  set isFiltered(bool value) {
    _isFiltered = value;
    notifyListeners();
  }

  bool get isSearching => _isSearching;

  set isSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int? get selectedCompoundId => _selectedCompoundId;

  set selectedCompoundId(int? value) {
    _selectedCompoundId = value;
    notifyListeners();
  }

  bool get isCompoundsLoading => _isCompoundsLoading;

  set isCompoundsLoading(bool value) {
    _isCompoundsLoading = value;
    notifyListeners();
  }

  int get selectedCategory => _selectedCategory;

  set selectedCategory(int value) {
    _selectedCategory = value;
    notifyListeners();
  }

  bool get isPagingLoading => _isPagingLoading;

  set isPagingLoading(bool value) {
    _isPagingLoading = value;
    notifyListeners();
  }

  bool get isError => _isError;

  set isError(bool value) {
    _isError = value;
    notifyListeners();
  }

  bool get refreshProducts => _refreshProducts;

  set refreshProducts(bool value) {
    _refreshProducts = value;
    notifyListeners();
  }

  bool get isSearchVisible => _isSearchVisible;

  set isSearchVisible(bool value) {
    _isSearchVisible = value;
    notifyListeners();
  }

  bool get refreshHeader => _refreshHeader;

  set refreshHeader(bool value) {
    _refreshHeader = value;
    notifyListeners();
  }

  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  CategoriesController? categoriesController;
  ConfigsController? configsController;
  late TextEditingController searchTextEditingController;
  late ScrollController subCategoriesScrollController;

  int page = 1;
  bool isProductsError = false;

  // filter vars.
  int? catId;
  

  late SubCategoriesResponse subcategoriesResponse;
 late AppNotifiers _appNotifiers;

  // ||... constructor ...||
  CategoryScreenNotifiers(this.context,this.catId ) {
    _appNotifiers=  Provider.of<AppNotifiers>(context, listen: false);
   
    categoriesController = CategoriesController.instance;
    configsController = ConfigsController.instance;
    searchTextEditingController = TextEditingController();
    subCategoriesScrollController = ScrollController();
    subCategoriesScrollController.addListener(() {
     
      if (subCategoriesScrollController.position.pixels <
          subCategoriesScrollController.position.maxScrollExtent) return;
                print('subCategoriesScrollController2');

      if (isLoading || isPagingLoading || isError) return;
      print('subCategoriesScrollController');
    });
  
    init();
  }

// ||...................... logic methods ............................||

  // init.
  Future<void> init({isInit: true}) async {
    //  isCompoundsLoading = true;
    //   isCategoriesLoading = false;
    //   isProductsLoading = false;
    //   isError = false;
    // if (!isInit) {
    //   isCompoundsLoading = true;
    //   isCategoriesLoading = true;
    //   isProductsLoading = true;
    //   isError = false;
    // }
    // if (compoundId == null) await _getCompounds();
    // await getProducts();
   // await getUserLocation();
  }

 



  // search about product.
  



// ||...................... logic methods ............................||

}
