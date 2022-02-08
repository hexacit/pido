import 'package:pido/src/controllers/api_controllers/user_controller.dart';
import 'package:pido/src/models/api_models/responses/areas_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../controllers/api_controllers/configs_controller.dart';
import '../../models/api_models/base_response.dart';
import '../../models/api_models/responses/cities_response.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart';
import '../app_notifiers.dart';

class UserAddressScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||

  bool _isLoading = true;
  bool _isError = false;
  bool _isBtnLoading = false;
  double? _rangeValue;
  bool _refresh = false;
  LatLng? userLocation;
  late List<Marker> markers;
  late AppNotifiers _appNotifiers;
int? _selectedCityId;
int? _selectedAreaId;
String? _selectedLocationName;
String? get selectedLocationName => _selectedLocationName;

  set selectedLocationName(String? value) {
    _selectedLocationName = value;
    notifyListeners();
  }
 int? get selectedAreaId => _selectedAreaId;

  set selectedAreaId(int? value) {
    _selectedAreaId = value;
    notifyListeners();
  }

 int? get selectedCityId => _selectedCityId;

  set selectedCityId(int? value) {
    _selectedCityId = value;
    notifyListeners();
  }


  bool get isError => _isError;

  set isError(bool value) {
    _isError = value;
    notifyListeners();
  }

  bool get refresh => _refresh;

  set refresh(bool value) {
    _refresh = value;
    notifyListeners();
  }

  double? get rangeValue => _rangeValue;

  set rangeValue(double? value) {
    _rangeValue = value;
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

  GlobalKey<FormState>? addressFormState;

  // ||... form fields ...|
  String? name;
  String? email;
  String? mobile;
  String? password;
  String? addressName;
  late ConfigsController configsController;
  late UserController userController;

  // ||... focus nodes ...||
  FocusNode? emailFocusNode;
  FocusNode? mobileFocusNode;
  late FocusNode passwordFocusNode;
  FocusNode? addressNameFocusNode;
  late TextEditingController addressNameTextEditingController;
  late TextEditingController homeNumberTextEditingController;
  late TextEditingController cityTextEditingController;
  late TextEditingController areaTextEditingController;
  late TextEditingController codeTextEditingController;

  late CitiesResponse citiesResponse;
  late AreasResponse areasResponse;
  // ||... constructor ...||
  UserAddressScreenNotifiers(this.context) {
    _appNotifiers = Provider.of<AppNotifiers>(context);
    userLocation = Provider.of<AppNotifiers>(context).userLocation;
    markers = [
      Marker(
        markerId: MarkerId('2'),
        position: LatLng(userLocation!.latitude, userLocation!.longitude),
      )
    ];
    addressFormState = GlobalKey();
    passwordFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    mobileFocusNode = FocusNode();
    addressNameFocusNode = FocusNode();
    configsController = ConfigsController.instance!;
    userController = UserController.instance!;
    addressNameTextEditingController=TextEditingController();
    homeNumberTextEditingController=TextEditingController();
    cityTextEditingController=TextEditingController();
    areaTextEditingController=TextEditingController();
    codeTextEditingController=TextEditingController();

    init() ;
  }

  // ||...................... logic methods ............................||

  // init.
  Future<void> init() async {
    await getCities();
   // await getAreas();
  }

// ||...................... logic methods ............................||
  Future<void> getCities() async {
    try {
      citiesResponse = await configsController.getCities();
    } catch (e) {
      isLoading = false;
      isError = true;
    }
  }

  // Future<void> getAreas() async {
  //   try {
  //     areasResponse = await configsController.getAreas();
  //     isLoading = false;
  //   } catch (e) {
  //     isLoading = false;
  //     isError = true;
  //   }
  // }


   Future<void> editAddress() async {
     
if(!addressFormState!.currentState!.validate())return;
     var response;
    try {
      isBtnLoading=true;

      isBtnLoading=false;
 print('here done');
      if(response.status!){
        print('here 11');
Helpers.showMessage(response.message, MessageType.MESSAGE_SUCCESS);
      }
      else{
        Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);

      }
    } catch (e) {
      print(e.toString());
      isBtnLoading=false;
            print('here error');

    }
  }
}
