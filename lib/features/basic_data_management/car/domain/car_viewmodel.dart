import 'package:almirabi/features/basic_data_management/car/domain/car_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/response_result.dart';
import '../../../loading_synchronizing_data/domain/loading_synchronizing_data_service.dart';
import '../data/car.dart';

class CarController extends GetxController {
  CarService carService = CarService.getInstance();

  LoadingSynchronizingDataService loadingSynchronizingDataService =
      LoadingSynchronizingDataService(type: Car);

  var isLoading = false.obs;
  var hideMainScreen = false.obs;
  RxList<Car> carList = <Car>[].obs;
  // RxList<Car> pagingList = <Product>[].obs;
  // List<Car> categoriesList = [];
  // List<Car> unitsList = [];
  RxList<Car> searchResults = RxList<Car>();
  Car? object;

  var page = 0.obs;
  final int limit = 10;
  var hasMore = true.obs;
  var hasLess = false.obs;
  TextEditingController searchProductController = TextEditingController();

  @override
  Future<void> onInit() async {
    await carData();
    super.onInit();
  }

  carData() async {
    var result = await displayCarList(paging: false);
    carList.value = result.data;
    // pagingList.value = result.data;
    update();
  }

  // ========================================== [ START DISPLAY PRODUCT LIST ] =============================================
  Future<dynamic> displayCarList(
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
      result = await carService.index();

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
  Future<dynamic> displayCar({required int id}) async {
    isLoading.value = true;
    dynamic result = await carService.show(val: id);
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
  Future<dynamic> createCar(
      {required Car car, bool isFromHistory = false}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      var remoteResult = await carService.createCarRemotely(obj: car);

      if (remoteResult is int) {
        car.id = remoteResult;

        await carService.create(obj: car, isRemotelyAdded: true);
        return ResponseResult(
            status: true, data: car, message: "Successful".tr);
      } else {
        return ResponseResult(message: remoteResult);
      }
    } else {
      return ResponseResult(message: "no_connection".tr);
    }
  }

// ========================================== [ END CREATE PRODUCT ] =============================================

// ========================================== [ START UPDATE PRODUCT ] =============================================
  Future<dynamic> updateCar({required Car car}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      var remoteResult =
          await carService.updateCarRemotely(id: car.id!, obj: car);
      if (remoteResult is! bool || remoteResult != true) {
        return ResponseResult(message: "error");
      } else {
        await carService.update(id: car.id!, obj: car, whereField: 'id');
        return ResponseResult(
            status: true, data: car, message: "Successful".tr);
      }
      //
    } else {
      return ResponseResult(message: "no_connection".tr);
    }
  }

// ========================================== [ END UPDATE PRODUCT ] =============================================

// ============================================ [ SEARCH PRODUCT ] ===============================================
  Future<void> search(String query) async {
    if (carList.isNotEmpty) {
      searchResults.clear();
      var result = await carService.search(query);
      if (result is List) {
        searchResults.addAll(result as List<Car>);
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
