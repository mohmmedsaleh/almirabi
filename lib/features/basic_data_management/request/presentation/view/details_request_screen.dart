import 'package:almirabi/core/shared_widgets/custom_app_bar.dart';
import 'package:almirabi/features/basic_data_management/request/data/request.dart';
import 'package:almirabi/features/basic_data_management/request/presentation/view/request_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/config/app_colors.dart';
import '../../../../../core/config/app_enums.dart';
import '../../../../../core/shared_widgets/app_custom_icon.dart';
import '../../../../../core/shared_widgets/app_custombackgrond.dart';
import '../../../../remote_database_setting/presentation/remote_database_screen.dart';
import '../../../car/domain/car_viewmodel.dart';
import '../../domain/request_viewmodel.dart';
import '../widgets/show_months_dailog.dart';
import 'add_edit_request_screen.dart';
import 'reports_list_screen.dart';

// class DetailsRequestScreen extends StatefulWidget {
//   DetailsRequestScreen({super.key, required this.item, this.isRequst = true});
//   Requests item;
//   bool isRequst;
//   @override
//   State<DetailsRequestScreen> createState() => _DetailsRequestScreenState();
// }

// class _DetailsRequestScreenState extends State<DetailsRequestScreen> {
//   late final CarController carController;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     carController = Get.put(CarController());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: customAppBar(headerBackground: true, userOpstionShow: true),
//       body: CustomBackGround(
//           child: GetBuilder<RequestController>(builder: (controller) {
//         return Column(
//           children: [
//             SizedBox(
//               height: Get.height * 0.02,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: IconButton(
//                       onPressed: () {
//                         widget.isRequst
//                             ? Get.offAll(() => const RequestListScreen())
//                             : Get.offAll(() => const ReportScreen());
//                       },
//                       icon: CircleAvatar(
//                           backgroundColor: AppColor.white,
//                           child:
//                               const Icon(Icons.arrow_back_ios_new_outlined))),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Center(
//                     child: Text(
//                       widget.isRequst
//                           ? "requst_details".tr
//                           : 'reports_details'.tr,
//                       style: TextStyle(
//                           fontSize: Get.width * 0.05,
//                           fontWeight: FontWeight.bold,
//                           color: AppColor.white),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                     flex: 1,
//                     child: widget.isRequst &&
//                             widget.item.state == RequestState.draft
//                         ? CircleAvatar(
//                             backgroundColor: AppColor.white,
//                             child: IconButton(
//                                 onPressed: () {
//                                   Get.to(() => AddEditRequestScreen(
//                                         objectToEdit: widget.item,
//                                         isAdd: false,
//                                       ));
//                                 },
//                                 icon: Icon(Icons.edit)))
//                         : Container())
//               ],
//             ),
//             // InkWell(
//             //   onTap: () {
//             //     Get.back();
//             //   },
//             //   child: Text("ssssssssss"),
//             // ),
//             SizedBox(
//               height: Get.height * 0.08,
//             ),
//             Row(
//               children: [
//                 CustomIcon(
//                   assetPath: 'assets/images/delivery-truck.png',
//                   size: Get.width * 0.1,
//                 ),
//                 Text(
//                     '${widget.item.car!.name != '' ? widget.item.car!.name : carController.carList.firstWhere((e) => e.id == widget.item.car!.id).name}'),
//               ],
//             ),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(6.0),
//                   child: Icon(
//                     Icons.date_range_outlined,
//                     color: AppColor.black,
//                     size: Get.width * 0.1,
//                   ),
//                 ),
//                 Text(
//                     '${'month'.tr} : ${monthName(int.parse(widget.item.monthName!))}'),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: Icon(
//                           Icons.date_range_outlined,
//                           color: AppColor.black,
//                           size: Get.width * 0.1,
//                         ),
//                       ),
//                       Expanded(
//                         flex: 5,
//                         child: Text(
//                           "${'from'.tr} : ${widget.item.fromDate!.substring(0, 10)}",
//                           style: TextStyle(
//                               fontSize: Get.width * 0.03,
//                               color: AppColor.black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: Icon(
//                           Icons.date_range_outlined,
//                           color: AppColor.black,
//                           size: Get.width * 0.1,
//                         ),
//                       ),
//                       Expanded(
//                         flex: 5,
//                         child: Text(
//                           "${'to'.tr} : ${widget.item.toDate!.substring(0, 10)}",
//                           style: TextStyle(
//                               fontSize: Get.width * 0.03,
//                               color: AppColor.black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: CustomIcon(
//                     assetPath: 'assets/images/destination.png',
//                     size: Get.width * 0.1,
//                   ),
//                 ),
//                 Expanded(
//                   flex: 5,
//                   child: Text(
//                     "${widget.item.sourcePathName != null ? widget.item.sourcePathName!.length > 17 ? '${widget.item.sourcePathName!.substring(0, 17)}...' : widget.item.sourcePathName : ''} ",
//                     style: TextStyle(
//                         fontSize: Get.width * 0.03, color: AppColor.black),
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       width: Get.width,
//                       padding: const EdgeInsets.all(10),
//                       margin: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                           color: const Color.fromRGBO(173, 89, 31, 200),
//                           border: Border.all(color: AppColor.brawn),
//                           borderRadius: BorderRadius.circular(15)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("destination".tr,
//                                   style: TextStyle(
//                                       fontSize: Get.width * 0.04,
//                                       fontWeight: FontWeight.bold,
//                                       color: AppColor.brawn)),
//                               Text("${widget.item.amoutTotal}",
//                                   style: TextStyle(
//                                       fontSize: Get.width * 0.04,
//                                       fontWeight: FontWeight.bold,
//                                       color: AppColor.brawn)),
//                             ],
//                           ),
//                           Container(
//                             width: Get.width,
//                             height: MediaQuery.sizeOf(context).height * 0.05,
//                             decoration: BoxDecoration(
//                                 color: AppColor.brawn,
//                                 border: Border.all(color: AppColor.brawn),
//                                 borderRadius: BorderRadius.circular(15)),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                     flex: 6,
//                                     child: Center(
//                                       child: Text(
//                                         "destination_path".tr,
//                                         style: TextStyle(
//                                             fontSize: Get.width * 0.03,
//                                             fontWeight: FontWeight.bold,
//                                             color: AppColor.white),
//                                       ),
//                                     )),
//                                 Expanded(
//                                     flex: 2,
//                                     child: Center(
//                                       child: Text(
//                                         "price".tr,
//                                         style: TextStyle(
//                                             fontSize: Get.width * 0.03,
//                                             fontWeight: FontWeight.bold,
//                                             color: AppColor.white),
//                                       ),
//                                     )),
//                               ],
//                             ),
//                           ),
//                           ...widget.item.requestLines!.map((e) => SizedBox(
//                                 width: Get.width,
//                                 height:
//                                     MediaQuery.sizeOf(context).height * 0.05,
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                         flex: 5,
//                                         child: Center(
//                                             child: Text(
//                                           e.destName!,
//                                           style: TextStyle(
//                                               fontSize: Get.width * 0.03,
//                                               fontWeight: FontWeight.bold,
//                                               color: AppColor.brawn),
//                                         ))),
//                                     Expanded(
//                                         flex: 2,
//                                         child: Center(
//                                           child: Text(
//                                             e.destPrice.toString(),
//                                             style: TextStyle(
//                                                 fontSize: Get.width * 0.03,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: AppColor.brawn),
//                                           ),
//                                         )),
//                                   ],
//                                 ),
//                               )),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       })),
//     ));
//   }
// }

