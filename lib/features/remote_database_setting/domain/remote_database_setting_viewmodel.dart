import 'dart:io';

import 'package:get/get.dart';
import '../../../core/config/app_shared_pr.dart';
import '../../../core/utils/response_result.dart';
import '../data/subscription_info.dart';
import 'remote_database_setting_service.dart';

class DatabaseSettingController extends GetxController {
  static DatabaseSettingController? _instance;
  var isLoading = false.obs;
  late RemoteDatabaseSettingService databaseSettingService;

  DatabaseSettingController._() {
    databaseSettingService = RemoteDatabaseSettingService();
  }

  static DatabaseSettingController getInstance() {
    _instance ??= DatabaseSettingController._();
    return _instance!;
  }

  // ========================================== [ checkDatabase ] =============================================
  /*
  cheack key login
    if correct return RemoteDatabaseSetting
      cheack Connection to db and  url
        if true save to local
        if false retern Invalid Database name or URL , please submit a ticket for Server verification
    if Subscription ended return string
    if SocketException return You Don't have an Internet Connection
    else return Failed to connect with server
  */
  Future<ResponseResult> checkDatabase(SubscriptionInfo subscriptionInfo) async {
    isLoading.value = true;
    dynamic result;
      var checkConnectionResult = await RemoteDatabaseSettingService()
          .checkConnection(subscriptionInfo: subscriptionInfo);

      if (checkConnectionResult is bool && checkConnectionResult == true) {
        result = ResponseResult(status: true);
             await SharedPr.setRemoteDatabaseInfo(
          subscriptionInfo: subscriptionInfo);
      } else {
        result = ResponseResult(
            message: "invalid_dborurl_message".tr);
      }
    isLoading.value = false;
    return result!;
  }

  // ========================================== [ checkDatabase ] =============================================
}
