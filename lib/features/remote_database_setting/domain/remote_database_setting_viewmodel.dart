import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'remote_database_setting_service.dart';

class DatabaseSettingLocalController extends GetxController {
  static DatabaseSettingLocalController? _instance;
  var isLoading = false.obs;
  RxString errorMessage = ''.obs;
  late RemoteDatabaseSettingService databaseSettingService;

  DatabaseSettingLocalController._() {
    databaseSettingService = RemoteDatabaseSettingService();
  }

  static DatabaseSettingLocalController getInstance() {
    _instance ??= DatabaseSettingLocalController._();
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
  // Future<ResponseResult> checkDatabase(
  //     SubscriptionInfo subscriptionInfo) async {
  //   isLoading.value = true;
  //   dynamic result;
  //   var connectivityResult = await (Connectivity().checkConnectivity());

  //   if (!connectivityResult.contains(ConnectivityResult.none)) {
  //     var checkConnectionResult = await RemoteDatabaseSettingService()
  //         .checkConnection(subscriptionInfo: subscriptionInfo);

  //     if (checkConnectionResult is bool && checkConnectionResult == true) {
  //       result = ResponseResult(status: true);
  //       await SharedPr.setRemoteDatabaseInfo(
  //           subscriptionInfo: subscriptionInfo);
  //     } else {
  //       result = ResponseResult(message: "invalid_dborurl_message".tr);
  //     }
  //   } else {
  //     result = ResponseResult(message: "no_connection".tr);
  //   }
  //   isLoading.value = false;
  //   return result!;
  // }

  // ========================================== [ checkDatabase ] =============================================
}
