import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:odoo_rpc/odoo_rpc.dart';
import '../../../core/config/app_shared_pr.dart';
import '../../../core/config/app_urls.dart';
import '../../authentication/utils/handle_exception_helper.dart';
import '../data/subscription_info.dart';
import 'remote_database_setting_repository.dart';

class RemoteDatabaseSettingService implements RemoteDatabaseSettingRepository {
  static late OdooClient odooClient;
  static late OdooSession odooSession;

  static Future instantiateOdooConnection({url, db, username, password}) async {
    try {
      // odooClient = OdooClient(url ?? hudaUrl);
      // odooSession = await odooClient.authenticate(
      //     db ?? "mydb", username ?? "admin", password ?? "admin");

      // odooClient = OdooClient(url ?? amalUrl2);
      // odooSession = await odooClient.authenticate(
      //     db ?? "mydb", username ?? "admin", password ?? "admin");

      odooClient = OdooClient(url ?? remoteURL);
      odooSession = await odooClient.authenticate(db ?? remotedB,
          username ?? remoteUsername, password ?? remotePassword);

      await SharedPr.setSessionId(
          sessionId: "session_id=${odooSession.id}"); // output OdooSession
      return true;
    } on OdooException {
      if (kDebugMode) {
        // print('OdooException : ${e.toString()}');
      }
      return 'login_information_incorrect'.tr;
    } catch (e) {
      // if (kDebugMode) {
      //   print('Exception : ${e.toString()}');
      // }
      return '${'failed_connect_server'.tr} - ${odooClient.baseURL}';
      // throw Exception('${'failed_connect_server'.tr} - ${odooClient.baseURL}');

      // return 'exception'.tr;
      // return '${'failed_connect_server'.tr} - ${odooClient.baseURL}';
    }
  }

  // ========================================== [ Check Connection ] =============================================

  @override
  Future checkConnection(
      {required SubscriptionInfo subscriptionInfo}) async {
    try {
      print('${subscriptionInfo.url}/web/login?db=${subscriptionInfo.db}');
      http.Response resBody = await http.get(Uri.parse(
          '${subscriptionInfo.url}/web/login?db=${subscriptionInfo.db}'));
      if (resBody.statusCode == 200) {
        if (kDebugMode) {
          //print(resBody.statusCode);
        }
        return true;
      }
      return false;
    } catch (e) {
      return handleException(
          exception: e, navigation: false, methodName: "checkConnection");
    }
  }

  // ========================================== [ Check Connection ] =============================================
  
}
