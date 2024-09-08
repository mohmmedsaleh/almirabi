import 'package:almirabi/core/config/app_colors.dart';
import 'package:almirabi/core/shared_widgets/custom_app_bar.dart';
import 'package:almirabi/core/utils/response_result.dart';
import 'package:almirabi/features/basic_data_management/car/data/car.dart';
import 'package:almirabi/features/basic_data_management/car/domain/car_viewmodel.dart';
import 'package:almirabi/features/basic_data_management/request/data/request.dart';
import 'package:almirabi/features/basic_data_management/request/presentation/view/details_request_screen.dart';
import 'package:almirabi/features/basic_data_management/request/presentation/view/request_list_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_month_select/flutter_month_select.dart';
import 'package:get/get.dart';

import '../../../../../core/config/app_enums.dart';
import '../../../../../core/config/app_shared_pr.dart';
import '../../../../../core/shared_widgets/app_custom_icon.dart';
import '../../../../../core/shared_widgets/app_drop_down_field.dart';
import '../../../../../core/shared_widgets/app_snack_bar.dart';
import '../../../../loading_synchronizing_data/domain/loading_synchronizing_data_viewmodel.dart';
import '../../../../remote_database_setting/presentation/remote_database_screen.dart';
import '../../../source_path/data/source_path.dart';
import '../../../source_path/data/source_path_line.dart';
import '../../../source_path/domain/source_path_viewmodel.dart';
import '../../domain/request_viewmodel.dart';
import '../widgets/show_months_dailog.dart';

// class AddEditRequestScreen extends StatefulWidget {
//   Requests? objectToEdit;
//   bool isAdd;
//   AddEditRequestScreen({super.key, this.objectToEdit, this.isAdd = true});
//   @override
//   State<AddEditRequestScreen> createState() => _AddEditRequestScreenState();
// }

// class _AddEditRequestScreenState extends State<AddEditRequestScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late final CarController carController;
//   late final SourcePathController sourcePathController;
//   late final RequestController requestController;
//   final TextEditingController nameController = TextEditingController(),
//       barcodeController = TextEditingController(),
//       unitPriceController = TextEditingController();
//   List<SourcePathLine> sourcePathLineList = [];
//   List<SourcePathLine> requestLineList = [];
//   List<SourcePath> sourcePathList = [];
//   final FocusNode nameFocusNode = FocusNode();
//   String? carid, sourcePathId, sourcePathLineId;
//   Requests? requests;
//   String? errorMessage;
//   int countErrors = 0;
//   int pagesNumber = 0;
//   bool isAdd = false;
//   double totalPrice = 0.0;
//   String? monthTextController;
//   int? month;
//   String? _firstValue;
//   String? _secondValue;
//   String? fromDateTextController, toDateTextController;
//   Car? carTextController;
//   SourcePath? sourcePathTextController;
//   // List<ProductUnit> productUnitList = [];
//   back() async {
//     // requestController.object = null;
//     // requestController.updateHideMenu(false);
//     // productController.update();
//     // await loadingDataController.getitems();
//   }

//   @override
//   void initState() {
//     super.initState();
//     carController = Get.put(CarController());
//     sourcePathController = Get.put(SourcePathController());
//     getData();
//     // requests!.car = carController.carList.first;
//     requestController = Get.put(RequestController());

//     // requestController.carData();
//     requests = widget.objectToEdit;
//     // if (product?.id != null) {
//     // nameController.text = product!.productName!;
//     // nameController.text = (SharedPr.lang == 'ar'
//     //     ? product!.productName!.ar001
//     //     : product!.productName!.enUS)!;
//     // barcodeController.text = product!.barcode ?? '';
//     // unitPriceController.text = product!.unitPrice!.toString();
//     // }

//     requests ??= Requests();
//   }

