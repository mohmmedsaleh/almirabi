import '../../features/authentication/utils/handle_exception_helper.dart';
import '../../features/authentication/utils/odoo_connection_helper.dart';

class GeneralOdooFun<T> {
  // T Function(Map<String, dynamic> data, {bool fromLocal})? fromJson;
  static GeneralOdooFun? _instance;
  late String modelName;

  // GeneralOdooFun._({required this.fromJson, required this.modelName}) {
  //   if (kDebugMode) {
  //     print("modelName : $modelName");
  //     print("T : $T");
  //   }
  // }
  GeneralOdooFun._({required this.modelName}) {
    // if (kDebugMode) {
    //   print("modelName : $modelName");
    //   print("T : $T");
    // }
  }

  static GeneralOdooFun? getInstance<T>(
      {required fromJsonFun, required modelName}) {
    if (_instance != null && _instance!.getType() != T.toString()) {
      _instance = null;
    }
    _instance = _instance ?? GeneralOdooFun<T>._(modelName: modelName);
    // _instance = _instance ??
    //     GeneralOdooFun<T>._(fromJson: fromJsonFun, modelName: modelName);
    return _instance;
  }

  Future create({required data, bool isRemotelyAdded = false}) async {
    try {
      var createId = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
        'model': modelName,
        'method': 'create',
        'args': [data.toJson(isRemotelyAdded: true)],
        'kwargs': {},
      });
      return createId;
    } catch (e) {
      return handleException(
          exception: e, navigation: true, methodName: "create$T");
    }
  }

  // Future index({List<String>? fields, bool fromLocal = true}) async {
  //   try {
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': modelName,
  //       'method': 'search_read',
  //       'args': [],
  //       'kwargs': {
  //         'context': {},
  //         'domain': [],
  //         'fields': fields == null ? fields : [],
  //         'order': 'id'
  //       },
  //     });
  //     return result.isEmpty || result == null
  //         ? null
  //         : result.map((e) => fromJson!(e,fromLocal: fromLocal)).toList();
  //   } catch (e) {handleException(exception: e, navigation: true, methodName: "getAll$T");
  //   }
  // }
  Future index({List<String>? fields}) async {
    try {
      var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
        'model': modelName,
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {},
          'domain': [],
          'fields': fields == null ? fields : [],
          'order': 'id'
        },
      });
      return result.isEmpty || result == null ? null : result;
    } catch (e) {
      return handleException(
          exception: e, navigation: true, methodName: "getAll$T");
    }
  }

  Future count() async {
    try {
      var countData = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
        'model': modelName,
        'method': 'search_read',
        'args': [],
        'kwargs': {},
      });
      return countData.isEmpty || countData == null ? 0 : countData.length;
    } catch (e) {
      return handleException(
          exception: e, navigation: true, methodName: "Count$T");
    }
  }

  // Future show({required int id, List<String>? fields ,bool fromLocal = true }) async {
  //   try {
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': modelName,
  //       'method': 'search_read',
  //       'args': [],
  //       'kwargs': {
  //         'context': {},
  //         'domain': [
  //           ['id', '=', id]
  //         ],
  //         'fields': fields == null ? fields : [],
  //         'order': 'id'
  //       },
  //     });
  //     return result.isEmpty || result == null ? null : fromJson!(result.first,fromLocal: fromLocal);
  //   } catch (e) {
  //     handleException(
  //         exception: e, navigation: true, methodName: "get $T ById");
  //   }
  // }
  Future show({required int id, List<String>? fields}) async {
    try {
      var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
        'model': modelName,
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {},
          'domain': [
            ['id', '=', id]
          ],
          'fields': fields ?? [],
          'order': 'id'
        },
      });
      return result.isEmpty || result == null ? null : result.first;
    } catch (e) {
      return handleException(
          exception: e, navigation: true, methodName: "get $T ById");
    }
  }

  Future delete({required int id}) async {
    try {
      bool result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
        'model': modelName,
        'method': 'unlink',
        'args': [id],
        'kwargs': {},
      });
      return result;
    } catch (e) {
      return handleException(
          exception: e, navigation: true, methodName: "delete $T");
    }
  }

  Future update({required int id, required dataUpdated}) async {
    try {
      bool result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
        'model': modelName,
        'method': 'write',
        'args': [
          id,
          dataUpdated.toJson(),
        ],
        'kwargs': {},
      });

      return result;
    } catch (e) {
      return handleException(
          exception: e, navigation: true, methodName: "update $T");
    }
  }

  String getType() {
    String runtimeType = this.runtimeType.toString();
    RegExp regExp = RegExp(r'<(.*?)>');
    Match? match = regExp.firstMatch(runtimeType);

    if (match != null) {
      return match.group(1)!;
    } else {
      throw Exception("No match found");
    }
  }
}
