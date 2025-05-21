// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:pos_desktop/core/config/app_shared_pr.dart';
// import 'package:pos_desktop/core/utils/validator_helper.dart';
// import 'package:pos_desktop/features/basic_data_management/product_unit/data/product_unit.dart';
// import 'package:pos_desktop/features/basic_data_management/products/data/product.dart';
// import 'package:pos_desktop/features/basic_data_management/products/data/product_name.dart';
// import 'package:pos_desktop/features/dashboard/domain/dashboard_viewmodel.dart';
// import 'package:pos_desktop/features/loading_synchronizing_data/presentation/utils/fetch_date.dart';
// import '../../../../core/config/app_colors.dart';
// import '../../../../core/config/app_enums.dart';
// import '../../../../core/config/app_lists.dart';
// import '../../../../core/config/app_styles.dart';
// import '../../../../core/shared_widgets/app_button.dart';
// import '../../../../core/shared_widgets/app_drop_down_field.dart';
// import '../../../../core/shared_widgets/app_snack_bar.dart';
// import '../../../../core/shared_widgets/app_text_field.dart';
// import '../../../../core/utils/response_result.dart';
// import '../../pos_categories/data/pos_category.dart';
// import '../domain/order_service.dart';
// import '../domain/order_viewmodel.dart';

// // ignore: must_be_immutable
// class AddProductScreen extends StatefulWidget {
//   Product? objectToEdit;

//   AddProductScreen({super.key, this.objectToEdit});

//   @override
//   State<AddProductScreen> createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   final ProductController productController =
//       Get.put(ProductController(), tag: 'productControllerMain');
//   final DashboardController dashboardController =
//       Get.put(DashboardController.getInstance());
//   final TextEditingController nameController = TextEditingController(),
//       barcodeController = TextEditingController(),
//       unitPriceController = TextEditingController();

//   final FocusNode nameFocusNode = FocusNode();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   Product? product;
//   String? errorMessage;
//   int countErrors = 0;
//   int pagesNumber = 0;
//   // List<ProductUnit> productUnitList = [];
//   back() async {
//     productController.object = null;
//     productController.updateHideMenu(false);
//     // productController.update();
//     // await loadingDataController.getitems();
//   }

//   @override
//   void initState() {
//     super.initState();
//     productController.categoriesData();
//     product = widget.objectToEdit;
//     if (product?.id != null) {
//       // nameController.text = product!.productName!;
//       nameController.text = (SharedPr.lang == 'ar'
//           ? product!.productName!.ar001
//           : product!.productName!.enUS)!;
//       barcodeController.text = product!.barcode ?? '';
//       unitPriceController.text = product!.unitPrice!.toString();
//     }

