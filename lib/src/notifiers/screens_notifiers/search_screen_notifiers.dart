import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pido/src/controllers/api_controllers/categories_controller.dart';
import 'package:pido/src/controllers/api_controllers/products_controller.dart';
import 'package:pido/src/models/api_models/base_response.dart';
import 'package:pido/src/models/api_models/responses/age_categories_response.dart';
import 'package:pido/src/models/api_models/responses/categories_response.dart';
import 'package:pido/src/models/api_models/responses/education_enviroment_response.dart';
import 'package:pido/src/models/api_models/responses/subcategories_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pido/src/models/sub_models/age.dart';
import 'package:pido/src/models/sub_models/product.dart';
import 'package:pido/src/models/sub_models/search_products.dart';
import '../../controllers/api_controllers/auth_controller.dart';
import '../../controllers/api_controllers/configs_controller.dart';
import '../../models/api_models/responses/cities_response.dart';
import '../../utils/app_shared.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart';

class SearchScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isLoading = true;
  bool _isBtnLoading = false;


  bool _refreshCategories = false;
  bool _isError = false;
  bool _isCategoriesLoading = true;

  bool _isSubCategoriesPagingLoading = false;
  bool _isProductsLoading = false;
  bool _isProductsError = false;
  bool _isFilterApplied = false;

  bool get isFilterApplied => _isFilterApplied;

  set isFilterApplied(bool value) {
    _isFilterApplied = value;
    notifyListeners();
  }
  bool get isProductsLoading => _isProductsLoading;

  set isProductsLoading(bool value) {
    _isProductsLoading = value;
    notifyListeners();
  }

  bool get isProductsError => _isProductsError;

  set isProductsError(bool value) {
    _isProductsError = value;
    notifyListeners();
  }

  bool get isSubCategoriesPagingLoading => _isSubCategoriesPagingLoading;

  set isSubCategoriesPagingLoading(bool value) {
    _isSubCategoriesPagingLoading = value;
    notifyListeners();
  }

  bool get isCategoriesLoading => _isCategoriesLoading;

  set isCategoriesLoading(bool value) {
    _isCategoriesLoading = value;
    notifyListeners();
  }


  bool get isError => _isError;

  set isError(bool value) {
    _isError = value;
    notifyListeners();
  }

  bool get refreshCategories => _refreshCategories;

  set refreshCategories(bool value) {
    _refreshCategories = value;
    notifyListeners();
  }









  bool get isBtnLoading => _isBtnLoading;

  set isBtnLoading(bool value) {
    _isBtnLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  CategoriesController? categoriesController;
List<Age>ages=[];
List<Product>products=[];
  late TextEditingController searchTextEditingController;
  late TextEditingController categoriesTextEditingController;
  late TextEditingController ageTextEditingController;
late ConfigsController _configsController;
late ProductsController _productsController;


  int categoriesPage = 1;
  int subCategoriesPage = 1;

// ||... Filter Fields ...||
  int? selectedCategoryId;
  int? selectedAgeCategoryId;
  int? selectedGender;
  PaginateProducts? searchResultData;
  final PagingController<int, Product> pagingController =
  PagingController(firstPageKey: 1);
  // ||... constructor ...||
  SearchScreenNotifiers(this.context) {
    searchTextEditingController = TextEditingController();
    categoriesTextEditingController = TextEditingController();
    ageTextEditingController = TextEditingController();
    _configsController=ConfigsController.instance!;
    _productsController=ProductsController.instance!;
    pagingController.addPageRequestListener((pageKey) {
      getFilteredProducts(pageKey);
    });
    init();

  }

  // ||...................... logic methods ............................||

  // init.
  void init() async {
await getAges();
  }
// ||...................... logic methods ............................||

  Future<void>getAges()async{

    try{
      BaseResponse baseResponse=await _configsController.getAges();
       if(baseResponse.status!){
      ages= List<Age>.from(baseResponse.data.map((x) => Age.fromJson(x)));
      }
       else{

         isError=true;
         Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
       }
      isLoading=false;

    }on Exception catch(e){
      print(e);
      isLoading=false;
      isError=true;
    }


  }
  Future<void>getFilteredProducts(int pageKey)async{
    //isFilterApplied=true;
    // isProductsLoading=true;
    // isProductsError=false;

    try{
      BaseResponse baseResponse=await _productsController.getFilteredProducts(
        categoryId: selectedCategoryId,
        ageId: selectedAgeCategoryId,
        gender: selectedGender,
        search: searchTextEditingController.text,
        page: pageKey
      );
      if(baseResponse.status!){
        searchResultData=PaginateProducts.fromJson(baseResponse.mapData!);
        final isLastPage = !searchResultData!.isMore!;

        if (isLastPage) {
          pagingController.appendLastPage(searchResultData!.results!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(searchResultData!.results!, nextPageKey);
        }
        //products= List<Product>.from(baseResponse.data.map((x) => Product.fromJson(x)));
      }
      else{

        isProductsError=true;
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
      }
     // isProductsLoading=false;

    }on Exception catch(e){
      print(e);
      pagingController.error = e;

      // isProductsLoading=false;
      // isProductsError=true;
    }


  }

Future<void>search()async{
  isFilterApplied=true;
  pagingController.refresh();
}
  Future<void>onFilter(
      int? categoryId,
      int? ageId,
      int? genderId,
      )async{
    print('filter');
    print('categoryId $categoryId ${this.selectedCategoryId}');
    print('ageId $ageId ${this.selectedGender}');
    print('genderId $genderId ${this.selectedGender}');

    if(categoryId==this.selectedCategoryId&&
        ageId==this.selectedAgeCategoryId&&
        genderId==this.selectedGender)
      return;
    this.selectedCategoryId=categoryId;
    this.selectedAgeCategoryId=ageId;
    this.selectedGender=genderId;
    search();
  }
  Future<void>onResetFilter(

      )async{
    if( this.selectedCategoryId==null&&this.selectedAgeCategoryId==null&&  this.selectedGender==null)
      return;
    this.selectedCategoryId=null;
    this.selectedAgeCategoryId=null;
    this.selectedGender=null;
    ageTextEditingController.text='';
    categoriesTextEditingController.text='';
    isFilterApplied=false;
    products=[];
    //getFilteredProducts();
  }

}
