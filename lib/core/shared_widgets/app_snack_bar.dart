import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_enums.dart';
import '../config/app_lists.dart';

void appSnackBar(
    {required dynamic message,
    MessageTypes messageType = MessageTypes.error,
    isDismissible = true}) {
  Get.rawSnackbar(
    messageText: message is String
        ? Text(message,
            style: TextStyle(color: Colors.white, fontSize: Get.height * 0.02))
        : message,
    isDismissible: isDismissible,
    duration: const Duration(seconds: 2),
    backgroundColor: messageTypesIcon[messageType]!.last as Color,
    icon: Icon(
      messageTypesIcon[messageType]!.first as IconData,
      color: Colors.white,
      size: Get.height * 0.03,
    ),
    margin: EdgeInsets.zero,
    snackStyle: SnackStyle.GROUNDED,
  );
}
