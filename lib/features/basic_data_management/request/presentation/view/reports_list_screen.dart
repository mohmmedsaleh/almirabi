import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/config/app_colors.dart';
import '../../../../../core/shared_widgets/app_custombackgrond.dart';
import '../../../../../core/shared_widgets/app_text_field.dart';
import '../../../../../core/shared_widgets/custom_app_bar.dart';
import '../../../../loading_synchronizing_data/domain/loading_synchronizing_data_viewmodel.dart';
import '../../../car/domain/car_viewmodel.dart';
import '../../../utils/filtter_request.dart';
import '../../domain/request_viewmodel.dart';
import 'request_list_screen.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late final LoadingDataController loadingDataController;
  late final RequestController requestController;
  late final CarController carController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    requestController = Get.put(RequestController());
    loadingDataController = Get.put(LoadingDataController());
    carController = Get.put(CarController());
    requestController.searchResults.clear();
  }

  @override
  void dispose() {
    requestController.searchResults.clear();
    requestController.searchReportsController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: customAppBar(headerBackground: true, userOpstionShow: true),
            body: CustomBackGround(
              height: Get.height * 0.18,
              child: GetBuilder<RequestController>(builder: (controller) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {
                                requestController.searchResults.clear();
                                requestController.searchReportsController.text =
                                    '';
                                Get.offAll(() => const RequestListScreen());
                              },
                              icon: CircleAvatar(
                                  backgroundColor: AppColor.white,
                                  child: const Icon(
                                      Icons.arrow_back_ios_new_outlined))),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Text(
                              "Reports".tr,
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Expanded(
                        //   flex: 1,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: GestureDetector(
                        //       onTap: () {
                        //         Get.to(() => AddEditRequestScreen());
                        //       },
                        //       child: ButtonElevated(
                        //           width: Get.width / 6,
                        //           text: 'add'.tr,
                        //           backgroundColor: AppColor.brawn,
                        //           iconData: Icons.add,
                        //           borderRadius: 25),
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 7),
                            child: ContainerTextField(
                              readOnly: true,
                              hintcolor: AppColor.white,
                              // width: (Get.width / 6) * 3,
                              height: MediaQuery.sizeOf(context).height * 0.05,
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColor.white,
                              ),
                              suffixIcon: requestController
                                      .searchReportsController.text.isNotEmpty
                                  ? Builder(builder: (iconContext) {
                                      return SizedBox(
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  // bool
                                                  //     isTrustedDevice =
                                                  //     await MacAddressHelper
                                                  //         .isTrustedDevice();
                                                  // if (isTrustedDevice) {

                                                  requestController
                                                      .searchReportsController
                                                      .text = '';
                                                  requestController
                                                      .searchResults
                                                      .clear();
                                                  requestController.update();
                                                  filtterRequestByState(
                                                      context: iconContext,
                                                      isLoacl: false,
                                                      requestController:
                                                          requestController);
                                                  requestController.update();
                                                  // }
                                                },
                                                icon: Icon(
                                                  Icons.filter_alt_sharp,
                                                  color: AppColor.white,
                                                )),
                                            IconButton(
                                                onPressed: () async {
                                                  // bool
                                                  //     isTrustedDevice =
                                                  //     await MacAddressHelper
                                                  //         .isTrustedDevice();
                                                  // if (isTrustedDevice) {
                                                  requestController
                                                      .searchReportsController
                                                      .text = '';
                                                  requestController
                                                      .searchResults
                                                      .clear();
                                                  requestController.update();
                                                  // }
                                                },
                                                icon: Icon(
                                                  Icons.cancel_outlined,
                                                  color: AppColor.white,
                                                )),
                                          ],
                                        ),
                                      );
                                    })
                                  : Builder(builder: (iconContext) {
                                      return IconButton(
                                          onPressed: () async {
                                            // bool
                                            //     isTrustedDevice =
                                            //     await MacAddressHelper
                                            //         .isTrustedDevice();
                                            // if (isTrustedDevice) {
                                            requestController
                                                .searchReportsController
                                                .text = '';
                                            requestController.searchResults
                                                .clear();
                                            requestController.update();
                                            filtterRequestByState(
                                                context: iconContext,
                                                isLoacl: false,
                                                requestController:
                                                    requestController);
                                            requestController.update();
                                            // }
                                          },
                                          icon: Icon(
                                            Icons.filter_alt_sharp,
                                            color: AppColor.white,
                                          ));
                                    }),

                              isPIN: true,
                              isAddOrEdit: true,
                              borderColor: AppColor.white,
                              labelText: 'filtter_by'.tr,
                              hintText: 'filtter_by'.tr,
                              iconcolor: AppColor.white,
                              color: AppColor.white,
                              borderRadius: 50,
                              fontSize: Get.width * 0.03,
                              maxLength: 20,
                              controller:
                                  requestController.searchReportsController,
                            ),
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: controller.dataSend.isNotEmpty
                        //       ? Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: GestureDetector(
                        //             onTap: () {
                        //               controller.createRequestRemotely(
                        //                   Requests: controller.dataSend);
                        //             },
                        //             child: ButtonElevated(
                        //                 width: Get.width / 5,
                        //                 text: 'send'.tr,
                        //                 backgroundColor: AppColor.brawn,
                        //                 iconData: Icons.send,
                        //                 borderRadius: 25),
                        //           ),
                        //         )
                        //       : Container(),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),

                    // TabBar(
                    //   onTap: (i) {
                    //     print(i);
                    //     _checkInternetAndSwitch(i);
                    //   },
                    //   indicatorSize: TabBarIndicatorSize.tab,
                    //   indicator: BoxDecoration(
                    //     color: AppColor.brawn,
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   dividerColor: Colors.transparent,
                    //   automaticIndicatorColorAdjustment: false,
                    //   labelColor: AppColor.white,
                    //   indicatorColor: Colors.transparent,
                    //   unselectedLabelColor: AppColor.white,
                    //   controller: _tabController,
                    //   tabs: [
                    //     Tab(text: "requests".tr),
                    //     Tab(text: "Reports".tr),
                    //   ],
                    // ),
                    // TabBarView(
                    //   controller: _tabController,
                    //   children: [
                    //     Center(child: Text("Content for Tab 1")),
                    //     Center(child: Text("Content for Tab 2")),
                    //     Center(child: Text("Content for Tab 3")),
                    //   ],
                    // ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.05,
                            ),
                            requestController.searchReportsController.text == ''
                                ? Wrap(
                                    direction: Axis.horizontal,
                                    children: [
                                      ...requestController.reportsList
                                          .map((item) => card_data(
                                                carController: carController,
                                                item: item,
                                              ))
                                    ],
                                  )
                                : Wrap(
                                    direction: Axis.horizontal,
                                    children: [
                                      ...requestController.searchResults
                                          .map((item) => card_data(
                                                carController: carController,
                                                item: item,
                                              ))
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                    // ButtonElevated(
                    //     onPressed: () {
                    //       Get.back();
                    //     },
                    //     text: 'ddddd')
                  ],
                );
              }),
            )));
  }
}
