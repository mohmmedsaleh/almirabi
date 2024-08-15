import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '../shared_widgets/app_snack_bar.dart';
import 'app_enums.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      appSnackBar(
          message: 'no_connection'.tr,
          messageType: MessageTypes.connectivityOff,
          isDismissible: false);
    } else {
      appSnackBar(
          message: 'connection_is_back'.tr, messageType: MessageTypes.success);
    }
  }
}
