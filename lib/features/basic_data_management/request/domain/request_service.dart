import 'package:almirabi/features/basic_data_management/request/data/request.dart';

import '../../../../core/config/app_table_structure.dart';
import '../../../../core/utils/general_local_db.dart';
import '../../../authentication/utils/handle_exception_helper.dart';
import 'request_repository.dart';

class RequestService extends RequestRepository {
  GeneralLocalDB<Requests>? _generalLocalDBInstance;
  static RequestService? requestDataServiceInstance;

  RequestService._() {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson)
            as GeneralLocalDB<Requests>?;
  }

  static RequestService getInstance() {
    requestDataServiceInstance =
        requestDataServiceInstance ?? RequestService._();
    return requestDataServiceInstance!;
  }

  @override
  Future createTable() async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson)
            as GeneralLocalDB<Requests>?;
    return await _generalLocalDBInstance!
        .createTable(structure: LocalDatabaseStructure.requestStructure);
  }

  @override
  Future dropTable() async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson)
            as GeneralLocalDB<Requests>?;
    return await _generalLocalDBInstance!.dropTable();
  }

  @override
  Future deleteData() async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson)
            as GeneralLocalDB<Requests>?;
    return await _generalLocalDBInstance!.deleteData();
  }

  @override
  Future index({int? offset, int? limit}) async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson)
            as GeneralLocalDB<Requests>?;
    return await _generalLocalDBInstance!.index(offset: offset, limit: limit);
  }

  @override
  Future show({required dynamic val}) async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson)
            as GeneralLocalDB<Requests>?;
    return await _generalLocalDBInstance!.show(val: val, whereArg: 'id');
  }

  @override
  Future<int> create({required obj, bool isRemotelyAdded = false}) async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson)
            as GeneralLocalDB<Requests>?;
    return await _generalLocalDBInstance!
        .create(obj: obj, isRemotelyAdded: isRemotelyAdded);
  }

  @override
  Future search(String query) async {
    try {
      _generalLocalDBInstance =
          GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson)
              as GeneralLocalDB<Requests>?;
      return await _generalLocalDBInstance!.filter(whereArgs: [
        '%$query%',
        '%$query%',
        '%$query%'
      ], where: 'product_name LIKE ? OR barcode LIKE ? OR default_code LIKE ?');
    } catch (e) {
      return handleException(
          exception: e, navigation: false, methodName: "ProductSearch");
    }
  }

  Future searchByState(String query) async {
    try {
      _generalLocalDBInstance =
          GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson)
              as GeneralLocalDB<Requests>?;
      return await _generalLocalDBInstance!
          .filter(whereArgs: [query], where: 'state = ?');
    } catch (e) {
      return handleException(
          exception: e, navigation: false, methodName: "searchByCateg");
    }
  }

  // object can be map or class object
  Future createRequestRemotely({required obj}) async {
    // try {
    //   int result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
    //     'model': OdooModels.productTemplate,
    //     'method': 'create',
    //     'args': [obj is Map<String, dynamic> ? obj : obj.toJson()],
    //     'kwargs': {},
    //   });
    //   // if (kDebugMode) {
    //   //   print('createProductRemotely : $result');
    //   // }
    //   return result;
    // } catch (e) {
    //   return handleException(
    //       exception: e, navigation: false, methodName: "createProductRemotely");
    // }
  }

  @override
  Future<int> update(
      {required int id, required obj, required String whereField}) async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson)
            as GeneralLocalDB<Requests>?;
    return await _generalLocalDBInstance!
        .update(id: id, obj: obj, whereField: 'id');
  }

  Future updateRequestRemotely({required int id, required obj}) async {
    // try {
    //   // print("id : $id");
    //   bool result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
    //     'model': OdooModels.productTemplate,
    //     'method': 'write',
    //     'args': [id, obj],
    //     'kwargs': {},
    //   });

    //   // if (kDebugMode) {
    //   //   print('updateProductRemotely : $result');
    //   // }
    //   return result;
    // } catch (e) {
    //   if (kDebugMode) {
    //     print("updateProductRemotely Exception : $e");
    //   }

    //   return handleException(
    //       exception: e, navigation: true, methodName: "updateProductRemotely");
    // }
  }
}
