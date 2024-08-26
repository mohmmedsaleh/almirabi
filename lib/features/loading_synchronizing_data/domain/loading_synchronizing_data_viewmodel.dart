// ignore_for_file: type_literal_in_constant_pattern, unnecessary_type_check

import 'dart:async';

import 'package:almirabi/features/basic_data_management/car/data/car.dart';
import 'package:almirabi/features/basic_data_management/source_path/data/source_path.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../../core/utils/define_type_function.dart';

import '../../../core/utils/general_local_db.dart';

import '../../basic_data_management/request/presentation/view/request_list_screen.dart';
import '../utils/fail_loading_dialog.dart';
import 'loading_synchronizing_data_service.dart';

class LoadingDataController extends GetxController {
  var isLoad = false.obs;
  var isRefresh = false.obs;
  var isUpdate = false.obs;
  var loadText = ''.obs;
  var loadTital = ''.obs;
  Map itemdata = {};
  bool isSelctedAll = false;
  String? itemUpdate;
  var countLoadData = RxMap();
  var lengthRemote = 0.obs;
  var isLoadData = false.obs;
  var isLoading = false.obs;
  bool fromReportScreen = false;
  // CustomerController customerController = Get.put(CustomerController());

  GeneralLocalDB? _instance;

  int count = 0;
  late LoadingSynchronizingDataService loadingSynchronizingDataService =
      LoadingSynchronizingDataService();
  List<int> posCategoryIdsList = [];

  LoadingDataController({bool fromReportsScreen = false}) {
    fromReportScreen = fromReportsScreen;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      loadingData();
      // await loadingPosCategoryIdsList();
      // await loadingRequest();
      // await loadingProduct(posCategoriesIds: posCategoryIdsList);
      // await loadingCustomer();
      // await loadingProductUnit();
      // await loadingPosSession();
      // _instance = getLocalInstanceType<Requests>();
      // _instance!.deleteData();
      update();
    } catch (_) {
      failLoadingDialog();
    }
  }

  loadingData({bool islogin = true}) async {
    isLoading.value = true;
    await loadingCar();
    // await loadingRequest();
    await loadingSourcePath();
    isLoading.value = false;
    if (fromReportScreen == false) {
      Get.offAll(() => const RequestListScreen2());
    }
  }

//   // =================================================== [ LOADING CURRENT POS SETTING ] ==========================================================
//   Future<dynamic> loadingCurrentPosSetting({required int posSettingId}) async {
//     isLoad.value = true;
//     dynamic result = await loadingSynchronizingDataService
//         .loadCurrentUserPosSettingInfo(posSettingId: posSettingId);
//     if (result is PosSettingInfo) {
//       result =
//           ResponseResult(status: true, message: "Successful".tr, data: result);
//     } else {
//       result = ResponseResult(message: result);
//     }
//     isLoad.value = false;
//     return result;
//   }

//   // =================================================== [ LOADING CURRENT POS SETTING ] ==========================================================

//   // =================================================== [ LOADING CURRENT POS SETTING CATEGORIES ] ==========================================================
//   Future<dynamic> loadingPosCategoryIdsList() async {
//     ResponseResult posSettingInfoListResult =
//         await loadingCurrentPosSetting(posSettingId: SharedPr.currentPosId!);

//     if (posSettingInfoListResult.status &&
//         (posSettingInfoListResult.data as PosSettingInfo)
//             .posCategoryIds!
//             .isNotEmpty) {
//       posCategoryIdsList =
//           (posSettingInfoListResult.data as PosSettingInfo).posCategoryIds!;
//     }

//     // if (kDebugMode) {
//     //   print("posCategoryIdsList : $posCategoryIdsList");
//     // }
//     return posCategoryIdsList;
//   }

//   // =================================================== [ LOADING CURRENT POS SETTING CATEGORIES ] ==========================================================

//   // ============================================================= [ START LOADING BASIC DATA ] ====================================================================

//   // [ LOADING PRODUCT UNITS ] ==========================================================
//   Future<void> loadingProductUnit() async {
//     isLoad.value = true;
//     loadText.value = 'Product Unit Loading';
//     loadTital.value = "Product Unit Loading";
//     isLoadData.value = true;
//     lengthRemote.value = 0;
//     final LoadingItemsCountController loadingItemsCountController =
//         Get.put(LoadingItemsCountController());
//     loadingItemsCountController.resetLoadingItemCount();
//     var list = await loadingSynchronizingDataService.loadProductUnitData();
//     isLoadData.value = false;
//     if (list is List) {
//       loadTital.value = "Create Product Unit";
//       lengthRemote.value = list.length;

//       await saveInLocalDB<ProductUnit>(list: list as List<ProductUnit>);
//     }
//     // print("=>>>>>>>>>>>>> ${countLoadData[loadTital]}");
//     // List<ProductUnit> list =
//     //     await loadingSynchronizingDataService.loadProductUnitData();
//     // await saveInLocalDB<ProductUnit>(list: list);
//     loadText.value = 'Completed';
//     isLoad.value = false;
//   }

//   Future<void> loadingPosSession() async {
//     isLoad.value = true;
//     loadText.value = 'Pos Session Loading';
//     loadTital.value = "Pos Session Loading";
//     isLoadData.value = true;

//     final LoadingItemsCountController loadingItemsCountController =
//         Get.put(LoadingItemsCountController());
//     loadingItemsCountController.resetLoadingItemCount();
//     lengthRemote.value = 0;
//     var list = await loadingSynchronizingDataService.loadPosSession();
//     isLoadData.value = false;
//     if (list is List && list.isNotEmpty) {
//       loadTital.value = "Create Pos Session";
//       lengthRemote.value = list.length;
//       _instance = GeneralLocalDB.getInstance<PosSession>(
//           fromJsonFun: PosSession.fromJson);
//       await _instance!.deleteData();
//       if (list.isNotEmpty) await _instance!.createList(recordsList: list);
//     }
//     loadText.value = 'Completed';
//     isLoad.value = false;
//   }

