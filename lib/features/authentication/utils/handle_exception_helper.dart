import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

String handleException(
    {dynamic exception, bool navigation = false, String? methodName}) {
  if (exception is OdooSessionExpiredException) {
    // if (navigation) {
    //   Get.offAll(() => const LoginScreen());
    // }
    return 'session_expired'.tr;
  } else if (exception is OdooException) {
    // if (kDebugMode) {
    //   print('${'failed_connect_server'.tr} - $exception');
    // }

    return 'failed_connect_server'.tr;
  } else if (exception is SocketException) {
    // if (kDebugMode) {
    //   print("$methodName Socket Exception : $exception");
    // }
    return "no_connection".tr;
  } else {
    if (kDebugMode) {
      print("$methodName Exception : $exception");
    }
    return "exception".tr;
  }
}
