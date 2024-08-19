import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/config/app_enums.dart';
import '../../../../core/utils/response_result.dart';
import '../../../authentication/utils/odoo_connection_helper.dart';
import '../../../loading_synchronizing_data/domain/loading_synchronizing_data_service.dart';
import '../data/request.dart';
import 'request_service.dart';

class RequestController extends GetxController {
  RequestService requestService = RequestService.getInstance();

  LoadingSynchronizingDataService loadingSynchronizingDataService =
      LoadingSynchronizingDataService(type: Requests);

  var isLoading = false.obs;
  var hideMainScreen = false.obs;
  RxList<Requests> requestList = <Requests>[].obs;
  RxList<Requests> reportsList = <Requests>[].obs;
  // RxList<Requests> pagingList = <Product>[].obs;
  // List<Requests> categoriesList = [];
  // List<Requests> unitsList = [];
  RxList<Requests> searchResults = RxList<Requests>();
  Requests? object;

  var page = 0.obs;
  final int limit = 10;
  var hasMore = true.obs;
  var hasLess = false.obs;
  RxList<Requests> dataSend = RxList<Requests>();
  RxList<Requests> dataRepots = RxList<Requests>();
  TextEditingController searchRequstsController = TextEditingController();
  TextEditingController searchReportsController = TextEditingController();

  String? carid, sourcePathId, sourcePathLineId;

  @override
  Future<void> onInit() async {
    super.onInit();
    await requestData();
  }

  requestData() async {
    var result = await displayRequestList(paging: false);
    requestList.value = result.data;
    // pagingList.value = result.data;
    update();
  }

  // ========================================== [ START DISPLAY PRODUCT LIST ] =============================================
  Future<dynamic> displayRequestList(
      {bool paging = false,
      String type = "current",
      int pageselecteed = -1}) async {
    dynamic result;
    if (paging) {
      // if (!isLoading.value) {
      //   isLoading.value = true;
      //   if (type == "suffix" && hasMore.value) {
      //     page.value++;
      //   } else if (type == "prefix" && hasLess.value) {
      //     page.value--;
      //   } else if (pageselecteed != -1) {
      //     page.value = pageselecteed;
      //   }
      //   result = await productService.index(
      //       offset: page.value * limit, limit: limit);
      //   if (result is List) {
      //     if ((type == "suffix" && hasMore.value)) {
      //       if (result.length < limit) {
      //         hasMore.value = false;
      //       }
      //       hasLess.value = true;
      //     } else if (type == "prefix" && hasLess.value) {
      //       if (page == 0) {
      //         hasLess.value = false;
      //       }
      //       hasMore.value = true;
      //     } else if (type == "current") {
      //       if (result.length < limit) {
      //         hasMore.value = false;
      //       }
      //     } else if (pageselecteed != -1) {
      //       hasLess.value = true;
      //       hasMore.value = true;
      //       if (page == 0) {
      //         hasLess.value = false;
      //       } else if (page ==
      //           (loadingDataController
      //                           .itemdata[Loaddata.products.name.toString()]
      //                       ['local'] ~/
      //                   limit) +
      //               (loadingDataController.itemdata[Loaddata.products.name
      //                               .toString()]['local'] %
      //                           limit !=
      //                       0
      //                   ? 1
      //                   : 0) -
      //               1) {
      //         // print("hello");
      //         hasMore.value = false;
      //       }
      //     }

      //     ProductController productController =
      //         Get.find(tag: 'productControllerMain');
      //     productController.productList.addAll(result as List<Product>);
      //     pagingList.clear();
      //     pagingList.addAll(result);
      //     productController.update();
      //     result = ResponseResult(
      //         status: true, message: "Successful".tr, data: result);
      //   } else {
      //     result = ResponseResult(message: result);
      //   }
      //   isLoading.value = false;
      // }
    } else {
      isLoading.value = true;
      print('========ELSE ===');
      result = await requestService.index();

      print(result);
      if (result is List) {
        requestList.clear();
        requestList.addAll(result as List<Requests>);
        dataSend.value =
            requestList.where((e) => e.state == RequestState.draft).toList();
        dataRepots.value = requestList.where((e) {
          return e.state == RequestState.closed;
        }).toList();
        print('dataRepots $dataRepots');
        result = ResponseResult(
            status: true, message: "Successful".tr, data: result);
      } else {
        result = ResponseResult(message: result);
      }
      isLoading.value = false;
    }
    RequestController requestController = Get.find();
    requestController.update();
    return result;
  }

  // ========================================== [ END DISPLAY PRODUCT LIST ] =============================================

  // ========================================== [ START DISPLAY PRODUCT ] =============================================
  Future<dynamic> displayRequest({required int id}) async {
    isLoading.value = true;
    dynamic result = await requestService.show(val: id);
    if (result is List) {
      result =
          ResponseResult(status: true, message: "Successful".tr, data: result);
    } else {
      result = ResponseResult(message: result);
    }
    isLoading.value = false;
    return result;
  }

  // ========================================== [ END DISPLAY PRODUCT ] =============================================

  // ========================================== [ START CREATE PRODUCT ] =============================================
  Future<dynamic> createRequest(
      {required Requests Requests, bool isFromHistory = false}) async {
    await requestService.create(
      obj: Requests,
    );
    return ResponseResult(
        status: true, data: Requests, message: "Successful".tr);
  }