//   // [ LOADING PRODUCTS ] ===============================================================
//   Future<void> loadingProduct({required List<int> posCategoriesIds}) async {
//     isLoad.value = true;
//     loadText.value = 'Product Loading';
//     loadTital.value = "Product Loading";
//     isLoadData.value = true;

//     final LoadingItemsCountController loadingItemsCountController =
//         Get.put(LoadingItemsCountController());
//     loadingItemsCountController.resetLoadingItemCount();
//     lengthRemote.value = 0;
//     var list = await loadingSynchronizingDataService
//         .loadProductDataBasedOnPosCategory(posCategoriesIds: posCategoriesIds);
//     isLoadData.value = false;
//     if (list is List) {
//       loadTital.value = "Create Product";
//       lengthRemote.value = list.length;
//       await saveInLocalDB<Product>(list: list as List<Product>);
//     }

//     // List<Product> list = await loadingSynchronizingDataService
//     //     .loadProductDataBasedOnPosCategory(posCategoriesIds: posCategoriesIds);
//     // await saveInLocalDB<Product>(list: list);
//     loadText.value = 'Completed';
//     isLoad.value = false;
//   }

  // [ LOADING POS CATEGORIES ] ===============================================================
  Future<void> loadingCar() async {
    isLoad.value = true;
    loadText.value = 'PosCategories Loading';

    loadTital.value = "Pos Category Loading";
    isLoadData.value = true;
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (!connectivityResult.contains(ConnectivityResult.none)) {
      lengthRemote.value = 0;
      var result = await loadingSynchronizingDataService.loadCars();
      isLoadData.value = false;
      if (result is List) {
        loadTital.value = "Create Pos Category";
        lengthRemote.value = result.length;
        await saveInLocalDB<Car>(list: result as List<Car>);
      }
    }
    // List<PosCategory> list = await loadingSynchronizingDataService
    //     .loadPosCategoryBasedOnUser(posCategoriesIds: posCategoriesIds);
    // await saveInLocalDB<PosCategory>(list: list);
    loadText.value = 'Completed';
    isLoad.value = false;
  }

  // Future<void> loadingRequest() async {
  //   print('=====================');
  //   isLoad.value = true;
  //   loadText.value = 'PosCategories Loading';

  //   loadTital.value = "Pos Category Loading";
  //   isLoadData.value = true;

  //   lengthRemote.value = 0;
  //   var result = await loadingSynchronizingDataService.loadRequest();
  //   print('result : $result');
  //   isLoadData.value = false;
  //   if (result is List) {
  //     loadTital.value = "Create Pos Category";
  //     lengthRemote.value = result.length;
  //     await saveInLocalDB<Requests>(list: result as List<Requests>);
  //   }
  //   // List<PosCategory> list = await loadingSynchronizingDataService
  //   //     .loadPosCategoryBasedOnUser(posCategoriesIds: posCategoriesIds);
  //   // await saveInLocalDB<PosCategory>(list: list);
  //   loadText.value = 'Completed';
  //   isLoad.value = false;
  // }

  Future<void> loadingSourcePath() async {
    isLoad.value = true;
    loadText.value = 'PosCategories Loading';

    loadTital.value = "Pos Category Loading";
    isLoadData.value = true;

    lengthRemote.value = 0;
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (!connectivityResult.contains(ConnectivityResult.none)) {
      var result = await loadingSynchronizingDataService.loadSourcePath();
      isLoadData.value = false;
      if (result is List) {
        loadTital.value = "Create Pos Category";
        lengthRemote.value = result.length;

        await saveInLocalDB<SourcePath>(list: result as List<SourcePath>);
      }
    }
    // List<PosCategory> list = await loadingSynchronizingDataService
    //     .loadPosCategoryBasedOnUser(posCategoriesIds: posCategoriesIds);
    // await saveInLocalDB<PosCategory>(list: list);
    loadText.value = 'Completed';
    isLoad.value = false;
  }
//   // [ LOADING CUSTOMERS ] ===============================================================
//   Future<void> loadingCustomer() async {
//     isLoad.value = true;
//     loadText.value = 'Customer Loading';
//     loadTital.value = "Customer Loading";
//     isLoadData.value = true;

//     final LoadingItemsCountController loadingItemsCountController =
//         Get.put(LoadingItemsCountController());
//     loadingItemsCountController.resetLoadingItemCount();
//     lengthRemote.value = 0;
//     var result = await loadingSynchronizingDataService.loadCustomerInfo();
//     isLoadData.value = false;
//     if (result is List) {
//       loadTital.value = "Create Customer";
//       lengthRemote.value = result.length;
//       await saveInLocalDB<Customer>(list: result as List<Customer>);
//     }
//     // List<Customer> list =
//     //     await loadingSynchronizingDataService.loadCustomerInfo();
//     // await saveInLocalDB<Customer>(list: list);

//     loadText.value = 'Completed';
//     isLoad.value = false;
//   }

//   // ============================================================= [ END LOADING BASIC DATA ] ====================================================================

//   // ============================================================= [ START SYNCHRONIZE LOCAL DB ] ====================================================================
//   Future<void> loadingData({required String type}) async {
//     Type typex = getModelClass(type);
//     // print('loadingData loadingData : $typex');
//     try {
//       if (typex == Product) {
//         await loadingProduct(posCategoriesIds: posCategoryIdsList);
//       } else if (typex == Customer) {
//         await loadingCustomer();
//       } else if (typex == ProductUnit) {
//         await loadingProductUnit();
//       } else if (typex == PosCategory) {
//         await loadingPosCategories(posCategoriesIds: posCategoryIdsList);
//       }
//     } catch (e) {
//       handleException(
//           exception: e, navigation: false, methodName: "loadingData $typex");
//     }
//   }

