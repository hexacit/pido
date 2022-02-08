// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import '../../controllers/api_controllers/configs_controller.dart';
// import '../../controllers/api_controllers/user_controller.dart';
// import '../../models/api_models/responses/blocks_response.dart';
// import '../../models/api_models/responses/cities_response.dart';
// import '../../models/api_models/responses/compounds_response.dart';
// import '../../models/api_models/responses/districts_response.dart';
// import '../../utils/app_shared.dart';
// import '../../utils/constants.dart';
// import '../../utils/enums.dart';
// import '../../utils/helpers.dart';

// class SelectLocationDialogNotifiers with ChangeNotifier {
//   // ||....................... notifiable ..................................||
//   bool _isLoading = true;
//   bool _isDistrictsLoading = false;
//   bool _isCompoundsLoading = false;
//   bool _isBlocksLoading = false;
//   CompoundsResponse? _compoundsResponse;
//   BlocksResponse? _blocksResponse;

//   bool get isLoading => _isLoading;

//   set isLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   CompoundsResponse? get compoundsResponse => _compoundsResponse;

//   set compoundsResponse(CompoundsResponse? value) {
//     _compoundsResponse = value;
//     notifyListeners();
//   }

//   bool get isDistrictsLoading => _isDistrictsLoading;

//   set isDistrictsLoading(bool value) {
//     _isDistrictsLoading = value;
//     notifyListeners();
//   }

//   bool get isCompoundsLoading => _isCompoundsLoading;

//   set isCompoundsLoading(bool value) {
//     _isCompoundsLoading = value;
//     notifyListeners();
//   }

//   BlocksResponse? get blocksResponse => _blocksResponse;

//   set blocksResponse(BlocksResponse? value) {
//     _blocksResponse = value;
//     notifyListeners();
//   }

//   bool get isBlocksLoading => _isBlocksLoading;

//   set isBlocksLoading(bool value) {
//     _isBlocksLoading = value;
//     notifyListeners();
//   }

//   // ||....................... notifiable ..................................||

//   //--------------------------------------------------------------------------------------------------//
//   BuildContext context;
//   UserController? userController;
//   ConfigsController? configsController;
//   CitiesResponse? citiesResponse;
//   late DistrictsResponse districtsResponse;

//   // ||... form fields ...|
//   int? cityId;
//   int? districtId;
//   int? compoundId;
//   int? blockId;

//   SelectLocationDialogNotifiers(this.context) {
//     userController = UserController.instance;
//     configsController = ConfigsController.instance;
//     init();
//   }

//   // ||...................... logic methods ............................||
//   void init() async {
//     try {
//       citiesResponse = await configsController!.getCities();
//       districtsResponse = await configsController!
//           .getDistrictsByCityId(citiesResponse!.cities!.data![0].id);
//       compoundsResponse = await configsController!
//           .getCompoundsByDistrictId(districtsResponse.districts!.data![0].id);
//       blocksResponse = await configsController!
//           .getBlocksByCompoundId(compoundsResponse!.compounds!.data![0].id);
//       cityId = citiesResponse!.cities!.data![0].id;
//       districtId = districtsResponse.districts!.data![0].id;
//       compoundId = compoundsResponse!.compounds!.data![0].id;
//       blockId = blocksResponse!.blocks!.data![0].id;
//       isLoading = false;
//     } catch (error) {
//       isLoading = false;
//       print(error);
//       Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
//     }
//   }

//   // get districts by city id.
//   void getDistrictsByCityId() async {
//     try {
//       isDistrictsLoading = true;
//       districtsResponse = await configsController!.getDistrictsByCityId(cityId);
//       isDistrictsLoading = false;
//       if (districtsResponse.districts!.data!.isNotEmpty) {
//         await getCompoundsByDistrictId(districtsResponse.districts!.data![0].id);
//         await getBlocksByCompoundId(compoundsResponse!.compounds!.data![0].id);
//       } else {
//         compoundsResponse = null;
//         blocksResponse = null;
//       }
//     } catch (error) {
//       isDistrictsLoading = false;
//       print(error);
//       Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
//     }
//   }

//   // get compounds by district id.
//   Future<void> getCompoundsByDistrictId(int? districtId) async {
//     try {
//       isCompoundsLoading = true;
//       compoundsResponse =
//           await configsController!.getCompoundsByDistrictId(districtId);
//       isCompoundsLoading = false;
//       if (compoundsResponse!.compounds!.data!.isNotEmpty) {
//         await getBlocksByCompoundId(compoundsResponse!.compounds!.data![0].id);
//       } else {
//         blocksResponse = null;
//       }
//     } catch (error) {
//       isCompoundsLoading = false;
//       print(error);
//       Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
//     }
//   }

//   // get blocks by compound id.
//   Future<void> getBlocksByCompoundId(int? compoundId) async {
//     try {
//       isBlocksLoading = true;
//       blocksResponse =
//           await configsController!.getBlocksByCompoundId(compoundId);
//       isBlocksLoading = false;
//     } catch (error) {
//       isBlocksLoading = false;
//       print(error);
//       Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
//     }
//   }

//   //||... submit ...||
//   void submit() {
//     if (compoundsResponse == null ||
//         citiesResponse == null ||
//         blocksResponse == null ||
//         compoundsResponse == null) {
//       Helpers.showMessage(AppShared.appLang['AllFieldsAreRequired'],
//           MessageType.MESSAGE_FAILED);
//     } else {
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         Constants.SCREENS_MAIN_SCREEN,
//         (route) => false,
//         arguments: compoundId,
//       );
//     }
//   }

//   // ||...................... logic methods ............................||

// }
