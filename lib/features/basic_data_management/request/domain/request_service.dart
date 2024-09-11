import 'package:almirabi/features/basic_data_management/request/data/request.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../core/config/app_enums.dart';
import '../../../../core/config/app_odoo_models.dart';
import '../../../../core/config/app_table_structure.dart';
import '../../../../core/utils/general_local_db.dart';
import '../../../authentication/utils/handle_exception_helper.dart';
import '../../../authentication/utils/odoo_connection_helper.dart';
import '../../source_path/data/source_path_line.dart';
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
  Future index({int? offset, int? limit, String? orderBy}) async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson)
            as GeneralLocalDB<Requests>?;
    return await _generalLocalDBInstance!
        .index(offset: offset, limit: limit, orderBy: orderBy);
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

  Future indexRemotly({required obj}) async {
    try {
      List listRequest = [];
      for (var e in (obj as List<Requests>)) {
        listRequest.add(e.requestsId);
      }

      var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
        'model': OdooModels.transfunctions,
        'method': 'return_driver_requests',
        'args': [listRequest],
        'kwargs': {
          // 'context': {},
          // 'domain': [
          //   ['id', 'in', listRequest]
          // ],
        },
      });
      if (kDebugMode) {
        print('indexRemotly : $result');
      }

      return result is List
          ? (result
              .map((e) => Requests.fromJson(e, fromTemblet: true))
              .toList())
          : 'failed_connect_server'.tr;
    } catch (e) {
      return handleException(
          exception: e, navigation: false, methodName: "indexRemotly");
    }
  }

  // object can be map or class object
  Future createRequestRemotely({required obj}) async {
    try {
      List listRequest = [];
      for (var e in (obj as List<Requests>)) {
        if (int.parse(e.monthName!) < 10) {
          e.monthName = '0${e.monthName!}';
        } else {
          e.monthName = e.monthName!.toString();
        }
        e.state = RequestState.closed;
        listRequest.add(e.toJson(isRemotelyAdded: true));
      }
      print(listRequest);
      // print(listRequest.last);
      // var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
      //   'model': OdooModels.requests,
      //   'method': 'search_read',
      //   'args': [],
      //   'kwargs': {},
      // });
      // print('object=============================');

      // var c = {
      //   // 'id': null,
      //   'product_car_id': 6287,
      //   'from_date': '2024-03-01',
      //   'to_date': '2024-03-31',
      //   'month_name': '03',
      //   'source_path_id': 2,
      //   // 'pricing_driving_ids': [2],
      //   // 'source_path_name':
      //   //     ' دوادمي+سكاكا+عرعر+رفحه - Duwadmi+Skaka+Arar+Rafha',
      //   'state': 'draft',
      //   'request_lines': [7],
      //   'driver_id': 541,
      //   // 'amout_total': 500.0
      // };
      // print(c);
      print([listRequest.first]);
      // var x = [
      //   {
      //     'product_car_id': 6287,
      //     'from_date': 2024 - 08 - 12,
      //     'to_date': 2024 - 08 - 14,
      //     'month_name': 05,
      //     'source_path_id': 2,
      //     'state': 'closed',
      //     'request_lines': [
      //       {
      //         "dest_id": 2,
      //         "dest_name": "عفيف+دوادمي+سكاكا+عرعر - Afif+Duwadmi+Skaka+Arar",
      //         "dest_price": 4000.0
      //       },
      //       {
      //         "dest_id": 2,
      //         "dest_name": "عفيف+دوادمي+سكاكا+عرعر - Afif+Duwadmi+Skaka+Arar",
      //         "dest_price": 4000.0
      //       }
      //     ],
      //     'driver_id': 541,
      //     'amout_total': 8000.0
      //   }
      // ];
      // var request_data = [
      //   {
      //     'product_car_id': 6287,
      //     'from_date': '2024-08-12',
      //     'to_date': '2024-08-14',
      //     'month_name': '05',
      //     'source_path_id': 2,
      //     // 'source_path_name': 'أفلاج - Aflaj',
      //     'state': 'draft',
      //     'request_lines': [
      //       {
      //         "dest_id": 2,
      //         "dest_name": "عفيف+دوادمي+سكاكا+عرعر - Afif+Duwadmi+Skaka+Arar",
      //         "dest_price": 4000.0
      //       },
      //       {
      //         "dest_id": 2,
      //         "dest_name": "عفيف+دوادمي+سكاكا+عرعر - Afif+Duwadmi+Skaka+Arar",
      //         "dest_price": 4000.0
      //       }
      //     ],
      //     'driver_id': 541,
      //     'amout_total': 4000.0
      //   }
      // ];
      var result2 = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
        'model': OdooModels.transfunctions,
        'method': 'create_driver_request',
        'args': [listRequest],
        'kwargs': {},
      });

      if (kDebugMode) {
        print('createRequestRemotely : $result2');
      }
      return result2 is List ? result2 : 'failed_connect_server'.tr;
    } catch (e) {
      print(e);
      return handleException(
          exception: e, navigation: false, methodName: "createRequestRemotely");
    }
  }

  Future createRequestLineRemotely({required obj}) async {
    try {
      // var result2 = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
      //   'model': OdooModels.transfunctions,
      //   'method': 'source_path_all',
      //   'args': [SharedPr.userObj!.id],
      //   'kwargs': {},
      // });

      // print(result2);
      var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
        'model': OdooModels.requestsLine,
        'method': 'search_read',
        'args': [],
        'kwargs': {},
      });
      // print('object=============================');
      // print("result=> $listRequest");

      // var c = {
      //   // 'id': null,
      //   'product_car_id': 6287,
      //   'from_date': '2024-03-01',
      //   'to_date': '2024-03-31',
      //   'month_name': '03',
      //   'source_path_id': 2,
      //   // 'pricing_driving_ids': [2],
      //   // 'source_path_name':
      //   //     ' دوادمي+سكاكا+عرعر+رفحه - Duwadmi+Skaka+Arar+Rafha',
      //   'state': 'draft',
      //   'request_lines': [7],
      //   'driver_id': 541,
      //   // 'amout_total': 500.0
      // };
      // print(c);
      var lines = obj.requestLines;
      var linesconected = [];
      for (var i = 0; i < (lines as List<SourcePathLine>).length; i++) {
        var lineData = {
          'source_path_id': obj.sourcePathId,
          'header_id': obj.requestsId,
          'destination_path_id': lines[i].destId,
          'price': lines[i].destPrice
        };
        linesconected.add(lineData);
      }
      var result3 = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
        'model': OdooModels.requestsLine,
        'method': 'create',
        'args': [linesconected],
        'kwargs': {},
      });
      if (kDebugMode) {
        print('createProductRemotely : $result3');
      }
      return result3;
    } catch (e) {
      return handleException(
          exception: e,
          navigation: false,
          methodName: "createRequestLineRemotely");
    }
  }

  @override
  Future<int> update(
      {required int id, required obj, required String whereField}) async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson)
            as GeneralLocalDB<Requests>?;
    return await _generalLocalDBInstance!
        .update(id: id, obj: obj, whereField: whereField);
  }

  @override
  Future updateWhere(
      {required int id,
      required obj,
      required columnToUpdate,
      required String whereField}) async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson)
            as GeneralLocalDB<Requests>?;
    return await _generalLocalDBInstance!.updatewhere(
        id: id,
        obj: obj,
        whereField: whereField,
        columnToUpdate: columnToUpdate);
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
  deleteRequste({
    required int id,
  }) async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson)
            as GeneralLocalDB<Requests>?;
    return await _generalLocalDBInstance!.delete(id: id, whereField: 'id');
  }
}
