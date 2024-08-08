import 'dart:io';

import 'package:get/get.dart';
import '../../../core/utils/response_result.dart';
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
  Future<ResponseResult> checkDatabase(String loginKey) async {
    isLoading.value = true;
    dynamic result;
    // var databaseSettingResult =
    //     await databaseSettingService.checkKeyLogin(loginKey: loginKey);

    // if (databaseSettingResult is SubscriptionInfo) {
    //   await SharedPr.setRemoteDatabaseInfo(
    //       subscriptionInfo: databaseSettingResult);

    //   var checkConnectionResult = await RemoteDatabaseSettingService()
    //       .checkConnection(databaseSettingModel: databaseSettingResult);

    //   if (checkConnectionResult is bool && checkConnectionResult == true) {
    //     result = ResponseResult(status: true);
    //   } else {
    //     result = ResponseResult(
    //         data: databaseSettingResult.subscriptionId,
    //         message: "send_ticket_message".tr);

    //     databaseSettingResult
    //       ..db
    //       ..url = null;
    //     await SharedPr.setRemoteDatabaseInfo(
    //         subscriptionInfo: databaseSettingResult);
    //   }
    // } else if (databaseSettingResult is String) {
    //   result = ResponseResult(message: databaseSettingResult);
    // } else if (databaseSettingResult is SocketException) {
    //   result = ResponseResult(message: "no_connection".tr);
    // } else {
    //   result = ResponseResult(message: databaseSettingResult.toString());
    // }
    isLoading.value = false;
    return result!;
  }

  // ========================================== [ checkDatabase ] =============================================
}
