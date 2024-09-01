// ignore_for_file: non_constant_identifier_names

import 'package:almirabi/features/authentication/domain/authentication_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_shared_pr.dart';
import '../../../core/config/app_table_structure.dart';
import '../../../core/utils/general_local_db.dart';
import '../../../core/utils/response_result.dart';
import '../data/login_info.dart';
import '../data/user.dart';

class AuthenticationController extends GetxController {
  final loginPinLoading = false.obs;
  final loading = false.obs;
  bool choosePin = false;
  GeneralLocalDB? _generalLocalDBinstance;

  TextEditingController pinKeyController = TextEditingController();
  static AuthenticationController? _instance;
  late AuthenticationService authenticateService;

  AuthenticationController._() {
    authenticateService = AuthenticationService.getInstance();
  }

  static AuthenticationController getInstance() {
    _instance ??= AuthenticationController._();
    return _instance!;
  }

  // ========================================== [ AUTHENTICATE ] =============================================
  Future<ResponseResult> authenticateUsingUsernameAndPassword(
      LoginInfo loginInfo) async {
    loading.value = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    dynamic authResult;
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      authResult = await authenticateService.authenticate(
          visaNumber: loginInfo.visaNumber!, pinNumber: loginInfo.pinNumber!);
      print(authResult);
      if (authResult is User) {
        await saveUserDataLocally(authResult: authResult);
        SharedPr.setUserObj(userObj: authResult);
        authResult = ResponseResult(
            status: true, message: "Successful".tr, data: authResult);

        await SharedPr.setUserObj(userObj: authResult.data);
      } else {
        authResult = ResponseResult(message: authResult);
      }
    } else {
      authResult = ResponseResult(message: "no_connection".tr);
    }
    loading.value = false;
    return authResult;
  }

  //  HELPER FUNCTION
  Future<void> saveUserDataLocally({required User authResult}) async {
    _generalLocalDBinstance =
        GeneralLocalDB.getInstance<User>(fromJsonFun: User.fromJson);
    await _generalLocalDBinstance!
        .createTable(structure: LocalDatabaseStructure.userStructure);
    // Map<String, dynamic>? objToCreate = {
    //   'username': authResult.userName,
    //   'pincode': authResult.pinCode,
    // };
    // objToCreate.addIf(
    //     authResult.password != null, 'password', authResult.password);

    // print(objToCreate);
    bool userExist = await _generalLocalDBinstance!
        .checkRowExists(val: authResult.id, whereKey: 'driver_id');
    if (userExist) {
      await _generalLocalDBinstance!
          .update(id: authResult.id, obj: authResult, whereField: 'driver_id');
    } else {
      await _generalLocalDBinstance!.create(obj: authResult);
    }
  }

  // ========================================== [ AUTHENTICATE ] =============================================
}
