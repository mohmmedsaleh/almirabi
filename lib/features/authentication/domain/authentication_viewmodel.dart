// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:almirabi/features/authentication/domain/authentication_service.dart';
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
    dynamic authResult = await authenticateService.authenticate(
        username: loginInfo.userName!, password: loginInfo.password!);

    if (authResult is User) {
      authResult.password = loginInfo.password;
      await saveUserDataLocally(authResult: authResult);
      authResult = ResponseResult(
          status: true, message: "Successful".tr, data: authResult);

      await SharedPr.setUserObj(userObj: authResult.data);
    } else {
      authResult = ResponseResult(message: authResult);
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
    Map<String, dynamic>? objToCreate = {
      'username': authResult.userName,
      'pincode': authResult.pinCode,
    };
    objToCreate.addIf(
        authResult.password != null, 'password', authResult.password);

    // print(objToCreate);
    bool userExist = await _generalLocalDBinstance!
        .checkRowExists(val: authResult.userName, whereKey: 'username');
    if (userExist) {
      await _generalLocalDBinstance!.update(
          id: authResult.userName, obj: objToCreate, whereField: 'username');
    } else {
      await _generalLocalDBinstance!.create(obj: objToCreate);
    }
  }

  // ========================================== [ AUTHENTICATE ] =============================================
}
