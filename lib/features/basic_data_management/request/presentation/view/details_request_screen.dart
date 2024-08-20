import 'package:almirabi/core/shared_widgets/custom_app_bar.dart';
import 'package:almirabi/features/basic_data_management/request/data/request.dart';
import 'package:almirabi/features/basic_data_management/request/presentation/view/request_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/config/app_colors.dart';
import '../../../../../core/shared_widgets/app_custom_icon.dart';
import '../../../../../core/shared_widgets/app_custombackgrond.dart';
import '../../../car/domain/car_viewmodel.dart';
import '../../domain/request_viewmodel.dart';
import '../widgets/show_months_dailog.dart';
import 'add_edit_request_screen.dart';
import 'reports_list_screen.dart';

class DetailsRequestScreen extends StatefulWidget {
  DetailsRequestScreen({super.key, required this.item, this.isRequst = true});
  Requests item;
  bool isRequst;
  @override
  State<DetailsRequestScreen> createState() => _DetailsRequestScreenState();
}

class _DetailsRequestScreenState extends State<DetailsRequestScreen> {
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
      body: CustomBackGround(
          child: GetBuilder<RequestController>(builder: (controller) {
        return Column(
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
                        widget.isRequst
                            ? Get.offAll(() => const RequestListScreen())
                            : Get.offAll(() => const ReportScreen());
                      },
                      icon: CircleAvatar(
                          backgroundColor: AppColor.white,
                          child:
                              const Icon(Icons.arrow_back_ios_new_outlined))),
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
                    child: widget.isRequst
                        ? CircleAvatar(
                            backgroundColor: AppColor.white,
                            child: IconButton(
                                onPressed: () {
                                  Get.to(() => AddEditRequestScreen(
                                        objectToEdit: widget.item,
                                        isAdd: false,
                                      ));
                                },
                                icon: Icon(Icons.edit)))
                        : Container())
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
            Row(
              children: [
                CustomIcon(
                  assetPath: 'assets/images/delivery-truck.png',
                  size: Get.width * 0.1,
                ),
                Text(
                    '${carController.carList.firstWhere((e) => e.id == widget.item.car!.id).name}'),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.date_range_outlined,
                    color: AppColor.black,
                    size: Get.width * 0.1,
                  ),
                ),
                Text(
                    '${'month'.tr} : ${monthName(int.parse(widget.item.monthName!))}'),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Icon(
                          Icons.date_range_outlined,
                          color: AppColor.black,
                          size: Get.width * 0.1,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          "${'from'.tr} : ${widget.item.fromDate!.substring(0, 10)}",
                          style: TextStyle(
                              fontSize: Get.width * 0.03,
                              color: AppColor.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Icon(
                          Icons.date_range_outlined,
                          color: AppColor.black,
                          size: Get.width * 0.1,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          "${'to'.tr} : ${widget.item.toDate!.substring(0, 10)}",
                          style: TextStyle(
                              fontSize: Get.width * 0.03,
                              color: AppColor.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
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
                    size: Get.width * 0.1,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    "${widget.item.sourcePathName!.length > 17 ? '${widget.item.sourcePathName!.substring(0, 17)}...' : widget.item.sourcePathName} ",
                    style: TextStyle(
                        fontSize: Get.width * 0.03, color: AppColor.black),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(173, 89, 31, 200),
                          border: Border.all(color: AppColor.brawn),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("destination".tr,
                                  style: TextStyle(
                                      fontSize: Get.width * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.brawn)),
                              Text("${widget.item.amoutTotal}",
                                  style: TextStyle(
                                      fontSize: Get.width * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.brawn)),
                            ],
                          ),
                          Container(
                            width: Get.width,
                            height: MediaQuery.sizeOf(context).height * 0.05,
                            decoration: BoxDecoration(
                                color: AppColor.brawn,
                                border: Border.all(color: AppColor.brawn),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 6,
                                    child: Center(
                                      child: Text(
                                        "destination_path".tr,
                                        style: TextStyle(
                                            fontSize: Get.width * 0.03,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.white),
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
                                            color: AppColor.white),
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
                                        child: Center(
                                            child: Text(
                                          e.destName!,
                                          style: TextStyle(
                                              fontSize: Get.width * 0.03,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.brawn),
                                        ))),
                                    Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Text(
                                            e.destPrice.toString(),
                                            style: TextStyle(
                                                fontSize: Get.width * 0.03,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.brawn),
                                          ),
                                        )),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      })),
    ));
  }
}
