// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:pos_desktop/core/config/app_colors.dart';
// import 'package:pos_desktop/core/shared_widgets/app_dialog.dart';
// import 'package:pos_desktop/core/shared_widgets/custom_app_bar.dart';
// import 'package:pos_desktop/core/utils/response_result.dart';

// showCustomersDialog({required ResponseResult items}) {
//   CustomDialog.getInstance().itemDialog(
//     title: 'customer_list'.tr,
//     content: Center(
//       child: Container(
//           width: Get.width,
//           height: Get.height * 0.66,
//           padding: const EdgeInsets.all(8),
//           child: items.status
//               ? SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       items.data["local"].isNotEmpty
//                           ? Expanded(
//                               child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text("customers removed from server"),
//                                       ...items.data["local"].map((item) =>
//                                           Container(
//                                               margin: const EdgeInsets.all(5),
//                                               height: Get.height * 0.05,
//                                               // width: MediaQuery.of(context).size.width,
//                                               decoration: BoxDecoration(
//                                                   color: AppColor.white,
//                                                   borderRadius:
//                                                       const BorderRadius.all(
//                                                           Radius.circular(
//                                                               100))),
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 50),
//                                                 child: Row(
//                                                   children: [
//                                                     Container(
//                                                       margin:
//                                                           const EdgeInsets.all(
//                                                               10),
//                                                       width: Get.height * 0.04,
//                                                       decoration: BoxDecoration(
//                                                         shape: BoxShape.circle,
//                                                         color: AppColor
//                                                             .shadepurple,
//                                                       ),
//                                                       child: Center(
//                                                           child: Text(
//                                                         (items.data["local"]
//                                                                     .indexOf(
//                                                                         item) +
//                                                                 1)
//                                                             .toString(),
//                                                         style: const TextStyle(
//                                                             color:
//                                                                 Colors.white),
//                                                       )),
//                                                     ),
//                                                     Expanded(
//                                                       flex: 1,
//                                                       child: Center(
//                                                         child: Text(item.name!),
//                                                       ),
//                                                     ),
//                                                     ClipRRect(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(100),
//                                                         child: item.image ==
//                                                                     "" ||
//                                                                 item.image ==
//                                                                     null
//                                                             ? CircleAvatar(
//                                                                 backgroundColor:
//                                                                     AppColor
//                                                                         .greyWithOpcity,
//                                                                 child: Icon(
//                                                                   Icons.person,
//                                                                   color: AppColor
//                                                                       .black,
//                                                                   size:
//                                                                       Get.height *
//                                                                           0.04,
//                                                                 ),
//                                                               )
//                                                             : isSvg(item.image!
//                                                                     .toString())
//                                                                 ? SvgPicture
//                                                                     .memory(
//                                                                     base64.decode(item
//                                                                         .image!
//                                                                         .toString()),
//                                                                     width:
//                                                                         Get.height *
//                                                                             0.04,
//                                                                     height:
//                                                                         Get.height *
//                                                                             0.04,
//                                                                   )
//                                                                 : Image.memory(
//                                                                     base64Decode(item
//                                                                         .image!
//                                                                         .toString()),
//                                                                     width:
//                                                                         Get.height *
//                                                                             0.04,
//                                                                     height:
//                                                                         Get.height *
//                                                                             0.04,
//                                                                   )),
//                                                     Expanded(
//                                                       flex: 1,
//                                                       child: Center(
//                                                         child: Text(
//                                                             item.email ?? ''),
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       flex: 1,
//                                                       child: Center(
//                                                         child: Text(
//                                                             item.phone ?? ''),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )))
                                    
//                                   ]),
//                             )
//                           : Container(),
//                       items.data["remot"].isNotEmpty
//                           ? Expanded(
//                               child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text("customers added from server"),
                                    
//                                       ...items.data["remot"].map((item) =>
//                                           Container(
//                                               margin: const EdgeInsets.all(5),
//                                               height: Get.height * 0.05,
//                                               // width: MediaQuery.of(context).size.width,
//                                               decoration: BoxDecoration(
//                                                   color: AppColor.white,
//                                                   borderRadius:
//                                                       const BorderRadius.all(
//                                                           Radius.circular(
//                                                               100))),
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 50),
//                                                 child: Row(
//                                                   children: [
//                                                     Container(
//                                                       margin:
//                                                           const EdgeInsets.all(
//                                                               10),
//                                                       width: Get.height * 0.04,
//                                                       decoration: BoxDecoration(
//                                                         shape: BoxShape.circle,
//                                                         color: AppColor
//                                                             .shadepurple,
//                                                       ),
//                                                       child: Center(
//                                                           child: Text(
//                                                         (items.data["remot"]
//                                                                     .indexOf(
//                                                                         item) +
//                                                                 1)
//                                                             .toString(),
//                                                         style: const TextStyle(
//                                                             color:
//                                                                 Colors.white),
//                                                       )),
//                                                     ),
//                                                     Expanded(
//                                                       flex: 1,
//                                                       child: Center(
//                                                         child: Text(item.name!),
//                                                       ),
//                                                     ),
//                                                     ClipRRect(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(100),
//                                                         child: item.image ==
//                                                                     "" ||
//                                                                 item.image ==
//                                                                     null
//                                                             ? CircleAvatar(
//                                                                 backgroundColor:
//                                                                     AppColor
//                                                                         .greyWithOpcity,
//                                                                 child: Icon(
//                                                                   Icons.person,
//                                                                   color: AppColor
//                                                                       .black,
//                                                                   size:
//                                                                       Get.height *
//                                                                           0.04,
//                                                                 ),
//                                                               )
//                                                             : isSvg(item.image!
//                                                                     .toString())
//                                                                 ? SvgPicture
//                                                                     .memory(
//                                                                     base64.decode(item
//                                                                         .image!
//                                                                         .toString()),
//                                                                     width:
//                                                                         Get.height *
//                                                                             0.04,
//                                                                     height:
//                                                                         Get.height *
//                                                                             0.04,
//                                                                   )
//                                                                 : Image.memory(
//                                                                     base64Decode(item
//                                                                         .image!
//                                                                         .toString()),
//                                                                     width:
//                                                                         Get.height *
//                                                                             0.04,
//                                                                     height:
//                                                                         Get.height *
//                                                                             0.04,
//                                                                   )),
//                                                     Expanded(
//                                                       flex: 1,
//                                                       child: Center(
//                                                         child: Text(
//                                                             item.email ?? ''),
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       flex: 1,
//                                                       child: Center(
//                                                         child: Text(
//                                                             item.phone ?? ''),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )))
                                    
//                                   ]),
//                             )
//                           : Container(),
//                     ],
//                   ),
//                 )
//               : Text(items.message)),
//     ),
//   );
// }
