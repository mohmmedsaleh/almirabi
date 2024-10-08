import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../../../core/config/app_shared_pr.dart';

class OdooProjectOwnerConnectionHelper {
  static late OdooClient odooClient;
  static OdooSession? odooSession;
  static bool sessionClosed = false;

  static Future instantiateOdooConnection(
      {required String username, required String password}) async {
    // change
    try {
      odooClient = OdooClient(SharedPr.subscriptionDetailsObj!.url!);
      odooSession = await odooClient.authenticate(
          SharedPr.subscriptionDetailsObj!.db!, username, password);
      SharedPr.setSessionId(sessionId: "session_id=${odooSession!.id}");
    } on OdooException {
      if (kDebugMode) {
        //  print('OdooException : ${e.toString()}');
      }
      return 'login_information_incorrect'.tr;
    } catch (e) {
      // sessionClosed = true;
      // if (kDebugMode) {
      //   print('Exception : ${e.toString()}');
      // }
      return 'exception'.tr;
    }
  }
}
