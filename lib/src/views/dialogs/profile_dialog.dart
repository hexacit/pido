// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../services/navigation_service.dart';
// import '../../styles/app_styles.dart';
// import '../../utils/app_shared.dart';
// import '../../utils/constants.dart';

// class ProfileDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.65,
//         padding: AppStyles.defaultPadding3,
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 alignment: AlignmentDirectional.centerEnd,
//                 margin: const EdgeInsets.only(top: 8),
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: SvgPicture.asset(
//                     '${Constants.ASSETS_IMAGES_PATH}close.svg',
//                     color: AppShared.appTheme['icons'],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   NavigationService.instance!.pushNamed(
//                       Constants.SCREENS_PHOTO_SCREEN,
//                       arguments: AppShared.currentUser!.imageProfile);
//                 },
//                 child: CircleAvatar(
//                   radius: 55,
//                   backgroundColor: Colors.white,
//                   backgroundImage: NetworkImage(
//                     AppShared.currentUser!.imageProfile!,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 AppShared.currentUser!.name!,
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: AppShared.appTheme['text'],
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 width: 105,
//                 height: 32,
//                 child: OutlineButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     Navigator.pushNamed(
//                         context, Constants.SCREENS_EDIT_PROFILE_SCREEN);
//                   },
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     AppShared.appLang['Edit']!,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                   borderSide: BorderSide(
//                     color: Theme.of(context).primaryColor,
//                     width: 1,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Divider(
//                 thickness: 0.5,
//                 indent: 20,
//                 endIndent: 20,
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Text(
//                 AppShared.appLang['MobileNumber']!,
//                 style: TextStyle(
//                   color: AppShared.appTheme['text2'],
//                   fontSize: 13,
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   SvgPicture.asset(
//                     '${Constants.ASSETS_IMAGES_PATH}mobile.svg',
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Container(
//                     child: Text(
//                       AppShared.currentUser!.mobile!,
//                       style: TextStyle(
//                         color: AppShared.appTheme['text'],
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 AppShared.appLang['Email']!,
//                 style: TextStyle(
//                   color: AppShared.appTheme['text2'],
//                   fontSize: 13,
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   SvgPicture.asset(
//                     '${Constants.ASSETS_IMAGES_PATH}email.svg',
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Container(
//                     child: Text(
//                       AppShared.currentUser!.email ??
//                           AppShared.appLang['EmailNotExist']!,
//                       style: TextStyle(
//                         color: AppShared.appTheme['text'],
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