//     product ??= Product();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProductController>(
//         tag: 'productControllerMain',
//         builder: (controller) {
//           return SingleChildScrollView(
//             child: Center(
//               child: Container(
//                 width: Get.width * 0.5,
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         TextButton(
//                             onPressed: () {
//                               back();
//                             },
//                             child: Text("${"products".tr} ")),
//                         Text(
//                             "/ ${(product?.id == null) ? 'add_new_product'.tr : 'edit_product'.tr} "),
//                       ],
//                     ),
//                     Card(
//                       child: Form(
//                         key: _formKey,
//                         child: Padding(
//                           padding: const EdgeInsets.all(30.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               // Center(
//                               //   child: sideUserMenu[
//                               //               SideUserMenu.dataManagement]![0]
//                               //           .last
//                               //           .first is IconData
//                               //       ? Icon(
//                               //           sideUserMenu[
//                               //                   SideUserMenu.dataManagement]![0]
//                               //               .last
//                               //               .first,
//                               //           size:
//                               //               MediaQuery.of(context).size.height *
//                               //                   0.1,
//                               //         )
//                               //       : Image.asset(
//                               //           "assets/image/${sideUserMenu[SideUserMenu.dataManagement]![0].last.first}.png",
//                               //           width:
//                               //               MediaQuery.of(context).size.height *
//                               //                   0.1,
//                               //           color: AppColor.purple,
//                               //         ),
//                               // ),

//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                           ((product?.id == null)
//                                                   ? 'add_new_product'
//                                                   : 'edit_product')
//                                               .tr,
//                                           style: AppStyle.textStyle(
//                                               color: AppColor.black,
//                                               fontSize: Get.width * 0.02,
//                                               fontWeight: FontWeight.bold)
//                                           //  AppStyle.header1,
//                                           ),
//                                       Text('add_new_product_message'.tr,
//                                           style: AppStyle.textStyle(
//                                               color: AppColor.grey,
//                                               fontSize: Get.width * 0.01,
//                                               fontWeight: FontWeight.bold)),
//                                     ],
//                                   ),
//                                   IconButton(
//                                     onPressed: () async {
//                                       final ImagePicker picker = ImagePicker();
//                                       final XFile? image =
//                                           await picker.pickImage(
//                                               source: ImageSource.gallery);
//                                       if (image != null) {
//                                         String imagePath = image.path;
//                                         File imageFile = File(imagePath);
//                                         Uint8List bytes =
//                                             await imageFile.readAsBytes();
//                                         String base64String =
//                                             base64.encode(bytes);
//                                         product!.image = base64String;
//                                         setState(() {});
//                                       }
//                                     },
//                                     icon: Container(
//                                       width: Get.width * 0.05,
//                                       height: Get.width * 0.05,
//                                       decoration: BoxDecoration(
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(25)),
//                                         color: AppColor.purple.withOpacity(0.1),
//                                       ),
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(25),
//                                         child: product!.image != null
//                                             ? Image.memory(
//                                                 base64Decode(product!.image!),
//                                                 fit: BoxFit.fill,
//                                                 width: Get.width * 0.05,
//                                                 height: Get.width * 0.05,
//                                               )
//                                             : Icon(
//                                                 Icons.photo,
//                                                 color: AppColor.purple,
//                                                 size: Get.width * 0.05,
//                                               ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: Get.height * 0.01),
//                               // Text('product_name'.tr,
//                               //     style: AppStyle.textStyle(
//                               //         color: AppColor.black,
//                               //         fontSize: Get.width * 0.01,
//                               //         fontWeight: FontWeight.bold)
//                               //     //  AppStyle.header1,
//                               //     ),
//                               // SizedBox(height: Get.height * 0.01),
//                               ContainerTextField(
//                                 width: Get.width * 0.45,
//                                 prefixIcon: Icons.person,
//                                 height:
//                                     MediaQuery.sizeOf(context).height * 0.05,
//                                 controller: nameController,
//                                 isPIN: true,
//                                 isAddOrEdit: true,
//                                 hintText: 'product_name'.tr,
//                                 labelText: 'product_name'.tr,
//                                 hintcolor: AppColor.black.withOpacity(0.5),
//                                 iconcolor: AppColor.black,
//                                 color: AppColor.black,
//                                 fontSize: Get.width * 0.01,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     errorMessage = 'required_message'.trParams(
//                                         {'field_name': 'product_name'.tr});
//                                     countErrors++;
//                                     return "";
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               SizedBox(height: Get.height * 0.02),
//                               // Text('product_unit_price'.tr,
//                               //     style: AppStyle.textStyle(
//                               //         color: AppColor.black,
//                               //         fontSize: Get.width * 0.01,
//                               //         fontWeight: FontWeight.bold)
//                               //     //  AppStyle.header1,
//                               //     ),
//                               // SizedBox(height: Get.height * 0.01),
//                               ContainerTextField(
//                                 width: Get.width * 0.45,
//                                 prefixIcon: Icons.price_change,
//                                 height:
//                                     MediaQuery.sizeOf(context).height * 0.05,
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter.allow(
//                                       RegExp('[0-9\$]+')),
//                                 ],
//                                 controller: unitPriceController,
//                                 isPIN: true,
//                                 isAddOrEdit: true,
//                                 hintText: 'product_unit_price'.tr,
//                                 labelText: 'product_unit_price'.tr,
//                                 hintcolor: AppColor.black.withOpacity(0.5),
//                                 iconcolor: AppColor.black,
//                                 color: AppColor.black,
//                                 fontSize: Get.width * 0.01,
//                                 validator: (value) {
//                                   var message = ValidatorHelper.priceValidation(
//                                       value: value!,
//                                       field: 'product_unit_price'.tr);
//                                   if (message == "") {
//                                     return null;
//                                   }
//                                   errorMessage = message;
//                                   return "";
//                                   // if (value == null || value.isEmpty) {
//                                   //   errorMessage = 'required_message'.trParams(
//                                   //       {'field_name': 'product_unit_price'.tr});
//                                   //   countErrors++;
//                                   //   return "";
//                                   // }
//                                   // return null;
//                                 },
//                               ),
//                               SizedBox(height: Get.height * 0.02),
//                               // Text('product_barcode'.tr,
//                               //     style: AppStyle.textStyle(
//                               //         color: AppColor.black,
//                               //         fontSize: Get.width * 0.01,
//                               //         fontWeight: FontWeight.bold)
//                               //     //  AppStyle.header1,
//                               //     ),
//                               // SizedBox(height: Get.height * 0.01),
//                               ContainerTextField(
//                                 width: Get.width * 0.45,
//                                 prefixIcon: Icons.barcode_reader,
//                                 height:
//                                     MediaQuery.sizeOf(context).height * 0.05,
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter.allow(
//                                       RegExp('[0-9\$]+')),
//                                 ],
//                                 controller: barcodeController,
//                                 isPIN: true,
//                                 isAddOrEdit: true,
//                                 hintText: 'product_barcode'.tr,
//                                 labelText: 'product_barcode'.tr,
//                                 hintcolor: AppColor.black.withOpacity(0.5),
//                                 iconcolor: AppColor.black,
//                                 color: AppColor.black,
//                                 fontSize: Get.width * 0.01,
//                                 // validator: (value) {
//                                 //   if (value == null || value.isEmpty) {
//                                 //     errorMessage = 'required_message'.trParams(
//                                 //         {'field_name': 'product_barcode'.tr});
//                                 //     countErrors++;
//                                 //     return "";
//                                 //   }
//                                 //   return null;
//                                 // },
//                               ),
//                               SizedBox(height: Get.height * 0.02),
//                               // Text('product_category'.tr,
//                               //     style: AppStyle.textStyle(
//                               //         color: AppColor.black,
//                               //         fontSize: Get.width * 0.01,
//                               //         fontWeight: FontWeight.bold)),
//                               // SizedBox(height: Get.height * 0.01),
//                               ContainerDropDownField(
//                                 width: Get.width * 0.45,
//                                 height:
//                                     MediaQuery.sizeOf(context).height * 0.05,
//                                 prefixIcon: Icons.category,
//                                 hintText: 'product_category'.tr,
//                                 labelText: 'product_category'.tr,
//                                 value: product!.soPosCategId,
//                                 color: AppColor.black,
//                                 // isPIN: true,
//                                 hintcolor: AppColor.black.withOpacity(0.5),
//                                 iconcolor: AppColor.black,
//                                 fontSize: Get.width * 0.01,
//                                 onChanged: (val) {
//                                   product!.soPosCategId = val;
//                                   PosCategory posCategory =
//                                       controller.categoriesList.firstWhere(
//                                           (element) => element.id == val,
//                                           orElse: () => PosCategory());
//                                   // product!.soPosCategName = posCategory.name;
//                                   product!.soPosCategName =
//                                       (SharedPr.lang == 'ar'
//                                           ? posCategory.name!.ar001
//                                           : posCategory.name!.enUS);
//                                 },
//                                 validator: (value) {
//                                   if (value == null) {
//                                     errorMessage = 'required_message'.trParams(
//                                         {'field_name': 'product_category'.tr});
//                                     countErrors++;
//                                     return "";
//                                   }
//                                   return null;
//                                 },
//                                 items: controller.categoriesList
//                                     .map((e) => DropdownMenuItem(
//                                           // value: e.id,
//                                           value: e.id,
//                                           child: Center(
//                                               child: Text((SharedPr.lang == 'ar'
//                                                   ? e.name!.ar001
//                                                   : e.name!.enUS)!)),
//                                         ))
//                                     .toList(),
//                               ),
//                               SizedBox(height: Get.height * 0.02),
//                               // Text('product_unit'.tr,
//                               //     style: AppStyle.textStyle(
//                               //         color: AppColor.black,
//                               //         fontSize: Get.width * 0.01,
//                               //         fontWeight: FontWeight.bold)),
//                               // SizedBox(height: Get.height * 0.01),
//                               ContainerDropDownField(
//                                 width: Get.width * 0.45,
//                                 height:
//                                     MediaQuery.sizeOf(context).height * 0.05,
//                                 prefixIcon: Icons.category,
//                                 hintText: 'product_unit'.tr,
//                                 labelText: 'product_unit'.tr,
//                                 // validator: (value) {
//                                 //   if (value == null) {
//                                 //     errorMessage = 'required_message'.trParams(
//                                 //         {'field_name': 'product_unit'.tr});
//                                 //     countErrors++;
//                                 //     return "";
//                                 //   }
//                                 //   return null;
//                                 // },
//                                 value: product!.uomId,
//                                 color: AppColor.black,
//                                 // isPIN: true,

//                                 hintcolor: AppColor.black.withOpacity(0.5),
//                                 iconcolor: AppColor.black,
//                                 fontSize: Get.width * 0.01,
//                                 onChanged: (val) {
//                                   product!.uomId = val;
//                                   ProductUnit productUnit = controller.unitsList
//                                       .firstWhere(
//                                           (element) => element.id == val,
//                                           orElse: () => ProductUnit());
//                                   product!.uomName = (SharedPr.lang == 'ar'
//                                       ? productUnit.name!.ar001
//                                       : productUnit.name!.enUS);
//                                   // product!.uomName = (SharedPr.lang == 'ar' ? productUnit.name! : productUnit.name!);
//                                 },
//                                 items: controller.unitsList
//                                     .map((e) => DropdownMenuItem(
//                                           // value: e.id,
//                                           value: e.id,
//                                           child: Center(
//                                               child: Text((SharedPr.lang == 'ar'
//                                                   ? e.name!.ar001
//                                                   : e.name!.enUS)!)),
//                                           // child: Center(child: Text((SharedPr.lang == 'ar' ? e.name! : e.name!))),
//                                         ))
//                                     .toList(),
//                               ),
//                               SizedBox(height: Get.height * 0.02),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   ButtonElevated(
//                                       width: Get.width * 0.15,
//                                       text: 'cancel'.tr,
//                                       backgroundColor: AppColor.shadepurple,
//                                       onPressed: () {
//                                         // productController.isLoading.value = false;
//                                         back();
//                                       }),
//                                   SizedBox(width: Get.width * 0.01),
//                                   Obx(() {
//                                     if (productController.isLoading.value) {
//                                       return CircularProgressIndicator(
//                                         color: AppColor.purple,
//                                         // backgroundColor: AppColor.black,
//                                       );
//                                     } else {
//                                       return ButtonElevated(
//                                           width: Get.width * 0.15,
//                                           text: (product?.id != null
//                                                   ? 'edit_product'
//                                                   : 'add_new_product')
//                                               .tr,
//                                           backgroundColor: AppColor.shadepurple,
//                                           onPressed: _onPressed);
//                                     }
//                                   }),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   _onPressed() async {
//     productController.isLoading.value = true;
//     ProductService.productDataServiceInstance = null;
//     ProductService.getInstance();

//     countErrors = 0;
//     if (_formKey.currentState!.validate()) {
//       product!
//         // ..productName = nameController.text
//         ..productName = product!.id == null
//             ? ProductName(enUS: nameController.text, ar001: nameController.text)
//             : ProductName(
//                 enUS: SharedPr.lang == 'en'
//                     ? nameController.text
//                     : product!.productName!.enUS,
//                 ar001: SharedPr.lang == 'ar'
//                     ? nameController.text
//                     : product!.productName!.ar001)
//         // ..productName = jsonEncode({"en_US": nameController.text, "ar_001": nameController.text})
//         ..barcode = barcodeController.text == "" ? null : barcodeController.text
//         ..unitPrice = double.parse(unitPriceController.text)
//         ..uomId = 1;

//       // if (product!.uomId == null && productController.unitsList.isNotEmpty) {
//       //   product!.uomName = productController.unitsList[0].name;
//       //   product!.uomId = productController.unitsList[0].id;
//       // }

//       ResponseResult responseResult;
//       if (product?.id == null) {
//         responseResult =
//             await productController.createProduct(product: product!);
//       } else {
//         responseResult =
//             await productController.updateProduct(product: product!);
//       }

//       if (responseResult.status) {
//         await loadingDataController.getitems();
//         pagesNumber = (loadingDataController
//                     .itemdata[Loaddata.products.name.toString()]['local'] ~/
//                 productController.limit) +
//             (loadingDataController.itemdata[Loaddata.products.name.toString()]
//                             ['local'] %
//                         productController.limit !=
//                     0
//                 ? 1
//                 : 0);
//         if (widget.objectToEdit == null && pagesNumber == 1) {
//           // customerController.customerList.add(func.data);
//           productController.pagingList.add(responseResult.data!);
//         }
//         // if (widget.objectToEdit == null) {
//         //   // productController.productList.add(responseResult.data!);
//         //   // productController.pagingList.add(responseResult.data!);

//         // }

//         productController.update();
//         // await loadingDataController.getitems();
//         product = null;
//         productController.isLoading.value = false;

//         appSnackBar(
//           messageType: MessageTypes.success,
//           message: responseResult.message,
//         );
//         back();
//       } else {
//         productController.isLoading.value = false;

//         appSnackBar(
//           message: responseResult.message,
//         );
//       }
//     } else {
//       productController.isLoading.value = false;

//       appSnackBar(
//         message: countErrors > 1 ? 'enter_required_info'.tr : errorMessage!,
//       );
//     }
//   }
// }