//   Future<bool?> synchronizeDB<T>({bool show = true}) async {
//     // CHECK IF DEVICE IS TRUSTED
//     bool isTrustedDevice = await MacAddressHelper.isTrustedDevice();
//     if (!isTrustedDevice) {
//       return null;
//     }
//     // CHECK CHECKSUM OF TWO LOCAL DB
//     bool? isIdenticalChecksum =
//         await compareDataChecksum<T>(posCategoriesIds: posCategoryIdsList);
//     if (kDebugMode) {
//       print("isIdenticalChecksum : $isIdenticalChecksum");
//     }
//     if (isIdenticalChecksum != null && isIdenticalChecksum) {
//       // if (kDebugMode) {
//       //   print("true true true");
//       // }
//       return true;
//     } else if (isIdenticalChecksum != null && !isIdenticalChecksum) {
//       if (show) {
//         appSnackBar(
//             message: 'synchronize_now'.tr,
//             messageType: MessageTypes.success,
//             isDismissible: false);
//       }

//       await updateHistoryBasedOnItemType<T>();
//       return false;
//     }
//     return null;
//   }

//   Future<bool?> compareDataChecksum<T>(
//       {required List<int> posCategoriesIds}) async {
//     late dynamic remoteCheckSum, itemsList;

//     remoteCheckSum = await loadingSynchronizingDataService
//         .getItemCheckSumRemotely<T>(posCategoriesId: posCategoriesIds);
//     _instance = getLocalInstanceType<T>();

//     itemsList = await _instance!.index();

//     if (remoteCheckSum is String) {
//       var localChecksum = await loadingSynchronizingDataService
//           .getCheckSumLocally<T>(recordsList: itemsList);
//       if (localChecksum is String) {
//         if (kDebugMode) {
//           print('localChecksum : $localChecksum');
//         }
//         if (remoteCheckSum == localChecksum) {
//           return true;
//         } else {
//           return false;
//         }
//       } else {
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }

  saveInLocalDB<T>({required List<T> list}) async {
    _instance = getLocalInstanceType<T>();
    // if (kDebugMode) {
    //   print("saveInLocalDB _instance : $_instance");
    //   print("saveInLocalDB _updateFunction : $_instance");
    // }

    // if (kDebugMode) {
    //   print('count list:$count');
    // }

    // if (kDebugMode) {
    //   print('_instance list : $_instance');
    // }
    _instance!.deleteData();
    if (list.isNotEmpty) {
      await _instance!.createList(recordsList: list);

      // var createList =
      // await _instance!.createList(recordsList: list).then((_) async {
      //   await _itemHistoryController.updateHistoryRecordOnFirstLogin<T>();
      //   await checkIsRegisteredController<T>();
      // }).catchError((_) {
      //   failLoadingDialog();
      // });
      // if (createList is int) {
      //   // await _instance!.index();
      //   await _itemHistoryController.updateHistoryRecordOnFirstLogin<T>();
      //   await checkIsRegisteredController<T>();
      // } else {
      //   failLoadingDialog();
      // }
    }
  }

//   // ============================================================= [ END SYNCHRONIZE LOCAL DB ] ====================================================================

// // ========================================== [ GET PRODUCT HISTORY ] =============================================
//   Future<ResponseResult> getProductHistory() async {
//     var result = await loadingSynchronizingDataService.getProductHistory();
//     if (result is List<BasicItemHistory>) {
//       return ResponseResult(status: true, data: result);
//     } else if (result == []) {
//       return ResponseResult(message: "empty_list".tr);
//     } else if (result is SocketException) {
//       return ResponseResult(message: "no_connection".tr);
//     } else {
//       return ResponseResult(message: result);
//     }
//   }

//   Future<ResponseResult> getFilteredHistory(
//       {required List<int> excludeIds, required String typeName}) async {
//     var result = await loadingSynchronizingDataService.getFilteredHistory(
//         excludeIds: excludeIds,
//         typeName: typeName,
//         // userPosCategories: posCategoryIdsList);
//         currentPosId: SharedPr.currentPosId!);
//     if (result is List<BasicItemHistory>) {
//       return ResponseResult(status: true, data: result);
//     } else if (result == []) {
//       return ResponseResult(message: "empty_list".tr);
//     } else if (result is SocketException) {
//       return ResponseResult(message: "no_connection".tr);
//     } else {
//       return ResponseResult(message: result);
//     }
//   }

//   // [ STEP (2) - DIVIDE ITEMS BASED ON STATUS ] =================================================================

//   Future<void> divideItemsBasedOnStatus<T>(
//       {required ResponseResult itemsHistoryList}) async {
//     // if (kDebugMode) {
//     //   print("divideItemsBasedOnStatus of type $T");
//     // }
//     if (T == ProductUnit) {
//       return;
//     }

//     // print(T);
//     _instance ??= getLocalInstanceType<T>();

//     List<dynamic> localIds = await _instance!.getIdsOnly();
//     // if (kDebugMode) {
//     //   print(localIds);
//     // }

//     BasicItemProcessor<T> processor =
//         getProcessor<T>(localIds: localIds.map<int>((e) => e).toList());
//     // Process items for T type
//     processItems<T>(
//         itemsHistoryList: itemsHistoryList.data, processor: processor);
//   }

//   BasicItemProcessor<T> getProcessor<T>({required List<int> localIds}) {
//     if (T == Product) {
//       return ProductProcessor(localIds: localIds) as BasicItemProcessor<T>;
//     } else if (T == Customer) {
//       return CustomerProcessor(localIds: localIds) as BasicItemProcessor<T>;
//     } else if (T == PosCategory) {
//       return PosCategoryProcessor(localIds: localIds) as BasicItemProcessor<T>;
//     } else {
//       throw Exception('Processor not defined for type $T');
//     }
//   }

