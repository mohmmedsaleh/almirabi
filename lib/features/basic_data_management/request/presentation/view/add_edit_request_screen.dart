import 'dart:convert';
import 'dart:ffi';

import 'package:almirabi/core/config/app_colors.dart';
import 'package:almirabi/core/shared_widgets/custom_app_bar.dart';
import 'package:almirabi/features/basic_data_management/car/data/car.dart';
import 'package:almirabi/features/basic_data_management/car/domain/car_viewmodel.dart';
import 'package:almirabi/features/basic_data_management/request/data/request.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_month_select/flutter_month_select.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import '../../../../../core/config/app_shared_pr.dart';
import '../../../../../core/shared_widgets/app_button.dart';
import '../../../../../core/shared_widgets/app_custom_icon.dart';
import '../../../../../core/shared_widgets/app_custombackgrond.dart';
import '../../../../../core/shared_widgets/app_drop_down_field.dart';
import '../../../source_path/data/source_path.dart';
import '../../../source_path/data/source_path_line.dart';
import '../../../source_path/domain/source_path_viewmodel.dart';
import '../../domain/request_viewmodel.dart';
import '../widgets/show_months_dailog.dart';

class AddEditRequestScreen extends StatefulWidget {
  Requests? objectToEdit;

  AddEditRequestScreen({super.key, this.objectToEdit});
  @override
  State<AddEditRequestScreen> createState() => _AddEditRequestScreenState();
}

