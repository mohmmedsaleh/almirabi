// // ignore_for_file: use_build_context_synchronously

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:input_quantity/input_quantity.dart';
// import 'package:popover/popover.dart';
// import 'package:pos_desktop/core/config/app_enums.dart';
// import 'package:pos_desktop/core/config/app_lists.dart';
// import 'package:pos_desktop/features/basic_data_management/pos_categories/data/pos_category.dart';
// import 'package:pos_desktop/features/basic_data_management/products/domain/product_service.dart';
// import 'package:pos_desktop/features/basic_data_management/products/presentation/add_edit_product_screen.dart';
// import 'package:pos_desktop/features/basic_data_management/utils/filtter_product_categ.dart';
// import 'package:pos_desktop/features/loading_synchronizing_data/presentation/utils/fetch_date.dart';
// import '../../../../core/config/app_colors.dart';
// import '../../../../core/config/app_shared_pr.dart';
// import '../../../../core/config/app_styles.dart';
// import '../../../../core/shared_widgets/app_basic_data_card.dart';
// import '../../../../core/shared_widgets/app_count_chart.dart';
// import '../../../../core/shared_widgets/app_empty_state.dart';
// import '../../../../core/shared_widgets/app_snack_bar.dart';
// import '../../../../core/shared_widgets/app_text_field.dart';
// import '../../../../core/shared_widgets/custom_app_bar.dart';
// import '../../../../core/utils/define_type_function.dart';
// import '../../../../core/utils/mac_address_helper.dart';
// import '../../../loading_synchronizing_data/domain/loading_synchronizing_data_viewmodel.dart';
// import '../../product_unit/data/product_unit.dart';
// import '../domain/order_viewmodel.dart';

// class ProductListScreen extends StatefulWidget {
//   const ProductListScreen({super.key});

//   @override
//   State<ProductListScreen> createState() => _ProductListScreenState();
// }

// class _ProductListScreenState extends State<ProductListScreen> {
//   TextEditingController searchBarController = TextEditingController();
//   late final ProductController productController;
//   Color iconcolor = AppColor.greyWithOpcity;
//   int selectedpag = 0;
//   int pagesNumber = 0;
//   @override
//   void initState() {
//     super.initState();
//     ProductService.productDataServiceInstance = null;
//     ProductService.getInstance();
//     productController =
//         Get.put(ProductController(), tag: 'productControllerMain');
//     selectedpag = productController.page.value;
//     getPagingList();
//   }

//   @override
//   void dispose() {
//     searchBarController.dispose();
//     productController.searchResults.clear();
//     super.dispose();
//   }

