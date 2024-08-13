import 'package:almirabi/core/shared_widgets/custom_app_bar.dart';
import 'package:almirabi/features/basic_data_management/request/domain/request_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/config/app_colors.dart';
import '../../../../../core/config/app_lists.dart';
import '../../../../../core/shared_widgets/app_button.dart';
import '../../../../../core/shared_widgets/app_custom_icon.dart';
import '../../../../../core/shared_widgets/app_custombackgrond.dart';
import '../../../../../core/shared_widgets/app_text_field.dart';
import '../../../../loading_synchronizing_data/domain/loading_synchronizing_data_viewmodel.dart';
import '../../../utils/filtter_request.dart';
import '../../domain/request_service.dart';
import 'add_edit_request_screen.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   LoadingDataController loadingDataController =
//       Get.put(LoadingDataController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:
//         Center(
//             child: Container(
//       child: ButtonElevated(
//           onPressed: () {
//             Get.back();
//           },
//           text: 'ddddd'),
//     )));
//   }
// }
class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  late final LoadingDataController loadingDataController;
  late final RequestController requestController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('======initState===========');
    requestController = Get.put(RequestController());
    loadingDataController = Get.put(LoadingDataController());
    RequestService.requestDataServiceInstance = null;
    RequestService.getInstance();

    getPagingList();
  }

  @override
  void dispose() {
    requestController.searchResults.clear();
    super.dispose();
  }

  Future getPagingList() async {
    await requestController.displayRequestList(paging: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(headerBackground: true),
        body: CustomBackGround(
          child: GetBuilder<RequestController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => AddEditRequestScreen());
                          },
                          child: ButtonElevated(
                              width: Get.width / 4,
                              text: 'add'.tr,
                              backgroundColor: AppColor.brawn,
                              iconData: Icons.add,
                              borderRadius: 25),
                        ),
                      ),
                      ContainerTextField(
                        readOnly: true,
                        hintcolor: AppColor.white,
                        width: (Get.width / 4) * 2,
                        height: MediaQuery.sizeOf(context).height * 0.05,
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColor.white,
                        ),
                        suffixIcon: Builder(builder: (iconContext) {
                          return IconButton(
                              onPressed: () async {
                                filtterRequestByState(
                                    context: iconContext,
                                    requests: requestController.requestList,
                                    requestController: requestController);
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
                        controller: requestController.searchProductController,
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          Wrap(
                            direction: Axis.horizontal,
                            children: [
                              ...requestController.requestList.map((item) =>
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: Get.width * 0.45,
                                          height: Get.height * 0.075,
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              color: AppColor.brawn,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  topRight:
                                                      Radius.circular(25))),
                                          child: Column(
                                            children: [
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     Row(
                                              //       children: [
                                              //         Container(
                                              //             decoration: BoxDecoration(
                                              //                 color: AppColor.white,
                                              //                 shape: BoxShape.circle),
                                              //             child: Padding(
                                              //                 padding:
                                              //                     const EdgeInsets
                                              //                         .all(3.0),
                                              //                 child: CustomIcon(
                                              //                     size:
                                              //                         Get.width * 0.1,
                                              //                     assetPath:
                                              //                         stateList[item
                                              //                                 .state]!
                                              //                             .first))),
                                              //         Padding(
                                              //           padding: const EdgeInsets
                                              //               .symmetric(
                                              //               horizontal: 4.0),
                                              //           child: Column(
                                              //             crossAxisAlignment:
                                              //                 CrossAxisAlignment
                                              //                     .start,
                                              //             children: [
                                              //               Text(
                                              //                 "${'car'.tr} : ${item.car!.id}",
                                              //                 style: TextStyle(
                                              //                     fontSize:
                                              //                         Get.width *
                                              //                             0.03,
                                              //                     color:
                                              //                         AppColor.white),
                                              //               ),
                                              //               Text(
                                              //                 "${'monthName'.tr} : ${item.monthName}",
                                              //                 style: TextStyle(
                                              //                     fontSize:
                                              //                         Get.width *
                                              //                             0.03,
                                              //                     color:
                                              //                         AppColor.white),
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         )
                                              //       ],
                                              //     ),
                                              //     // IconButton(
                                              //     //     onPressed: () {},
                                              //     //     icon: Icon(
                                              //     //       Icons.edit,
                                              //     //       color: AppColor.white,
                                              //     //       size: Get.width * 0.05,
                                              //     //     ))
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            width: Get.width * 0.45,
                                            height: Get.height * 0.09,
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    173, 89, 35, 100),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(25),
                                                    bottomRight:
                                                        Radius.circular(25))),
                                            child: Column(children: [
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.start,
                                              //   children: [
                                              //     Text(
                                              //       "${'from'.tr} : ${item.fromDate}",
                                              //       style: TextStyle(
                                              //           fontSize: Get.width * 0.03,
                                              //           color: AppColor.brawn),
                                              //     ),
                                              //   ],
                                              // ),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.start,
                                              //   children: [
                                              //     Text(
                                              //       "${'to'.tr} : ${item.toDate}",
                                              //       style: TextStyle(
                                              //           fontSize: Get.width * 0.03,
                                              //           color: AppColor.brawn),
                                              //     ),
                                              //   ],
                                              // ),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.start,
                                              //   children: [
                                              //     Text(
                                              //       "${'source'.tr} : ${item.sourcePathName!.length > 17 ? '${item.sourcePathName!.substring(0, 17)}...' : item.sourcePathName} ",
                                              //       style: TextStyle(
                                              //           fontSize: Get.width * 0.03,
                                              //           color: AppColor.brawn),
                                              //     ),
                                              //   ],
                                              // )
                                            ]))
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ButtonElevated(
                      onPressed: () {
                        Get.back();
                      },
                      text: 'ddddd')
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
