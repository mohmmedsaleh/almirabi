import 'package:get/get.dart';

import 'app_connectivity.dart';

class NetworkConnectivityChecker {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
