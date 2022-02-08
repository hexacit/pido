// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import '../../models/sub_models/order.dart';
// import '../../notifiers/app_notifiers.dart';
// import '../../notifiers/components_notifiers/order_component_notifiers.dart';
// import '../../styles/app_styles.dart';
// import '../../utils/app_shared.dart';
// import '../../utils/constants.dart';
// import '../../utils/helpers.dart';
// import '../../views/components/parent_component.dart';

// class OrderComponent extends StatelessWidget {
//   final Order order;

//   OrderComponent({
//     required this.order,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => OrderComponentNotifiers(),
//       child: OrderComponentBody(
//         order: order,
//       ),
//     );
//   }
// }

// class OrderComponentBody extends StatefulWidget {
//   final Order order;

//   OrderComponentBody({
//     required this.order,
//   });

//   @override
//   _OrderComponentBodyState createState() => _OrderComponentBodyState();
// }

// class _OrderComponentBodyState extends State<OrderComponentBody> {
//   late OrderComponentNotifiers _orderComponentNotifiers;
//   late AppNotifiers _appNotifiers;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _orderComponentNotifiers =
//         Provider.of<OrderComponentNotifiers>(context, listen: false);
//     _appNotifiers = Provider.of<AppNotifiers>(context, listen: false);
//     _orderComponentNotifiers.orderStatus = widget.order.status;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.pushNamed(
//           context,
//           Constants.SCREENS_ORDER_DETAILS_SCREEN,
//           arguments: widget.order,
//         );
//       },
//       child: Container(
//         padding: AppStyles.defaultPadding3,
//         width: double.infinity,
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         decoration: BoxDecoration(
//           color: AppShared.appTheme['background'],
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Text(
//                   '${AppShared.appLang['OrderId']} : ${widget.order.id}',
//                   style: TextStyle(
//                     fontSize: AppShared.screenUtil.setSp(40) as double?,
//                     color: AppShared.appTheme['text'],
//                   ),
//                 ),
//                 Spacer(),
//                 Row(
//                   children: <Widget>[
//                     SvgPicture.asset(
//                       '${Constants.ASSETS_IMAGES_PATH}time.svg',
//                       color: AppShared.appTheme['icons'],
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       widget.order.createdAt!,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: AppShared.appTheme['text2'],
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Text(
//               '${AppShared.appLang['Total']} : ${widget.order.totalPrice} ${AppShared.currency}',
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//             Row(
//               children: <Widget>[
//                 Spacer(
//                   flex: 3,
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: InkWell(
//                     onTap: AppShared.currentUser!.type ==
//                                 Constants.USER_TYPE_CUSTOMER ||
//                             !_appNotifiers.canChangeOrderStatus
//                         ? null
//                         : () {
//                             showDialog(
//                               context: context,
//                            builder: (BuildContext context) {
//                              return   ParentComponent(
//                                 child: Dialog(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   child: Container(
//                                     padding: AppStyles.defaultPadding2,
//                                     height: MediaQuery.of(context).size.height *
//                                         0.3,
//                                     child: ListView.builder(
//                                       itemCount:
//                                           Helpers.getOrderStatuses().length - 1,
//                                       itemBuilder: (_, index) => ListTile(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                           if (Helpers.getOrderStatuses()[
//                                                   index + 1] ==
//                                               Helpers.getOrderStatusName(
//                                                   widget.order.status!)) return;
//                                           widget.order.status = index;
//                                           if (widget.order.status ==
//                                               Constants
//                                                   .ORDER_STATUS_ON_DELIVERY) {
//                                             _appNotifiers.orders
//                                                 .add(widget.order);
//                                             _appNotifiers
//                                                 .driverOrdersScreenNotifiers
//                                                 .listenToLocationUpdates();
//                                           } else {
//                                             if (_appNotifiers.orders
//                                                 .remove(widget.order)) {
//                                               _orderComponentNotifiers
//                                                   .orderController!
//                                                   .deleteOrder(widget.order.id
//                                                       .toString());
//                                             }
//                                           }
//                                           _orderComponentNotifiers
//                                               .notifyOrderStatus(
//                                                   widget.order.status);
//                                           _orderComponentNotifiers
//                                               .changeOrderStatus(
//                                                   orderId: widget.order.id,
//                                                   status: index);
//                                         },
//                                         leading: Icon(
//                                           Icons.flag,
//                                           color: Helpers.getOrderStatuses()[
//                                                       index + 1] ==
//                                                   Helpers.getOrderStatusName(
//                                                       widget.order.status!)
//                                               ? Theme.of(context).primaryColor
//                                               : Colors.grey,
//                                         ),
//                                         trailing: Helpers.getOrderStatuses()[
//                                                     index + 1] ==
//                                                 Helpers.getOrderStatusName(
//                                                     widget.order.status!)
//                                             ? SvgPicture.asset(
//                                                 '${Constants.ASSETS_IMAGES_PATH}check.svg',
//                                                 color: Theme.of(context)
//                                                     .primaryColor,
//                                               )
//                                             : Container(
//                                                 width: 0,
//                                               ),
//                                         title: Text(
//                                           Helpers.getOrderStatusName(index)!,
//                                           style: TextStyle(
//                                             color: Helpers.getOrderStatuses()[
//                                                         index + 1] ==
//                                                     Helpers.getOrderStatusName(
//                                                         widget.order.status!)
//                                                 ? Theme.of(context).primaryColor
//                                                 : Colors.grey,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                              },
//                             );
//                           },
//                     child: Selector<OrderComponentNotifiers, int?>(
//                       selector: (_, value) => value.orderStatus,
//                       builder: (_, orderStatus, __) => Container(
//                         padding: AppStyles.defaultPadding2,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).primaryColor,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Expanded(
//                               child: Text(
//                                 Helpers.getOrderStatusName(orderStatus!)!,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 13,
//                                 ),
//                               ),
//                             ),
//                             Transform(
//                               alignment: Alignment.center,
//                               transform: Matrix4.rotationY(
//                                 Directionality.of(context) == TextDirection.rtl
//                                     ? pi
//                                     : 0,
//                               ),
//                               child: SvgPicture.asset(
//                                 '${Constants.ASSETS_IMAGES_PATH}arraw2.svg',
//                                 width: 13,
//                                 height: 13,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 15,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