//   Future<void> processItems<T>(
//       {required List<BasicItemHistory> itemsHistoryList,
//       required BasicItemProcessor<T> processor}) async {
//     List<T> insertList = [];
//     List<T> updateList = [];
//     List<int> deleteList = [];

//     for (BasicItemHistory element in itemsHistoryList) {
//       if (processor.shouldInsert(
//           element: element, posCategoryIds: posCategoryIdsList)) {
//         insertList.add(processor.processElement(element: element) as T);
//       } else if (processor.shouldUpdate(element: element)) {
//         updateList.add(processor.processElement(element: element) as T);
//       } else if (processor.shouldDelete(element: element)) {
//         deleteList.add(
//             processor.processElement(element: element, isDelete: true) as int);
//       }
//     }
//     if (kDebugMode) {
//       print('ToUpdate : $updateList');
//       print('deleteList : $deleteList');
//       print('insertList : $insertList');
//     }
//     // if (kDebugMode) {
//     //   print('$T ToUpdate _instance : $_instance');
//     // }
//     if (updateList.isNotEmpty) {
//       // if (kDebugMode) {
//       //   print('ToUpdate : $updateList');
//       // }
//       // var updatedata =
//       // await _instance!
//       //     .updateList(recordsList: updateList, whereKey: 'id')
//       //     .then((_) {})
//       //     .catchError((_) {
//       //   failLoadingDialog();
//       // });
//       // if (updatedata is int) {
//       // } else {
//       //   failLoadingDialog();
//       // }

//       await _instance!.updateList(recordsList: updateList, whereKey: 'id');
//     }

//     if (insertList.isNotEmpty) {
//       // if (kDebugMode) {
//       //   print('$T ToInsert.isNotEmpty : ${insertList.isNotEmpty}');
//       // }
//       // var createList =
//       // await _instance!
//       //     .createList(recordsList: insertList)
//       //     .then((_) {})
//       //     .catchError((_) {
//       //   failLoadingDialog();
//       // });
//       // if (createList is int) {
//       // } else {
//       //   failLoadingDialog();
//       // }

//       await _instance!.createList(recordsList: insertList);
//     }

//     if (deleteList.isNotEmpty) {
//       // if (kDebugMode) {
//       //   print('$T ToDelete.isNotEmpty : ${deleteList.isNotEmpty}');
//       // }

//       // await deleteUntouchedRecordsFromHistory();
//       await _instance!.deleteList(
//           recordsList: deleteList,
//           whereKey: T == Product ? 'product_id' : 'id');
//     }

//     // Do something with insertList, updateList, and deleteList
//     // if (kDebugMode) {
//     //   print('Insert List: $insertList');
//     //   print('Update List: $updateList');
//     //   print('Delete List: $deleteList');
//     // }
//   }

//   // [ STEP (3) - UPDATE ITEM HISTORY REMOTELY ] =================================================================
//   // updateItemHistoryRemotely({required ResponseResult historyList}) async {
//   //   await loadingSynchronizingDataService.updateItemHistory(
//   //       itemHistory: historyList.data);
//   // }

//   updateItemHistoryRemotely({required String typeName}) async {
//     await loadingSynchronizingDataService.updateItemHistory(typeName: typeName);
//   }

//   // [ STEP (4) - UPDATE HISTORY BASED ON ITEM TYPE ] =================================================================
//   updateHistoryBasedOnItemType<T>() async {
//     // if (kDebugMode) {
//     //   print("typeNameX type $T");
//     // }
//     String typeNameX = getOdooModels<T>();

//     if (kDebugMode) {
//       print("typeNameX type $typeNameX");
//     }

//     var result = await getFilteredHistory(
//         excludeIds: <int>[SharedPr.currentPosId!], typeName: typeNameX);
//     // if (kDebugMode) {
//     //   print("FilteredHistory ${result.status}");
//     // }

//     if (result.status) {
//       await divideItemsBasedOnStatus<T>(itemsHistoryList: result);
//       // if (kDebugMode) {
//       //   print('divideItemsBasedOnStatus executed');
//       // }
//       await updateItemHistoryRemotely(typeName: typeNameX);
//       // if (kDebugMode) {
//       //   print('divideItemsBasedOnStatus executed');
//       // }
//       // change
//       await checkIsRegisteredController<T>();
//     } else {
//       // if (kDebugMode) {
//       //   print(result.message);
//       // }
//     }
//   }

//   // =========================================================== [ SAVE IN LOCAL DB ] ==========================================================
//   // change
//   Future checkIsRegisteredController<T>() async {
//     if (T == PosCategory) {
//       // DONE :)
//       bool categoryControllerRegistered =
//           Get.isRegistered<PosCategoryController>(
//               tag: 'categoryControllerMain');
//       if (categoryControllerRegistered) {
//         if (kDebugMode) {
//           print(
//               "========================== [ UPDATE CATE. LIST AFTER SYNCHRONIZE ] ===========================");
//         }
//         _instance = GeneralLocalDB.getInstance<PosCategory>(
//             fromJsonFun: PosCategory.fromJson);
//         PosCategoryController posCategoryController =
//             Get.find(tag: 'categoryControllerMain');

//         posCategoryController.posCategoryList
//             .assignAll((await _instance!.index()) as List<PosCategory>);

//         posCategoryController.update();
//         // await getitems();
//         // if (kDebugMode) {
//         //   print(
//         //       "========================== [ UPDATE CATE. LIST AFTER SYNCHRONIZE ] ===========================");
//         // }
//       }
//     } else if (T == Product) {
//       bool productControllerRegistered =
//           Get.isRegistered<ProductController>(tag: 'productControllerMain');
//       if (productControllerRegistered) {
//         // if (kDebugMode) {
//         //   print(
//         //       "========================== [ UPDATE PROD. LIST AFTER SYNCHRONIZE ] ===========================");
//         // }

