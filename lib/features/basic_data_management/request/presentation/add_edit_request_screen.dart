import 'dart:convert';

import 'package:almirabi/core/config/app_colors.dart';
import 'package:almirabi/core/shared_widgets/custom_app_bar.dart';
import 'package:almirabi/features/basic_data_management/car/data/car.dart';
import 'package:almirabi/features/basic_data_management/car/domain/car_viewmodel.dart';
import 'package:almirabi/features/basic_data_management/request/data/request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import '../../../../core/config/app_shared_pr.dart';
import '../../../../core/shared_widgets/app_custom_icon.dart';
import '../../../../core/shared_widgets/app_custombackgrond.dart';
import '../../../../core/shared_widgets/app_drop_down_field.dart';
import '../../source_path/data/source_path.dart';
import '../../source_path/data/source_path_line.dart';
import '../../source_path/domain/source_path_viewmodel.dart';
import '../domain/request_viewmodel.dart';

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
  // late final RequestController requestController;
  final TextEditingController nameController = TextEditingController(),
      barcodeController = TextEditingController(),
      unitPriceController = TextEditingController();
  List<SourcePathLine> sourcePathLineList = [];
  List<SourcePath> sourcePathList = [];
  final FocusNode nameFocusNode = FocusNode();
  int? carid, sourcePathId;
  Requests? requests;
  String? errorMessage;
  int countErrors = 0;
  int pagesNumber = 0;
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
    carController.carData();
    sourcePathController.SourcePathData();
    // requests!.car = carController.carList.first;
    // requestController = Get.put(RequestController());
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(headerBackground: true),
        body: CustomBackGround(
            child: GetBuilder<RequestController>(builder: (controller) {
          return Container(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Center(
                    child: Text(
                  "add_new_requst",
                  style: TextStyle(
                      fontSize: Get.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: AppColor.white),
                )),
                // InkWell(
                //   onTap: () {
                //     Get.back();
                //   },
                //   child: Text("ssssssssss"),
                // ),
                SizedBox(
                  height: Get.height * 0.08,
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          ContainerDropDownField(
                            width: Get.width,
                            height: MediaQuery.sizeOf(context).height * 0.05,
                            prefixIcon: CustomIcon(
                              assetPath: 'assets/images/delivery-truck.png',
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
                              Car car = carController.carList.firstWhere(
                                  (element) => element.id == val,
                                  orElse: () => Car());

                              sourcePathList = sourcePathController
                                  .sourcePathList
                                  .where((e) => e.car!.id == val)
                                  .toList();
                              if (sourcePathList.isNotEmpty) {
                                carid = val;
                              }

                              requests!.car = car;
                              controller.update();
                            },
                            validator: (value) {
                              if (value == null) {
                                errorMessage = 'required_message'.trParams(
                                    {'field_name': 'product_category'.tr});
                                countErrors++;
                                return "";
                              }
                              return null;
                            },
                            items: carController.carList
                                .map((e) => DropdownMenuItem(
                                      // value: e.id,
                                      value: e.id,
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
                            height: Get.height * 0.01,
                          ),
                          carid != null
                              ? ContainerDropDownField(
                                  width: Get.width,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.05,
                                  prefixIcon: CustomIcon(
                                    assetPath: 'assets/images/destination.png',
                                    size: Get.width * 0.05,
                                  ),
                                  hintText: 'source_path'.tr,
                                  labelText: 'source_path'.tr,
                                  value: sourcePathId,
                                  color: AppColor.black,
                                  // isPIN: true,
                                  hintcolor: AppColor.black.withOpacity(0.5),
                                  iconcolor: AppColor.black,
                                  fontSize: Get.width * 0.03,
                                  onChanged: (val) {
                                    SourcePath sourcePath = sourcePathController
                                        .sourcePathList
                                        .firstWhere(
                                            (element) =>
                                                element.sourcePathId == val,
                                            orElse: () => SourcePath());
                                    print(sourcePath.lins);
                                    sourcePathLineList = sourcePath.lins!;
                                    print(sourcePathLineList);
                                    // sourcePathLineList = jsonDecode(sourcePath);
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      errorMessage = 'required_message'
                                          .trParams({
                                        'field_name': 'product_category'.tr
                                      });
                                      countErrors++;
                                      return "";
                                    }
                                    return null;
                                  },
                                  items: sourcePathList
                                      .map((e) => DropdownMenuItem(
                                            // value: e.id,
                                            value: e.sourcePathId,
                                            child: Center(
                                                child: Text(
                                              (e.sourcePathName)!,
                                              style: TextStyle(
                                                  fontSize: Get.width * 0.03,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.black),
                                            )),
                                          ))
                                      .toList(),
                                )
                              : Container(),
                        ],
                      ),
                    ))
              ],
            ),
          );
        })),
      ),
    );
  }
}
