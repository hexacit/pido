// import 'dart:async';
// import 'dart:ui';
//
// import 'package:binqassem/src/models/sub_models/exception.dart';
// import 'package:binqassem/src/models/sub_models/service_item.dart';
// import 'package:binqassem/src/notifiers/app_notifiers.dart';
// import 'package:binqassem/src/notifiers/screens_notifiers/search_results_screen_notifiers.dart';
// import 'package:binqassem/src/utils/appMethods.dart';
// import 'package:binqassem/src/utils/enums.dart';
// import 'package:binqassem/src/utils/helpers.dart';
// import 'package:binqassem/src/views/components/empty_component.dart';
// import 'package:binqassem/src/views/components/error_component.dart';
// import 'package:binqassem/src/views/components/service_component.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:binqassem/src/themes/app_themes.dart';
// import 'package:provider/provider.dart';
// import '../../utils/app_shared.dart';
// import '../../utils/constants.dart';
// import '../../views/components/loading_component.dart';
// import '../components/parent_component.dart';
// import 'package:tuple/tuple.dart';
// import 'package:easy_localization/easy_localization.dart' as easy;
//
// class SearchResultsScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//       BuildContext mcontext=ModalRoute.of(context)!.settings.arguments as BuildContext;
//
//     return ParentComponent(
//       child: ChangeNotifierProvider<SearchResultsScreenNotifiers>(
//         create: (_) => SearchResultsScreenNotifiers(mcontext),
//         child: SearchResultsScreenBody(),
//       ),
//     );
//   }
// }
//
// class SearchResultsScreenBody extends StatefulWidget {
//   @override
//   _SearchResultsScreenBodyState createState() =>
//       _SearchResultsScreenBodyState();
// }
//
// class _SearchResultsScreenBodyState extends State<SearchResultsScreenBody> {
//   late SearchResultsScreenNotifiers _searchResultsScreenNotifiers;
//   late AppNotifiers _appNotifiers;
//
//   @override
//   void initState() {
//     super.initState();
//     _searchResultsScreenNotifiers =
//         Provider.of<SearchResultsScreenNotifiers>(context, listen: false);
//     _appNotifiers = Provider.of<AppNotifiers>(context, listen: false);
//
//     _searchResultsScreenNotifiers.init();
//   }
// late Completer<GoogleMapController> controller;
//   ClusterManager<ServicItem>? manager;
//   Future<void> getServicesOnMap({
//     bool isInit = true,
//     bool reset = false,
//   }) async {
//     if (reset) {
//     _searchResultsScreenNotifiers.  selectedserviceId = null;
//     //_searchResultsScreenNotifiers.  markers.removeWhere((element) => element.markerId.value != 'user');
//     }
//
//     try {
//       if (!isInit) {
//         _searchResultsScreenNotifiers.isError = false;
//         _searchResultsScreenNotifiers.isLoading = true;
//         manager=null;
//          controller= Completer();
//       }
//       print('before');
//       _searchResultsScreenNotifiers.servicesOnMapResponse = await _searchResultsScreenNotifiers.servicesController.getServicesOnMap(
//            location: 0,
//           latitude: _appNotifiers.userLocation!.latitude,
//           longitude: _appNotifiers.userLocation!.longitude,
//           categoryId: _searchResultsScreenNotifiers.searchScreenNotifiers.selectedCategoryId,
//           ageCategoryId: _searchResultsScreenNotifiers.searchScreenNotifiers.selectedAgeCategoryId,
//           cityId: _searchResultsScreenNotifiers.searchScreenNotifiers.selectedCityId,
//           educationEnviromentId: _searchResultsScreenNotifiers.searchScreenNotifiers.selectedEducationEnvironmentId,
//           gender: _searchResultsScreenNotifiers.searchScreenNotifiers.selectedGender,
//           subCategoryId: _searchResultsScreenNotifiers.searchScreenNotifiers.selectedSubCategoryId,
//           timeId: _searchResultsScreenNotifiers.searchScreenNotifiers.selectedTimeId,
//           search: _searchResultsScreenNotifiers.searchScreenNotifiers.searchTextEditingController.text,);
//                 print('after');
//
//      // if (manager == null) {
//         manager = ClusterManager<ServicItem>(_searchResultsScreenNotifiers.servicesOnMapResponse!.data!,
//             (Set<Marker> markers) {
//           print('Updated ${markers.length} markers');
//
//           _searchResultsScreenNotifiers.markers = markers.toList();
//          // _homeScreenNotifiers.refresh = !_homeScreenNotifiers.refresh;
//          setState(() {
//
//          });
//         },
//             markerBuilder: markerBuilder,
//             levels: [1, 4.25, 6.75, 8.25, 11.5, 14.5, 16.0, 16.5, 20.0],
//             extraPercent: 0.2,
//             stopClusteringZoom: 17.0);
//      // } else {
//       //  manager!.setItems(servicesOnMapResponse!.data!);
//      // }
//      _searchResultsScreenNotifiers. isLoading = false;
//                 print('after2');
//
//       if (!_searchResultsScreenNotifiers.servicesOnMapResponse!.status!) {
//         Helpers.showMessage(
//             _searchResultsScreenNotifiers.servicesOnMapResponse!.message, MessageType.MESSAGE_FAILED);
//       } else {
//                         print('after3');
//                        // _homeScreenNotifiers.refresh=!_homeScreenNotifiers.refresh;
//
//       }
//     } on ApiException catch (e) {
//       rethrow;
//     } on Exception catch (error) {
//       _searchResultsScreenNotifiers.isError = true;
//       _searchResultsScreenNotifiers.isLoading = false;
//       print(error);
//       Helpers.showMessage(
//           AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
//     }
//   }
//
//   Future<Marker> Function(Cluster<ServicItem>) get markerBuilder {
//     return (cluster) async {
//         return Marker(
//           markerId: MarkerId(cluster.getId()),
//           position: cluster.location,
//           onTap: () async {
//             print('marker tapped');
//             if (cluster.isMultiple) {
//               print('marker tapped44');
//               double zoom = await (await this.controller.future).getZoomLevel();
//               print('----zoom $zoom');
//               List level = [1, 4.25, 6.75, 8.25, 11.5, 14.5, 16.0, 16.5, 20.0];
//
//               for (int i = 0; i < level.length - 1; i++) {
//                 if (level[i] > zoom) {
//                   zoom = level[i];
//                   (await this.controller.future).animateCamera(
//                       CameraUpdate.newCameraPosition(CameraPosition(target:cluster.location,zoom: zoom )));
//                   _searchResultsScreenNotifiers.refresh = !_searchResultsScreenNotifiers.refresh;
//                   return;
//                 }
//               }
//
//               //  ( await controller.future).animateCamera(CameraUpdate.newLatLngZoom(cluster.location, 10));
//             }
//             print('---- $cluster');
//             cluster.items.forEach((p) => print(p));
//           },
//           icon: (cluster.isMultiple)
//               ? await getMarkerBitmap(cluster.isMultiple ? 125 : 75,
//                   text: cluster.isMultiple ? cluster.count.toString() : null)
//               : await getMarkerImageFromUrl(
//                   cluster.items.toList()[0].category!.image!,
//                   70,
//                 ),
//         );
//       };
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text(
//           'SearchResults'.tr(),
//           style: textStyleNeoSansRegular.copyWith(
//               fontSize: 17, color: Color(0xff222B45)),
//         ),
//         leading: BackButton(
//           color: Color(0xff121924),
//         ),
//         actions: [
//           Selector<SearchResultsScreenNotifiers, int>(
//             selector: (_, value) => value.displayMod,
//             builder: (_, displayMod, __) => displayMod == 1
//                 ? IconButton(
//                     onPressed: () {
//                       _searchResultsScreenNotifiers.displayMod = 0;
//                     },
//                     icon: Icon(Icons.list,color: Color(0xff8F9BB2),))
//                 : Container(
//                     child: IconButton(
//                       onPressed: () {
//                         _searchResultsScreenNotifiers.displayMod = 1;
//                                                                    getServicesOnMap(isInit: false);
//
//                       },
//                       icon: SvgPicture.asset(
//                           '${Constants.ASSETS_IMAGES_PATH}map.svg'),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//       backgroundColor: AppShared.appTheme['background'],
//       body:
//           Selector<SearchResultsScreenNotifiers, Tuple4<bool, bool, int, bool>>(
//         selector: (_, value) => Tuple4(
//             value.isLoading, value.isError, value.displayMod, value.refresh),
//         builder: (_, tuple, __) => tuple.item2
//             ? Center(
//                 child: ErrorComponent(
//                   onTryAgainTap: () {
//                     _searchResultsScreenNotifiers.init();
//                   },
//                 ),
//               )
//             :
//
//             tuple.item1?
//
//             Center(child: LoadingComponent(),)
//             :
//              SafeArea(
//                 child: Column(
//                   children: [
//
//                     Expanded(
//                         child: tuple.item3 == 1
//                             ? GoogleMap(
//                                 onTap: (position) {},
//                                 mapType: MapType.normal,
//
//                                                        onCameraMove:    manager!.onCameraMove,
//           onCameraIdle:     manager!.updateMap,
//                                 initialCameraPosition: CameraPosition(
//                                   zoom: 14,
//                                     target: _appNotifiers.userLocation!),
//                                  markers: Set.from(_searchResultsScreenNotifiers.markers),
//                                 onMapCreated: (GoogleMapController controller) {
//                                     if( !  this.controller.isCompleted)
//                                                           this.controller.complete(controller);
//                                                               manager!.setMapId(controller.mapId);
//
//                                   //_controller.complete(controller);
//                                 },
//                                 zoomControlsEnabled: false,
//                                 myLocationEnabled: false,
//                                 myLocationButtonEnabled: false,
//                               )
//                             : Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child:
//                                 _searchResultsScreenNotifiers.servicesResponse.items!.data!.isEmpty?
//
//                                 EmptyComponent(text: 'NoSearchResults'.tr())
//                                 :
//
//                                  ListView.separated(
//                                    itemCount: _searchResultsScreenNotifiers.servicesResponse.items!.data!.length,
//                                     itemBuilder: (_, index) {
//                                       print(_searchResultsScreenNotifiers.servicesResponse.items!.data!.length);
//                                       return ServiceItemComponent(servicItem: _searchResultsScreenNotifiers.servicesResponse.items!.data![index], locationMode: 0);
//                                     },
//                                     separatorBuilder: (_, index) {
//                                       return SizedBox(
//                                         height: 12,
//                                       );
//                                     },
//                                    ),
//                               )),
//                   ],
//                 ),
//               ),
//       ),
//       bottomSheet: Selector<SearchResultsScreenNotifiers, bool>(
//         selector: (_, value) => value.isPagingLoading,
//         builder: (_, isPagingLoading, __) => isPagingLoading
//             ? Container(
//                 height: 100,
//                 child: Center(
//                   child: LoadingComponent(),
//                 ),
//               )
//             : Container(
//                 height: 0,
//               ),
//       ),
//     );
//   }
// }