//         ProductController productController =
//             Get.find(tag: 'productControllerMain');
//         // productController.page.value = 0;
//         productController.hasMore.value = true;
//         productController.hasLess.value = false;
//         // stop that
//         // productController.page.value = 0;
//         _instance = GeneralLocalDB.getInstance<PosCategory>(
//             fromJsonFun: PosCategory.fromJson);
//         productController.categoriesList
//             .assignAll((await _instance!.index()) as List<PosCategory>);
//         _instance =
//             GeneralLocalDB.getInstance<Product>(fromJsonFun: Product.fromJson);
//         productController.productList.assignAll((await _instance!.index(
//             offset: productController.page.value * productController.limit,
//             limit: productController.limit)) as List<Product>);
//         // if (kDebugMode) {
//         //   print(productController.productList.length);
//         // }
//         productController.pagingList.assignAll((await _instance!.index(
//             offset: productController.page.value * productController.limit,
//             limit: productController.limit)) as List<Product>);
//         // productController.page.value++;
//         productController.update();
//         // await getitems();
//         // if (kDebugMode) {
//         //   print(
//         //       "========================== [ UPDATE PROD. LIST AFTER SYNCHRONIZE ] ===========================");
//         // }
//       }
//     } else if (T == Customer) {
//       // DONE :)
//       bool customerControllerRegistered =
//           Get.isRegistered<CustomerController>(tag: 'customerControllerMain');
//       if (customerControllerRegistered) {
//         // if (kDebugMode) {
//         //   print(
//         //       "========================== [ UPDATE CUST. LIST AFTER SYNCHRONIZE ] ===========================");
//         // }
//         _instance = GeneralLocalDB.getInstance<Customer>(
//             fromJsonFun: Customer.fromJson);
//         CustomerController customerController =
//             Get.find(tag: 'customerControllerMain');

//         customerController.hasMore.value = true;
//         // stop that
//         // customerController.page.value = 0;
//         customerController.customerList.assignAll((await _instance!.index(
//             offset: customerController.page.value * customerController.limit,
//             limit: customerController.limit)) as List<Customer>);

//         customerController.customerpagingList.assignAll((await _instance!.index(
//             offset: customerController.page.value * customerController.limit,
//             limit: customerController.limit)) as List<Customer>);
//         // customerController.page.value++;

//         customerController.update();

//         // if (kDebugMode) {
//         //   print(
//         //       "customerController.customerList ${customerController.customerList.length}");
//         //   print(
//         //       "========================== [ UPDATE CUST. LIST AFTER SYNCHRONIZE ] ===========================");
//         // }
//       }
//     }
//   }

// // ========================================== [ GET PRODUCT HISTORY ] =============================================

//   Future<ResponseResult> countAll() async {
//     var result = await loadingSynchronizingDataService.countAll();
//     if (result is CountItems) {
//       return ResponseResult(status: true, data: result);
//     } else {
//       return ResponseResult(
//           status: true,
//           data:
//               CountItems(categoryCount: 0, productCount: 0, customerCount: 0));
//     }
//   }

// // ========================================== [ GET PRODUCT HISTORY ] =============================================
//   // Future<ResponseResult> getRemotProductIsNotIds(
//   //     {required List<int> productids}) async {
//   //   var result = await loadingSynchronizingDataService.getRemotProductIsNotIds(
//   //       ids: productids, posCategoriesIds: posCategoryIdsList);
//   //   if (result is List) {
//   //     return ResponseResult(status: true, data: result);
//   //   }
//   //   if (result == null) {
//   //     return ResponseResult(status: true, data: []);
//   //   } else {
//   //     return ResponseResult(message: result);
//   //   }
//   // }

//   // Future<ResponseResult> getRemotPosCategoryIsNotIds(
//   //     {required List<int> categoryids}) async {
//   //   var result = await PosCategoryController().getRemotPosCategoryIsNotIds(
//   //       ids: categoryids, posSetting: SharedPr.userObj!.posConfigIds!);
//   //   if (result is List) {
//   //     return ResponseResult(status: true, data: result);
//   //   }
//   //   if (result == null) {
//   //     return ResponseResult(status: true, data: []);
//   //   } else {
//   //     return ResponseResult(message: result);
//   //   }
//   // }

//   // Future<ResponseResult> getRemotCustomerIsNotIds(
//   //     {required List<int> customerids}) async {
//   //   var result =
//   //       await CustomerController().getRemotCustomerIsNotIds(ids: customerids);
//   //   if (result is List) {
//   //     return ResponseResult(status: true, data: result);
//   //   }
//   //   if (result == null) {
//   //     return ResponseResult(status: true, data: []);
//   //   } else {
//   //     return ResponseResult(message: result);
//   //   }
//   // }

//   Future<ResponseResult> getItemIsNotInRemote<T>(
//       {required List<int> ids}) async {
//     dynamic result;
//     switch (T) {
//       case Product:
//         result = await loadingSynchronizingDataService.getRemotProductIsNotIds(
//             ids: ids, posCategoriesIds: posCategoryIdsList);
//         break;
//       case PosCategory:
//         result = await PosCategoryController().getRemotPosCategoryIsNotIds(
//             ids: ids, posSetting: SharedPr.userObj!.posConfigIds!);
//         break;
//       case Customer:
//         result = await CustomerController().getRemotCustomerIsNotIds(ids: ids);
//         break;

//       default:
//     }
//     // if (T == Product) {
//     //   result = await loadingSynchronizingDataService.getRemotProductIsNotIds(ids: ids, posCategoriesIds: posCategoryIdsList);
//     // } else if (T == Customer) {
//     //   result = await CustomerController().getRemotCustomerIsNotIds(ids: ids);
//     // } else if (T == PosCategory) {
//     //   result = await PosCategoryController().getRemotPosCategoryIsNotIds(ids: ids, posSetting: SharedPr.userObj!.posConfigIds!);
//     // }
//     if (result is List) {
//       return ResponseResult(status: true, data: result);
//     }
//     if (result == null) {
//       return ResponseResult(status: true, data: []);
//     } else {
//       return ResponseResult(message: result);
//     }
//   }

