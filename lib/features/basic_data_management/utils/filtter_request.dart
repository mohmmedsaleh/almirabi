import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_lists.dart';
import '../request/domain/request_viewmodel.dart';

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
                  item.key.text,
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
