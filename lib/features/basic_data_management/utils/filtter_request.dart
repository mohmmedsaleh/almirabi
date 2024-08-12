import 'package:almirabi/features/basic_data_management/request/data/request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:popover/popover.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_lists.dart';
import '../../../core/config/app_shared_pr.dart';
import '../../../core/config/app_styles.dart';
import '../request/domain/request_viewmodel.dart';

filtterRequestByState(
    {required BuildContext context,
    required List<Requests> requests,
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
          ...stateList.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  requestController.searchByState(item.name);
                  requestController.searchProductController.text =
                      "${item.name}";
                },
                child: Text(
                  item.text,
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