//   Future getSelectedLoadDataCount() async {
//     int count = 0;
//     loaddata.forEach((key, value) {
//       if (value[0] == true) {
//         count++;
//       }
//     });
//     return count;
//   }

//   Future selectLoadData(
//       bool newValue, MapEntry<Loaddata, List<bool>> map) async {
//     var selectedLoadData = loaddata.entries.firstWhere((element) {
//       return element.key == map.key;
//     });
//     loaddata[selectedLoadData.key] = [newValue];
//     count = await getSelectedLoadDataCount();
//     if (count > 0) {
//       if (loaddata.length == count) {
//         isSelctedAll = true;
//       } else {
//         isSelctedAll = false;
//       }
//     }
//     update(["selected load data"]);
//   }

//   Future selectAllLoadData() async {
//     loaddata.updateAll((key, value) => [true]);
//     isSelctedAll = true;
//     count = await getSelectedLoadDataCount();
//     update(["selected load data"]);
//   }

//   Future<ResponseResult> updateAllLoadData() async {
//     if (count == 0 || count == loaddata.length) {
//       //// update all data
//     } else {
//       /// update only selected
//     }
//     return ResponseResult(
//       status: true,
//     );
//   }

//   Future deletSelected() async {
//     loaddata.updateAll((key, value) => [false]);
//     isSelctedAll = false;
//     count = 0;
//     update(["selected load data"]);
//   }

//   Future getitems() async {
//     try {
//       // print("start ===========================================");
//       // print(itemdata);
//       final remoteCount = await countAll();
//       final productCount =
//           await loadingSynchronizingDataService.getCountDataLocal<Product>();
//       final customerCount =
//           await loadingSynchronizingDataService.getCountDataLocal<Customer>();
//       final categoryCount = await loadingSynchronizingDataService
//           .getCountDataLocal<PosCategory>();
//       final productUnit = await loadingSynchronizingDataService
//           .getCountDataLocal<ProductUnit>();

//       // List<Map> itemsData = [];
//       // print("remoteCount status ${remoteCount.status}");
//       // print("remoteCount data ${remoteCount.data}");
//       // print("remoteCustomerCount data ${remoteCount.data.toJson()}");
//       // print("befor update $itemdata");
//       itemdata[Loaddata.products.name.toString()] = {
//         "remote": remoteCount.data.productCount,
//         "local": productCount is int ? productCount : 0
//       };

//       itemdata[Loaddata.customers.name.toString()] = {
//         "remote": remoteCount.data.customerCount,
//         "local": customerCount is int ? customerCount : 0
//       };

//       itemdata[Loaddata.categories.name.toString()] = {
//         "remote": remoteCount.data.categoryCount,
//         "local": categoryCount is int ? categoryCount : 0
//       };
//       itemdata[Loaddata.priceList.name.toString()] = {
//         "remote": 0,
//         "local": productUnit is int ? productUnit : 0
//       };
//       update(['card_loading_data']);
//       update(['pagin']);
//       return ResponseResult(status: true, data: itemdata);
//     } catch (e) {
//       // Handle the error appropriately
//       return ResponseResult(status: false, message: 'Failed to fetch items');
//     }
//   }
//   //
//   // updateProductHistoryRemotely(
//   //     {required ResponseResult productHistoryList}) async {
//   //   await loadingSynchronizingDataService.updateItemHistory(
//   //       itemHistory: productHistoryList.data);
//   // }

//   Future refreshDataFromRemoteServer({required String name}) async {
//     try {
//       isRefresh.value = true;
//       if (name == 'products') {
//         loadText.value = 'refresh Product';
//         await updateHistoryBasedOnItemType<Product>();
//       } else if (name == 'customers') {
//         loadText.value = 'refresh customers';
//         await updateHistoryBasedOnItemType<Customer>();
//       } else if (name == 'categories') {
//         loadText.value = 'refresh categories';
//         await updateHistoryBasedOnItemType<PosCategory>();
//       }
//       loadText.value = 'Completed';
//       isRefresh.value = false;
//     } catch (e) {
//       return handleException(
//           exception: e,
//           navigation: false,
//           methodName: "refreshDataFromRemoteServer");
//     }
//   }

//   // Future<ResponseResult> showProdectInRemoteServerAndNotInLocal() async {
//   //   try {
//   //     // get all odoo id from local db
//   //     var ids = await loadingSynchronizingDataService.getLocalIds<Product>();
//   //     if (kDebugMode) {
//   //       print(" showProdectInRemoteServerAndNotInLocal ids+++++++ : $ids");
//   //     }

//   //     if (ids is List) {
//   //       if (kDebugMode) {
//   //         print("start showProdectInRemoteServerAndNotInLocal");
//   //       }
//   //       // go to remot server to get all prodect is not in local
//   //       var result = await getRemotProductIsNotIds(productids: ids.cast<int>());
//   //       if (kDebugMode) {
//   //         print("result status +++++++ : ${result.status}");
//   //         print("result message +++++++ : ${result.message}");
//   //         print("result data+++++++ : ${result.data}");
//   //       }
//   //       if (result.status) {
//   //         if (result.data.isNotEmpty) {
//   //           return ResponseResult(status: true, data: result.data);
//   //         } else {
//   //           return ResponseResult(message: 'empty_list'.tr);
//   //         }
//   //       } else {
//   //         return ResponseResult(message: result.message);
//   //       }
//   //     } else {
//   //       return ResponseResult(message: ids);
//   //     }
//   //   } catch (e) {
//   //     var error = handleException(
//   //         exception: e,
//   //         navigation: false,
//   //         methodName: "showDataFromRemoteServer");
//   //     return ResponseResult(message: error);
//   //   }
//   // }

