import 'dart:convert';
import 'dart:ui';

import 'package:almirabi/features/basic_data_management/car/data/car.dart';
import 'package:almirabi/features/basic_data_management/source_path/data/source_path.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/authentication/data/user.dart';
import '../../features/remote_database_setting/data/subscription_info.dart';

class SharedPr {
  SharedPr._();

  static SharedPreferences? _prefs;

  static Future<SharedPreferences> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // =================== [ VARIABLE DECLARATION ] ==========================
  static String? _lang, _userObj, _sessionId, _subscriptionDetailsObj;

  // =================== [ VARIABLE DECLARATION ] ==========================

  // ===================== [ GET ACCESSORS ] ============================
  static String? get lang => _lang ?? Get.deviceLocale!.languageCode;
  static String? get sessionId => _sessionId;
  static SubscriptionInfo? get subscriptionDetailsObj =>
      _subscriptionDetailsObj == null
          ? null
          : SubscriptionInfo.fromJson(jsonDecode(_subscriptionDetailsObj!));
  static User? get userObj =>
      _userObj == null ? null : User.fromJson(jsonDecode(_userObj!));
  // ===================== [ GET ACCESSORS ] ============================

  static void retrieveInfo() {
    _lang = _prefs!.getString('lang');
    _sessionId = _prefs!.getString('session_id');
    _subscriptionDetailsObj = _prefs!.getString('subscriptionDetailsObj');
    _userObj = _prefs!.getString('userObj');
  }

  // ============================ [ LANGUAGE INFO ] ====================================
  static Future<bool> setLanguage({required String lang}) async {
    await _prefs!.setString('lang', lang);
    _lang = lang;
    Get.updateLocale(Locale(lang));
    return true;
  }

  // ============================ [ LANGUAGE INFO ] ====================================
  // ============================ [ Remote Database Info ] ====================================
  static Future<bool> setRemoteDatabaseInfo(
      {required SubscriptionInfo subscriptionInfo}) async {
    String convertedUserObj = jsonEncode(subscriptionInfo.toJson());
    await _prefs!.setString('subscriptionDetailsObj', convertedUserObj);
    _subscriptionDetailsObj = convertedUserObj;
    return true;
  }
  // ============================ [ Remote Database Info ] ====================================

  // ============================ [ USER OBJECT INFO ] ====================================
  static Future<bool> setUserObj({required User userObj}) async {
    String convertedUserObj = jsonEncode(userObj.toJson());
    await _prefs!.setString('userObj', convertedUserObj);
    _userObj = convertedUserObj;
    return true;
  }

  static Future<bool> updateUserObj({required User updateData}) async {
    User user = User(
        id: userObj!.id,
        name: userObj!.name,
        image_1920: userObj!.image_1920,
        sourcePath: SourcePath(
            sourcePathId: updateData.sourcePath!.sourcePathId,
            sourcePathName: updateData.sourcePath!.sourcePathName,
            car: Car(
                id: updateData.sourcePath!.car!.id,
                name: updateData.sourcePath!.car!.name),
            lins: updateData.sourcePath!.lins));
    String convertedUserObj = jsonEncode(user.toJson());
    await _prefs!.setString('userObj', convertedUserObj);
    _userObj = convertedUserObj;
    return true;
  }
  // ============================ [ USER OBJECT INFO ] ====================================

  static Future<bool> setSessionId({required String sessionId}) async {
    await _prefs!.setString('session_id', sessionId);
    _sessionId = sessionId;
    return true;
  }

  static Future<bool> removeUserObj() async {
    await _prefs!.remove('userObj');
    _userObj = null;
    return true;
  }
  // ============================ [ USER OBJECT INFO ] ====================================

  // ============================ [ SET CURRENT POS INFO AND TOKEN ] ====================================
  static Future<bool> removeUnnecessarryInfoIftheDeveiceNotTrusted() async {
    await _prefs!.remove('userObj');
    _userObj = null;
    await _prefs!.remove('session_id');
    _sessionId = null;

    return true;
  }
}
