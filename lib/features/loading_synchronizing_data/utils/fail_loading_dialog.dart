import 'package:almirabi/features/authentication/presentation/views/login_screen.dart';
import 'package:get/get.dart';

import '../../../core/shared_widgets/app_dialog.dart';
import '../../../core/utils/create_local_db_tables.dart';
import '../presentation/views/data_loading_screen.dart';

void failLoadingDialog() {
  CustomDialog.getInstance().dialog(
      title: 'error_message',
      message: 'loading_error'.tr,
      primaryButtonText: 'retry',
      onPressed: () async {
        Get.back();
        await DBHelper.dropDBTable(isDeleteBasicData: true);
        await DBHelper.createDBTables();
        Get.offAll(() => const DataLoadingScreen());
      },
      secondaryOnPressed: () async {
        await DBHelper.dropDBTable(isDeleteBasicData: true);
        await DBHelper.createDBTables();
        Get.offAll(() => const LoginScreen2());
      });
}
