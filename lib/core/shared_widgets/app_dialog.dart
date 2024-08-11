import 'package:almirabi/core/shared_widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';
import '../config/app_enums.dart';
import '../config/app_lists.dart';
import '../config/app_styles.dart';

class CustomDialog {
  static CustomDialog? _instance;

  CustomDialog._();

  static CustomDialog getInstance() {
    _instance ??= CustomDialog._();
    return _instance!;
  }

  dialog(
      {required String title,
      required String message,
      String? primaryButtonText,
      String? secondaryButtonText,
      IconData? icon,
      MessageTypes dialogType = MessageTypes.success,
      Widget? content,
      double? fontSizeButton,
      double? fontSizetext,
      bool barrierDismissible = true,
      void Function()? onPressed,
      void Function()? secondaryOnPressed}) {
    Get.defaultDialog(
      title: title.tr,
      barrierDismissible: barrierDismissible,
      // titleStyle: TextStyle(fontSize: fontSizetext ?? 20),
      titlePadding: const EdgeInsets.only(top: 30.0),
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(
              icon ?? messageTypesIcon[dialogType]!.first as IconData,
              color: messageTypesIcon[dialogType]!.last as Color,
              size: Get.width * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(message,
                  textAlign: TextAlign.center,
                  style: AppStyle.textStyle(
                      fontSize: fontSizetext ?? 20,
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackwithopacity)),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            if (content != null) ...[
              Center(
                child: content,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (primaryButtonText != null) ...[
                  ButtonElevated(
                      text: primaryButtonText.tr,
                      width: Get.width / 7,
                      backgroundColor: AppColor.shadepurple,
                      textStyle: AppStyle.textStyle(
                          color: Colors.white,
                          fontSize: fontSizeButton ?? 20,
                          fontWeight: FontWeight.normal),
                      onPressed: onPressed),
                  // SizedBox(
                  //   width: Get.width * 0.01,
                  // ),
                ],
                SizedBox(
                  width: Get.width * 0.01,
                ),
                ButtonElevated(
                    text: secondaryButtonText ?? 'cancel'.tr,
                    width: Get.width / 8,
                    borderColor: AppColor.shadepurple,
                    textStyle: AppStyle.textStyle(
                        color: AppColor.shadepurple,
                        fontSize: fontSizeButton ?? 20,
                        fontWeight: FontWeight.normal),
                    onPressed: secondaryOnPressed ??
                        () async {
                          Get.back();
                        }),
              ],
            )
          ],
        ),
      ),
    );
  }

  itemDialog(
      {required String title,
      String? primaryButtonText,
      Widget? content,
      double? fontSizeButton,
      double? fontSizetext,
      bool barrierDismissible = true,
      GlobalKey<FormState>? formKey,
      GlobalKey<NavigatorState>? navigatorKey,
      void Function()? onPressed}) {
    Get.defaultDialog(
      navigatorKey: navigatorKey,
      title: title.tr,
      titlePadding: const EdgeInsets.only(top: 30.0),
      barrierDismissible: barrierDismissible,
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              if (content != null) ...[
                Center(
                  child: content,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (primaryButtonText != null) ...[
                    ButtonElevated(
                        text: primaryButtonText.tr,
                        width: Get.width / 7,
                        backgroundColor: AppColor.shadepurple,
                        textStyle: AppStyle.textStyle(
                            color: Colors.white,
                            fontSize: fontSizeButton ?? 20,
                            fontWeight: FontWeight.normal),
                        onPressed: onPressed),
                  ],
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