class _AddEditRequestScreenState extends State<AddEditRequestScreen> {
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
  int? month;
  String? _firstValue;
  String? _secondValue;
  DateTime? fromDate, toDate;
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
    requestController.update();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(headerBackground: true),
        body: CustomBackGround(
            child: GetBuilder<RequestController>(builder: (controller) {
          print('=========================dddddddd==============0');
          return Container(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: CircleAvatar(
                              backgroundColor: AppColor.white,
                              child: Icon(Icons.arrow_back_ios_new_outlined))),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          "add_new_requst",
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
                // InkWell(
                //   onTap: () {
                //     Get.back();
                //   },
                //   child: Text("ssssssssss"),
                // ),
                SizedBox(
                  height: Get.height * 0.08,
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
                                  ContainerDropDownField(
                                    width: Get.width,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.05,
                                    onTap: () {
                                      print('onTap==============');
                                      sourcePathId = null;
                                      carid = null;
                                      sourcePathList = [];
                                      requestLineList = [];
                                      requests!.sourcePathId = null;
                                      requests!.sourcePathName = null;
                                      requests!.requestLines = [];
                                      sourcePathLineList = [];
                                      controller.update();
                                    },
                                    prefixIcon: CustomIcon(
                                      assetPath:
                                          'assets/images/delivery-truck.png',
                                      size: Get.width * 0.05,
                                    ),
                                    hintText: 'car_name'.tr,
                                    labelText: 'car_name'.tr,
                                    value: carid,
                                    color: AppColor.black,
                                    // isPIN: true,
                                    hintcolor: AppColor.black.withOpacity(0.5),
                                    iconcolor: AppColor.black,
                                    fontSize: Get.width * 0.03,
                                    onChanged: (val) {
                                      print('onChanged==============');
                                      Car car = carController.carList
                                          .firstWhere(
                                              (element) => element.name == val,
                                              orElse: () => Car());

                                      sourcePathList = sourcePathController
                                          .sourcePathList
                                          .where((e) => e.car!.id == car.id)
                                          .toList();

                                      if (sourcePathList.isNotEmpty) {
                                        carid = val;
                                      } else {
                                        //snakbar
                                      }

                                      requests!.car = car;
                                      controller.update();
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        errorMessage = 'required_message'
                                            .trParams(
                                                {'field_name': 'car_name'.tr});
                                        countErrors++;
                                        return "";
                                      }
                                      return null;
                                    },
                                    items: carController.carList
                                        .map((e) => DropdownMenuItem<String>(
                                              // value: e.id,
                                              value: e.name,
                                              child: Center(
                                                  child: Text(
                                                (e.name)!,
                                                style: TextStyle(
                                                    fontSize: Get.width * 0.03,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.black),
                                              )),
                                            ))
                                        .toList(),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  carid != null
                                      ? ContainerDropDownField(
                                          width: Get.width,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.05,
                                          prefixIcon: CustomIcon(
                                            assetPath:
                                                'assets/images/destination.png',
                                            size: Get.width * 0.05,
                                          ),
                                          hintText: 'source_path'.tr,
                                          labelText: 'source_path'.tr,
                                          value: sourcePathId,
                                          color: AppColor.black,
                                          // isPIN: true,
                                          hintcolor:
                                              AppColor.black.withOpacity(0.5),
                                          iconcolor: AppColor.black,
                                          fontSize: Get.width * 0.03,
                                          onTap: () {
                                            sourcePathId = null;
                                            sourcePathLineList = [];
                                            requestLineList = [];
                                            requests!.sourcePathId = null;
                                            requests!.sourcePathName = null;
                                            requests!.requestLines = [];
                                            controller.update();
                                          },
                                          onChanged: (val) {
                                            sourcePathId = val;
                                            SourcePath sourcePath =
                                                sourcePathController
                                                    .sourcePathList
                                                    .firstWhere(
                                                        (element) =>
                                                            element
                                                                .sourcePathName ==
                                                            val,
                                                        orElse: () =>
                                                            SourcePath());
                                            if (sourcePath.lins!.isNotEmpty) {
                                              sourcePathLineList =
                                                  sourcePath.lins!;
                                            } else {
                                              sourcePathLineList =
                                                  sourcePath.lins!;
                                              //snake bar
                                            }
                                            requests!.sourcePathId =
                                                sourcePath.sourcePathId;
                                            requests!.sourcePathName =
                                                sourcePath.sourcePathName;
                                            controller.update();
                                            // sourcePathLineList = jsonDecode(sourcePath);
                                          },
                                          validator: (value) {
                                            if (value == null) {
                                              errorMessage = 'required_message'
                                                  .trParams({
                                                'field_name': 'source_path'.tr
                                              });
                                              countErrors++;
                                              return "";
                                            }
                                            return null;
                                          },
                                          items: sourcePathList.map((e) {
                                            print(
                                                " =============> ${e.sourcePathName}");
                                            return DropdownMenuItem<String>(
                                              // value: e.id,
                                              value: e.sourcePathName,
                                              child: Center(
                                                  child: Text(
                                                (e.sourcePathName)!,
                                                style: TextStyle(
                                                    fontSize: Get.width * 0.03,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.black),
                                              )),
                                            );
                                          }).toList(),
                                        )
                                      : Container(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          fromDate = await showDatePickerDialog(
                                              context: context,
                                              minDate: DateTime(1990, 1, 1),
                                              maxDate: DateTime(2100, 12, 31),
                                              height: Get.height / 3);
                                          if (fromDate != null) {
                                            requests!.fromDate =
                                                fromDate.toString();
                                          } else {
                                            ///snakbar
                                          }
                                        },
                                        child: ButtonElevated(
                                            width: Get.width / 4,
                                            text: 'from'.tr,
                                            backgroundColor: AppColor.brawn,
                                            // iconData: Icons.add,
                                            borderRadius: 25),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final toDate =
                                              await showDatePickerDialog(
                                                  context: context,
                                                  minDate: DateTime(1990, 1, 1),
                                                  maxDate:
                                                      DateTime(2100, 12, 31),
                                                  height: Get.height / 3);
                                          if (toDate != null) {
                                            requests!.fromDate =
                                                toDate.toString();
                                          } else {
                                            ///snakbar
                                          }
                                        },
                                        child: ButtonElevated(
                                            width: Get.width / 4,
                                            text: 'to'.tr,
                                            backgroundColor: AppColor.brawn,
                                            // iconData: Icons.add,
                                            borderRadius: 25),
                                      ),
                                      GestureDetector(
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
                                          print(month);
                                          if (month != null) {
                                            requests!.fromDate =
                                                month.toString();
                                          } else {
                                            ///snakbar
                                          }
                                        },
                                        child: ButtonElevated(
                                            width: Get.width / 4,
                                            text: 'month'.tr,
                                            backgroundColor: AppColor.brawn,
                                            // iconData: Icons.add,
                                            borderRadius: 25),
                                      ),
                                    ],
                                  ),
                                  requestLineList.isNotEmpty
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: Get.height * 0.02,
                                            ),
                                            Container(
                                              width: Get.width,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                      173, 89, 31, 200),
                                                  border: Border.all(
                                                      color: AppColor.brawn),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Destination",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Get.width *
                                                                      0.04,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColor
                                                                  .brawn)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            isAdd = true;
                                                            controller.update();
                                                          },
                                                          child: ButtonElevated(
                                                              width:
                                                                  Get.width / 4,
                                                              text: 'new'.tr,
                                                              backgroundColor:
                                                                  AppColor
                                                                      .brawn,
                                                              // iconData: Icons.add,
                                                              borderRadius: 25),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: Get.width,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.05,
                                                    decoration: BoxDecoration(
                                                        color: AppColor.brawn,
                                                        border: Border.all(
                                                            color:
                                                                AppColor.brawn),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 5,
                                                            child: Center(
                                                              child: Text(
                                                                "Destination path",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Get.width *
                                                                            0.03,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColor
                                                                        .white),
                                                              ),
                                                            )),
                                                        Expanded(
                                                            flex: 2,
                                                            child: Center(
                                                              child: Text(
                                                                "price",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Get.width *
                                                                            0.03,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColor
                                                                        .white),
                                                              ),
                                                            )),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container()),
                                                      ],
                                                    ),
                                                  ),
                                                  ...requestLineList
                                                      .map((e) => Container(
                                                            width: Get.width,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.05,
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                    flex: 5,
                                                                    child: Center(
                                                                        child: Text(
                                                                      e.destName!,
                                                                      style: TextStyle(
                                                                          fontSize: Get.width *
                                                                              0.03,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              AppColor.brawn),
                                                                    ))),
                                                                Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        e.destPrice
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize: Get.width *
                                                                                0.03,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: AppColor.brawn),
                                                                      ),
                                                                    )),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Center(
                                                                        child: IconButton(
                                                                            onPressed: () {
                                                                              totalPrice -= e.destPrice!;
                                                                              requestLineList.remove(e);
                                                                              requests!.requestLines = requestLineList;
                                                                              controller.update();
                                                                            },
                                                                            icon: Icon(Icons.delete)))),
                                                              ],
                                                            ),
                                                          )),
                                                  isAdd
                                                      ? Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  ContainerDropDownField(
                                                                // width: Get.width,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.05,
                                                                prefixIcon:
                                                                    CustomIcon(
                                                                  assetPath:
                                                                      'assets/images/destination.png',
                                                                  size:
                                                                      Get.width *
                                                                          0.05,
                                                                ),
                                                                hintText:
                                                                    'source_dest'
                                                                        .tr,
                                                                labelText:
                                                                    'source_dest'
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
                                                                  SourcePathLine
                                                                      sourcePathLine =
                                                                      sourcePathLineList.firstWhere(
                                                                          (element) =>
                                                                              element.destId ==
                                                                              val,
                                                                          orElse: () =>
                                                                              SourcePathLine());
                                                                  requestLineList
                                                                      .add(
                                                                          sourcePathLine);
                                                                  totalPrice +=
                                                                      sourcePathLine
                                                                          .destPrice!;
                                                                  requests!
                                                                          .requestLines =
                                                                      requestLineList;
                                                                  isAdd = false;
                                                                  controller
                                                                      .update();

                                                                  // sourcePathLineList = jsonDecode(sourcePath);
                                                                },
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                      null) {
                                                                    errorMessage =
                                                                        'required_message'
                                                                            .trParams({
                                                                      'field_name':
                                                                          'product_category'
                                                                              .tr
                                                                    });
                                                                    countErrors++;
                                                                    return "";
                                                                  }
                                                                  return null;
                                                                },
                                                                items:
                                                                    sourcePathLineList
                                                                        .map((e) =>
                                                                            DropdownMenuItem<String>(
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
                                                                onPressed: () {
                                                                  isAdd = false;
                                                                  controller
                                                                      .update();
                                                                },
                                                                icon: Icon(Icons
                                                                    .cancel_sharp))
                                                          ],
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  sourcePathLineList.isNotEmpty
                                      ? requestLineList.isEmpty
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: Get.height * 0.02,
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
                                                  hintText: 'source_dest'.tr,
                                                  labelText: 'source_dest'.tr,
                                                  value: sourcePathLineId,
                                                  color: AppColor.black,
                                                  // isPIN: true,
                                                  hintcolor: AppColor.black
                                                      .withOpacity(0.5),
                                                  iconcolor: AppColor.black,
                                                  fontSize: Get.width * 0.03,
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

                                                    requestLineList
                                                        .add(sourcePathLine);
                                                    totalPrice = sourcePathLine
                                                        .destPrice!;
                                                    requests!.requestLines =
                                                        requestLineList;
                                                    controller.update();

                                                    // sourcePathLineList = jsonDecode(sourcePath);
                                                  },
                                                  validator: (value) {
                                                    if (value == null) {
                                                      errorMessage =
                                                          'required_message'
                                                              .trParams({
                                                        'field_name':
                                                            'source_dest'.tr
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
                                ],
                              ),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: _firstValue,
                            onChanged: (value) {
                              setState(() {
                                _firstValue = value;
                                _secondValue =
                                    null; // clear the second dropdown
                              });
                            },
                            items: carController.carList.map((option) {
                              return DropdownMenuItem<String>(
                                value: option.name,
                                child: Text(option.name!),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 16.0),
                          DropdownButtonFormField<String>(
                            value: _secondValue,
                            onChanged: (value) {
                              setState(() {
                                _secondValue = value;
                              });
                            },
                            items: sourcePathList.map((option) {
                              return DropdownMenuItem<String>(
                                value: option.sourcePathName,
                                child: Text(option.sourcePathName!),
                              );
                            }).toList(),
                          ),
                          requestLineList.isNotEmpty
                              ? Container(
                                  width: Get.width,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          173, 89, 31, 200),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text("Total Price :"),
                                          Text("$totalPrice")
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: ButtonElevated(
                                              width: Get.width,
                                              text: 'save'.tr,
                                              backgroundColor: AppColor.brawn,
                                              // iconData: Icons.add,
                                              borderRadius: 25),
                                        ),
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
        })),
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

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? _firstValue;
  String? _secondValue;

  List<String> _firstOptions = ['Option 1', 'Option 2', 'Option 3'];
  List<String> _secondOptions = [
    'Sub-option 1',
    'Sub-option 2',
    'Sub-option 3'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: _firstValue,
          onChanged: (value) {
            setState(() {
              _firstValue = value;
              _secondValue = null; // clear the second dropdown
            });
          },
          items: _firstOptions.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
        ),
        SizedBox(height: 16.0),
        DropdownButtonFormField<String>(
          value: _secondValue,
          onChanged: (value) {
            setState(() {
              _secondValue = value;
            });
          },
          items: _secondOptions.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
        ),
      ],
    );
  }
}