//   // // show products in remote server and not in local
//   // Future<ResponseResult> showCategoryInRemoteServerAndNotInLocal() async {
//   //   try {
//   //     // get all odoo id from local db
//   //     var ids =
//   //         await loadingSynchronizingDataService.getLocalIds<PosCategory>();
//   //     if (kDebugMode) {
//   //       print(" showCategoryInRemoteServerAndNotInLocal ids+++++++ : $ids");
//   //     }

//   //     if (ids is List) {
//   //       if (kDebugMode) {
//   //         print("start showCategoryInRemoteServerAndNotInLocal");
//   //       }
//   //       // go to remot server to get all prodect is not in local
//   //       var result =
//   //           await getRemotPosCategoryIsNotIds(categoryids: ids.cast<int>());
//   //       if (kDebugMode) {
//   //         print("result categoryids  status +++++++ : ${result.status}");
//   //         print("result categoryids  message +++++++ : ${result.message}");
//   //         print("result categoryids  data+++++++ : ${result.data}");
//   //       }
//   //       if (result.status) {
//   //         if (result.data.isNotEmpty) {
//   //           return ResponseResult(status: true, data: result.data);
//   //         } else {
//   //           return ResponseResult(message: 'empty_list'.tr);
//   //         }
//   //       } else {
//   //         return ResponseResult(message: result.message);
//   //       }
//   //     } else {
//   //       return ResponseResult(message: ids);
//   //     }
//   //   } catch (e) {
//   //     var error = handleException(
//   //         exception: e,
//   //         navigation: false,
//   //         methodName: "showCategoryInRemoteServerAndNotInLocal");
//   //     return ResponseResult(message: error);
//   //   }
//   // }

//   // // show products in remote server and not in local
//   // Future<ResponseResult> showCustomerInRemoteServerAndNotInLocal() async {
//   //   try {
//   //     // get all odoo id from local db
//   //     var ids = await loadingSynchronizingDataService.getLocalIds<Customer>();
//   //     if (kDebugMode) {
//   //       print(" showCustomerInRemoteServerAndNotInLocal ids+++++++ : $ids");
//   //     }

//   //     if (ids is List) {
//   //       if (kDebugMode) {
//   //         print("start showCustomerInRemoteServerAndNotInLocal");
//   //       }
//   //       // go to remot server to get all prodect is not in local
//   //       var result =
//   //           await getRemotCustomerIsNotIds(customerids: ids.cast<int>());
//   //       if (kDebugMode) {
//   //         print("result Customerids  status +++++++ : ${result.status}");
//   //         print("result Customerids  message +++++++ : ${result.message}");
//   //         print("result Customerids  data+++++++ : ${result.data}");
//   //       }
//   //       if (result.status) {
//   //         if (result.data.isNotEmpty) {
//   //           return ResponseResult(status: true, data: result.data);
//   //         } else {
//   //           return ResponseResult(message: 'empty_list'.tr);
//   //         }
//   //       } else {
//   //         return ResponseResult(message: result.message);
//   //       }
//   //     } else {
//   //       return ResponseResult(message: ids);
//   //     }
//   //   } catch (e) {
//   //     var error = handleException(
//   //         exception: e,
//   //         navigation: false,
//   //         methodName: "showCategoryInRemoteServerAndNotInLocal");
//   //     return ResponseResult(message: error);
//   //   }
//   // }

//   Future<ResponseResult> showItemBasedOnItemType<T>() async {
//     try {
//       var localData = [];
//       // get all odoo id from local db
//       var ids = await loadingSynchronizingDataService.getLocalIds<T>();
//       String typeNameX = getOdooModels<T>();
//       var deleteRusult = await loadingSynchronizingDataService
//           .getCountDeleteData(
//               excludeIds: <int>[SharedPr.currentPosId!], typeName: typeNameX);
//       if (kDebugMode) {
//         print(" showProdectInRemoteServerAndNotInLocal ids+++++++ : $ids");
//       }

//       if (ids is List) {
//         print("deleteRusult $deleteRusult");
//         print("T $T");
//         if (deleteRusult is List && deleteRusult.isNotEmpty) {
//           switch (T) {
//             case Product:
//               List result =
//                   (deleteRusult).map((item) => item.productId).toList();
//               print("result Product  $result");
//               localData = await loadingSynchronizingDataService.getLocalData<T>(
//                   ids: result);
//               print("localData Product  $localData");
//               break;
//             case PosCategory:
//               List result =
//                   (deleteRusult).map((item) => item.categoryId).toList();
//               print("result PosCategory  $result");
//               localData = await loadingSynchronizingDataService.getLocalData<T>(
//                   ids: result);
//               print("localData PosCategory  $localData");
//               break;
//             case Customer:
//               List result =
//                   (deleteRusult).map((item) => item.customerId).toList();
//               print("result Customer  $result");
//               localData = await loadingSynchronizingDataService.getLocalData<T>(
//                   ids: result);
//               print("localData Customer  $localData");
//               break;
//             default:
//           }
//         }
//         // if (kDebugMode) {
//         //   print("start showProdectInRemoteServerAndNotInLocal");
//         // }
//         // go to remot server to get all prodect is not in local
//         ResponseResult result =
//             await getItemIsNotInRemote<T>(ids: ids.cast<int>());
//         // if (kDebugMode) {
//         //   print("result status +++++++ : ${result.status}");
//         //   print("result message +++++++ : ${result.message}");
//         //   print("result data+++++++ : ${result.data}");
//         // }

