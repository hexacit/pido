import 'dart:async';

import 'package:pido/src/controllers/api_controllers/products_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/api_models/responses/category_products_response.dart';
import 'package:pido/src/models/api_models/responses/nav_categories_response.dart';
import 'package:pido/src/models/sub_models/category.dart';
import 'package:pido/src/models/sub_models/categories_products.dart';
import 'package:pido/src/models/sub_models/category_product.dart';
import 'package:pido/src/notifiers/app_notifiers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../controllers/api_controllers/categories_controller.dart';
import '../../../../controllers/api_controllers/configs_controller.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/helpers.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class HomeScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isLoading = true;
  bool _isCategoriesLoading = true;
  bool _isCategoriesError = false;

  bool _isPaginationLoading = false;
  bool _isError = false;
  bool _isFiltered = false;
  bool _isNavCategoriesLoading = false;

  bool _refreshCategories = false;

  int _displayMod = 0;
  int _selectedCategoryId=0 ;

  // _____filter Attributes___________||
  String? _selectedParentCategoryName;
  String? _selectedCategoryName;
  int? _selectedParentCategoryId ;

  int? _selectedFilterCategoryId ;
  double?minPrice;
  double?maxPrice;
  ProductsMode _productsMode=ProductsMode.ALL;
  ProductsMode get productsMode => _productsMode;

  set productsMode(ProductsMode value) {
    _productsMode = value;
    notifyListeners();
  }

  Map<String,dynamic>attributes={};

  int? get selectedFilterCategoryId => _selectedFilterCategoryId;

  set selectedFilterCategoryId(int? value) {
    _selectedFilterCategoryId = value;
    notifyListeners();
  }
  int? get selectedParentCategoryId => _selectedParentCategoryId;

  set selectedParentCategoryId(int? value) {
    _selectedParentCategoryId = value;
    notifyListeners();
  }

  bool get isCategoriesError => _isCategoriesError;

  set isCategoriesError(bool value) {
    _isCategoriesError = value;
    notifyListeners();
  }

  bool _refresh = false;
  late List<Marker> markers;

  String? get selectedCategoryName => _selectedCategoryName;

  set selectedCategoryName(String? value) {
    _selectedCategoryName = value;
    notifyListeners();
  }

  String? get selectedParentCategoryName => _selectedParentCategoryName;

  set selectedParentCategoryName(String? value) {
    _selectedParentCategoryName = value;
    notifyListeners();
  }

  bool get refreshCategories => _refreshCategories;

  set refreshCategories(bool value) {
    _refreshCategories = value;
    notifyListeners();
  }




  bool get isNavCategoriesLoading => _isNavCategoriesLoading;

  set isNavCategoriesLoading(bool value) {
    _isNavCategoriesLoading = value;
    notifyListeners();
  }

  bool get refresh => _refresh;

  set refresh(bool value) {
    _refresh = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
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

  bool get isPaginationLoading => _isPaginationLoading;

  set isPaginationLoading(bool value) {
    _isPaginationLoading = value;
    notifyListeners();
  }

  bool get isCategoriesLoading => _isCategoriesLoading;

  set isCategoriesLoading(bool value) {
    _isCategoriesLoading = value;
    notifyListeners();
  }

  int get selectedCategoryId => _selectedCategoryId;

  set selectedCategoryId(int value) {
    _selectedCategoryId = value;
    notifyListeners();
  }





  bool get isError => _isError;

  set isError(bool value) {
    _isError = value;
    notifyListeners();
  }





  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  CategoriesController? categoriesController;
  ConfigsController? configsController;
  late TextEditingController searchTextEditingController;

  int page = 1;
  int categoriesPage = 1;
  bool isProductsError = false;

  // filter vars.



 // late CategoriesResponse categoriesResponse;
   NavCategoriesResponse? navCategoriesResponse;
  CategoryProductsData? categoryProductsData;
  CategoryProductsData? categoryAttributeData;
  List<MenuCategory>? categories;
  List<CategoriesProducts>? categoriesProducts;
  CategoryProducts? categoryProducts;

  late ProductsController productsController;
  late ScrollController productsScrollController;

  late AppNotifiers appNotifiers;

  // ||... constructor ...||
  HomeScreenNotifiers(this.context,) {
    categoriesController = CategoriesController.instance;
    configsController = ConfigsController.instance;
    productsController=ProductsController.instance!;
    searchTextEditingController = TextEditingController();
    productsScrollController = ScrollController();

    productsScrollController.addListener(() {
      if (productsScrollController.position.pixels <
          productsScrollController.position.maxScrollExtent) return;

      if (isLoading || isPaginationLoading || isError) return;
      getCategoryProducts();
    });



    init();
  }

// ||...................... logic methods ............................||

  // init.
  Future<void> init({isInit: true}) async {

    if (!isInit) {
      isLoading = true;
      isError = false;
      isCategoriesLoading = true;
      isCategoriesError = false;
      print('here refresh');
    }
   await getCategories();
   await getProducts();




  }



  Future<void> getCategories()async{
    BaseResponse baseResponse;
    print('here');

    try{
      baseResponse= await categoriesController!.getCategories();
      if(baseResponse.status!){
        print('categories true $categories');
        categories=List<MenuCategory>.from(baseResponse.data.map((e)=>MenuCategory.fromJson(e)));}
      else{
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);

      }
      isCategoriesLoading=false;


    }
    on Exception catch(e){
      isCategoriesLoading=false;
      isCategoriesError=true;
      print(e);

    }

  }


  Future<void> getCategoryProducts({bool isInit: true,bool reset = false})async{
    BaseResponse baseResponse;
    print('here');
    if(reset){
      page=1;
    }
    if (!isInit) {
      isLoading = true;
      isError = false;

    }
    if (page == 1){
      try{
        baseResponse= await productsController.getProducts(
          categoryId: selectedCategoryId,

        );
        if(baseResponse.status!){
          print('categories true $categories');
          categoryProducts=CategoryProducts.fromJson(baseResponse.mapData!);
          page++;

        }
        else{
          Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);

        }
        isLoading=false;


      }
      on Exception catch(e){
        isLoading=false;
        isError=true;
        print(e);

      }
    }
    else{
      print('before page $page ismore${categoryProducts!.isMore!}');
      if ( !categoryProducts!.isMore!) return;
      isPaginationLoading=true;
      try{
        baseResponse= await productsController.getProducts(
          categoryId: selectedCategoryId,
          page: page,

        );
        if(baseResponse.status!){
          print('categories true $categories');
          CategoryProducts  newData=CategoryProducts.fromJson(baseResponse.mapData!);
          categoryProducts!.items!.addAll(newData.items!);
          categoryProducts!.isMore=newData.isMore;
          print('after page $page ismore ${categoryProducts!.isMore!} ismorenew ${newData.isMore}');

          refresh=!refresh;
          page++;

        }
        else{
          Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);

        }
        isPaginationLoading=false;


      }
      on Exception catch(e){
        isPaginationLoading=false;
        print(e);

      }
    }


  }
  Future<void> getProducts({isInit: true})async{
    BaseResponse baseResponse;
    print('here');
    if (!isInit) {
      isLoading = true;
      isError = false;

    }
    try{
      baseResponse= await productsController.getProducts(
          categoryId: selectedCategoryId
      );
      if(baseResponse.status!){
        print('categories true $categories');
        categoriesProducts=List<CategoriesProducts>.from(baseResponse.data.map((e)=>CategoriesProducts.fromJson(e)));

      }
      else{
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);

      }
      isLoading=false;


    }
    on Exception catch(e){
      isLoading=false;
      isError=true;
      print(e);

    }

  }


// ||...................... logic methods ............................||

}