class DetailsRequestScreen2 extends StatefulWidget {
  DetailsRequestScreen2({super.key, required this.item, this.isRequst = true});
  Requests item;
  bool isRequst;
  @override
  State<DetailsRequestScreen2> createState() => _DetailsRequestScreen2State();
}

class _DetailsRequestScreen2State extends State<DetailsRequestScreen2> {
  late final CarController carController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carController = Get.put(CarController());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: customAppBar(headerBackground: true, userOpstionShow: true),
      body: GetBuilder<RequestController>(builder: (controller) {
        return Column(
          children: [
            CustomBack(
                height: MediaQuery.of(context).size.height * 0.1,
                color: Color(0XFF3967d7),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            widget.isRequst
                                ? Get.offAll(() => const RequestListScreen2())
                                : Get.offAll(() => const ReportScreen2());
                          },
                          icon: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Color(0XFF3967d7),
                                size: Get.width * 0.05,
                              ))),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          widget.isRequst
                              ? "requst_details".tr
                              : 'reports_details'.tr,
                          style: TextStyle(
                              fontSize: Get.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: AppColor.white),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: widget.isRequst &&
                                widget.item.state == RequestState.draft
                            ? IconButton(
                                onPressed: () {
                                  Get.to(() => AddEditRequestScreen2(
                                        objectToEdit: widget.item,
                                        isAdd: false,
                                      ));
                                },
                                icon: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.edit,
                                    color: Color(0XFF3967d7),
                                    size: Get.width * 0.05,
                                  ),
                                ))
                            : Container())
                  ],
                )),
            // InkWell(
            //   onTap: () {
            //     Get.back();
            //   },
            //   child: Text("ssssssssss"),
            // ),
            // SizedBox(
            //   height: Get.height * 0.08,
            // ),
            SizedBox(
              height: Get.height * 0.03,
            ),

            Text(
                '${'month'.tr} : ${monthName(int.parse(widget.item.monthName!))}'),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: Get.height * 0.1,
                  width: Get.width * 0.3,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 100,
                            color: AppColor.backgroundTable,
                            offset: Offset(2, 2))
                      ],
                      color: AppColor.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            color: Color(0xffc3c3c6).withOpacity(0.5),
                            shape: BoxShape.circle),
                        child: Icon(Icons.date_range_outlined,
                            color: AppColor.black.withOpacity(0.5),
                            size: Get.width * 0.05),
                      ),
                      Center(
                          child: Text(
                        'from'.tr,
                        style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.03),
                      )),
                      Text(
                        "${widget.item.fromDate!.substring(0, 10)}",
                        style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.03),
                      )
                    ],
                  ),
                ),
                Container(
                  height: Get.height * 0.1,
                  width: Get.width * 0.3,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 100,
                            color: AppColor.backgroundTable,
                            offset: Offset(2, 2))
                      ],
                      color: AppColor.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            color: Color(0xffc3c3c6).withOpacity(0.5),
                            shape: BoxShape.circle),
                        child: Icon(Icons.date_range_outlined,
                            color: AppColor.black.withOpacity(0.5),
                            size: Get.width * 0.05),
                      ),
                      Center(
                          child: Text(
                        'to'.tr,
                        style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.03),
                      )),
                      Text(
                        "${widget.item.toDate!.substring(0, 10)}",
                        style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.03),
                      )
                    ],
                  ),
                ),
                // Container(
                //   height: Get.width * 0.12,
                //   width: Get.width * 0.12,
                //   margin: EdgeInsets.all(10),
                //   padding: const EdgeInsets.all(6.0),
                //   decoration: BoxDecoration(
                //       color: AppColor.backgroundTable, shape: BoxShape.circle),
                //   child: CustomIcon(
                //       padding: 4,
                //       assetPath: 'assets/images/delivery-truck.png',
                //       color: AppColor.black.withOpacity(0.5),
                //       size: Get.width * 0.1),
                // ),
                // Text(
                //     '${widget.item.car!.name != '' ? widget.item.car!.name : carController.carList.firstWhere((e) => e.id == widget.item.car!.id).name}'),
              ],
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: Get.height * 0.1,
                  width: Get.width * 0.3,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 100,
                            color: AppColor.backgroundTable,
                            offset: Offset(2, 2))
                      ],
                      color: AppColor.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            color: Color(0xffc3c3c6).withOpacity(0.5),
                            shape: BoxShape.circle),
                        child: CustomIcon(
                            padding: 0,
                            assetPath: 'assets/images/delivery-truck.png',
                            color: AppColor.black.withOpacity(0.5),
                            size: Get.width * 0.05),
                      ),
                      Center(
                          child: Text(
                        'car_name'.tr,
                        style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.03),
                      )),
                      Text(
                        "${widget.item.car!.name != '' ? widget.item.car!.name : carController.carList.firstWhere((e) => e.id == widget.item.car!.id).name}",
                        style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.03),
                      )
                    ],
                  ),
                ),

                Container(
                  height: Get.height * 0.1,
                  width: Get.width * 0.3,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 100,
                            color: AppColor.backgroundTable,
                            offset: Offset(2, 2))
                      ],
                      color: AppColor.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            color: Color(0xffc3c3c6).withOpacity(0.5),
                            shape: BoxShape.circle),
                        child: Icon(Icons.location_on,
                            color: AppColor.black.withOpacity(0.5),
                            size: Get.width * 0.05),
                      ),
                      Center(
                          child: Text(
                        'source_path'.tr,
                        style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.03),
                      )),
                      Text(
                        "${widget.item.sourcePathName != null ? widget.item.sourcePathName!.length > 13 ? '${widget.item.sourcePathName!.substring(0, 13)}...' : widget.item.sourcePathName : ''}",
                        style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.03),
                      )
                    ],
                  ),
                ),
                // Container(
                //   height: Get.width * 0.12,
                //   width: Get.width * 0.12,
                //   margin: EdgeInsets.all(10),
                //   padding: const EdgeInsets.all(6.0),
                //   decoration: BoxDecoration(
                //       color: AppColor.backgroundTable, shape: BoxShape.circle),
                //   child: CustomIcon(
                //       padding: 4,
                //       assetPath: 'assets/images/delivery-truck.png',
                //       color: AppColor.black.withOpacity(0.5),
                //       size: Get.width * 0.1),
                // ),
                // Text(
                //     '${widget.item.car!.name != '' ? widget.item.car!.name : carController.carList.firstWhere((e) => e.id == widget.item.car!.id).name}'),
              ],
            ),
            // Row(
            //   children: [
            //     Container(
            //       height: Get.width * 0.12,
            //       width: Get.width * 0.12,
            //       margin: EdgeInsets.all(10),
            //       padding: const EdgeInsets.all(6.0),
            //       decoration: BoxDecoration(
            //           color: AppColor.backgroundTable, shape: BoxShape.circle),
            //       child: Icon(Icons.date_range_outlined,
            //           color: AppColor.black.withOpacity(0.5),
            //           size: Get.width * 0.08),
            //     ),
            //     Text(
            //         '${'month'.tr} : ${monthName(int.parse(widget.item.monthName!))}'),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Expanded(
            //             flex: 3,
            //             child: Container(
            //               height: Get.width * 0.12,
            //               margin: EdgeInsets.all(10),
            //               padding: const EdgeInsets.all(6.0),
            //               decoration: BoxDecoration(
            //                   color: AppColor.backgroundTable,
            //                   shape: BoxShape.circle),
            //               child: Icon(Icons.date_range_outlined,
            //                   color: AppColor.black.withOpacity(0.5),
            //                   size: Get.width * 0.08),
            //             ),
            //           ),
            //           Expanded(
            //             flex: 5,
            //             child: Text(
            //               "${'from'.tr} : ${widget.item.fromDate!.substring(0, 10)}",
            //               style: TextStyle(
            //                   fontSize: Get.width * 0.03,
            //                   color: AppColor.black,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Expanded(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Expanded(
            //             flex: 3,
            //             child: Container(
            //               height: Get.width * 0.12,
            //               margin: EdgeInsets.all(10),
            //               padding: const EdgeInsets.all(6.0),
            //               decoration: BoxDecoration(
            //                   color: AppColor.backgroundTable,
            //                   shape: BoxShape.circle),
            //               child: Icon(Icons.date_range_outlined,
            //                   color: AppColor.black.withOpacity(0.5),
            //                   size: Get.width * 0.08),
            //             ),
            //           ),
            //           Expanded(
            //             flex: 5,
            //             child: Text(
            //               "${'to'.tr} : ${widget.item.toDate!.substring(0, 10)}",
            //               style: TextStyle(
            //                   fontSize: Get.width * 0.03,
            //                   color: AppColor.black,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Container(
            //         height: Get.width * 0.12,
            //         width: Get.width * 0.12,
            //         margin: EdgeInsets.all(10),
            //         padding: const EdgeInsets.all(6.0),
            //         decoration: BoxDecoration(
            //             color: AppColor.backgroundTable,
            //             shape: BoxShape.circle),
            //         child: Icon(Icons.location_on,
            //             color: AppColor.black.withOpacity(0.5),
            //             size: Get.width * 0.08)),
            //     Text(
            //       "${widget.item.sourcePathName != null ? widget.item.sourcePathName!.length > 17 ? '${widget.item.sourcePathName!.substring(0, 17)}...' : widget.item.sourcePathName : ''} ",
            //     ),
            //   ],
            // ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(5),
                      // decoration: BoxDecoration(
                      //     color: const Color.fromRGBO(173, 89, 31, 200),
                      //     border: Border.all(color: AppColor.brawn),
                      //     borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text("destination".tr,
                                style: TextStyle(
                                    fontSize: Get.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0XFF3967d7))),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text("destination".tr,
                          //           style: TextStyle(
                          //               fontSize: Get.width * 0.04,
                          //               fontWeight: FontWeight.bold,
                          //               color: Color(0XFF3967d7))),
                          //       Text("${widget.item.amoutTotal}",
                          //           style: TextStyle(
                          //               fontSize: Get.width * 0.04,
                          //               fontWeight: FontWeight.bold,
                          //               color: Color(0XFF3967d7))),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   width: Get.width,
                          //   height: MediaQuery.sizeOf(context).height * 0.05,
                          //   decoration: BoxDecoration(
                          //       color: AppColor.brawn,
                          //       border: Border.all(color: AppColor.brawn),
                          //       borderRadius: BorderRadius.circular(15)),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //           flex: 6,
                          //           child: Center(
                          //             child: Text(
                          //               "destination_path".tr,
                          //               style: TextStyle(
                          //                   fontSize: Get.width * 0.03,
                          //                   fontWeight: FontWeight.bold,
                          //                   color: AppColor.white),
                          //             ),
                          //           )),
                          //       Expanded(
                          //           flex: 2,
                          //           child: Center(
                          //             child: Text(
                          //               "price".tr,
                          //               style: TextStyle(
                          //                   fontSize: Get.width * 0.03,
                          //                   fontWeight: FontWeight.bold,
                          //                   color: AppColor.white),
                          //             ),
                          //           )),
                          //     ],
                          //   ),
                          // ),
                          Container(
                            width: Get.width,
                            height: MediaQuery.sizeOf(context).height * 0.05,
                            decoration: BoxDecoration(
                              color: Color(0XFF3967d7).withOpacity(0.1),
                              // borderRadius:
                              //     BorderRadius
                              //         .circular(
                              //             10)
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: Center(
                                      child: Text(
                                        "destination_path".tr,
                                        style: TextStyle(
                                            fontSize: Get.width * 0.03,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0XFF3967d7)),
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        "price".tr,
                                        style: TextStyle(
                                            fontSize: Get.width * 0.03,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0XFF3967d7)),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          ...widget.item.requestLines!.map((e) => SizedBox(
                                width: Get.width,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.05,
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              border: Border.symmetric(
                                                  vertical: BorderSide(
                                                      color: Color(0XFF3967d7)
                                                          .withOpacity(0.1))),
                                              color: Color(0XFF3967d7)
                                                  .withOpacity(0.05)),
                                          child: Center(
                                              child: Text(
                                            e.destName!,
                                            style: TextStyle(
                                                fontSize: Get.width * 0.03,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0XFF3967d7)
                                                    .withOpacity(0.7)),
                                          )),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              border: Border.symmetric(
                                                  vertical: BorderSide(
                                                      color: Color(0XFF3967d7)
                                                          .withOpacity(0.1))),
                                              color: Color(0XFF3967d7)
                                                  .withOpacity(0.05)),
                                          child: Center(
                                            child: Text(
                                              e.destPrice.toString(),
                                              style: TextStyle(
                                                  fontSize: Get.width * 0.03,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0XFF3967d7)
                                                      .withOpacity(0.7)),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              )),
                          // ...widget.item.requestLines!.map((e) => SizedBox(
                          //       width: Get.width,
                          //       height:
                          //           MediaQuery.sizeOf(context).height * 0.05,
                          //       child: Row(
                          //         children: [
                          //           Expanded(
                          //               flex: 5,
                          //               child: Center(
                          //                   child: Text(
                          //                 e.destName!,
                          //                 style: TextStyle(
                          //                     fontSize: Get.width * 0.03,
                          //                     fontWeight: FontWeight.bold,
                          //                     color: AppColor.brawn),
                          //               ))),
                          //           Expanded(
                          //               flex: 2,
                          //               child: Center(
                          //                 child: Text(
                          //                   e.destPrice.toString(),
                          //                   style: TextStyle(
                          //                       fontSize: Get.width * 0.03,
                          //                       fontWeight: FontWeight.bold,
                          //                       color: AppColor.brawn),
                          //                 ),
                          //               )),
                          //         ],
                          //       ),
                          //     )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("${widget.item.amoutTotal}",
                                    style: TextStyle(
                                        fontSize: Get.width * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0XFF3967d7))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    ));
  }
}