//   Future getPagingList() async {
//     await productController.displayProductList(
//       paging: true,
//       type: "current",
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProductController>(
//         tag: 'productControllerMain',
//         builder: (controller) {
//           return !productController.hideMainScreen.value
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Text(
//                                         'product_list'.tr,
//                                         style: AppStyle.header1,
//                                       ),
//                                       SizedBox(
//                                           height: MediaQuery.sizeOf(context)
//                                                   .height *
//                                               0.01),
//                                       SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.9,
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 IconButton(
//                                                     onPressed: () async {
//                                                       bool isTrustedDevice =
//                                                           await MacAddressHelper
//                                                               .isTrustedDevice();
//                                                       if (isTrustedDevice) {
//                                                         productController
//                                                             .updateHideMenu(
//                                                                 true);
//                                                       }
//                                                     },
//                                                     icon: Container(
//                                                         width: Get.width / 15,
//                                                         height:
//                                                             MediaQuery.sizeOf(
//                                                                         context)
//                                                                     .height *
//                                                                 0.05,
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: AppColor
//                                                               .shadepurple,
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(50),
//                                                         ),
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                           child: Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceEvenly,
//                                                             children: [
//                                                               Icon(
//                                                                 Icons
//                                                                     .add_circle_outline_outlined,
//                                                                 color: AppColor
//                                                                     .white,
//                                                               ),
//                                                               Text('new'.tr,
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontSize:
//                                                                           Get.width *
//                                                                               0.01,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .normal)),
//                                                             ],
//                                                           ),
//                                                         ))),
//                                                 ContainerTextField(
//                                                   width: Get.width / 3,
//                                                   height:
//                                                       MediaQuery.sizeOf(context)
//                                                               .height *
//                                                           0.05,
//                                                   prefixIcon: Icons.search,
//                                                   suffixIcon: productController
//                                                           .searchProductController
//                                                           .text
//                                                           .isNotEmpty
//                                                       ? Builder(builder:
//                                                           (iconContext) {
//                                                           return SizedBox(
//                                                             width: 100,
//                                                             child: Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .end,
//                                                               children: [
//                                                                 IconButton(
//                                                                     onPressed:
//                                                                         () async {
//                                                                       bool
//                                                                           isTrustedDevice =
//                                                                           await MacAddressHelper
//                                                                               .isTrustedDevice();
//                                                                       if (isTrustedDevice) {
//                                                                         productController
//                                                                             .searchProductController
//                                                                             .text = '';
//                                                                         productController
//                                                                             .searchResults
//                                                                             .clear();
//                                                                         productController
//                                                                             .update();
//                                                                         filtterProductByCategory(
//                                                                             context:
//                                                                                 iconContext,
//                                                                             product:
//                                                                                 productController.productList,
//                                                                             productController: productController);
//                                                                       }
//                                                                     },
//                                                                     icon: Icon(
//                                                                       Icons
//                                                                           .filter_alt_sharp,
//                                                                       color: AppColor
//                                                                           .grey
//                                                                           .withOpacity(
//                                                                               0.7),
//                                                                     )),
//                                                                 IconButton(
//                                                                     onPressed:
//                                                                         () async {
//                                                                       bool
//                                                                           isTrustedDevice =
//                                                                           await MacAddressHelper
//                                                                               .isTrustedDevice();
//                                                                       if (isTrustedDevice) {
//                                                                         productController
//                                                                             .searchProductController
//                                                                             .text = '';
//                                                                         productController
//                                                                             .searchResults
//                                                                             .clear();
//                                                                         productController
//                                                                             .update();
//                                                                       }
//                                                                     },
//                                                                     icon: Icon(
//                                                                       Icons
//                                                                           .cancel_outlined,
//                                                                       color: AppColor
//                                                                           .grey
//                                                                           .withOpacity(
//                                                                               0.7),
//                                                                     )),
//                                                               ],
//                                                             ),
//                                                           );
//                                                         })
//                                                       : Builder(builder:
//                                                           (iconContext) {
//                                                           return IconButton(
//                                                               onPressed:
//                                                                   () async {
//                                                                 bool
//                                                                     isTrustedDevice =
//                                                                     await MacAddressHelper
//                                                                         .isTrustedDevice();
//                                                                 if (isTrustedDevice) {
//                                                                   productController
//                                                                       .searchProductController
//                                                                       .text = '';
//                                                                   productController
//                                                                       .searchResults
//                                                                       .clear();
//                                                                   productController
//                                                                       .update();
//                                                                   filtterProductByCategory(
//                                                                       context:
//                                                                           iconContext,
//                                                                       product:
//                                                                           productController
//                                                                               .productList,
//                                                                       productController:
//                                                                           productController);
//                                                                 }
//                                                               },
//                                                               icon: Icon(
//                                                                 Icons
//                                                                     .filter_alt_sharp,
//                                                                 color: AppColor
//                                                                     .grey
//                                                                     .withOpacity(
//                                                                         0.7),
//                                                               ));
//                                                         }),
//                                                   isPIN: true,
//                                                   isAddOrEdit: true,
//                                                   borderColor: AppColor.purple,
//                                                   labelText: 'product_name'.tr,
//                                                   hintText: 'product_name'.tr,
//                                                   hintcolor: AppColor.purple,
//                                                   iconcolor: AppColor.purple,
//                                                   color: AppColor.purple,
//                                                   borderRadius: 50,
//                                                   fontSize: Get.width * 0.013,
//                                                   maxLength: 20,
//                                                   controller: productController
//                                                       .searchProductController,
//                                                   onChanged: (text) async {
//                                                     bool isTrustedDevice =
//                                                         await MacAddressHelper
//                                                             .isTrustedDevice();
//                                                     if (isTrustedDevice) {
//                                                       if (productController
//                                                               .searchProductController
//                                                               .text ==
//                                                           '') {
//                                                         productController
//                                                             .searchResults
//                                                             .clear();
//                                                         productController
//                                                             .update();
//                                                       } else {
//                                                         productController.search(
//                                                             productController
//                                                                 .searchProductController
//                                                                 .text);
//                                                       }
//                                                     }
//                                                   },
//                                                 ),
//                                                 IconButton(
//                                                     onPressed: () async {
//                                                       bool isTrustedDevice =
//                                                           await MacAddressHelper
//                                                               .isTrustedDevice();
//                                                       if (isTrustedDevice) {
//                                                         var e = loaddata.entries
//                                                             .firstWhere(
//                                                                 (element) =>
//                                                                     element
//                                                                         .key ==
//                                                                     Loaddata
//                                                                         .products);
//                                                         loadingDataController
//                                                             .updateAll(
//                                                                 name: e.key
//                                                                     .toString());
//                                                         // await productController
//                                                         //     .displayProductList(
//                                                         //         paging: true,
//                                                         //         type: "",
//                                                         //         pageselecteed:
//                                                         //             selectedpag);
//                                                         loadingDataController
//                                                             .update([
//                                                           'card_loading_data'
//                                                         ]);
//                                                       }
//                                                     },
//                                                     icon: Container(
//                                                         width: Get.width / 10,
//                                                         height:
//                                                             MediaQuery.sizeOf(
//                                                                         context)
//                                                                     .height *
//                                                                 0.05,
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: AppColor
//                                                               .shadepurple,
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(50),
//                                                         ),
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceEvenly,
//                                                           children: [
//                                                             Icon(
//                                                               Icons
//                                                                   .update_rounded,
//                                                               color: AppColor
//                                                                   .white,
//                                                             ),
//                                                             Text(
//                                                                 'Update_All'.tr,
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .white,
//                                                                     fontSize:
//                                                                         Get.width *
//                                                                             0.01,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .normal)),
//                                                           ],
//                                                         ))),
//                                                 IconButton(
//                                                     onPressed: () async {
//                                                       bool isTrustedDevice =
//                                                           await MacAddressHelper
//                                                               .isTrustedDevice();
//                                                       if (isTrustedDevice) {
//                                                         var e = loaddata.entries
//                                                             .firstWhere(
//                                                                 (element) =>
//                                                                     element
//                                                                         .key ==
//                                                                     Loaddata
//                                                                         .products);
//                                                         bool? result =
//                                                             await synchronizeBasedOnModelType(
//                                                                 type: e.key
//                                                                     .toString());
//                                                         await productController
//                                                             .displayProductList(
//                                                                 paging: true,
//                                                                 type: "",
//                                                                 pageselecteed:
//                                                                     selectedpag);
//                                                         if (result == true) {
//                                                           appSnackBar(
//                                                               message:
//                                                                   'synchronized'
//                                                                       .tr,
//                                                               messageType:
//                                                                   MessageTypes
//                                                                       .success,
//                                                               isDismissible:
//                                                                   false);
//                                                         }
//                                                         loadingDataController
//                                                             .update([
//                                                           'card_loading_data'
//                                                         ]);
//                                                         loadingDataController
//                                                             .update(
//                                                                 ['loading']);
//                                                       }
//                                                     },
//                                                     icon: Container(
//                                                         width: Get.width / 10,
//                                                         height:
//                                                             MediaQuery.sizeOf(
//                                                                         context)
//                                                                     .height *
//                                                                 0.05,
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: AppColor
//                                                               .shadepurple,
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(50),
//                                                         ),
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceEvenly,
//                                                           children: [
//                                                             Icon(
//                                                               Icons.sync,
//                                                               color: AppColor
//                                                                   .white,
//                                                             ),
//                                                             Text(
//                                                                 'synchronization'
//                                                                     .tr,
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .white,
//                                                                     fontSize:
//                                                                         Get.width *
//                                                                             0.01,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .normal)),
//                                                           ],
//                                                         ))),
//                                                 IconButton(
//                                                     onPressed: () async {
//                                                       bool isTrustedDevice =
//                                                           await MacAddressHelper
//                                                               .isTrustedDevice();
//                                                       if (isTrustedDevice) {
//                                                         appSnackBar(
//                                                             message:
//                                                                 'data_show'.tr,
//                                                             messageType:
//                                                                 MessageTypes
//                                                                     .success,
//                                                             isDismissible:
//                                                                 false);
//                                                         await Future.delayed(
//                                                             const Duration(
//                                                                 seconds: 2));
//                                                         await loadingDataController
//                                                             .showDialog(
//                                                                 name: Loaddata
//                                                                     .products
//                                                                     .name
//                                                                     .toString());
//                                                       }
//                                                     },
//                                                     icon: Container(
//                                                         width: Get.width / 10,
//                                                         height:
//                                                             MediaQuery.sizeOf(
//                                                                         context)
//                                                                     .height *
//                                                                 0.05,
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: AppColor
//                                                               .shadepurple,
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(50),
//                                                         ),
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceEvenly,
//                                                           children: [
//                                                             Icon(
//                                                               Icons.view_list,
//                                                               color: AppColor
//                                                                   .white,
//                                                             ),
//                                                             Text("display".tr,
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .white,
//                                                                     fontSize:
//                                                                         Get.width *
//                                                                             0.01,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .normal)),
//                                                           ],
//                                                         ))),

//                                                 // ElevatedButton(
//                                                 //   onPressed: () async {
//                                                 //     await productController
//                                                 //         .displayProductList(
//                                                 //             paging: true);
//                                                 //   },
//                                                 //   child: Text('load_more'.tr),
//                                                 // ),
//                                               ],
//                                             ),
//                                             GetBuilder<LoadingDataController>(
//                                                 id: "card_loading_data",
//                                                 builder: (_) {
//                                                   return CircularProgressBarWithNumbers(
//                                                     startNumber: loadingDataController
//                                                             .itemdata
//                                                             .containsKey(
//                                                                 Loaddata
//                                                                     .products
//                                                                     .name
//                                                                     .toString())
//                                                         ? loadingDataController
//                                                                     .itemdata[
//                                                                 Loaddata
//                                                                     .products.name
//                                                                     .toString()]
//                                                             ['local']
//                                                         : 0,
//                                                     endNumber: loadingDataController
//                                                             .itemdata
//                                                             .containsKey(
//                                                                 Loaddata
//                                                                     .products
//                                                                     .name
//                                                                     .toString())
//                                                         ? loadingDataController
//                                                                     .itemdata[
//                                                                 Loaddata
//                                                                     .products.name
//                                                                     .toString()]
//                                                             ['remote']
//                                                         : 0,
//                                                   );
//                                                 }),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             searchBarController.text != "" &&
//                                     productController.searchResults.isEmpty
//                                 ? Center(
//                                     child: Text('empty_filter'.tr),
//                                   )
//                                 : Expanded(
//                                     child:
//                                         productController.productList.isNotEmpty
//                                             ? Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(16.0),
//                                                 child: Column(
//                                                   children: [
//                                                     Container(
//                                                         margin:
//                                                             const EdgeInsets.all(
//                                                                 2),
//                                                         height:
//                                                             Get.height * 0.05,
//                                                         width:
//                                                             MediaQuery.of(context)
//                                                                 .size
//                                                                 .width,
//                                                         decoration: BoxDecoration(
//                                                             color:
//                                                                 AppColor.purple,
//                                                             borderRadius:
//                                                                 const BorderRadius
//                                                                     .all(
//                                                                     Radius.circular(
//                                                                         100))),
//                                                         child: Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .symmetric(
//                                                                     horizontal:
//                                                                         50),
//                                                             child: Row(
//                                                                 children: [
//                                                                   Container(
//                                                                       width: Get
//                                                                               .width *
//                                                                           0.04,
//                                                                       height: Get
//                                                                               .height *
//                                                                           0.04,
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .center,
//                                                                       child: Center(
//                                                                           child: Text(
//                                                                         "#".tr,
//                                                                         style: TextStyle(
//                                                                             color:
//                                                                                 Colors.white,
//                                                                             fontSize: Get.width * 0.01),
//                                                                       ))),
//                                                                   Expanded(
//                                                                       flex: 1,
//                                                                       child: Center(
//                                                                           child: Text(
//                                                                         "product_image"
//                                                                             .tr,
//                                                                         style: TextStyle(
//                                                                             color:
//                                                                                 Colors.white,
//                                                                             fontSize: Get.width * 0.01),
//                                                                       ))),
//                                                                   Expanded(
//                                                                       flex: 2,
//                                                                       child: Center(
//                                                                           child: Text(
//                                                                         "product_name"
//                                                                             .tr,
//                                                                         style: TextStyle(
//                                                                             color:
//                                                                                 Colors.white,
//                                                                             fontSize: Get.width * 0.01),
//                                                                       ))),
//                                                                   Expanded(
//                                                                       flex: 1,
//                                                                       child: Center(
//                                                                           child: Text(
//                                                                         "product_category"
//                                                                             .tr,
//                                                                         style: TextStyle(
//                                                                             color:
//                                                                                 Colors.white,
//                                                                             fontSize: Get.width * 0.01),
//                                                                       ))),
//                                                                   Expanded(
//                                                                       flex: 1,
//                                                                       child: Center(
//                                                                           child: Text(
//                                                                         "product_unit_price"
//                                                                             .tr,
//                                                                         style: TextStyle(
//                                                                             color:
//                                                                                 Colors.white,
//                                                                             fontSize: Get.width * 0.01),
//                                                                       ))),
//                                                                   Expanded(
//                                                                       flex: 1,
//                                                                       child: Center(
//                                                                           child: Text(
//                                                                         "product_unit"
//                                                                             .tr,
//                                                                         style: TextStyle(
//                                                                             color:
//                                                                                 Colors.white,
//                                                                             fontSize: Get.width * 0.01),
//                                                                       ))),
//                                                                   const Expanded(
//                                                                       flex: 1,
//                                                                       child: Center(
//                                                                           child: Text(
//                                                                         "",
//                                                                         style: TextStyle(
//                                                                             color:
//                                                                                 Colors.white),
//                                                                       ))),
//                                                                 ]))),
//                                                     Expanded(
//                                                       child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: ListView.builder(
//                                                           itemCount: productController
//                                                                   .searchResults
//                                                                   .isNotEmpty
//                                                               ? productController
//                                                                   .searchResults
//                                                                   .length
//                                                               : productController
//                                                                   .pagingList
//                                                                   .length,
//                                                           itemBuilder:
//                                                               (BuildContext
//                                                                       context,
//                                                                   int index) {
//                                                             var item = productController
//                                                                     .searchResults
//                                                                     .isNotEmpty
//                                                                 ? productController
//                                                                         .searchResults[
//                                                                     index]
//                                                                 : productController
//                                                                         .pagingList[
//                                                                     index];

//                                                             ProductUnit?
//                                                                 unitObject =
//                                                                 productController
//                                                                     .unitsList
//                                                                     .firstWhereOrNull((element) =>
//                                                                         element
//                                                                             .id ==
//                                                                         item.uomId);

//                                                             PosCategory?
//                                                                 categoryObject =
//                                                                 productController
//                                                                     .categoriesList
//                                                                     .firstWhereOrNull((element) =>
//                                                                         element
//                                                                             .id ==
//                                                                         item.soPosCategId);
//                                                             return Container(
//                                                                 margin:
//                                                                     const EdgeInsets
//                                                                         .all(2),
//                                                                 height:
//                                                                     Get.height *
//                                                                         0.05,
//                                                                 width: MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .width,
//                                                                 decoration: BoxDecoration(
//                                                                     color: AppColor
//                                                                         .white,
//                                                                     borderRadius:
//                                                                         const BorderRadius
//                                                                             .all(
//                                                                             Radius.circular(100))),
//                                                                 child: Padding(
//                                                                   padding: const EdgeInsets
//                                                                       .symmetric(
//                                                                       horizontal:
//                                                                           50),
//                                                                   child: Row(
//                                                                     children: [
//                                                                       Container(
//                                                                         width: Get.width *
//                                                                             0.04,
//                                                                         height: Get.height *
//                                                                             0.04,
//                                                                         alignment:
//                                                                             Alignment.center,
//                                                                         padding: const EdgeInsets
//                                                                             .all(
//                                                                             5),
//                                                                         decoration:
//                                                                             BoxDecoration(
//                                                                           shape:
//                                                                               BoxShape.rectangle,
//                                                                           borderRadius:
//                                                                               BorderRadius.circular(10),
//                                                                           color:
//                                                                               AppColor.shadepurple,
//                                                                         ),
//                                                                         child:
//                                                                             Text(
//                                                                           ((index + 1) + (selectedpag * productController.limit))
//                                                                               .toString(),
//                                                                           style: TextStyle(
//                                                                               fontSize: Get.width * 0.01,
//                                                                               color: Colors.white),
//                                                                         ),
//                                                                       ),
//                                                                       Expanded(
//                                                                         flex: 1,
//                                                                         child: ClipRRect(
//                                                                             borderRadius: BorderRadius.circular(100),
//                                                                             child: item.image == null
//                                                                                 ? CircleAvatar(
//                                                                                     backgroundColor: AppColor.greyWithOpcity,
//                                                                                     child: Image.asset(
//                                                                                       "assets/image/product.png",
//                                                                                       width: MediaQuery.of(context).size.width * 0.02,
//                                                                                       color: AppColor.grey,
//                                                                                     ),
//                                                                                   )
//                                                                                 : isSvg(item.image!.toString())
//                                                                                     ? CircleAvatar(
//                                                                                         backgroundColor: AppColor.greyWithOpcity,
//                                                                                         child: SvgPicture.memory(
//                                                                                           base64.decode(item.image!.toString()),
//                                                                                           width: Get.height * 0.04,
//                                                                                           height: Get.height * 0.04,
//                                                                                         ),
//                                                                                       )
//                                                                                     : CircleAvatar(
//                                                                                         backgroundColor: AppColor.greyWithOpcity,
//                                                                                         child: Image.memory(
//                                                                                           base64Decode(item.image!.toString()),
//                                                                                           width: Get.height * 0.04,
//                                                                                           height: Get.height * 0.04,
//                                                                                         ),
//                                                                                       )),
//                                                                       ),
//                                                                       Expanded(
//                                                                         flex: 2,
//                                                                         child:
//                                                                             Center(
//                                                                           child:
//                                                                               Text(
//                                                                             (SharedPr.lang == 'ar' ? item.productName!.ar001 : item.productName!.enUS) ??
//                                                                                 '',
//                                                                             style:
//                                                                                 TextStyle(fontSize: Get.width * 0.01),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       Expanded(
//                                                                         flex: 1,
//                                                                         child:
//                                                                             Center(
//                                                                           child:
//                                                                               Text(
//                                                                             SharedPr.lang == 'ar'
//                                                                                 ? categoryObject!.name!.ar001 ?? ""
//                                                                                 : categoryObject!.name!.enUS ?? "",
//                                                                             style:
//                                                                                 TextStyle(fontSize: Get.width * 0.01),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       Expanded(
//                                                                         flex: 1,
//                                                                         child:
//                                                                             Center(
//                                                                           child:
//                                                                               Text(
//                                                                             item.unitPrice.toString(),
//                                                                             style:
//                                                                                 TextStyle(fontSize: Get.width * 0.01),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       Expanded(
//                                                                         flex: 1,
//                                                                         child:
//                                                                             Center(
//                                                                           child:
//                                                                               Text(
//                                                                             (SharedPr.lang == 'ar' ? unitObject?.name?.ar001 : unitObject?.name?.enUS) ??
//                                                                                 "",
//                                                                             style:
//                                                                                 TextStyle(fontSize: Get.width * 0.01),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       Expanded(
//                                                                         flex: 1,
//                                                                         child:
//                                                                             Row(
//                                                                           mainAxisAlignment:
//                                                                               MainAxisAlignment.spaceEvenly,
//                                                                           children: [
//                                                                             IconButton(
//                                                                               onPressed: () {
//                                                                                 productController.object = item;
//                                                                                 productController.updateHideMenu(true);
//                                                                               },
//                                                                               icon: Icon(
//                                                                                 Icons.edit,
//                                                                                 color: AppColor.purple,
//                                                                               ),
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       )
//                                                                     ],
//                                                                   ),
//                                                                 ));
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             : const AppEmptyState(),
//                                   ),

//                             // ButtonElevated(
//                             //     text: (controller.hideMainScreen.value
//                             //             ? 'back'
//                             //             : 'add_new_product')
//                             //         .tr,
//                             //     width: Get.width * 0.15,
//                             //     backgroundColor: AppColor.shadepurple,
//                             //     onPressed: () {
//                             //       if (controller.hideMainScreen.value == true &&
//                             //           object != null) {
//                             //         object = null;
//                             //       }
//                             //       controller.updateHideMenu();
//                             //     }),
//                             // !productController.hideMainScreen.value
//                             //     ? Center(
//                             //         child: Container(
//                             //           width: Get.width * 0.85,
//                             //           height: Get.height * 0.5,
//                             //           padding: const EdgeInsets.all(8),
//                             //           child: Card(
//                             //             surfaceTintColor: AppColor.white,
//                             //             child: DataTable(
//                             //                 headingRowColor: MaterialStateProperty.resolveWith(
//                             //                     (states) => AppColor.greyWithOpcity),
//                             //                 columns: [
//                             //                   DataColumn(
//                             //                     label: Text(
//                             //                       'product_name'.tr,
//                             //                       style: AppStyle.titleStyle,
//                             //                     ),
//                             //                   ),
//                             //                   DataColumn(
//                             //                     label: Text(
//                             //                       'product_category'.tr,
//                             //                       style: AppStyle.titleStyle,
//                             //                     ),
//                             //                   ),
//                             //                   DataColumn(
//                             //                       label: Text(
//                             //                     'product_barcode'.tr,
//                             //                     style: AppStyle.titleStyle,
//                             //                   )),
//                             //                   DataColumn(
//                             //                     label: Text(
//                             //                       'product_unit_price'.tr,
//                             //                       style: AppStyle.titleStyle,
//                             //                     ),
//                             //                   ),
//                             //                   DataColumn(
//                             //                     label: Text(
//                             //                       'edit'.tr,
//                             //                       style: AppStyle.titleStyle,
//                             //                     ),
//                             //                   ),
//                             //                   // DataColumn(
//                             //                   //   label: Text(
//                             //                   //     'delete'.tr,
//                             //                   //     style: AppStyle.titleStyle,
//                             //                   //   ),
//                             //                   // ),
//                             //                 ],
//                             //                 rows: [
//                             //                   for (var item
//                             //                       in controller.searchResults.isNotEmpty
//                             //                           ? controller.searchResults
//                             //                           : controller.productList)
//                             //                     DataRow(cells: [
//                             //                       DataCell(Text(item.productName ?? '')),
//                             //                       DataCell(Text(item.soPosCategName ?? '')),
//                             //                       DataCell(Text(item.barcode ?? '')),
//                             //                       DataCell(Text(item.unitPrice.toString())),
//                             //                       DataCell(IconButton(
//                             //                         icon: const Icon(Icons.edit),
//                             //                         onPressed: () {
//                             //                           object = item;
//                             //                           controller.updateHideMenu();
//                             //                         },
//                             //                       )),
//                             //                       // DataCell(IconButton(
//                             //                       //   icon: const Icon(Icons.delete),
//                             //                       //   onPressed: () async {
//                             //                       //     var responseResult = await controller
//                             //                       //         .deleteProduct(product: item);

//                             //                       //     if (responseResult.status) {
//                             //                       //       controller.productList.remove(item);
//                             //                       //       controller.update();
//                             //                       //       appSnackBar(
//                             //                       //         messageType: MessageTypes.success,
//                             //                       //         message: responseResult.message,
//                             //                       //       );
//                             //                       //     } else {
//                             //                       //       controller.update();
//                             //                       //       appSnackBar(
//                             //                       //         message: responseResult.message,
//                             //                       //       );
//                             //                       //     }
//                             //                       //   },
//                             //                       // )),
//                             //                     ]),
//                             //                 ]),
//                             //           ),
//                             //         ),
//                             //       )
//                           ],
//                         ),
//                       ),
//                       GetBuilder<LoadingDataController>(
//                           id: "pagin",
//                           builder: (controller) {
//                             pagesNumber = (loadingDataController.itemdata[
//                                             Loaddata.products.name.toString()]
//                                         ['local'] ~/
//                                     productController.limit) +
//                                 (loadingDataController.itemdata[Loaddata
//                                                 .products.name
//                                                 .toString()]['local'] %
//                                             productController.limit !=
//                                         0
//                                     ? 1
//                                     : 0);
//                             return loadingDataController.itemdata
//                                     .containsKey(Loaddata.products.name)
//                                 ? ((loadingDataController.itemdata[Loaddata
//                                                     .products.name
//                                                     .toString()]['local'] ~/
//                                                 productController.limit) +
//                                             (loadingDataController.itemdata[
//                                                                 Loaddata
//                                                                     .products.name
//                                                                     .toString()]
//                                                             ['local'] %
//                                                         productController
//                                                             .limit !=
//                                                     0
//                                                 ? 1
//                                                 : 0)) >
//                                         10
//                                     ? Container(
//                                         width: (Get.height * 0.2),
//                                         height: Get.height * 0.03,
//                                         decoration: BoxDecoration(
//                                           color: AppColor.shadepurple,
//                                           borderRadius:
//                                               BorderRadius.circular(50),
//                                         ),
//                                         padding: const EdgeInsets.all(5),
//                                         child: InputQty(
//                                           qtyFormProps: QtyFormProps(
//                                               cursorColor: AppColor.white,
//                                               style: TextStyle(
//                                                   fontSize: Get.height * 0.015,
//                                                   color: AppColor.white,
//                                                   fontWeight: FontWeight.bold)),
//                                           decoration: QtyDecorationProps(
//                                               minusBtn: Icon(
//                                                 Icons.remove,
//                                                 size: Get.height * 0.02,
//                                                 color: AppColor.white,
//                                               ),
//                                               plusBtn: Icon(
//                                                 Icons.add,
//                                                 size: Get.height * 0.02,
//                                                 color: AppColor.white,
//                                               ),
//                                               btnColor: AppColor.white,
//                                               borderShape:
//                                                   BorderShapeBtn.circle,
//                                               border: InputBorder.none),
//                                           maxVal: ((loadingDataController
//                                                               .itemdata[
//                                                           Loaddata.products.name
//                                                               .toString()]
//                                                       ['local'] ~/
//                                                   productController.limit) +
//                                               (loadingDataController.itemdata[Loaddata
//                                                                   .products.name
//                                                                   .toString()]
//                                                               ['local'] %
//                                                           productController
//                                                               .limit !=
//                                                       0
//                                                   ? 1
//                                                   : 0)),
//                                           initVal: selectedpag + 1,
//                                           minVal: 1,
//                                           steps: 1,
//                                           onQtyChanged: (val) async {
//                                             int value;
//                                             if (val is double) {
//                                               value = val.toInt();
//                                             } else {
//                                               value = val;
//                                             }
//                                             selectedpag = value - 1;
//                                             await productController
//                                                 .displayProductList(
//                                                     paging: true,
//                                                     type: "",
//                                                     pageselecteed: selectedpag);
//                                           },
//                                         ),
//                                       )
//                                     : SingleChildScrollView(
//                                         scrollDirection: Axis.horizontal,
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             if (productController
//                                                     .hasLess.value &&
//                                                 pagesNumber != 1) ...[
//                                               InkWell(
//                                                   onTap: () async {
//                                                     await productController
//                                                         .displayProductList(
//                                                       paging: true,
//                                                       type: "prefix",
//                                                     );
//                                                     selectedpag--;
//                                                   },
//                                                   child: Container(
//                                                     padding:
//                                                         const EdgeInsets.all(5),
//                                                     decoration: BoxDecoration(
//                                                         shape: BoxShape.circle,
//                                                         color: AppColor
//                                                             .greyWithOpcity),
//                                                     child: Icon(
//                                                       Icons.arrow_back_ios,
//                                                       size: Get.height * 0.03,
//                                                     ),
//                                                   ))
//                                             ],
//                                             if (pagesNumber != 1) ...[
//                                               SizedBox(
//                                                 width: ((loadingDataController
//                                                                         .itemdata[
//                                                                     Loaddata
//                                                                         .products
//                                                                         .name
//                                                                         .toString()]
//                                                                 ['local'] ~/
//                                                             productController
//                                                                 .limit) +
//                                                         (loadingDataController.itemdata[Loaddata
//                                                                             .products
//                                                                             .name
//                                                                             .toString()]
//                                                                         [
//                                                                         'local'] %
//                                                                     productController
//                                                                         .limit !=
//                                                                 0
//                                                             ? 1
//                                                             : 0)) *
//                                                     (Get.height * 0.045),
//                                                 height: Get.height * 0.04,
//                                                 child: ListView.builder(
//                                                     scrollDirection:
//                                                         Axis.horizontal,
//                                                     itemCount: (loadingDataController
//                                                                         .itemdata[
//                                                                     Loaddata
//                                                                         .products
//                                                                         .name
//                                                                         .toString()]
//                                                                 ['local'] ~/
//                                                             productController
//                                                                 .limit) +
//                                                         (loadingDataController.itemdata[Loaddata.products.name.toString()]['local'] %
//                                                                     productController
//                                                                         .limit !=
//                                                                 0
//                                                             ? 1
//                                                             : 0),
//                                                     itemBuilder:
//                                                         (BuildContext context,
//                                                             int index) {
//                                                       // print(index);
//                                                       return InkWell(
//                                                         onTap: () async {
//                                                           selectedpag = index;
//                                                           // print(
//                                                           //     "selectedpag : $selectedpag");
//                                                           await productController
//                                                               .displayProductList(
//                                                                   paging: true,
//                                                                   type: "",
//                                                                   pageselecteed:
//                                                                       selectedpag);
//                                                         },
//                                                         child: Container(
//                                                             margin:
//                                                                 const EdgeInsets
//                                                                     .symmetric(
//                                                                     horizontal:
//                                                                         2),
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .all(2),
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               shape: BoxShape
//                                                                   .circle,
//                                                               color: index ==
//                                                                       selectedpag
//                                                                   ? AppColor
//                                                                       .purple
//                                                                   : AppColor
//                                                                       .greyWithOpcity,
//                                                             ),
//                                                             alignment: Alignment
//                                                                 .center,
//                                                             width: Get.height *
//                                                                 0.04,
//                                                             height: Get.height *
//                                                                 0.04,
//                                                             child: Text(
//                                                               "${index + 1}",
//                                                               style: TextStyle(
//                                                                   color: index ==
//                                                                           selectedpag
//                                                                       ? AppColor
//                                                                           .white
//                                                                       : AppColor
//                                                                           .black,
//                                                                   fontSize:
//                                                                       Get.height *
//                                                                           0.02),
//                                                             )),
//                                                       );
//                                                     }),
//                                               ),
//                                             ],
//                                             if (productController
//                                                     .hasMore.value &&
//                                                 pagesNumber != 1) ...[
//                                               InkWell(
//                                                   onTap: () async {
//                                                     await productController
//                                                         .displayProductList(
//                                                             paging: true,
//                                                             type: "suffix");
//                                                     selectedpag++;
//                                                   },
//                                                   child: Container(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               5),
//                                                       decoration: BoxDecoration(
//                                                           shape:
//                                                               BoxShape.circle,
//                                                           color: AppColor
//                                                               .greyWithOpcity),
//                                                       child: Icon(
//                                                         Icons.arrow_forward_ios,
//                                                         size: Get.height * 0.03,
//                                                       )))
//                                             ],
//                                           ],
//                                         ),
//                                       )
//                                 : Container();
//                           })
//                     ],
//                   ),
//                 )
//               : AddProductScreen(objectToEdit: productController.object);
//         });
//   }
// }


