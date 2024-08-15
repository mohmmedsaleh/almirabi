import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/response_result.dart';
import '../../../loading_synchronizing_data/domain/loading_synchronizing_data_service.dart';
import '../data/source_path.dart';
import 'source_path_service.dart';

class SourcePathController extends GetxController {
  SourcePathService sourcePathService = SourcePathService.getInstance();

  LoadingSynchronizingDataService loadingSynchronizingDataService =
      LoadingSynchronizingDataService(type: SourcePath);

  var isLoading = false.obs;
  var hideMainScreen = false.obs;
  RxList<SourcePath> sourcePathList = <SourcePath>[].obs;
  // RxList<SourcePath> pagingList = <Product>[].obs;
  // List<SourcePath> categoriesList = [];
  // List<SourcePath> unitsList = [];
  RxList<SourcePath> searchResults = RxList<SourcePath>();
  SourcePath? object;

  var page = 0.obs;
  final int limit = 10;
  var hasMore = true.obs;
  var hasLess = false.obs;
  TextEditingController searchProductController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await SourcePathData();
  }

  SourcePathData() async {
    var result = await displaySourcePathList(paging: false);
    sourcePathList.value = result.data;
    print(sourcePathList.first.lins);
    // pagingList.value = result.data;
    update();
  }

  // ========================================== [ START DISPLAY PRODUCT LIST ] =============================================
  Future<dynamic> displaySourcePathList(
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
      result = await sourcePathService.index();

      if (result is List) {
        result = ResponseResult(
            status: true, message: "Successful".tr, data: result);
      } else {
        result = ResponseResult(message: result);
      }
      isLoading.value = false;
    }

    return result;
  }

  // ========================================== [ END DISPLAY PRODUCT LIST ] =============================================

  // ========================================== [ START DISPLAY PRODUCT ] =============================================
  Future<dynamic> displaySourcePath({required int id}) async {
    isLoading.value = true;
    dynamic result = await sourcePathService.show(val: id);
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
      {required SourcePath SourcePath, bool isFromHistory = false}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      var remoteResult =
          await sourcePathService.createSourcePathRemotely(obj: SourcePath);

      if (remoteResult is int) {
        SourcePath.sourcePathId = remoteResult;

        await sourcePathService.create(obj: SourcePath, isRemotelyAdded: true);
        return ResponseResult(
            status: true, data: SourcePath, message: "Successful".tr);
      } else {
        return ResponseResult(message: remoteResult);
      }
    } else {
      return ResponseResult(message: "no_connection".tr);
    }
  }

// ========================================== [ END CREATE PRODUCT ] =============================================

// ========================================== [ START UPDATE PRODUCT ] =============================================
  Future<dynamic> updateRequest({required SourcePath SourcePath}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      var remoteResult = await sourcePathService.updateSourcePathRemotely(
          id: SourcePath.sourcePathId!, obj: SourcePath);
      if (remoteResult is! bool || remoteResult != true) {
        return ResponseResult(message: "error");
      } else {
        await sourcePathService.update(
            id: SourcePath.sourcePathId!, obj: SourcePath, whereField: 'id');
        return ResponseResult(
            status: true, data: SourcePath, message: "Successful".tr);
      }
      //
    } else {
      return ResponseResult(message: "no_connection".tr);
    }
  }

// ========================================== [ END UPDATE PRODUCT ] =============================================

// ============================================ [ SEARCH PRODUCT ] ===============================================
  Future<void> search(String query) async {
    if (sourcePathList.isNotEmpty) {
      searchResults.clear();
      var result = await sourcePathService.search(query);
      if (result is List) {
        searchResults.addAll(result as List<SourcePath>);
      }
      // for (Product product in productList) {
      //   if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
      //     searchResults.add(product);
      //   }
      // }
      update();
    }
  }

  // Future<void> searchByCateg(int query) async {
  //   if (productList.isNotEmpty) {
  //     searchResults.clear();
  //     var result = await productService.searchByCateg(query);
  //     if (result is List) {
  //       searchResults.addAll(result as List<Product>);
  //     }
  //     update();
  //   }
  // }

// ============================================ [ SEARCH PRODUCT ] ===============================================

  updateHideMenu(bool value) {
    hideMainScreen.value = value;
    // if (kDebugMode) {
    //   print('hideMainScreen.value : ${hideMainScreen.value}');
    // }
    update();
  }
}
