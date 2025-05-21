// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pos_desktop/core/config/app_colors.dart';
// import 'package:pos_desktop/core/config/app_shared_pr.dart';
// import 'package:pos_desktop/core/shared_widgets/app_dialog.dart';
// import 'package:pos_desktop/core/utils/response_result.dart';

// showCategorysDialog({required ResponseResult items}) {
//   CustomDialog.getInstance().itemDialog(
//     title: 'pos_category_list'.tr,
//     content: Center(child: Container(
//           width: Get.width,
//           height: Get.height * 0.66,
//           // height: Get.height * 0.75,
//           padding: const EdgeInsets.all(8),
//           child: items.status
//               ? SingleChildScrollView(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       items.data["local"].isNotEmpty
//                           ?
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                           const Text("categories removed from server"),
//                           ...items.data["local"].map((item) => Container(
//                               margin: const EdgeInsets.all(5),
//                               height: Get.height * 0.05,
//                               decoration: BoxDecoration(
//                                   color: AppColor.white,
//                                   borderRadius:
//                                       const BorderRadius.all(Radius.circular(100))),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 50),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       margin: const EdgeInsets.all(10),
//                                       width: Get.height * 0.04,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: AppColor.shadepurple,
//                                       ),
//                                       child: Center(
//                                           child: Text(
//                                         (items.data["local"].indexOf(item) + 1).toString(),
//                                         style: const TextStyle(color: Colors.white),
//                                       )),
//                                     ),
//                                     Expanded(
//                                       flex: 1,
//                                       child: Center(
//                                         child: Text((SharedPr.lang == 'ar' ? item.name!.ar001 : item.name!.enUS)!),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )))
//                         ]),
//                       ): Container(),
//                       items.data["remot"].isNotEmpty?
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                           const Text("categories added from server"),
//                           ...items.data["remot"].map((item) => Container(
//                               margin: const EdgeInsets.all(5),
//                               height: Get.height * 0.05,
//                               decoration: BoxDecoration(
//                                   color: AppColor.white,
//                                   borderRadius:
//                                       const BorderRadius.all(Radius.circular(100))),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 50),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       margin: const EdgeInsets.all(10),
//                                       width: Get.height * 0.04,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: AppColor.shadepurple,
//                                       ),
//                                       child: Center(
//                                           child: Text(
//                                         (items.data["remot"].indexOf(item) + 1).toString(),
//                                         style: const TextStyle(color: Colors.white),
//                                       )),
//                                     ),
//                                     Expanded(
//                                       flex: 1,
//                                       child: Center(
//                                         child: Text((SharedPr.lang == 'ar' ? item.name!.ar001 : item.name!.enUS)!),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )))
//                         ]),
//                       )
//                       : Container(),
                    
//                     ],
//                   ),
//                 )
//               : Text(items.message)),
//     ),
//   );
// }
