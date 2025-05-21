// ignore_for_file: type_literal_in_constant_pattern

import 'package:almirabi/features/authentication/data/user.dart';
import 'package:almirabi/features/basic_data_management/source_path/data/source_path.dart';
import 'package:get/get.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../../../core/config/app_odoo_models.dart';
import '../../../core/config/app_shared_pr.dart';
import '../../../core/utils/define_type_function.dart';
import '../../../core/utils/general_local_db.dart';
import '../../authentication/utils/handle_exception_helper.dart';
import '../../authentication/utils/odoo_connection_helper.dart';

import 'loading_synchronizing_data_repository.dart';

class LoadingSynchronizingDataService
    extends LoadingSynchronizingDataRepository {
  GeneralLocalDB? _instance;

  LoadingSynchronizingDataService({type}) {
    _instance = getLocalInstanceType(type: type);
    // switch (type) {
    //   case ProductUnit:
    //     _instance = GeneralLocalDB.getInstance<ProductUnit>(
    //         fromJsonFun: ProductUnit.fromJson);
    //     break;
    //   case Product:
    //     _instance =
    //         GeneralLocalDB.getInstance<Product>(fromJsonFun: Product.fromJson);
    //     break;
    //   case PosCategory:
    //     _instance = GeneralLocalDB.getInstance<PosCategory>(
    //         fromJsonFun: PosCategory.fromJson);
    //     break;
    //   case Customer:
    //     _instance = GeneralLocalDB.getInstance<Customer>(
    //         fromJsonFun: Customer.fromJson);
    //     break;

    //   default:
    // }
  }

  @override
  Future<dynamic> loadData() async {
    try {
      // var result2 = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
      //   'model': OdooModels.hremployee,
      //   'method': 'search_read',
      //   'args': [],
      //   'kwargs': {
      //     'context': {},
      //     'domain': [
      //       // ['car_flag', '=', true],
      //     ],
      //     // 'fields': ['name'],
      //   },
      // });
      var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
        'model': OdooModels.transfunctions,
        'method': 'product_car_list',
        'args': [SharedPr.userObj!.id],
        'kwargs': {},
      });
      if (result is bool) {
        return result;
      }
      print('product_car_list : $result');
      return result is bool
          ? <User>[]
          : (result as List).map((e) => User.fromJson(e)).toList();
    } on OdooSessionExpiredException {
      // OdooProjectOwnerConnectionHelper.sessionClosed = true;
      // if (kDebugMode) {
      //   print("session_expired");
      // }
      return 'session_expired'.tr;
    } on OdooException catch (e) {
      return e.toString().replaceFirst('Exception: ', '');
    } catch (e) {
      return handleException(
          exception: e, navigation: false, methodName: "loadCars");
    }
  }

  @override
  Future updateData(
      {required int id,
      required obj,
      required columnToUpdate,
      required String whereField}) async {
    GeneralLocalDB<User>? generalLocalDBInstance =
        GeneralLocalDB.getInstance<User>(fromJsonFun: User.fromJson)
            as GeneralLocalDB<User>?;
    return await generalLocalDBInstance!.updatewhere(
        id: id,
        obj: obj,
        whereField: whereField,
        columnToUpdate: columnToUpdate);
  }
  // @override
  // Future<dynamic> loadRequest() async {
  //   try {
  //     print('load requests :===========${SharedPr.userObj!}========');
  //     // var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //     //   'model': OdooModels.requests,
  //     //   'method': 'search_read',
  //     //   'args': [],
  //     //   'kwargs': {
  //     //     'context': {},
  //     //     'domain': [
  //     //       // ['', '=', true],
  //     //     ],
  //     //     // 'fields': ['name'],
  //     //   },
  //     // });
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.transfunctions,
  //       'method': 'return_driver_requests_list',
  //       'args': [SharedPr.userObj!.id],
  //       'kwargs': {},
  //     });
  //     if (result is bool) {
  //       return result;
  //     }
  //     print('result : $result');
  //     // var result2 = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //     //   'model': OdooModels.transfunctions,
  //     //   'method': 'source_path_list',
  //     //   'args': [541, 6287],
  //     //   'kwargs': {},
  //     // });
  //     // print('result : ${result2}');
  //     return result.isEmpty
  //         ? <Requests>[]
  //         : (result as List).map((e) => Requests.fromJson(e)).toList();
  //   } on OdooSessionExpiredException {
  //     // OdooProjectOwnerConnectionHelper.sessionClosed = true;
  //     // if (kDebugMode) {
  //     //   print("session_expired");
  //     // }
  //     return 'session_expired'.tr;
  //   } on OdooException catch (e) {
  //     print(e);
  //     return e.toString().replaceFirst('Exception: ', '');
  //   } catch (e) {
  //     print(e);
  //     return handleException(
  //         exception: e,
  //         navigation: false,
  //         methodName: "loadUserPosSettingInfo");
  //   }
  // }

  @override
  Future<dynamic> loadSourcePath() async {
    try {
      var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
        'model': OdooModels.transfunctions,
        'method': 'source_path_all',
        'args': [SharedPr.userObj!.id],
        'kwargs': {},
      });
      if (result is bool) {
        return result;
      }
      return result.isEmpty
          ? <SourcePath>[]
          : (result as List).map((e) => SourcePath.fromJson(e)).toList();
    } on OdooSessionExpiredException {
      // OdooProjectOwnerConnectionHelper.sessionClosed = true;
      // if (kDebugMode) {
      //   print("session_expired");
      // }
      return 'session_expired'.tr;
    } on OdooException catch (e) {
      return e.toString().replaceFirst('Exception: ', '');
    } catch (e) {
      return handleException(
          exception: e, navigation: false, methodName: "loadSourcePath");
    }
  }
  // @override
  // Future<dynamic> loadCustomerInfo() async {
  //   try {
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.customer,
  //       'method': 'search_read',
  //       'args': [],
  //       'kwargs': {
  //         'context': {},
  //         'domain': [
  //           ['customer_rank', '>', 0],
  //           ['active', '=', true],
  //         ],
  //         'fields': [
  //           'name',
  //           'email',
  //           'phone',
  //           'customer_rank',
  //           'image_1920',
  //           'vat'
  //         ],
  //         'order': 'id'
  //       },
  //     });
  //     // if (kDebugMode) {
  //     //   print("loadCustomerInfo: ${result.length}");
  //     //   print("loadCustomerInfo: ${result}");
  //     // }
  //     return result.isEmpty
  //         ? <Customer>[]
  //         : (result as List).map((e) => Customer.fromJson(e)).toList();
  //   } catch (e) {
  //     return handleException(
  //         exception: e, navigation: false, methodName: "loadCustomerInfo");
  //   }
  // }

  // @override
  // Future<dynamic> loadCurrentUserPosSettingInfo(
  //     {required int posSettingId}) async {
  //   try {
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.posSetting,
  //       'method': 'search_read',
  //       'args': [],
  //       'kwargs': {
  //         'context': {},
  //         'domain': [
  //           ['id', '=', posSettingId],
  //         ],
  //         'fields': [],
  //       },
  //     });
  //     return result == null ? null : PosSettingInfo.fromJson(result.first);
  //   } catch (e) {
  //     return handleException(
  //         exception: e,
  //         navigation: false,
  //         methodName: "loadCurrentUserPosSettingInfo");
  //   }
  // }

  // @override
  // Future loadPosCategoryBasedOnUser() async {
  //   try {
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.posCategoryTransit,
  //       'method': 'get_translated_category_names',
  //       'args': [SharedPr.currentPosId],
  //       'kwargs': {
  //         // 'context': {},
  //         // 'domain': [
  //         //   ['id', 'in', posCategoriesIds]
  //         // ],
  //         // 'fields': [],
  //       },
  //     });
  //     // if (kDebugMode) {
  //     //   print("loadPosCategoryBasedOnUser");
  //     // }
  //     return result.isEmpty
  //         ? <PosCategory>[]
  //         : (result as List)
  //             .map((e) => PosCategory.fromJson(e, fromPosCategoryModel: false))
  //             .toList();
  //   } catch (e) {
  //     return handleException(
  //         exception: e,
  //         navigation: false,
  //         methodName: "loadPosCategoryBasedOnUser");
  //   }
  // }

  // @override
  // Future loadProductUnitData() async {
  //   try {
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.uomUom,
  //       'method': 'get_translated_uom_names',
  //       'args': [],
  //       'kwargs': {
  //         // 'context': {},
  //         // 'domain': [
  //         //   ['active', '=', true]
  //         //   // ['is_pos_groupable', '=', true]
  //         // ],
  //         // 'fields': [],
  //       },
  //     });
  //     return result.isEmpty
  //         ? <ProductUnit>[]
  //         : (result as List)
  //             .map((e) => ProductUnit.fromJson(e, fromLocal: false))
  //             .toList();
  //   } catch (e) {
  //     return handleException(
  //         exception: e, navigation: false, methodName: "loadProductUnitData");
  //   }
  // }

  // @override
  // Future loadPosSession() async {
  //   try {
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': 'so.pos.session',
  //       'method': 'search_read',
  //       'args': [],
  //       'kwargs': {
  //         'context': {},
  //         'domain': [
  //           ['pos_id', '=', SharedPr.currentPosId]
  //         ],
  //       },
  //     });
  //     return result.isEmpty || result == null
  //         ? <PosSession>[]
  //         : (result as List)
  //             .map((e) => PosSession.fromJson(e, fromLocal: false))
  //             .toList();
  //   } catch (e) {
  //     return handleException(
  //         exception: e, navigation: false, methodName: "getAllPosSession");
  //   }
  // }

  // @override
  // Future loadProductDataBasedOnPosCategory(
  //     {required List<int> posCategoriesIds}) async {
  //   try {
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.posSetting,
  //       'method': 'get_products_by_pos_category',
  //       'args': [SharedPr.currentPosId],
  //       'kwargs': {},
  //     });
  //     //
  //     // if (kDebugMode) {
  //     //   print('loadProductDataBasedOnPosCategory length : ${result.length}');
  //     //   print('loadProductDataBasedOnPosCategory result : $result');
  //     // }
  //     return result.isEmpty
  //         ? <Product>[]
  //         : (result as List).map<Product>((e) => Product.fromJson(e)).toList();
  //   } catch (e) {
  //     // print(e);
  //     return handleException(
  //         exception: e,
  //         navigation: false,
  //         methodName: "loadProductDataBasedOnPosCategory");
  //   }
  // }

  // @override
  // Future getProductHistory() async {
  //   try {
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.itemsHistory,
  //       'method': 'search_read',
  //       'args': [],
  //       'domain': [
  //         ['type_name', '=', 'product.template'],
  //         // ['used_by', 'ilike', '%${SharedPr.currentPosId}%' ]
  //       ],
  //       'kwargs': {},
  //     });

  //     return result.isEmpty
  //         ? <int>[]
  //         : (result as List).map((e) => e["product_id"][0]).toList();
  //   } catch (e) {
  //     return handleException(
  //         exception: e, navigation: false, methodName: "getProductHistory");
  //   }
  // }

  // @override
  // Future getFilteredHistory(
  //     {required List<int> excludeIds,
  //     required String typeName,
  //     required int currentPosId}) async {
  //   try {
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.itemsHistory,
  //       'method': 'get_filtered_history',
  //       'args': [excludeIds, typeName, SharedPr.currentPosId],
  //       'domain': [],
  //       'kwargs': {},
  //     });
  //     if (kDebugMode) {
  //       print(
  //           'excludeIds : $excludeIds, typeName : $typeName, currentPosId : $currentPosId');
  //       print("getFilteredHistory result : $result");
  //     }

  //     return result.isEmpty || result == null
  //         ? <BasicItemHistory>[]
  //         : (result as List).map((e) => BasicItemHistory.fromJson(e)).toList();
  //   } catch (e) {
  //     // print("catch $e");
  //     return handleException(
  //         exception: e, navigation: false, methodName: "getFilteredHistory");
  //   }
  // }

  // Future getFilteredHistoryIsNotLocall({
  //   required List<int> excludeIds,
  //   required String typeName,
  //   required List<int> userPosCategories,
  //   required List ids,
  //   required String domain,
  // }) async {
  //   try {
  //     // if (kDebugMode) {
  //     //   print("excludeIds $excludeIds");
  //     //   print("typeName $typeName");
  //     //   print("userPosCategories $userPosCategories");
  //     //   print("ids $ids");
  //     //   print("domain $domain");
  //     // }
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.itemsHistory,
  //       'method': 'get_filtered_history',
  //       'args': [excludeIds, typeName, userPosCategories],
  //       'domain': ids.isEmpty
  //           ? [
  //               ['is_added', '=', false],
  //             ]
  //           : [
  //               [domain, 'not in', ids],
  //               ['is_added', '=', false],
  //             ],
  //       'kwargs': {},
  //     });
  //     // if (kDebugMode) {
  //     //   print("update+++++++ $result");
  //     // }
  //     return result.isEmpty || result == null
  //         ? <BasicItemHistory>[]
  //         : (result as List).map((e) => BasicItemHistory.fromJson(e)).toList();
  //   } catch (e) {
  //     return handleException(
  //         exception: e, navigation: false, methodName: "getFilteredHistory");
  //   }
  // }

  // @override
  // Future getProductByIds({required List ids}) async {
  //   try {
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.product,
  //       'method': 'search_read',
  //       'args': [],
  //       'kwargs': {
  //         'domain': [
  //           ['id', 'in', ids],
  //           ['active', '=', true],
  //           ['pos_available', '=', true]
  //         ],
  //         'fields': [
  //           'id',
  //           'name',
  //           'product_tmpl_id',
  //           'uom_id',
  //           'uom_name',
  //           'so_pos_categ_id',
  //           'default_code',
  //           'barcode',
  //           'image_1920',
  //           'currency_id',
  //           'unit_price'
  //         ],
  //       },
  //     });

  //     result.isEmpty
  //         ? null
  //         : (result as List).map((e) => Product.fromJson(e)).toList();
  //   } catch (e) {
  //     return handleException(
  //         exception: e, navigation: false, methodName: "getProductByIds");
  //   }
  // }

  // // @override
  // // Future updateItemHistory({required List<BasicItemHistory> itemHistory}) async {
  // //   List<Map<String, dynamic>> usedByList = [];
  // //   for (var item in itemHistory) {
  // //     if (item.id == null) continue;
  // //     Set usedBySet = item.usedBy!.toSet();
  // //     usedBySet.addAll(<int>[SharedPr.currentPosId!]);
  // //     usedByList.add({'id': item.id, 'used_by': usedBySet.toList()});
  // //   }
  // //   if (kDebugMode) {
  // //     print('usedByList : $usedByList');
  // //   }
  // //
  // //   try {
  // //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  // //       'model': OdooModels.posSetting,
  // //       'method': 'bulk_update_used_by',
  // //       'args': [usedByList],
  // //       'kwargs': {},
  // //     });
  // //     if (kDebugMode) {
  // //       print("updateItemHistory result $result");
  // //     }
  // //
  // //     return result == null ? false : true;
  // //   } catch (e) {
  // //     return handleException(
  // //         exception: e, navigation: false, methodName: "updateItemHistory");
  // //   }
  // // }
  // @override
  // Future updateItemHistory({required String typeName, int? itemId}) async {
  //   try {
  //     var listToSend = [SharedPr.currentPosId, typeName];
  //     listToSend.addIf(itemId != null, itemId);
  //     if (kDebugMode) {
  //       print(listToSend);
  //     }
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.itemsHistory,
  //       'method': 'bulk_update_used_by',
  //       'args': listToSend,
  //       'kwargs': {},
  //     });
  //     if (kDebugMode) {
  //       print("updateItemHistory result $result");
  //     }

  //     return result == null ? false : true;
  //   } catch (e) {
  //     return handleException(
  //         exception: e, navigation: false, methodName: "updateItemHistory");
  //   }
  // }

  // @override
  // Future deleteProductHistory({required List<int> ids}) async {
  //   try {
  //     bool result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.itemsHistory,
  //       'method': 'unlink',
  //       'args': [ids],
  //       'kwargs': {},
  //     });

  //     return result;
  //   } catch (e) {
  //     return handleException(
  //         exception: e, navigation: false, methodName: "deleteProductHistory");
  //   }
  // }

  // @override
  // Future refreshLocalDataFromRemoteServer(
  //     {required String typeName, required List<int> userPosCategories}) async {
  //   try {
  //     // fetch the data from server model product_history
  //     // var remoteProductHistory = await getProductHistory();
  //     var remoteProductHistory = await getFilteredHistory(
  //         excludeIds: <int>[SharedPr.currentPosId!],
  //         typeName: typeName,
  //         currentPosId: SharedPr.currentPosId!);

  //     // check If there is any  data
  //     if (remoteProductHistory!.isNotEmpty &&
  //         remoteProductHistory.runtimeType != String) {
  //       List<Product> productToInsert =
  //           (remoteProductHistory as List<BasicItemHistory>)
  //               .where((element) => element.isAdded!)
  //               .map((e) => e.product!)
  //               .toList();

  //       List<Product> productToUpdate = (remoteProductHistory)
  //           .where((element) => !element.isAdded!)
  //           .map((e) => e.product!)
  //           .toList();

  //       var updateCount = await _instance!
  //           .updateList(recordsList: productToUpdate, whereKey: 'product_id');

  //       var createCount =
  //           await _instance!.createList(recordsList: productToInsert);

  //       var prodects = remoteProductHistory.map((e) => e.productId!).toList();
  //       if ((productToUpdate.isNotEmpty && updateCount > 0) ||
  //           (productToInsert.isNotEmpty && createCount > 0)) {
  //         // delete the data from the server model product_history
  //         await deleteProductHistory(ids: prodects);
  //       }

  //       // if (updateCount > 0 && createCount > 0) {
  //       //   var prodects = remoteProductHistory.map((e) => e.productId!).toList();
  //       //   if (kDebugMode) {
  //       //     print("befor delete ++++++++++++++++++++");
  //       //   }
  //       //   // delete the data from the server model product_history
  //       //   await deleteProductHistory(ids: prodects);
  //       //   print("after delete ++++++++++++++++++++");
  //       // }
  //     }
  //   } catch (e) {
  //     return handleException(
  //         exception: e,
  //         navigation: false,
  //         methodName: "refreshLocalDataFromRemoteServer");
  //   }
  // }

  // Future getLocalIds<T>() async {
  //   try {
  //     _instance = getLocalInstanceType<T>();
  //     List result = await _instance!.index();
  //     return result.isEmpty ? [] : result.map((e) => e.id).toList();
  //   } catch (e) {
  //     return handleException(
  //         exception: e, navigation: false, methodName: "getLocal$T Ids");
  //   }
  // }

  // Future getLocalData<T>({required ids}) async {
  //   try {
  //     List result;
  //     _instance = getLocalInstanceType<T>();
  //     if (T == Product) {
  //       result = await _instance!.filter(
  //           where:
  //               'product_id IN (${List.generate(ids.length, (_) => '?').join(', ')})',
  //           whereArgs: ids);
  //     } else {
  //       result = await _instance!.filter(
  //           where:
  //               'id IN (${List.generate(ids.length, (_) => '?').join(', ')})',
  //           whereArgs: ids);
  //     }

  //     return result;
  //   } catch (e) {
  //     return handleException(
  //         exception: e, navigation: false, methodName: "getLocalData$T");
  //   }
  // }

  // // Future getCountRemotProduct({required List<int> posCategoriesIds}) async {
  // //   try {
  // //     if (kDebugMode) {
  // //       print("get from remot +++++ $posCategoriesIds");
  // //     }
  // //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  // //       'model': OdooModels.productTemplate,
  // //       'method': 'search_count',
  // //       'args': [],
  // //       'kwargs': {
  // //         'domain': [
  // //           ['so_pos_categ_id', 'in', posCategoriesIds],
  // //           ['pos_available', '=', true],
  // //           ['active', '=', true]
  // //         ],
  // //       },
  // //     });
  // //     return result;
  // //   } catch (e) {
  // //     return handleException(
  // //         exception: e, navigation: false, methodName: "getCountRemotProduct");
  // //   }
  // // }

  // Future getRemotProductIsNotIds(
  //     {required List<int> ids, required List<int> posCategoriesIds}) async {
  //   try {
  //     if (kDebugMode) {
  //       print("getRemotProductIsNotIds ids+++++++ : $ids");
  //       print("posCategoriesIds ids+++++++ : $posCategoriesIds");
  //     }
  //     // OdooProjectOwnerConnectionHelper.odooClient.frontendLang =
  //     //     SharedPr.lang == 'ar' ? 'ar_001' : 'en_US';
  //     List result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.productTemplate,
  //       'method': 'search_read',
  //       'args': [],
  //       'kwargs': {
  //         'domain': [
  //           ['id', 'not in', ids],
  //           ['so_pos_categ_id', 'in', posCategoriesIds],
  //           ['active', '=', true],
  //           ['pos_available', '=', true]
  //         ],
  //         // 'fields': ["display_name", 'name'],
  //         'context': {'lang': SharedPr.lang == 'ar' ? 'ar_001' : 'en_US'}
  //       },
  //     });
  //     print("getRemotProductByIds $result");
  //     print("getRemotProductByIds ${result.length}");
  //     return result.isEmpty
  //         ? null
  //         : result.map((e) => Product.fromJson(e, fromTemblet: true)).toList();
  //   } catch (e) {
  //     print("object+++ $e");
  //     return handleException(
  //         exception: e,
  //         navigation: false,
  //         methodName: "getRemotProductIsNotIds");
  //   }
  // }

  // Future getCountDataLocal<T>() async {
  //   try {
  //     _instance = getLocalInstanceType<T>();

  //     var result = await _instance!.checkIfThereIsRowsInTable();
  //     return result;
  //   } catch (e) {
  //     return handleException(
  //         exception: e, navigation: false, methodName: "getCountLocal$T");
  //   }
  // }

  // Future countAll() async {
  //   try {
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.itemsHistory,
  //       'method': 'count_all',
  //       'args': [SharedPr.currentPosId],
  //       'kwargs': {},
  //     });
  //     return CountItems.fromJson(result);
  //   } catch (e) {
  //     return handleException(
  //         exception: e, navigation: false, methodName: "countAll");
  //   }
  // }

  // Future getCountDeleteData(
  //     {required List<int> excludeIds, required String typeName}) async {
  //   try {
  //     var result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
  //       'model': OdooModels.itemsHistory,
  //       'method': 'get_filtered_history',
  //       'args': [excludeIds, typeName, SharedPr.currentPosId],
  //       // 'domain': [],
  //       'domain': [
  //         ["is_deleted", '=', true]
  //       ],
  //       'kwargs': {},
  //     });
  //     if (kDebugMode) {
  //       print(
  //           'excludeIds delete : $excludeIds, typeName : $typeName, currentPosId : ${SharedPr.currentPosId}');
  //       // print("getCountDeleteData result : $result");
  //     }
  //     return result.isEmpty || result == null
  //         ? <BasicItemHistory>[]
  //         : (result as List).map((e) => BasicItemHistory.fromJson(e)).toList();
  //   } catch (e) {
  //     return handleException(
  //         exception: e, navigation: false, methodName: "getCountDeleteData");
  //   }
  // }
}