//   getData() async {
//     await carController.carData();
//     await sourcePathController.SourcePathData();
//     if (!widget.isAdd) {
//       carid = carController.carList
//           .firstWhere((e) => e.id == widget.objectToEdit!.car!.id)
//           .name;
//       sourcePathList = sourcePathController.sourcePathList
//           .where((e) => e.car!.id == widget.objectToEdit!.car!.id)
//           .toList();
//       sourcePathId = widget.objectToEdit!.sourcePathName;
//       requestLineList.addAll(widget.objectToEdit!.requestLines!);
//       SourcePath sourcePath = sourcePathController.sourcePathList.firstWhere(
//           (element) => element.sourcePathName == sourcePathId,
//           orElse: () => SourcePath());
//       sourcePathLineList = sourcePath.lins!;
//       carTextController = Car(id: widget.objectToEdit!.car!.id, name: carid);
//       sourcePathTextController = SourcePath(
//           sourcePathId: widget.objectToEdit!.sourcePathId,
//           sourcePathName: widget.objectToEdit!.sourcePathName);
//       fromDateTextController = widget.objectToEdit!.fromDate;
//       toDateTextController = widget.objectToEdit!.toDate;
//       monthTextController = widget.objectToEdit!.monthName;
//       totalPrice = widget.objectToEdit!.amoutTotal!;
//     }
//     requestController.update();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: customAppBar(headerBackground: true, userOpstionShow: true),
//         body: CustomBackGround(
//             child: GetBuilder<RequestController>(builder: (controller) {
//           return Container(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: Get.height * 0.02,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: IconButton(
//                           onPressed: () {
//                             widget.isAdd
//                                 ? Get.offAll(() => const RequestListScreen())
//                                 : Get.back();
//                           },
//                           icon: CircleAvatar(
//                               backgroundColor: AppColor.white,
//                               child: const Icon(
//                                   Icons.arrow_back_ios_new_outlined))),
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Center(
//                         child: Text(
//                           "add_new_requst".tr,
//                           style: TextStyle(
//                               fontSize: Get.width * 0.05,
//                               fontWeight: FontWeight.bold,
//                               color: AppColor.white),
//                         ),
//                       ),
//                     ),
//                     Expanded(flex: 1, child: Container())
//                   ],
//                 ),
//                 // InkWell(
//                 //   onTap: () {
//                 //     Get.back();
//                 //   },
//                 //   child: Text("ssssssssss"),
//                 // ),
//                 SizedBox(
//                   height: Get.height * 0.08,
//                 ),
//                 Expanded(
//                   child: Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 16.0),
//                               child: Column(
//                                 children: [
//                                   ContainerDropDownField(
//                                     width: Get.width,
//                                     height: MediaQuery.sizeOf(context).height *
//                                         0.05,
//                                     onTap: () {
//                                       if (widget.isAdd) {
//                                         sourcePathTextController = null;
//                                       }
//                                       sourcePathId = null;
//                                       carid = null;
//                                       sourcePathList = [];
//                                       requestLineList = [];

//                                       sourcePathLineList = [];
//                                       controller.update();
//                                     },
//                                     prefixIcon: CustomIcon(
//                                       assetPath:
//                                           'assets/images/delivery-truck.png',
//                                       size: Get.width * 0.05,
//                                     ),
//                                     hintText: 'car_name'.tr,
//                                     labelText: 'car_name'.tr,
//                                     value: carid,
//                                     color: AppColor.black,
//                                     // isPIN: true,
//                                     hintcolor: AppColor.black.withOpacity(0.5),
//                                     iconcolor: AppColor.black,
//                                     fontSize: Get.width * 0.03,
//                                     onChanged: (val) {
//                                       Car car = carController.carList
//                                           .firstWhere(
//                                               (element) => element.name == val,
//                                               orElse: () => Car());
//                                       sourcePathList = sourcePathController
//                                           .sourcePathList
//                                           .where((e) => e.car!.id == car.id)
//                                           .toList();

//                                       if (sourcePathList.isNotEmpty) {
//                                         carid = val;
//                                       } else {
//                                         //snakbar
//                                       }
//                                       carTextController = car;
//                                       // requests!.car = car;
//                                       controller.update();
//                                     },
//                                     validator: (value) {
//                                       if (value == null) {
//                                         errorMessage = 'required_message'
//                                             .trParams(
//                                                 {'field_name': 'car_name'.tr});
//                                         countErrors++;
//                                         return "";
//                                       }
//                                       return null;
//                                     },
//                                     items: carController.carList
//                                         .map((e) => DropdownMenuItem<String>(
//                                               // value: e.id,
//                                               value: e.name,
//                                               child: Center(
//                                                   child: Text(
//                                                 (e.name)!,
//                                                 style: TextStyle(
//                                                     fontSize: Get.width * 0.03,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: AppColor.black),
//                                               )),
//                                             ))
//                                         .toList(),
//                                   ),
//                                   SizedBox(
//                                     height: Get.height * 0.02,
//                                   ),
//                                   carid != null
//                                       ? ContainerDropDownField(
//                                           width: Get.width,
//                                           height: MediaQuery.sizeOf(context)
//                                                   .height *
//                                               0.05,
//                                           prefixIcon: CustomIcon(
//                                             assetPath:
//                                                 'assets/images/destination.png',
//                                             size: Get.width * 0.05,
//                                           ),
//                                           hintText: 'source_path'.tr,
//                                           labelText: 'source_path'.tr,
//                                           value: sourcePathId,
//                                           color: AppColor.black,
//                                           // isPIN: true,
//                                           hintcolor:
//                                               AppColor.black.withOpacity(0.5),
//                                           iconcolor: AppColor.black,
//                                           fontSize: Get.width * 0.03,
//                                           onTap: () {
//                                             sourcePathId = null;
//                                             sourcePathLineList = [];
//                                             requestLineList = [];
//                                             if (isAdd) {
//                                               sourcePathTextController = null;
//                                             }

//                                             controller.update();
//                                           },
//                                           onChanged: (val) {
//                                             sourcePathId = val;
//                                             SourcePath sourcePath =
//                                                 sourcePathController
//                                                     .sourcePathList
//                                                     .firstWhere(
//                                                         (element) =>
//                                                             element
//                                                                 .sourcePathName ==
//                                                             val,
//                                                         orElse: () =>
//                                                             SourcePath());

//                                             if (sourcePath.lins!.isNotEmpty) {
//                                               sourcePathLineList =
//                                                   sourcePath.lins!;
//                                             } else {
//                                               sourcePathLineList =
//                                                   sourcePath.lins!;
//                                               //snake bar
//                                             }
//                                             sourcePathTextController =
//                                                 sourcePath;
//                                             // requests!.sourcePathId =
//                                             //     sourcePath.sourcePathId;
//                                             // requests!.sourcePathName =
//                                             //     sourcePath.sourcePathName;
//                                             controller.update();
//                                             // sourcePathLineList = jsonDecode(sourcePath);
//                                           },
//                                           validator: (value) {
//                                             if (value == null) {
//                                               errorMessage = 'required_message'
//                                                   .trParams({
//                                                 'field_name': 'source_path'.tr
//                                               });
//                                               countErrors++;
//                                               return "";
//                                             }
//                                             return null;
//                                           },
//                                           items: sourcePathList.map((e) {
//                                             return DropdownMenuItem<String>(
//                                               // value: e.id,
//                                               value: e.sourcePathName,
//                                               child: Center(
//                                                   child: Text(
//                                                 (e.sourcePathName)!,
//                                                 style: TextStyle(
//                                                     fontSize: Get.width * 0.03,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: AppColor.black),
//                                               )),
//                                             );
//                                           }).toList(),
//                                         )
//                                       : Container(),
//                                   SizedBox(
//                                     height: Get.height * 0.02,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Column(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () async {
//                                               // final date =
//                                               //     await showDatePickerDialog(
//                                               //   context: context,
//                                               //   minDate: DateTime(1990, 1, 1),
//                                               //   maxDate: DateTime(2100, 12, 31),
//                                               //   height: Get.height / 3,
//                                               //   initialPickerType:
//                                               //       PickerType.months,
//                                               // );
//                                               month = await _selectMonth();
//                                               if (month != null) {
//                                                 if (month! < 10) {
//                                                   monthTextController =
//                                                       '0${month}';
//                                                 } else {
//                                                   monthTextController =
//                                                       month.toString();
//                                                 }
//                                                 fromDateTextController =
//                                                     DateTime(
//                                                             DateTime.now().year,
//                                                             month!,
//                                                             1)
//                                                         .toString()
//                                                         .substring(0, 10);
//                                                 toDateTextController = DateTime(
//                                                         DateTime.now().year,
//                                                         month! + 1,
//                                                         0)
//                                                     .toString()
//                                                     .substring(0, 10);
//                                               } else {
//                                                 ///snakbar
//                                               }
//                                               controller.update();
//                                             },
//                                             child: ButtonElevated(
//                                                 width: Get.width / 4,
//                                                 text: 'month'.tr,
//                                                 backgroundColor: AppColor.brawn,
//                                                 // iconData: Icons.add,
//                                                 borderRadius: 25),
//                                           ),
//                                           Text(monthTextController != null
//                                               ? monthName(int.parse(
//                                                   monthTextController!))
//                                               : '')
//                                         ],
//                                       ),
//                                       Column(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () async {
//                                               DateTime? fromdate =
//                                                   await showDatePickerDialog(
//                                                       context: context,
//                                                       minDate:
//                                                           DateTime(1990, 1, 1),
//                                                       maxDate: DateTime(
//                                                           2100, 12, 31),
//                                                       height: Get.height / 3);
//                                               if (fromdate != null) {
//                                                 fromDateTextController =
//                                                     fromdate
//                                                         .toString()
//                                                         .substring(0, 10);
//                                               } else {
//                                                 ///snakbar
//                                               }
//                                               controller.update();
//                                             },
//                                             child: ButtonElevated(
//                                                 width: Get.width / 4,
//                                                 text: 'from'.tr,
//                                                 backgroundColor: AppColor.brawn,
//                                                 // iconData: Icons.add,
//                                                 borderRadius: 25),
//                                           ),
//                                           Text(fromDateTextController != null
//                                               ? fromDateTextController
//                                                   .toString()
//                                                   .substring(0, 10)
//                                               : '')
//                                         ],
//                                       ),
//                                       Column(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () async {
//                                               final todate =
//                                                   await showDatePickerDialog(
//                                                       context: context,
//                                                       minDate:
//                                                           DateTime(1990, 1, 1),
//                                                       maxDate: DateTime(
//                                                           2100, 12, 31),
//                                                       height: Get.height / 3);
//                                               if (todate != null) {
//                                                 toDateTextController = todate
//                                                     .toString()
//                                                     .substring(0, 10);
//                                               } else {
//                                                 ///snakbar
//                                               }
//                                               controller.update();
//                                             },
//                                             child: ButtonElevated(
//                                                 width: Get.width / 4,
//                                                 text: 'to'.tr,
//                                                 backgroundColor: AppColor.brawn,
//                                                 // iconData: Icons.add,
//                                                 borderRadius: 25),
//                                           ),
//                                           Text(toDateTextController != null
//                                               ? toDateTextController
//                                                   .toString()
//                                                   .substring(0, 10)
//                                               : '')
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   sourcePathLineList.isNotEmpty
//                                       ? requestLineList.isEmpty
//                                           ? Column(
//                                               children: [
//                                                 SizedBox(
//                                                   height: Get.height * 0.01,
//                                                 ),
//                                                 ContainerDropDownField(
//                                                   width: Get.width,
//                                                   height:
//                                                       MediaQuery.sizeOf(context)
//                                                               .height *
//                                                           0.05,
//                                                   prefixIcon: CustomIcon(
//                                                     assetPath:
//                                                         'assets/images/destination.png',
//                                                     size: Get.width * 0.05,
//                                                   ),
//                                                   hintText:
//                                                       'destination_path'.tr,
//                                                   labelText:
//                                                       'destination_path'.tr,
//                                                   value: sourcePathLineId,
//                                                   color: AppColor.black,
//                                                   // isPIN: true,
//                                                   hintcolor: AppColor.black
//                                                       .withOpacity(0.5),
//                                                   iconcolor: AppColor.black,
//                                                   fontSize: Get.width * 0.03,
//                                                   onTap: () {
//                                                     if (widget.isAdd) {
//                                                       // requests!.requestLines =
//                                                       //     [];
//                                                     }
//                                                   },
//                                                   onChanged: (val) {
//                                                     SourcePathLine
//                                                         sourcePathLine =
//                                                         sourcePathLineList.firstWhere(
//                                                             (element) =>
//                                                                 element
//                                                                     .destName ==
//                                                                 val,
//                                                             orElse: () =>
//                                                                 SourcePathLine());

//                                                     requestLineList
//                                                         .add(sourcePathLine);
//                                                     totalPrice = sourcePathLine
//                                                         .destPrice!;
//                                                     // requests!.requestLines =
//                                                     //     requestLineList;
//                                                     controller.update();

//                                                     // sourcePathLineList = jsonDecode(sourcePath);
//                                                   },
//                                                   validator: (value) {
//                                                     if (value == null) {
//                                                       errorMessage =
//                                                           'required_message'
//                                                               .trParams({
//                                                         'field_name':
//                                                             'destination_path'
//                                                                 .tr
//                                                       });
//                                                       countErrors++;
//                                                       return "";
//                                                     }
//                                                     return null;
//                                                   },
//                                                   items: sourcePathLineList
//                                                       .map(
//                                                           (e) =>
//                                                               DropdownMenuItem<
//                                                                   String>(
//                                                                 // value: e.id,
//                                                                 value:
//                                                                     e.destName,
//                                                                 child: Row(
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .center,
//                                                                   children: [
//                                                                     Expanded(
//                                                                       flex: 1,
//                                                                       child:
//                                                                           Align(
//                                                                         alignment:
//                                                                             Alignment.center,
//                                                                         child:
//                                                                             Text(
//                                                                           (e.destName)!,
//                                                                           style: TextStyle(
//                                                                               fontSize: Get.width * 0.03,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColor.black),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Expanded(
//                                                                       flex: 1,
//                                                                       child:
//                                                                           Align(
//                                                                         alignment:
//                                                                             Alignment.center,
//                                                                         child:
//                                                                             Text(
//                                                                           (e.destPrice
//                                                                               .toString()),
//                                                                           style: TextStyle(
//                                                                               fontSize: Get.width * 0.03,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColor.black),
//                                                                         ),
//                                                                       ),
//                                                                     )
//                                                                   ],
//                                                                 ),
//                                                               ))
//                                                       .toList(),
//                                                 ),
//                                               ],
//                                             )
//                                           : Container()
//                                       : Container(),
//                                   Expanded(
//                                     child: requestLineList.isNotEmpty
//                                         ? SingleChildScrollView(
//                                             child: Column(
//                                               children: [
//                                                 SizedBox(
//                                                   height: Get.height * 0.01,
//                                                 ),
//                                                 Container(
//                                                   width: Get.width,
//                                                   padding:
//                                                       const EdgeInsets.all(5),
//                                                   decoration: BoxDecoration(
//                                                       color:
//                                                           const Color.fromRGBO(
//                                                               173, 89, 31, 200),
//                                                       border: Border.all(
//                                                           color:
//                                                               AppColor.brawn),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15)),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Text("destination".tr,
//                                                               style: TextStyle(
//                                                                   fontSize:
//                                                                       Get.width *
//                                                                           0.04,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   color: AppColor
//                                                                       .brawn)),
//                                                           Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .all(8.0),
//                                                             child:
//                                                                 GestureDetector(
//                                                               onTap: () {
//                                                                 isAdd = true;
//                                                                 controller
//                                                                     .update();
//                                                               },
//                                                               child:
//                                                                   ButtonElevated(
//                                                                       width:
//                                                                           Get.width /
//                                                                               4,
//                                                                       text: 'new'
//                                                                           .tr,
//                                                                       backgroundColor:
//                                                                           AppColor
//                                                                               .brawn,
//                                                                       // iconData: Icons.add,
//                                                                       borderRadius:
//                                                                           25),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Container(
//                                                         width: Get.width,
//                                                         height:
//                                                             MediaQuery.sizeOf(
//                                                                         context)
//                                                                     .height *
//                                                                 0.05,
//                                                         decoration: BoxDecoration(
//                                                             color:
//                                                                 AppColor.brawn,
//                                                             border: Border.all(
//                                                                 color: AppColor
//                                                                     .brawn),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         15)),
//                                                         child: Row(
//                                                           children: [
//                                                             Expanded(
//                                                                 flex: 5,
//                                                                 child: Center(
//                                                                   child: Text(
//                                                                     "destination_path"
//                                                                         .tr,
//                                                                     style: TextStyle(
//                                                                         fontSize:
//                                                                             Get.width *
//                                                                                 0.03,
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .bold,
//                                                                         color: AppColor
//                                                                             .white),
//                                                                   ),
//                                                                 )),
//                                                             Expanded(
//                                                                 flex: 2,
//                                                                 child: Center(
//                                                                   child: Text(
//                                                                     "price".tr,
//                                                                     style: TextStyle(
//                                                                         fontSize:
//                                                                             Get.width *
//                                                                                 0.03,
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .bold,
//                                                                         color: AppColor
//                                                                             .white),
//                                                                   ),
//                                                                 )),
//                                                             Expanded(
//                                                                 flex: 1,
//                                                                 child:
//                                                                     Container()),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       ...requestLineList
//                                                           .map((e) => SizedBox(
//                                                                 width:
//                                                                     Get.width,
//                                                                 height: MediaQuery.sizeOf(
//                                                                             context)
//                                                                         .height *
//                                                                     0.05,
//                                                                 child: Row(
//                                                                   children: [
//                                                                     Expanded(
//                                                                         flex: 5,
//                                                                         child: Center(
//                                                                             child: Text(
//                                                                           e.destName!,
//                                                                           style: TextStyle(
//                                                                               fontSize: Get.width * 0.03,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColor.brawn),
//                                                                         ))),
//                                                                     Expanded(
//                                                                         flex: 2,
//                                                                         child:
//                                                                             Center(
//                                                                           child:
//                                                                               Text(
//                                                                             e.destPrice.toString(),
//                                                                             style: TextStyle(
//                                                                                 fontSize: Get.width * 0.03,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: AppColor.brawn),
//                                                                           ),
//                                                                         )),
//                                                                     Expanded(
//                                                                         flex: 1,
//                                                                         child: Center(
//                                                                             child: IconButton(
//                                                                                 onPressed: () {
//                                                                                   totalPrice -= e.destPrice!;
//                                                                                   requestLineList.remove(e);
//                                                                                   // requests!.requestLines = requestLineList;
//                                                                                   controller.update();
//                                                                                 },
//                                                                                 icon: const Icon(Icons.delete)))),
//                                                                   ],
//                                                                 ),
//                                                               )),
//                                                       isAdd
//                                                           ? Row(
//                                                               children: [
//                                                                 Expanded(
//                                                                   child:
//                                                                       ContainerDropDownField(
//                                                                     // width: Get.width,
//                                                                     height: MediaQuery.sizeOf(context)
//                                                                             .height *
//                                                                         0.05,
//                                                                     prefixIcon:
//                                                                         CustomIcon(
//                                                                       assetPath:
//                                                                           'assets/images/destination.png',
//                                                                       size: Get
//                                                                               .width *
//                                                                           0.05,
//                                                                     ),
//                                                                     hintText:
//                                                                         'destination_path'
//                                                                             .tr,
//                                                                     labelText:
//                                                                         'destination_path'
//                                                                             .tr,
//                                                                     value:
//                                                                         sourcePathLineId,
//                                                                     color: AppColor
//                                                                         .black,
//                                                                     // isPIN: true,
//                                                                     hintcolor: AppColor
//                                                                         .black
//                                                                         .withOpacity(
//                                                                             0.5),
//                                                                     iconcolor:
//                                                                         AppColor
//                                                                             .black,
//                                                                     fontSize:
//                                                                         Get.width *
//                                                                             0.03,
//                                                                     onChanged:
//                                                                         (val) {
//                                                                       SourcePathLine sourcePathLine = sourcePathLineList.firstWhere(
//                                                                           (element) =>
//                                                                               element.destName ==
//                                                                               val,
//                                                                           orElse: () =>
//                                                                               SourcePathLine());
//                                                                       requestLineList
//                                                                           .add(
//                                                                               sourcePathLine);
//                                                                       totalPrice +=
//                                                                           sourcePathLine
//                                                                               .destPrice!;
//                                                                       // requests!
//                                                                       //         .requestLines =
//                                                                       //     requestLineList;
//                                                                       isAdd =
//                                                                           false;
//                                                                       controller
//                                                                           .update();

//                                                                       // sourcePathLineList = jsonDecode(sourcePath);
//                                                                     },
//                                                                     validator:
//                                                                         (value) {
//                                                                       if (value ==
//                                                                           null) {
//                                                                         errorMessage =
//                                                                             'required_message'.trParams({
//                                                                           'field_name':
//                                                                               'destination_path'.tr
//                                                                         });
//                                                                         countErrors++;
//                                                                         return "";
//                                                                       }
//                                                                       return null;
//                                                                     },
//                                                                     items: sourcePathLineList
//                                                                         .map((e) => DropdownMenuItem<String>(
//                                                                               // value: e.id,
//                                                                               value: e.destName,
//                                                                               child: Row(
//                                                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                                                 children: [
//                                                                                   Expanded(
//                                                                                     flex: 1,
//                                                                                     child: Align(
//                                                                                       alignment: Alignment.center,
//                                                                                       child: Text(
//                                                                                         (e.destName)!,
//                                                                                         style: TextStyle(fontSize: Get.width * 0.03, fontWeight: FontWeight.bold, color: AppColor.black),
//                                                                                       ),
//                                                                                     ),
//                                                                                   ),
//                                                                                   Expanded(
//                                                                                     flex: 1,
//                                                                                     child: Align(
//                                                                                       alignment: Alignment.center,
//                                                                                       child: Text(
//                                                                                         (e.destPrice.toString()),
//                                                                                         style: TextStyle(fontSize: Get.width * 0.03, fontWeight: FontWeight.bold, color: AppColor.black),
//                                                                                       ),
//                                                                                     ),
//                                                                                   )
//                                                                                 ],
//                                                                               ),
//                                                                             ))
//                                                                         .toList(),
//                                                                   ),
//                                                                 ),
//                                                                 IconButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       isAdd =
//                                                                           false;
//                                                                       controller
//                                                                           .update();
//                                                                     },
//                                                                     icon: const Icon(
//                                                                         Icons
//                                                                             .cancel_sharp))
//                                                               ],
//                                                             )
//                                                           : Container()
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         : Container(),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           requestLineList.isNotEmpty
//                               ? Container(
//                                   width: Get.width,
//                                   padding: const EdgeInsets.all(5),
//                                   decoration: const BoxDecoration(
//                                       color: Color.fromRGBO(173, 89, 31, 200),
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(20),
//                                           topRight: Radius.circular(20))),
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                         children: [
//                                           Text("${'total_price'.tr} :"),
//                                           Text("$totalPrice")
//                                         ],
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: GestureDetector(
//                                           onTap: () async {
//                                             if (fromDateTextController !=
//                                                     null &&
//                                                 toDateTextController != null &&
//                                                 monthTextController != null &&
//                                                 requestLineList.isNotEmpty &&
//                                                 carTextController?.name !=
//                                                     null &&
//                                                 sourcePathTextController
//                                                         ?.sourcePathName !=
//                                                     null) {
//                                               if (toDateTextController!
//                                                           .substring(5, 7) ==
//                                                       monthTextController &&
//                                                   fromDateTextController!
//                                                           .substring(5, 7) ==
//                                                       monthTextController) {
//                                                 requests = Requests(
//                                                     state: RequestState.draft,
//                                                     amoutTotal: totalPrice,
//                                                     driverId:
//                                                         SharedPr.userObj!.id,
//                                                     car: carTextController,
//                                                     sourcePathId:
//                                                         sourcePathTextController!
//                                                             .sourcePathId,
//                                                     fromDate:
//                                                         fromDateTextController,
//                                                     requestLines:
//                                                         requestLineList,
//                                                     toDate:
//                                                         toDateTextController,
//                                                     monthName:
//                                                         monthTextController,
//                                                     sourcePathName:
//                                                         sourcePathTextController!
//                                                             .sourcePathName);
//                                                 ResponseResult result;
//                                                 // print(requests!.toJson());
//                                                 if (widget.isAdd) {
//                                                   result = await controller
//                                                       .createRequest(
//                                                           Requests: requests!);
//                                                 } else {
//                                                   requests!.id =
//                                                       widget.objectToEdit!.id;
//                                                   result = await controller
//                                                       .updateRequest(
//                                                           Requests: requests!);
//                                                 }

//                                                 if (result.status) {
//                                                   await requestController
//                                                       .requestData();
//                                                   widget.isAdd
//                                                       ? Get.offAll(() =>
//                                                           const RequestListScreen())
//                                                       : Get.off(() =>
//                                                           DetailsRequestScreen(
//                                                             item: requests!,
//                                                           ));

//                                                   appSnackBar(
//                                                       messageType:
//                                                           MessageTypes.success,
//                                                       message: 'Successful'.tr);
//                                                 } else {
//                                                   appSnackBar(
//                                                       message: result.message);
//                                                 }
//                                               } else {
//                                                 appSnackBar(
//                                                     message:
//                                                         'date_match_error'.tr);
//                                               }
//                                             } else {
//                                               appSnackBar(
//                                                   message:
//                                                       'enter_required_info'.tr);
//                                             }
//                                           },
//                                           child: ButtonElevated(
//                                               width: Get.width,
//                                               text: 'save'.tr,
//                                               backgroundColor: AppColor.brawn,
//                                               // iconData: Icons.add,
//                                               borderRadius: 25),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               : Container(),
//                         ],
//                       )),
//                 )
//               ],
//             ),
//           );
//         })),
//       ),
//     );
//   }

//   Future _selectMonth() async {
//     final monthselcted = await showDialog<int>(
//       context: context,
//       builder: (BuildContext context) => MonthPickerDialog(
//         initialMonth: month ?? DateTime.now().month,
//       ),
//     );
//     return monthselcted;
//   }
// }

class AddEditRequestScreen2 extends StatefulWidget {
  Requests? objectToEdit;
  bool isAdd;
  AddEditRequestScreen2({super.key, this.objectToEdit, this.isAdd = true});
  @override
  State<AddEditRequestScreen2> createState() => _AddEditRequestScreen2State();
}

class _AddEditRequestScreen2State extends State<AddEditRequestScreen2> {
  final _formKey = GlobalKey<FormState>();
  late final CarController carController;
  late final SourcePathController sourcePathController;
  late final RequestController requestController;
  final TextEditingController nameController = TextEditingController(),
      barcodeController = TextEditingController(),
      unitPriceController = TextEditingController();
  List<SourcePathLine> sourcePathLineList = [];
  List<SourcePathLine> requestLineList = [];
  List<SourcePath> sourcePathList = [];
  final FocusNode nameFocusNode = FocusNode();
  String? carid, sourcePathId, sourcePathLineId;
  Requests? requests;
  String? errorMessage;
  int countErrors = 0;
  int pagesNumber = 0;
  bool isAdd = false;
  double totalPrice = 0.0;
  String? monthTextController;
  int? month;
  String? _firstValue;
  String? _secondValue;
  String? fromDateTextController, toDateTextController;
  Car? carTextController;
  SourcePath? sourcePathTextController;
  // List<ProductUnit> productUnitList = [];
  back() async {
    // requestController.object = null;
    // requestController.updateHideMenu(false);
    // productController.update();
    // await loadingDataController.getitems();
  }

  @override
  void initState() {
    super.initState();
    carController = Get.put(CarController());
    sourcePathController = Get.put(SourcePathController());
    getData();
    // requests!.car = carController.carList.first;
    requestController = Get.put(RequestController());

    // requestController.carData();
    requests = widget.objectToEdit;
    // if (product?.id != null) {
    // nameController.text = product!.productName!;
    // nameController.text = (SharedPr.lang == 'ar'
    //     ? product!.productName!.ar001
    //     : product!.productName!.enUS)!;
    // barcodeController.text = product!.barcode ?? '';
    // unitPriceController.text = product!.unitPrice!.toString();
    // }

    requests ??= Requests();
  }

  getData() async {
    await carController.carData();
    await sourcePathController.SourcePathData();

    if (!widget.isAdd) {
      // carid = carController.carList
      //     .firstWhere((e) => e.id == widget.objectToEdit!.car!.id)
      //     .name;
      // sourcePathList = sourcePathController.sourcePathList
      //     .where((e) => e.car!.id == widget.objectToEdit!.car!.id)
      //     .toList();
      // sourcePathId = widget.objectToEdit!.sourcePathName;
      requestLineList.addAll(widget.objectToEdit!.requestLines!);
      // SourcePath sourcePath = sourcePathController.sourcePathList.firstWhere(
      //     (element) => element.sourcePathName == sourcePathId,
      //     orElse: () => SourcePath());
      // sourcePathLineList = sourcePath.lins!;
      carTextController = Car(
          id: widget.objectToEdit!.car!.id,
          name: widget.objectToEdit!.car!.name);
      sourcePathTextController = SourcePath(
          sourcePathId: widget.objectToEdit!.sourcePathId,
          sourcePathName: widget.objectToEdit!.sourcePathName);
      fromDateTextController = widget.objectToEdit!.fromDate;
      toDateTextController = widget.objectToEdit!.toDate;
      monthTextController = int.parse(widget.objectToEdit!.monthName!) < 10
          ? '0${int.parse(widget.objectToEdit!.monthName!)}'
          : widget.objectToEdit!.monthName;
      totalPrice = widget.objectToEdit!.amoutTotal!;

      sourcePathLineList = SharedPr.userObj!.sourcePath!.lins!;
    } else {
      sourcePathLineList = SharedPr.userObj!.sourcePath!.lins!;
      carTextController = Car(
          id: SharedPr.userObj!.sourcePath!.car!.id!,
          name: SharedPr.userObj!.sourcePath!.car!.name!);
      sourcePathTextController = SourcePath(
          sourcePathId: SharedPr.userObj!.sourcePath!.sourcePathId,
          sourcePathName: SharedPr.userObj!.sourcePath!.sourcePathName);
    }
    requestController.update();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFfafafa),
        appBar: customAppBar(headerBackground: true, userOpstionShow: true),
        body: GetBuilder<RequestController>(builder: (controller) {
          return Container(
            child: Column(
              children: [
                CustomBack(
                  height: MediaQuery.of(context).size.height * 0.12,
                  color: const Color(0XFF3967d7),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: IconButton(
                                onPressed: () {
                                  widget.isAdd
                                      ? Get.offAll(
                                          () => const RequestListScreen2())
                                      : Get.back();
                                },
                                icon: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: AppColor.white,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.arrow_back_ios_new_outlined,
                                      color: const Color(0XFF3967d7),
                                      size: Get.width * 0.05,
                                    ))),
                          ),
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Text(
                                widget.isAdd
                                    ? "add_new_requst".tr
                                    : "edit_requst".tr,
                                style: TextStyle(
                                    fontSize: Get.width * 0.05,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.white),
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container())
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            SharedPr.userObj!.sourcePath!.sourcePathName!,
                            style: TextStyle(
                                color: AppColor.white,
                                fontSize: Get.width * 0.03),
                          ),
                          Text(
                            SharedPr.userObj!.sourcePath!.car!.name!,
                            style: TextStyle(
                                color: AppColor.white,
                                fontSize: Get.width * 0.03),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     Get.back();
                //   },
                //   child: Text("ssssssssss"),
                // ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Expanded(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  // ContainerDropDownField(
                                  //   width: Get.width,
                                  //   height: MediaQuery.sizeOf(context).height *
                                  //       0.05,
                                  //   onTap: () {
                                  //     if (widget.isAdd) {
                                  //       sourcePathTextController = null;
                                  //     }
                                  //     sourcePathId = null;
                                  //     carid = null;
                                  //     sourcePathList = [];
                                  //     requestLineList = [];

                                  //     sourcePathLineList = [];
                                  //     controller.update();
                                  //   },
                                  //   prefixIcon: CustomIcon(
                                  //     assetPath:
                                  //         'assets/images/delivery-truck.png',
                                  //     size: Get.width * 0.05,
                                  //   ),
                                  //   hintText: 'car_name'.tr,
                                  //   labelText: 'car_name'.tr,
                                  //   value: carid,
                                  //   color: AppColor.black,
                                  //   // isPIN: true,
                                  //   hintcolor: AppColor.black.withOpacity(0.5),
                                  //   iconcolor: AppColor.black,
                                  //   fontSize: Get.width * 0.03,
                                  //   onChanged: (val) {
                                  //     Car car = carController.carList
                                  //         .firstWhere(
                                  //             (element) => element.name == val,
                                  //             orElse: () => Car());
                                  //     sourcePathList = sourcePathController
                                  //         .sourcePathList
                                  //         .where((e) => e.car!.id == car.id)
                                  //         .toList();

                                  //     if (sourcePathList.isNotEmpty) {
                                  //       carid = val;
                                  //     } else {
                                  //       //snakbar
                                  //     }
                                  //     carTextController = car;
                                  //     // requests!.car = car;
                                  //     controller.update();
                                  //   },
                                  //   validator: (value) {
                                  //     if (value == null) {
                                  //       errorMessage = 'required_message'
                                  //           .trParams(
                                  //               {'field_name': 'car_name'.tr});
                                  //       countErrors++;
                                  //       return "";
                                  //     }
                                  //     return null;
                                  //   },
                                  //   items: carController.carList
                                  //       .map((e) => DropdownMenuItem<String>(
                                  //             // value: e.id,
                                  //             value: e.name,
                                  //             child: Center(
                                  //                 child: Text(
                                  //               (e.name)!,
                                  //               style: TextStyle(
                                  //                   fontSize: Get.width * 0.03,
                                  //                   fontWeight: FontWeight.bold,
                                  //                   color: AppColor.black),
                                  //             )),
                                  //           ))
                                  //       .toList(),
                                  // ),
                                  // SizedBox(
                                  //   height: Get.height * 0.02,
                                  // ),
                                  // carid != null
                                  //     ? ContainerDropDownField(
                                  //         width: Get.width,
                                  //         height: MediaQuery.sizeOf(context)
                                  //                 .height *
                                  //             0.05,
                                  //         prefixIcon: CustomIcon(
                                  //           assetPath:
                                  //               'assets/images/destination.png',
                                  //           size: Get.width * 0.05,
                                  //         ),
                                  //         hintText: 'source_path'.tr,
                                  //         labelText: 'source_path'.tr,
                                  //         value: sourcePathId,
                                  //         color: AppColor.black,
                                  //         // isPIN: true,
                                  //         hintcolor:
                                  //             AppColor.black.withOpacity(0.5),
                                  //         iconcolor: AppColor.black,
                                  //         fontSize: Get.width * 0.03,
                                  //         onTap: () {
                                  //           sourcePathId = null;
                                  //           sourcePathLineList = [];
                                  //           requestLineList = [];
                                  //           if (isAdd) {
                                  //             sourcePathTextController = null;
                                  //           }

                                  //           controller.update();
                                  //         },
                                  //         onChanged: (val) {
                                  //           sourcePathId = val;
                                  //           SourcePath sourcePath =
                                  //               sourcePathController
                                  //                   .sourcePathList
                                  //                   .firstWhere(
                                  //                       (element) =>
                                  //                           element
                                  //                               .sourcePathName ==
                                  //                           val,
                                  //                       orElse: () =>
                                  //                           SourcePath());

                                  //           if (sourcePath.lins!.isNotEmpty) {
                                  //             sourcePathLineList =
                                  //                 sourcePath.lins!;
                                  //           } else {
                                  //             sourcePathLineList =
                                  //                 sourcePath.lins!;
                                  //             //snake bar
                                  //           }
                                  //           sourcePathTextController =
                                  //               sourcePath;
                                  //           // requests!.sourcePathId =
                                  //           //     sourcePath.sourcePathId;
                                  //           // requests!.sourcePathName =
                                  //           //     sourcePath.sourcePathName;
                                  //           controller.update();
                                  //           // sourcePathLineList = jsonDecode(sourcePath);
                                  //         },
                                  //         validator: (value) {
                                  //           if (value == null) {
                                  //             errorMessage = 'required_message'
                                  //                 .trParams({
                                  //               'field_name': 'source_path'.tr
                                  //             });
                                  //             countErrors++;
                                  //             return "";
                                  //           }
                                  //           return null;
                                  //         },
                                  //         items: sourcePathList.map((e) {
                                  //           return DropdownMenuItem<String>(
                                  //             // value: e.id,
                                  //             value: e.sourcePathName,
                                  //             child: Center(
                                  //                 child: Text(
                                  //               (e.sourcePathName)!,
                                  //               style: TextStyle(
                                  //                   fontSize: Get.width * 0.03,
                                  //                   fontWeight: FontWeight.bold,
                                  //                   color: AppColor.black),
                                  //             )),
                                  //           );
                                  //         }).toList(),
                                  //       )
                                  //     : Container(),
                                  // SizedBox(
                                  //   height: Get.height * 0.02,
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(flex: 1, child: Container()),
                                      Expanded(flex: 2, child: Container()),
                                      Expanded(
                                        flex: 1,
                                        child: Obx(() {
                                          if (controller.loading.value) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: AppColor.white,
                                                backgroundColor: AppColor.black,
                                              ),
                                            );
                                          } else {
                                            return GestureDetector(
                                                onTap: () async {
                                                  controller.loading.value =
                                                      true;
                                                  controller.update();
                                                  LoadingDataController
                                                      loadingDataController =
                                                      Get.put(
                                                          LoadingDataController(
                                                              fromReportsScreen:
                                                                  true));
                                                  await loadingDataController
                                                      .loadData();
                                                  requestLineList = [];
                                                  sourcePathLineList = SharedPr
                                                      .userObj!
                                                      .sourcePath!
                                                      .lins!;
                                                  carTextController = Car(
                                                      id: SharedPr.userObj!
                                                          .sourcePath!.car!.id!,
                                                      name: SharedPr
                                                          .userObj!
                                                          .sourcePath!
                                                          .car!
                                                          .name!);
                                                  sourcePathTextController =
                                                      SourcePath(
                                                          sourcePathId: SharedPr
                                                              .userObj!
                                                              .sourcePath!
                                                              .sourcePathId,
                                                          sourcePathName: SharedPr
                                                              .userObj!
                                                              .sourcePath!
                                                              .sourcePathName);
                                                  controller.loading.value =
                                                      false;
                                                  // isAdd = true;
                                                  controller.update();
                                                },
                                                child: Container(
                                                    // width: Get.width * 0.25,
                                                    height: Get.height * 0.035,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              blurRadius: 100,
                                                              color: AppColor
                                                                  .backgroundTable,
                                                              offset:
                                                                  const Offset(
                                                                      2, 2))
                                                        ],
                                                        color: const Color(
                                                                0XFF3967d7)
                                                            .withOpacity(0.1)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Center(
                                                            child: Text(
                                                          'refresh'.tr,
                                                          style: TextStyle(
                                                              color:
                                                                  // Color(0XFF3967d7),
                                                                  AppColor
                                                                      .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize:
                                                                  Get.width *
                                                                      0.03),
                                                        )),
                                                        Icon(
                                                          Icons.refresh,
                                                          size:
                                                              Get.width * 0.05,
                                                        )
                                                      ],
                                                    )));
                                          }
                                        }),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: GestureDetector(
                                            onTap: () async {
                                              // final date =
                                              //     await showDatePickerDialog(
                                              //   context: context,
                                              //   minDate: DateTime(1990, 1, 1),
                                              //   maxDate: DateTime(2100, 12, 31),
                                              //   height: Get.height / 3,
                                              //   initialPickerType:
                                              //       PickerType.months,
                                              // );
                                              month = await _selectMonth();
                                              if (month != null) {
                                                var isFind = controller
                                                    .requestList
                                                    .any((e) =>
                                                        e.fromDate ==
                                                        DateTime(
                                                                DateTime.now()
                                                                    .year,
                                                                month!,
                                                                1)
                                                            .toString()
                                                            .substring(0, 10));
                                                // var ss = controller.requestList
                                                //     .firstWhere((e) =>
                                                //         e.fromDate ==
                                                //         DateTime(
                                                //                 DateTime.now()
                                                //                     .year,
                                                //                 month!,
                                                //                 1)
                                                //             .toString()
                                                //             .substring(0, 10));
                                                // print(ss.fromDate);
                                                if (isFind) {
                                                  ///snakbar
                                                  appSnackBar(
                                                      message:
                                                          'period_valdation'
                                                              .tr);
                                                } else {
                                                  if (month! < 10) {
                                                    monthTextController =
                                                        '0$month';
                                                  } else {
                                                    monthTextController =
                                                        month.toString();
                                                  }
                                                  fromDateTextController =
                                                      DateTime(
                                                              DateTime.now()
                                                                  .year,
                                                              month!,
                                                              1)
                                                          .toString()
                                                          .substring(0, 10);
                                                  toDateTextController =
                                                      DateTime(
                                                              DateTime.now()
                                                                  .year,
                                                              month! + 1,
                                                              0)
                                                          .toString()
                                                          .substring(0, 10);
                                                }
                                              } else {
                                                ///snakbar

                                                appSnackBar(
                                                    message:
                                                        'required_message_f'
                                                            .trParams({
                                                  'field_name': 'period'.tr
                                                }));
                                              }
                                              controller.update();
                                            },
                                            child: Container(
                                              height: Get.height * 0.05,
                                              // width: Get.width * 0.89,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 100,
                                                        color: AppColor
                                                            .backgroundTable,
                                                        offset:
                                                            const Offset(2, 2))
                                                  ],
                                                  color: const Color(0xffc3c3c6)
                                                      .withOpacity(0.5)),
                                              child: Row(
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment.,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: AppColor.white,
                                                    ),
                                                    child: Icon(
                                                        Icons
                                                            .date_range_outlined,
                                                        color: AppColor.black
                                                            .withOpacity(0.5),
                                                        size:
                                                            Get.height * 0.02),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '${'period'.tr} : ',
                                                            style: TextStyle(
                                                                color: AppColor
                                                                    .black,
                                                                // fontWeight:
                                                                //     FontWeight
                                                                //         .bold,
                                                                fontSize:
                                                                    Get.width *
                                                                        0.03),
                                                          ),
                                                          monthTextController !=
                                                                  null
                                                              ? Text(
                                                                  monthTextController !=
                                                                          null
                                                                      ? monthName(
                                                                          int.parse(
                                                                              monthTextController!))
                                                                      : '',
                                                                  style: TextStyle(
                                                                      color: AppColor.black,
                                                                      // fontWeight:
                                                                      //     FontWeight
                                                                      //         .bold,
                                                                      fontSize: Get.width * 0.03),
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: GestureDetector(
                                      //       onTap: () async {
                                      //         // final date =
                                      //         //     await showDatePickerDialog(
                                      //         //   context: context,
                                      //         //   minDate: DateTime(1990, 1, 1),
                                      //         //   maxDate: DateTime(2100, 12, 31),
                                      //         //   height: Get.height / 3,
                                      //         //   initialPickerType:
                                      //         //       PickerType.months,
                                      //         // );
                                      //         month = await _selectMonth();
                                      //         if (month != null) {
                                      //           if (month! < 10) {
                                      //             monthTextController =
                                      //                 '0${month}';
                                      //           } else {
                                      //             monthTextController =
                                      //                 month.toString();
                                      //           }
                                      //           fromDateTextController =
                                      //               DateTime(
                                      //                       DateTime.now().year,
                                      //                       month!,
                                      //                       1)
                                      //                   .toString()
                                      //                   .substring(0, 10);
                                      //           toDateTextController = DateTime(
                                      //                   DateTime.now().year,
                                      //                   month! + 1,
                                      //                   0)
                                      //               .toString()
                                      //               .substring(0, 10);
                                      //         } else {
                                      //           ///snakbar
                                      //         }
                                      //         controller.update();
                                      //       },
                                      //       child: Container(
                                      //         height: Get.height * 0.1,
                                      //         padding: EdgeInsets.all(8),
                                      //         decoration: BoxDecoration(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(10),
                                      //             boxShadow: [
                                      //               BoxShadow(
                                      //                   blurRadius: 100,
                                      //                   color: AppColor
                                      //                       .backgroundTable,
                                      //                   offset: Offset(2, 2))
                                      //             ],
                                      //             color: Color(0xffc3c3c6)
                                      //                 .withOpacity(0.5)),
                                      //         child: Column(
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment.center,
                                      //           children: [
                                      //             Container(
                                      //               padding:
                                      //                   const EdgeInsets.all(
                                      //                       6.0),
                                      //               decoration: BoxDecoration(
                                      //                   color: AppColor.white,
                                      //                   shape: BoxShape.circle),
                                      //               child: Icon(
                                      //                   Icons
                                      //                       .date_range_outlined,
                                      //                   color: AppColor.black
                                      //                       .withOpacity(0.5),
                                      //                   size: Get.width * 0.05),
                                      //             ),
                                      //             Center(
                                      //                 child: Text(
                                      //               'month'.tr,
                                      //               style: TextStyle(
                                      //                   color: AppColor.black,
                                      //                   fontWeight:
                                      //                       FontWeight.bold,
                                      //                   fontSize:
                                      //                       Get.width * 0.03),
                                      //             )),
                                      //             monthTextController != null
                                      //                 ? Text(
                                      //                     monthTextController !=
                                      //                             null
                                      //                         ? monthName(int.parse(
                                      //                             monthTextController!))
                                      //                         : '',
                                      //                     style: TextStyle(
                                      //                         color: AppColor
                                      //                             .black,
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .bold,
                                      //                         fontSize:
                                      //                             Get.width *
                                      //                                 0.03),
                                      //                   )
                                      //                 : Container()
                                      //           ],
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: GestureDetector(
                                      //       onTap: () async {
                                      //         DateTime? fromdate =
                                      //             await showDatePickerDialog(
                                      //                 context: context,
                                      //                 minDate:
                                      //                     DateTime(1990, 1, 1),
                                      //                 maxDate: DateTime(
                                      //                     2100, 12, 31),
                                      //                 height: Get.height / 3);
                                      //         if (fromdate != null) {
                                      //           fromDateTextController =
                                      //               fromdate
                                      //                   .toString()
                                      //                   .substring(0, 10);
                                      //         } else {
                                      //           ///snakbar
                                      //         }
                                      //         controller.update();
                                      //       },
                                      //       child: Container(
                                      //         height: Get.height * 0.1,
                                      //         padding: EdgeInsets.all(8),
                                      //         decoration: BoxDecoration(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(10),
                                      //             boxShadow: [
                                      //               BoxShadow(
                                      //                   blurRadius: 100,
                                      //                   color: AppColor
                                      //                       .backgroundTable,
                                      //                   offset: Offset(2, 2))
                                      //             ],
                                      //             color: Color(0xffc3c3c6)
                                      //                 .withOpacity(0.5)),
                                      //         child: Column(
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment.center,
                                      //           children: [
                                      //             Container(
                                      //               padding:
                                      //                   const EdgeInsets.all(
                                      //                       6.0),
                                      //               decoration: BoxDecoration(
                                      //                   color: AppColor.white,
                                      //                   shape: BoxShape.circle),
                                      //               child: Icon(
                                      //                   Icons
                                      //                       .date_range_outlined,
                                      //                   color: AppColor.black
                                      //                       .withOpacity(0.5),
                                      //                   size: Get.width * 0.05),
                                      //             ),
                                      //             Center(
                                      //                 child: Text(
                                      //               'from'.tr,
                                      //               style: TextStyle(
                                      //                   color: AppColor.black,
                                      //                   fontWeight:
                                      //                       FontWeight.bold,
                                      //                   fontSize:
                                      //                       Get.width * 0.03),
                                      //             )),
                                      //             fromDateTextController != null
                                      //                 ? Text(
                                      //                     fromDateTextController !=
                                      //                             null
                                      //                         ? fromDateTextController
                                      //                             .toString()
                                      //                             .substring(
                                      //                                 0, 10)
                                      //                         : '',
                                      //                     style: TextStyle(
                                      //                         color: AppColor
                                      //                             .black,
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .bold,
                                      //                         fontSize:
                                      //                             Get.width *
                                      //                                 0.03),
                                      //                   )
                                      //                 : Container()
                                      //           ],
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: GestureDetector(
                                      //       onTap: () async {
                                      //         final todate =
                                      //             await showDatePickerDialog(
                                      //                 context: context,
                                      //                 minDate:
                                      //                     DateTime(1990, 1, 1),
                                      //                 maxDate: DateTime(
                                      //                     2100, 12, 31),
                                      //                 height: Get.height / 3);
                                      //         if (todate != null) {
                                      //           toDateTextController = todate
                                      //               .toString()
                                      //               .substring(0, 10);
                                      //         } else {
                                      //           ///snakbar
                                      //         }
                                      //         controller.update();
                                      //       },
                                      //       child: Container(
                                      //         height: Get.height * 0.1,
                                      //         padding: EdgeInsets.all(8),
                                      //         decoration: BoxDecoration(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(10),
                                      //             boxShadow: [
                                      //               BoxShadow(
                                      //                   blurRadius: 100,
                                      //                   color: AppColor
                                      //                       .backgroundTable,
                                      //                   offset: Offset(2, 2))
                                      //             ],
                                      //             color: Color(0xffc3c3c6)
                                      //                 .withOpacity(0.5)),
                                      //         child: Column(
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment.center,
                                      //           children: [
                                      //             Container(
                                      //               padding:
                                      //                   const EdgeInsets.all(
                                      //                       6.0),
                                      //               decoration: BoxDecoration(
                                      //                   color: AppColor.white,
                                      //                   shape: BoxShape.circle),
                                      //               child: Icon(
                                      //                   Icons
                                      //                       .date_range_outlined,
                                      //                   color: AppColor.black
                                      //                       .withOpacity(0.5),
                                      //                   size: Get.width * 0.05),
                                      //             ),
                                      //             Center(
                                      //                 child: Text(
                                      //               'to'.tr,
                                      //               style: TextStyle(
                                      //                   color: AppColor.black,
                                      //                   fontWeight:
                                      //                       FontWeight.bold,
                                      //                   fontSize:
                                      //                       Get.width * 0.03),
                                      //             )),
                                      //             toDateTextController != null
                                      //                 ? Text(
                                      //                     toDateTextController !=
                                      //                             null
                                      //                         ? toDateTextController
                                      //                             .toString()
                                      //                             .substring(
                                      //                                 0, 10)
                                      //                         : '',
                                      //                     style: TextStyle(
                                      //                         color: AppColor
                                      //                             .black,
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .bold,
                                      //                         fontSize:
                                      //                             Get.width *
                                      //                                 0.03),
                                      //                   )
                                      //                 : Container()
                                      //           ],
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  sourcePathLineList.isNotEmpty
                                      ? requestLineList.isEmpty
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                ContainerDropDownField(
                                                  width: Get.width,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.05,
                                                  prefixIcon: CustomIcon(
                                                    assetPath:
                                                        'assets/images/destination.png',
                                                    size: Get.width * 0.05,
                                                  ),
                                                  hintText:
                                                      'destination_path'.tr,
                                                  labelText:
                                                      'destination_path'.tr,
                                                  value: sourcePathLineId,
                                                  color: AppColor.black,
                                                  // isPIN: true,
                                                  hintcolor: AppColor.black
                                                      .withOpacity(0.5),
                                                  iconcolor: AppColor.black,
                                                  fontSize: Get.width * 0.03,
                                                  onTap: () {
                                                    if (widget.isAdd) {
                                                      // requests!.requestLines =
                                                      //     [];
                                                    }
                                                  },
                                                  onChanged: (val) {
                                                    SourcePathLine
                                                        sourcePathLine =
                                                        sourcePathLineList.firstWhere(
                                                            (element) =>
                                                                element
                                                                    .destName ==
                                                                val,
                                                            orElse: () =>
                                                                SourcePathLine());
                                                    sourcePathLine.quantity = 1;
                                                    sourcePathLine
                                                            .destTotalPrice =
                                                        sourcePathLine
                                                                .quantity! *
                                                            sourcePathLine
                                                                .destPrice!;
                                                    requestLineList
                                                        .add(sourcePathLine);
                                                    totalPrice = sourcePathLine
                                                        .destPrice!;
                                                    // requests!.requestLines =
                                                    //     requestLineList;
                                                    controller.update();

                                                    // sourcePathLineList = jsonDecode(sourcePath);
                                                  },
                                                  validator: (value) {
                                                    if (value == null) {
                                                      errorMessage =
                                                          'required_message'
                                                              .trParams({
                                                        'field_name':
                                                            'destination_path'
                                                                .tr
                                                      });
                                                      countErrors++;
                                                      return "";
                                                    }
                                                    return null;
                                                  },
                                                  items: sourcePathLineList
                                                      .map(
                                                          (e) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                // value: e.id,
                                                                value:
                                                                    e.destName,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          (e.destName)!,
                                                                          style: TextStyle(
                                                                              fontSize: Get.width * 0.03,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: AppColor.black),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          (e.destPrice
                                                                              .toString()),
                                                                          style: TextStyle(
                                                                              fontSize: Get.width * 0.03,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: AppColor.black),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ))
                                                      .toList(),
                                                ),
                                              ],
                                            )
                                          : Container()
                                      : Container(),
                                  Expanded(
                                    child: requestLineList.isNotEmpty
                                        ? SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: Get.height * 0.001,
                                                ),
                                                Container(
                                                  width: Get.width,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  // decoration: BoxDecoration(
                                                  //     color:
                                                  //         const Color.fromRGBO(
                                                  //             173, 89, 31, 200),
                                                  //     border: Border.all(
                                                  //         color:
                                                  //             AppColor.brawn),
                                                  //     borderRadius:
                                                  //         BorderRadius.circular(
                                                  //             15)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("destination".tr,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Get.width *
                                                                          0.04,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: const Color(
                                                                      0XFF3967d7))),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  isAdd = true;
                                                                  controller
                                                                      .update();
                                                                },
                                                                child: Container(
                                                                    width: Get.width * 0.2,
                                                                    height: Get.height * 0.03,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              blurRadius: 100,
                                                                              color: AppColor.backgroundTable,
                                                                              offset: const Offset(2, 2))
                                                                        ],
                                                                        color: const Color(0XFF3967d7).withOpacity(0.1)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      'new'.tr,
                                                                      style: TextStyle(
                                                                          color: AppColor.black,
                                                                          // fontWeight: FontWeight.w600,
                                                                          fontSize: Get.width * 0.04),
                                                                    ))),
                                                              )),
                                                        ],
                                                      ),
                                                      // Container(
                                                      //   width: Get.width,
                                                      //   height:
                                                      //       MediaQuery.sizeOf(
                                                      //                   context)
                                                      //               .height *
                                                      //           0.05,
                                                      //   decoration:
                                                      //       BoxDecoration(
                                                      //     color: Color(
                                                      //             0XFF3967d7)
                                                      //         .withOpacity(0.1),
                                                      //     // borderRadius:
                                                      //     //     BorderRadius
                                                      //     //         .circular(
                                                      //     //             10)
                                                      //   ),
                                                      //   child: Row(
                                                      //     children: [
                                                      //       Expanded(
                                                      //           flex: 5,
                                                      //           child: Center(
                                                      //             child: Text(
                                                      //               "destination_path"
                                                      //                   .tr,
                                                      //               style: TextStyle(
                                                      //                   fontSize:
                                                      //                       Get.width *
                                                      //                           0.03,
                                                      //                   fontWeight:
                                                      //                       FontWeight
                                                      //                           .bold,
                                                      //                   color: Color(
                                                      //                       0XFF3967d7)),
                                                      //             ),
                                                      //           )),
                                                      //       Expanded(
                                                      //           flex: 2,
                                                      //           child: Center(
                                                      //             child: Text(
                                                      //               "price".tr,
                                                      //               style: TextStyle(
                                                      //                   fontSize:
                                                      //                       Get.width *
                                                      //                           0.03,
                                                      //                   fontWeight:
                                                      //                       FontWeight
                                                      //                           .bold,
                                                      //                   color: Color(
                                                      //                       0XFF3967d7)),
                                                      //             ),
                                                      //           )),
                                                      //       Expanded(
                                                      //           flex: 1,
                                                      //           child:
                                                      //               Container()),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      isAdd
                                                          ? Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      ContainerDropDownField(
                                                                    // width: Get.width,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.05,
                                                                    prefixIcon:
                                                                        CustomIcon(
                                                                      assetPath:
                                                                          'assets/images/destination.png',
                                                                      size: Get
                                                                              .width *
                                                                          0.05,
                                                                    ),
                                                                    hintText:
                                                                        'destination_path'
                                                                            .tr,
                                                                    labelText:
                                                                        'destination_path'
                                                                            .tr,
                                                                    value:
                                                                        sourcePathLineId,
                                                                    color: AppColor
                                                                        .black,
                                                                    // isPIN: true,
                                                                    hintcolor: AppColor
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5),
                                                                    iconcolor:
                                                                        AppColor
                                                                            .black,
                                                                    fontSize:
                                                                        Get.width *
                                                                            0.03,
                                                                    onChanged:
                                                                        (val) {
                                                                      SourcePathLine sourcePathLine = sourcePathLineList.firstWhere(
                                                                          (element) =>
                                                                              element.destName ==
                                                                              val,
                                                                          orElse: () =>
                                                                              SourcePathLine());

                                                                      var isAdded =
                                                                          requestLineList
                                                                              .any(
                                                                        (e) =>
                                                                            e.destName ==
                                                                            sourcePathLine.destName,
                                                                      );

                                                                      if (isAdded) {
                                                                        var index = requestLineList.indexWhere((e) =>
                                                                            e.destId ==
                                                                            sourcePathLine.destId);

                                                                        sourcePathLine
                                                                            .quantity = requestLineList[index]
                                                                                .quantity! +
                                                                            1;
                                                                        sourcePathLine
                                                                            .destTotalPrice = sourcePathLine
                                                                                .quantity! *
                                                                            sourcePathLine.destPrice!;
                                                                        requestLineList
                                                                            .remove(requestLineList[index]);
                                                                        requestLineList
                                                                            .add(sourcePathLine);
                                                                      } else {
                                                                        sourcePathLine
                                                                            .quantity = 1;
                                                                        sourcePathLine
                                                                            .destTotalPrice = sourcePathLine
                                                                                .quantity! *
                                                                            sourcePathLine.destPrice!;
                                                                        requestLineList
                                                                            .add(sourcePathLine);
                                                                      }
                                                                      print(
                                                                          'sourcePathLine.destTotalPrice ${sourcePathLine.destTotalPrice}');
                                                                      totalPrice +=
                                                                          sourcePathLine
                                                                              .destPrice!;
                                                                      // requests!
                                                                      //         .requestLines =
                                                                      //     requestLineList;
                                                                      isAdd =
                                                                          false;
                                                                      controller
                                                                          .update();

                                                                      // sourcePathLineList = jsonDecode(sourcePath);
                                                                    },
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                          null) {
                                                                        errorMessage =
                                                                            'required_message'.trParams({
                                                                          'field_name':
                                                                              'destination_path'.tr
                                                                        });
                                                                        countErrors++;
                                                                        return "";
                                                                      }
                                                                      return null;
                                                                    },
                                                                    items: sourcePathLineList
                                                                        .map((e) => DropdownMenuItem<String>(
                                                                              // value: e.id,
                                                                              value: e.destName,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: Align(
                                                                                      alignment: Alignment.center,
                                                                                      child: Text(
                                                                                        (e.destName)!,
                                                                                        style: TextStyle(fontSize: Get.width * 0.03, fontWeight: FontWeight.bold, color: AppColor.black),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: Align(
                                                                                      alignment: Alignment.center,
                                                                                      child: Text(
                                                                                        (e.destPrice.toString()),
                                                                                        style: TextStyle(fontSize: Get.width * 0.03, fontWeight: FontWeight.bold, color: AppColor.black),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ))
                                                                        .toList(),
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      isAdd =
                                                                          false;
                                                                      controller
                                                                          .update();
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .cancel_sharp))
                                                              ],
                                                            )
                                                          : Container(),
                                                      ...requestLineList
                                                          .map((e) => Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      e.quantity =
                                                                          e.quantity! +
                                                                              1;
                                                                      e.destTotalPrice =
                                                                          e.quantity! *
                                                                              e.destPrice!;
                                                                      totalPrice +=
                                                                          e.destPrice!;
                                                                      controller
                                                                          .update();
                                                                    },
                                                                    child:
                                                                        SourcePathLineContainer(
                                                                      e: e,
                                                                      isAddOrEdit:
                                                                          true,
                                                                      onPressed:
                                                                          () {
                                                                        totalPrice -=
                                                                            e.destTotalPrice!;
                                                                        requestLineList
                                                                            .remove(e);
                                                                        // requests!.requestLines = requestLineList;
                                                                        controller
                                                                            .update();
                                                                      },
                                                                    )),
                                                              )),
                                                      // ...requestLineList
                                                      //     .map((e) => SizedBox(
                                                      //           width:
                                                      //               Get.width,
                                                      //           height: MediaQuery.sizeOf(
                                                      //                       context)
                                                      //                   .height *
                                                      //               0.05,
                                                      //           child: Row(
                                                      //             children: [
                                                      //               Expanded(
                                                      //                   flex: 5,
                                                      //                   child:
                                                      //                       Container(
                                                      //                     padding:
                                                      //                         EdgeInsets.symmetric(horizontal: 10),
                                                      //                     decoration: BoxDecoration(
                                                      //                         border: Border.symmetric(vertical: BorderSide(color: Color(0XFF3967d7).withOpacity(0.1))),
                                                      //                         color: Color(0XFF3967d7).withOpacity(0.05)),
                                                      //                     child: Center(
                                                      //                         child: Text(
                                                      //                       e.destName!,
                                                      //                       style: TextStyle(
                                                      //                           fontSize: Get.width * 0.03,
                                                      //                           fontWeight: FontWeight.bold,
                                                      //                           color: Color(0XFF3967d7).withOpacity(0.7)),
                                                      //                     )),
                                                      //                   )),
                                                      //               Expanded(
                                                      //                   flex: 1,
                                                      //                   child:
                                                      //                       Container(
                                                      //                     padding:
                                                      //                         EdgeInsets.symmetric(horizontal: 10),
                                                      //                     decoration: BoxDecoration(
                                                      //                         border: Border.symmetric(vertical: BorderSide(color: Color(0XFF3967d7).withOpacity(0.1))),
                                                      //                         color: Color(0XFF3967d7).withOpacity(0.05)),
                                                      //                     child:
                                                      //                         Center(
                                                      //                       child:
                                                      //                           Text(
                                                      //                         e.quantity.toString(),
                                                      //                         style: TextStyle(fontSize: Get.width * 0.03, fontWeight: FontWeight.bold, color: Color(0XFF3967d7).withOpacity(0.7)),
                                                      //                       ),
                                                      //                     ),
                                                      //                   )),
                                                      //               Expanded(
                                                      //                   flex: 2,
                                                      //                   child:
                                                      //                       Container(
                                                      //                     padding:
                                                      //                         EdgeInsets.symmetric(horizontal: 10),
                                                      //                     decoration: BoxDecoration(
                                                      //                         border: Border.symmetric(vertical: BorderSide(color: Color(0XFF3967d7).withOpacity(0.1))),
                                                      //                         color: Color(0XFF3967d7).withOpacity(0.05)),
                                                      //                     child:
                                                      //                         Center(
                                                      //                       child:
                                                      //                           Text(
                                                      //                         e.destPrice.toString(),
                                                      //                         style: TextStyle(fontSize: Get.width * 0.03, fontWeight: FontWeight.bold, color: Color(0XFF3967d7).withOpacity(0.7)),
                                                      //                       ),
                                                      //                     ),
                                                      //                   )),
                                                      //               Expanded(
                                                      //                   flex: 1,
                                                      //                   child:
                                                      //                       Container(
                                                      //                     // padding:
                                                      //                     //     EdgeInsets.symmetric(horizontal: 20),
                                                      //                     decoration: BoxDecoration(
                                                      //                         border: Border.symmetric(vertical: BorderSide(color: Color(0XFF3967d7).withOpacity(0.1))),
                                                      //                         color: Color(0XFF3967d7).withOpacity(0.05)),
                                                      //                     child: IconButton(
                                                      //                         onPressed: () {
                                                      //                           totalPrice -= e.destPrice!;
                                                      //                           requestLineList.remove(e);
                                                      //                           // requests!.requestLines = requestLineList;
                                                      //                           controller.update();
                                                      //                         },
                                                      //                         icon: const Icon(Icons.delete)),
                                                      //                   )),
                                                      //             ],
                                                      //           ),
                                                      //         )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          requestLineList.isNotEmpty
                              ? Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: const Color(0XFF3967d7)
                                          .withOpacity(0.07),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "${'total_price'.tr} :",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: Get.width * 0.035),
                                          ),
                                          Text(
                                            "${totalPrice} SAR",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: Get.width * 0.035),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                            onTap: () async {
                                              if (fromDateTextController !=
                                                      null &&
                                                  toDateTextController !=
                                                      null &&
                                                  monthTextController != null &&
                                                  requestLineList.isNotEmpty &&
                                                  carTextController?.name !=
                                                      null &&
                                                  sourcePathTextController
                                                          ?.sourcePathName !=
                                                      null) {
                                                if (toDateTextController!
                                                            .substring(5, 7) ==
                                                        monthTextController &&
                                                    fromDateTextController!
                                                            .substring(5, 7) ==
                                                        monthTextController) {
                                                  print(monthTextController);
                                                  requests = Requests(
                                                      state: RequestState.draft,
                                                      amoutTotal: totalPrice,
                                                      driverId:
                                                          SharedPr.userObj!.id,
                                                      car: carTextController,
                                                      sourcePathId:
                                                          sourcePathTextController!
                                                              .sourcePathId,
                                                      fromDate:
                                                          fromDateTextController,
                                                      requestLines:
                                                          requestLineList,
                                                      toDate:
                                                          toDateTextController,
                                                      monthName:
                                                          monthTextController,
                                                      sourcePathName:
                                                          sourcePathTextController!
                                                              .sourcePathName);
                                                  ResponseResult result;

                                                  print(
                                                      'requests ${requests!.toJson()}');
                                                  if (widget.isAdd) {
                                                    result = await controller
                                                        .createRequest(
                                                            Requests:
                                                                requests!);
                                                  } else {
                                                    requests!.id =
                                                        widget.objectToEdit!.id;
                                                    result = await controller
                                                        .updateRequest(
                                                            Requests:
                                                                requests!);
                                                  }

                                                  if (result.status) {
                                                    await requestController
                                                        .requestData();
                                                    widget.isAdd
                                                        ? Get.offAll(() =>
                                                            const RequestListScreen2())
                                                        : Get.off(() =>
                                                            DetailsRequestScreen2(
                                                              item: requests!,
                                                            ));

                                                    appSnackBar(
                                                        messageType:
                                                            MessageTypes
                                                                .success,
                                                        message:
                                                            'Successful'.tr);
                                                  } else {
                                                    appSnackBar(
                                                        message:
                                                            result.message);
                                                  }
                                                } else {
                                                  print(fromDateTextController);
                                                  print(toDateTextController);
                                                  print(monthTextController);
                                                  appSnackBar(
                                                      message:
                                                          'date_match_error'
                                                              .tr);
                                                }
                                              } else {
                                                appSnackBar(
                                                    message:
                                                        'enter_required_info'
                                                            .tr);
                                              }
                                            },
                                            child: Container(
                                              width: Get.width,
                                              padding: const EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: const Color(0XFF3967d7)
                                                      .withOpacity(0.2)),
                                              child: Center(
                                                  child: Text(
                                                'save'.tr,
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Get.width * 0.04),
                                              )),
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      )),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Future _selectMonth() async {
    final monthselcted = await showDialog<int>(
      context: context,
      builder: (BuildContext context) => MonthPickerDialog(
        initialMonth: month ?? DateTime.now().month,
      ),
    );
    return monthselcted;
  }
}