  Future<dynamic> createRequestRemotely(
      {required List<Requests> requests, bool isFromHistory = false}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (!connectivityResult.contains(ConnectivityResult.none)) {
      OdooProjectOwnerConnectionHelper.odooSession = null;
      await OdooProjectOwnerConnectionHelper.instantiateOdooConnection();
      var remoteResult =
          await requestService.createRequestRemotely(obj: requests);
      print(remoteResult);
      print(remoteResult.runtimeType);
      if (remoteResult is List) {
        print("sending Successful");
        for (var i = 0; i < requests.length; i++) {
          requests[i].requestsId = remoteResult[i];
          requests[i].state = RequestState.closed;
          var remoteRequestLine =
              await requestService.createRequestLineRemotely(obj: requests[i]);

          await requestService.update(
              id: requests[i].id!, obj: requests[i], whereField: 'id');
        }
        // car.id = remoteResult;

        // await requestService.create(obj: car, isRemotelyAdded: true);
        print("save Successful");
        update();
        return ResponseResult(
            status: true, data: requests, message: "Successful".tr);
      } else {
        print(remoteResult);
        // return ResponseResult(message: remoteResult);
      }
    } else {
      return ResponseResult(message: "no_connection".tr);
    }
  }

// ========================================== [ END CREATE PRODUCT ] =============================================

// ========================================== [ START UPDATE PRODUCT ] =============================================
  Future<dynamic> updateRequest({required Requests Requests}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      var remoteResult = await requestService.updateRequestRemotely(
          id: Requests.id!, obj: Requests);
      if (remoteResult is! bool || remoteResult != true) {
        return ResponseResult(message: "error");
      } else {
        await requestService.update(
            id: Requests.id!, obj: Requests, whereField: 'id');
        return ResponseResult(
            status: true, data: Requests, message: "Successful".tr);
      }
      //
    } else {
      return ResponseResult(message: "no_connection".tr);
    }
  }

// ========================================== [ END UPDATE PRODUCT ] =============================================

// ============================================ [ SEARCH PRODUCT ] ===============================================
  Future<void> search(String query) async {
    if (requestList.isNotEmpty) {
      searchResults.clear();
      var result = await requestService.search(query);
      if (result is List) {
        searchResults.addAll(result as List<Requests>);
      }
      // for (Product product in productList) {
      //   if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
      //     searchResults.add(product);
      //   }
      // }
      update();
    }
  }

  Future getAllReports() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (!connectivityResult.contains(ConnectivityResult.none)) {
      OdooProjectOwnerConnectionHelper.odooSession = null;
      await OdooProjectOwnerConnectionHelper.instantiateOdooConnection();
      var remoteResult = await requestService.indexRemotly(obj: dataRepots);
      reportsList.clear();
      if (remoteResult is List<Requests>) {
        print("get Successful $remoteResult");
        print('''  id INTEGER PRIMARY KEY,product_car_id INTEGER, 
               requests_id INTEGER,  from_date TEXT,to_date TEXT,month_name INTEGER,
               source_path_id INTEGER, source_path_name TEXT,
               state TEXT,request_lines TEXT,driver_id INTEGER,amout_total REAL''');
        for (var i = 0; i < remoteResult.length; i++) {
          remoteResult[i].requestLines = [];
          await requestService.updateWhere(
              id: remoteResult[i].id!,
              obj: [
                remoteResult[i].fromDate,
                remoteResult[i].toDate,
                remoteResult[i].monthName,
                remoteResult[i].state
              ],
              whereField: 'requests_id',
              columnToUpdate:
                  ' from_date = ?, to_date = ?, month_name = ? , state = ? ');
          for (var element in requestList) {
            if (element.requestsId == remoteResult[i].id!) {
              element.fromDate = remoteResult[i].fromDate;
              element.toDate = remoteResult[i].toDate;
              element.monthName = remoteResult[i].monthName;
              element.state = remoteResult[i].state;
              reportsList.add(element);
            }
          }
        }
        update();
        print('reportsList $reportsList');

        // // car.id = remoteResult;

        // // await requestService.create(obj: car, isRemotelyAdded: true);
        // print("save Successful");
        // update();
        return ResponseResult(
            status: true, data: remoteResult, message: "Successful".tr);
      } else {
        print(remoteResult.runtimeType);
        // return ResponseResult(message: remoteResult);
      }
    } else {
      return ResponseResult(message: "no_connection".tr);
    }
  }

  Future<void> searchByState(String query, bool isLoacl) async {
    if (isLoacl) {
      if (requestList.isNotEmpty) {
        searchResults.clear();
        var result = await requestService.searchByState(query);
        print(result);
        if (result is List) {
          print(searchResults);
          searchResults.addAll(result as List<Requests>);
        }
        update();
      }
    } else {}
  }

// ============================================ [ SEARCH PRODUCT ] ===============================================

  updateHideMenu(bool value) {
    hideMainScreen.value = value;
    // if (kDebugMode) {
    //   print('hideMainScreen.value : ${hideMainScreen.value}');
    // }
    update();
  }

  updatedropDown() {
    sourcePathId = null;
    carid = null;
    update();
  }
}
