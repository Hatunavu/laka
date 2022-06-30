// import 'package:client_tggt/core/constant/constant.dart';
// import 'package:client_tggt/model/user/user_model.dart';
// import 'package:client_tggt/screen/home/home_controller.dart';
// import 'package:client_tggt/screen/home/home_setup_controller.dart';
// import 'package:client_tggt/services/theme_services.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SetupWidget extends StatelessWidget {
//   const SetupWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final HomeSetupController c = Get.put(HomeSetupController());
//     UserModel userProfile = c.userData.value;
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Change mode: ",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
//               ),
//               Obx(() => Switch(
//                   value: c.theme.value,
//                   onChanged: (e) {
//                     ThemeServices().switchTheme();
//                     c.changeModeThem();
//                   }))
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 30.h,
//         ),
//         Container(
//           width: 200.w,
//           height: 200.w,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             image: DecorationImage(
//                 image: NetworkImage('${userProfile.avatar}'), fit: BoxFit.fill),
//           ),
//         ),
//         SizedBox(
//           height: kDefaultPadding,
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Flexible(
//                 child: Text(
//                   '${userProfile.email}',
//                   style: TextStyle(fontSize: 18.sp),
//                   maxLines: 2,
//                   softWrap: false,
//                   overflow: TextOverflow.fade,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: kDefaultPadding,
//         ),
//         Text(
//           'greet'.tr,
//           style: TextStyle(fontSize: 20.sp),
//         ),
//         const SizedBox(
//           height: kDefaultPadding,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Change language: ",
//               style: TextStyle(fontSize: 18.sp),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//           ],
//         ),
//         GestureDetector(
//           onTap: () {},
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 50),
//             child: DropdownButton<String>(
//               value: c.language.value,
//               elevation: 16,
//               icon: Icon(Icons.arrow_drop_down_circle),
//               isExpanded: true,
//               items: <String>['vietnamese', 'english'].map((e) {
//                 return DropdownMenuItem(
//                   value: e,
//                   child: Text(e),
//                 );
//               }).toList(),
//               onChanged: (e) {
//                 c.changeLanguage('$e');
//               },
//             ),
//           ),
//         ),
//         SizedBox(
//           height: kDefaultPadding,
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//           child: SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ButtonStyle(
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0),
//                 )),
//                 padding:
//                     MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(12)),
//               ),
//               onPressed: () {},
//               child: Text(
//                 "Button",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