class SourcePathLineContainer extends StatelessWidget {
  SourcePathLineContainer(
      {super.key, required this.e, this.isAddOrEdit = false, this.onPressed});
  SourcePathLine e;
  bool isAddOrEdit;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      // margin:
      //     EdgeInsets
      //         .all(
      //             8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0XFF3967d7).withOpacity(0.05)),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: Get.height * 0.03,
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.backgroundTable.withOpacity(0.5),
              ),
              child: Icon(Icons.location_on,
                  color: AppColor.black.withOpacity(0.5),
                  size: Get.height * 0.02),
            ),
          ),
          Expanded(
              flex: 10,
              child: Column(
                children: [
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: -4.0),
                    title: Text(
                      e.destName!,
                      style: TextStyle(
                          fontSize: Get.width * 0.03,
                          fontWeight: FontWeight.bold,
                          color: const Color(0XFF3967d7).withOpacity(0.7)),
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          '${'quantity'.tr}',
                          style: TextStyle(
                              fontSize: Get.width * 0.02,
                              fontWeight: FontWeight.bold,
                              color: const Color(0XFF3967d7).withOpacity(0.7)),
                        ),
                        Text(
                          '${e.quantity.toString()}',
                          style: TextStyle(
                              fontSize: Get.width * 0.03,
                              fontWeight: FontWeight.bold,
                              color: const Color(0XFF3967d7).withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider()),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: -4.0),
                    title: Text(
                      '${e.destPrice.toString()} SAR',
                      style: TextStyle(
                          fontSize: Get.width * 0.03,
                          fontWeight: FontWeight.bold,
                          color: const Color(0XFF3967d7).withOpacity(0.7)),
                    ),
                    trailing: Text(
                      '${e.destTotalPrice.toString()} SAR',
                      style: TextStyle(
                          fontSize: Get.width * 0.03,
                          fontWeight: FontWeight.bold,
                          color: const Color(0XFF3967d7).withOpacity(0.7)),
                    ),
                  ),
                ],
              )
              //   ListTile(
              // leading:
              //     const Icon(Icons.location_on),
              // title:
              //     Text(
              //   e.destName!,
              //   style: TextStyle(fontSize: Get.width * 0.03, fontWeight: FontWeight.bold, color: const Color(0XFF3967d7).withOpacity(0.7)),
              // ),
              // subtitle:
              //     Text(
              //   e.destPrice.toString(),
              //   style: TextStyle(fontSize: Get.width * 0.03, fontWeight: FontWeight.bold, color: const Color(0XFF3967d7).withOpacity(0.7)),
              // ),
              // trailing:
              //     Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Text(
              //       e.quantity.toString(),
              //       style: TextStyle(fontSize: Get.width * 0.03, fontWeight: FontWeight.bold, color: const Color(0XFF3967d7).withOpacity(0.7)),
              //     ),
              //     Text(
              //       e.destTotalPrice.toString(),
              //       style: TextStyle(fontSize: Get.width * 0.03, fontWeight: FontWeight.bold, color: const Color(0XFF3967d7).withOpacity(0.7)),
              //     ),
              //   ],
              // ),

              // Row(children: [ Text(
              //   e.destPrice
              //       .toString(),
              //   style: TextStyle(
              //       fontSize:
              //           Get.width *
              //               0.03,
              //       fontWeight:
              //           FontWeight
              //               .bold,
              //       color: Color(0XFF3967d7)
              //           .withOpacity(0.7)),
              // ), Text(
              //   e.destPrice
              //       .toString(),
              //   style: TextStyle(
              //       fontSize:
              //           Get.width *
              //               0.03,
              //       fontWeight:
              //           FontWeight
              //               .bold,
              //       color: Color(0XFF3967d7)
              //           .withOpacity(0.7)),
              // ),],),
              // ),
              ),
          isAddOrEdit
              ? Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: onPressed,
                    icon: Container(
                      height: Get.height * 0.03,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.backgroundTable.withOpacity(0.5),
                      ),
                      child: Icon(Icons.delete,
                          color: AppColor.black.withOpacity(0.5),
                          size: Get.height * 0.02),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