//         if (result.status) {
//           print("data ${{"remot": result.data, "local": localData}}");
//           return ResponseResult(
//               status: true, data: {"remot": result.data, "local": localData});
//         } else {
//           return ResponseResult(message: result.message);
//         }
//       } else {
//         return ResponseResult(message: ids);
//       }
//     } catch (e) {
//       var error = handleException(
//           exception: e,
//           navigation: false,
//           methodName: "showItemBasedOnItemType$T");
//       return ResponseResult(message: error);
//     }
//   }

//   Future showDialog({required String name}) async {
//     try {
//       isRefresh.value = true;
//       switch (name) {
//         case "products":
//           loadText.value = 'show Product';
//           await showItemBasedOnItemType<Product>().then((result) {
//             loadText.value = 'Completed';
//             isRefresh.value = false;
//             if (result.status) {
//               if (result.data["remot"].isEmpty &&
//                   result.data["local"].isEmpty) {
//                 appSnackBar(
//                     message: "empty_filter".tr,
//                     messageType: MessageTypes.success);
//               } else {
//                 showProductsDialog(items: result);
//               }
//             }
//           });
//           break;
//         case "categories":
//           loadText.value = 'show categories';
//           await showItemBasedOnItemType<PosCategory>().then((result) {
//             loadText.value = 'Completed';
//             isRefresh.value = false;
//             if (result.status) {
//               if (result.data["remot"].isEmpty &&
//                   result.data["local"].isEmpty) {
//                 appSnackBar(
//                     message: "empty_filter".tr,
//                     messageType: MessageTypes.success);
//               } else {
//                 showCategorysDialog(items: result);
//               }
//             }
//             // showCategorysDialog(items: result);
//           });
//           break;
//         case "customers":
//           loadText.value = 'show customers';
//           await showItemBasedOnItemType<Customer>().then((result) {
//             loadText.value = 'Completed';
//             isRefresh.value = false;
//             if (result.status) {
//               if (result.data["remot"].isEmpty &&
//                   result.data["local"].isEmpty) {
//                 appSnackBar(
//                     message: "empty_filter".tr,
//                     messageType: MessageTypes.success);
//               } else {
//                 showCustomersDialog(items: result);
//               }
//             }
//             //
//           });
//           break;
//         default:
//       }
//     } catch (e) {
//       return handleException(
//           exception: e, navigation: false, methodName: "showDialog");
//     }
//   }

//   Future updateAll({required String name}) async {
//     itemUpdate = name;
//     isUpdate.value = true;
//     update(['loading']);
//     CustomDialog.getInstance().itemDialog(
//         title: 'warning_message'.tr,
//         barrierDismissible: false,
//         content: Text('update_data'.tr));

//     // CHECK IF DEVICE IS TRUSTED
//     bool isTrustedDevice = await MacAddressHelper.isTrustedDevice();
//     if (!isTrustedDevice) {
//       isUpdate.value = false;
//       Get.close(1);
//       update(['card_loading_data']);
//       update(['loading']);
//       return;
//     }
//     _instance = getLocalInstanceTypeByName(name: name);
//     await _instance!.deleteData();
//     await loadingPosCategoryIdsList();
//     await loadingData(type: name);
//     isUpdate.value = false;
//     Get.close(1);
//     await getitems();
//     update(['card_loading_data']);
//     update(['loading']);

//     // switch (name) {
//     //   case "productUnit":
//     //     await loadingProductUnit();
//     //     // itemUpdate = "null";
//     //     isUpdate.value = false;
//     //     Get.back();
//     //     await getitems();
//     //     update(['card_loading_data']);
//     //     update(['loading']);

//     //     break;
//     //   case "products":
//     //     await loadingProduct(posCategoriesIds: posCategoryIdsList);
//     //     isUpdate.value = false;
//     //     Get.back();
//     //     // itemUpdate = "null";
//     //     await getitems();
//     //     update(['card_loading_data']);
//     //     update(['loading']);
//     //     break;
//     //   case "categories":
//     //     await loadingPosCategories(posCategoriesIds: posCategoryIdsList);
//     //     isUpdate.value = false;
//     //     Get.back();
//     //     // itemUpdate = "null";
//     //     await getitems();
//     //     update(['card_loading_data']);
//     //     update(['loading']);
//     //     break;
//     //   case "customers":
//     //     await loadingCustomer();
//     //     isUpdate.value = false;
//     //     Get.back();
//     //     // itemUpdate = "null";
//     //     await getitems();
//     //     update(['card_loading_data']);
//     //     update(['loading']);
//     //     break;

//     //   default:
//     //     isUpdate.value = false;
//     //     Get.back();
//     //     // itemUpdate = "null";
//     //     await getitems();
//     //     update(['card_loading_data']);
//     //     update(['loading']);
//     //     break;
//     // }
//   }

// //   Future<ResponseResult> fetchData<T>() async {
// //     int local = 0;
// //     int remote = 0;
// //     switch (T) {
// //       case Product:
// //         await loadingSynchronizingDataService
// //             .getCountLocalProduct()
// //             .then((value) => value is int ? local = value : local = 0);
// //         await getCountRemotProduct()
// //             .then((value) => value.status ? remote = value.data : remote = 0);
// //         break;
// //       case PosCategory:
// //         await loadingSynchronizingDataService
// //             .getPosCategoryLocal()
// //             .then((value) => value is int ? local = value : local = 0);
// //         await countRemotPosCategory()
// //             .then((value) => value.status ? remote = value.data : remote = 0);
// //         break;
// //       case Customer:
// //         await loadingSynchronizingDataService
// //             .getCountLocalCustomer()
// //             .then((value) => value is int ? local = value : local = 0);
// //         await customerController
// //             .countCustomersRemot()
// //             .then((value) => value.status ? remote = value.data : remote = 0);
// //         break;

// //       default:
// //     }
// //     print({'remote': remote, 'local': local});
// //     return ResponseResult(
// //         status: true, data: {'remote': remote, 'local': local});
// //   }
}
