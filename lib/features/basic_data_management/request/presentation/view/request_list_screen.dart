import 'package:almirabi/core/shared_widgets/custom_app_bar.dart';
import 'package:almirabi/features/basic_data_management/car/domain/car_viewmodel.dart';
import 'package:almirabi/features/basic_data_management/request/domain/request_viewmodel.dart';
import 'package:almirabi/features/basic_data_management/request/presentation/view/details_request_screen.dart';
import 'package:almirabi/features/basic_data_management/source_path/domain/source_path_viewmodel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/config/app_colors.dart';
import '../../../../../core/config/app_lists.dart';
import '../../../../../core/shared_widgets/app_custom_icon.dart';
import '../../../../../core/shared_widgets/app_custombackgrond.dart';
import '../../../../../core/shared_widgets/app_text_field.dart';
import '../../../../loading_synchronizing_data/domain/loading_synchronizing_data_viewmodel.dart';
import '../../../car/data/car.dart';
import '../../../source_path/data/source_path.dart';
import '../../utils/filtter_request.dart';
import '../../data/request.dart';
import '../../domain/request_service.dart';
import '../widgets/show_months_dailog.dart';
import 'add_edit_request_screen.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen>
    with SingleTickerProviderStateMixin {
  late final RequestController requestController;
  late final CarController carController;
  late final SourcePathController sourcePathController;
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('======initState===========');
    requestController = Get.put(RequestController());
    carController = Get.put(CarController());
    sourcePathController = Get.put(SourcePathController());
    RequestService.requestDataServiceInstance = null;
    RequestService.getInstance();
    _tabController = TabController(length: 2, vsync: this);
    getPagingList();
  }

  @override
  void dispose() {
    requestController.searchResults.clear();
    requestController.searchRequstsController.text = '';
    _tabController.dispose();
    super.dispose();
  }

  Future getPagingList() async {
    await requestController.displayRequestList(paging: false);
  }

  Future<void> _checkInternetAndSwitch(int index) async {
    if (index == 1) {
      // "Reports" tab
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // No internet connection, switch back to "Requests" tab
        _tabController.index = 0; // Switch to the first tab
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text("No internet connection! Switching back to Requests.")),
        );
      }
      // You can add more logic here if you want to proceed with "Reports"
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(headerBackground: true),
        body: CustomBackGround(
          // height: Get.height * 0.18,
          child: GetBuilder<RequestController>(builder: (controller) {
            return Column(
              children: [
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
                                  .searchRequstsController.text.isNotEmpty
                              ? Builder(builder: (iconContext) {
                                  return SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              // bool
                                              //     isTrustedDevice =
                                              //     await MacAddressHelper
                                              //         .isTrustedDevice();
                                              // if (isTrustedDevice) {

                                              requestController
                                                  .searchRequstsController
                                                  .text = '';
                                              requestController.searchResults
                                                  .clear();
                                              requestController.update();
                                              filtterRequestByState(
                                                  context: iconContext,
                                                  isLoacl: true,
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
                                                  .searchRequstsController
                                                  .text = '';
                                              requestController.searchResults
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
                                            .searchRequstsController.text = '';
                                        requestController.searchResults.clear();
                                        requestController.update();
                                        filtterRequestByState(
                                            context: iconContext,
                                            isLoacl: true,
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
                          controller: requestController.searchRequstsController,
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
                        requestController.searchRequstsController.text == ''
                            ? Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  ...requestController.requestList
                                      .map((item) => card_data(
                                            sourcePathController:
                                                sourcePathController,
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
                                            sourcePathController:
                                                sourcePathController,
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  requestController.createRequestRemotely(
                      requests: requestController.dataSend);
                },
                icon: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: AppColor.brawn, shape: BoxShape.circle),
                    child: Icon(
                      Icons.send,
                      color: AppColor.white,
                    ))),
            IconButton(
                onPressed: () {
                  Get.to(() => AddEditRequestScreen());
                },
                icon: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: AppColor.brawn, shape: BoxShape.circle),
                    child: Icon(
                      Icons.add,
                      color: AppColor.white,
                    ))),
          ],
        ),
      ),
    );
  }
}

class card_data extends StatelessWidget {
  const card_data({
    super.key,
    required this.carController,
    required this.sourcePathController,
    required this.item,
  });

  final CarController carController;
  final SourcePathController sourcePathController;
  final Requests item;

  @override
  Widget build(BuildContext context) {
    Car car = carController.carList.firstWhere((e) => e.id == item.car!.id);
    SourcePath sourcePath = sourcePathController.sourcePathList
        .firstWhere((e) => e.sourcePathId == item.sourcePathId!);

    return InkWell(
      onTap: () {
        Get.to(() => DetailsRequestScreen(item: item));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Container(
              width: Get.width * 0.45,
              height: Get.height * 0.07,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: AppColor.brawn,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  shape: BoxShape.circle),
                              child: CustomIcon(
                                  size: Get.width * 0.07,
                                  assetPath: stateList[item.state]!.first)),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${'car'.tr} : ${car.name ?? ''}",
                                  style: TextStyle(
                                      fontSize: Get.width * 0.03,
                                      color: AppColor.white),
                                ),
                                Text(
                                  "${'month'.tr} : ${monthName(int.parse(item.monthName!))}",
                                  style: TextStyle(
                                      fontSize: Get.width * 0.03,
                                      color: AppColor.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: Icon(
                      //       Icons.edit,
                      //       color: AppColor.white,
                      //       size: Get.width * 0.05,
                      //     ))
                    ],
                  ),
                ],
              ),
            ),
            Container(
                width: Get.width * 0.45,
                height: Get.height * 0.1,
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(173, 89, 35, 100),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.date_range_outlined,
                          color: AppColor.white,
                          size: Get.height * 0.02,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          "${'from'.tr} : ${item.fromDate!.substring(0, 10)}",
                          style: TextStyle(
                              fontSize: Get.width * 0.03,
                              color: AppColor.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.date_range_outlined,
                          color: AppColor.white,
                          size: Get.height * 0.02,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          "${'to'.tr} : ${item.toDate!.substring(0, 10)}",
                          style: TextStyle(
                              fontSize: Get.width * 0.03,
                              color: AppColor.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomIcon(
                          assetPath: 'assets/images/destination.png',
                          size: Get.height * 0.02,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          "${sourcePath.sourcePathName == null ? '' : sourcePath.sourcePathName!.length > 17 ? '${sourcePath.sourcePathName!.substring(0, 17)}...' : sourcePath.sourcePathName} ",
                          style: TextStyle(
                              fontSize: Get.width * 0.03,
                              color: AppColor.white),
                        ),
                      ),
                    ],
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
