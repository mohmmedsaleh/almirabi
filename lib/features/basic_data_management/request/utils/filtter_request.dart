import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_lists.dart';
import '../../../../core/shared_widgets/app_drop_down_field.dart';
import '../domain/request_viewmodel.dart';

filtterRequestByState(
    {required BuildContext context,
    required bool isLoacl,
    required RequestController requestController}) {
  return showPopover(
    direction: PopoverDirection.bottom,
    context: context,
    width: Get.width * 0.4,
    // height: Get.height * 0.15,
    backgroundColor: AppColor.white,
    bodyBuilder: (context) {
      return SingleChildScrollView(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ...stateList.entries.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  requestController.searchByState(item.key.name, isLoacl);
                  if (isLoacl) {
                    requestController.searchRequstsController.text =
                        item.key.name;
                  } else {
                    requestController.searchReportsController.text =
                        item.key.name;
                  }
                },
                child: Text(
                  item.key.toString(),
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: Get.width * 0.03,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
        ]),
      );
    },
  );
}

class FilterState extends StatelessWidget {
  FilterState(
      {super.key, required this.isLoacl, required this.requestController});
  RequestController requestController;
  bool isLoacl;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.2,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Text(
              //     'filtter_by'.tr,
              //     style: TextStyle(
              //         fontSize: Get.width * 0.04,
              //         color: Color(0XFF3967d7)),
              //   ),
              // ),
              isLoacl
                  ? requestController.searchRequstsController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () async {
                            // bool
                            //     isTrustedDevice =
                            //     await MacAddressHelper
                            //         .isTrustedDevice();
                            // if (isTrustedDevice) {
                            Navigator.of(context).pop();
                            requestController.searchRequstsController.text = '';
                            requestController.filtterRequstBy = null;
                            requestController.searchResults.clear();
                            requestController.update();
                            // }
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: AppColor.black,
                          ))
                      : Container()
                  : requestController.searchReportsController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () async {
                            // bool
                            //     isTrustedDevice =
                            //     await MacAddressHelper
                            //         .isTrustedDevice();
                            // if (isTrustedDevice) {
                            Navigator.of(context).pop();
                            requestController.searchReportsController.text = '';
                            requestController.filtterReportBy = null;
                            requestController.searchResults.clear();
                            requestController.update();
                            // }
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: AppColor.black,
                          ))
                      : Container(),
              Expanded(
                child: ContainerDropDownField(
                  width: Get.width,
                  height: MediaQuery.sizeOf(context).height * 0.05,
                  onTap: () {
                    isLoacl
                        ? requestController.searchRequstsController.text = ''
                        : requestController.searchReportsController.text = '';

                    requestController.searchResults.clear();
                    requestController.update();
                  },
                  // prefixIcon: CustomIcon(
                  //   assetPath: 'assets/images/delivery-truck.png',
                  //   size: Get.width * 0.05,
                  // ),
                  hintText: 'filtter_by'.tr,
                  labelText: 'filtter_by'.tr,
                  value: isLoacl
                      ? requestController.filtterRequstBy
                      : requestController.filtterReportBy,
                  color: AppColor.black,
                  // isPIN: true,
                  hintcolor: AppColor.black.withOpacity(0.5),
                  iconcolor: AppColor.black,
                  fontSize: Get.width * 0.03,
                  onChanged: (val) {
                    isLoacl
                        ? requestController.filtterRequstBy = val
                        : requestController.filtterReportBy = val;
                  },
                  validator: (value) {
                    // if (value == null) {
                    //   // errorMessage = 'required_message'
                    //   //     .trParams({'field_name': 'car_name'.tr});
                    //   // countErrors++;
                    //   return "";
                    // }
                    return null;
                  },
                  items: stateList.entries
                      .map((e) => DropdownMenuItem<String>(
                            // value: e.id,
                            value: e.key.name,
                            child: Center(
                                child: Text(
                              (e.key.toString()),
                              style: TextStyle(
                                  fontSize: Get.width * 0.03,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black),
                            )),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              if (isLoacl) {
                if (requestController.filtterRequstBy != null) {
                  Navigator.of(context).pop();
                  requestController.searchByState(
                      requestController.filtterRequstBy!, isLoacl);
                  requestController.searchRequstsController.text =
                      requestController.filtterRequstBy!;
                  requestController.update();
                }
              } else {
                if (requestController.filtterReportBy != null) {
                  Navigator.of(context).pop();
                  requestController.searchByState(
                      requestController.filtterReportBy!, isLoacl);
                  requestController.searchReportsController.text =
                      requestController.filtterReportBy!;
                  requestController.update();
                }
              }
            },
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0XFF3967d7).withOpacity(0.2)),
              child: Center(
                  child: Text(
                'filtter_by'.tr,
                style: TextStyle(
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.04),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
