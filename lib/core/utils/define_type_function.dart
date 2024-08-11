// [ HELPER FUNCTION ] =================================================================
import 'package:almirabi/features/basic_data_management/car/data/car.dart';
import 'package:almirabi/features/basic_data_management/source_path/data/source_path.dart';
import 'package:get/get.dart';

// ignore_for_file: type_literal_in_constant_pattern

// [ HELPER FUNCTION ] =================================================================

import '../../features/authentication/utils/handle_exception_helper.dart';
import '../../features/basic_data_management/request/data/request.dart';
import '../../features/loading_synchronizing_data/presentation/utils/fetch_date.dart';
import '../config/app_enums.dart';
import '../config/app_odoo_models.dart';
import '../shared_widgets/app_snack_bar.dart';
import 'general_local_db.dart';

setFromJsonType<T>() {
  dynamic fromJson;
  if (T == Requests) {
    fromJson = Requests.fromJson;
  }
  // else if (T == PosCategory) {
  //   fromJson = PosCategory.fromJson;
  // } else if (T == Customer) {
  //   fromJson = Customer.fromJson;
  // } else if (T == ProductUnit) {
  //   fromJson = ProductUnit.fromJson;
  // }
  return fromJson;
}

setToJsonType<T>(record) {
  dynamic toJson;
  if (T == Requests) {
    toJson = record.toJson();
  }
  //  else if (T == PosCategory) {
  //   toJson = record.toJson();
  // } else if (T == Customer) {
  //   toJson = record.toJson();
  // } else if (T == ProductUnit) {
  //   toJson = record.toJson();
  // }
  return toJson;
}

Type getModelClass(String type) {
  if (type == Loaddata.requests.toString()) {
    return Requests;
  }
  //  else if (type == Loaddata.categories.toString()) {
  //   return PosCategory;
  // } else if (type == Loaddata.customers.toString()) {
  //   return Customer;
  // } else if (type == Loaddata.productUnit.toString()) {
  //   return ProductUnit;
  // }
  return Requests;
}

String getNameBasedOnType<T>() {
  if (T == Requests) {
    return Loaddata.requests.toString();
  }
  // else if (T == PosCategory) {
  //   return Loaddata.categories.toString();
  // } else if (T == Customer) {
  //   return Loaddata.customers.toString();
  // } else if (T == ProductUnit) {
  //   return Loaddata.productUnit.toString();
  // }
  return Loaddata.requests.toString();
}

// Future synchronizeBasedOnModelType({required String type}) async {
//   Type typex = getModelClass(type);
//   bool? result;
//   if (typex == Requests) {
//     result = await loadingDataController.synchronizeDB<Requests>();
//   }
//   //  else if (typex == Customer) {
//   //   result = await loadingDataController.synchronizeDB<Customer>();
//   // } else if (typex == ProductUnit) {
//   //   result = await loadingDataController.synchronizeDB<ProductUnit>();
//   // } else if (typex == PosCategory) {
//   //   result = await loadingDataController.synchronizeDB<PosCategory>();
//   // }
//   // await loadingDataController.getitems();
//   return result;
// }

// Future synchronizeAllItem() async {
//   try {
//     appSnackBar(
//         message: 'synchronize_now'.tr,
//         messageType: MessageTypes.success,
//         isDismissible: false);
//     await loadingDataController.synchronizeDB<Requests>(show: false);
//     // await loadingDataController.synchronizeDB<Customer>(show: false);
//     // await loadingDataController.synchronizeDB<ProductUnit>(show: false);
//     // await loadingDataController.synchronizeDB<PosCategory>(show: false);
//     await loadingDataController.getitems();
//     return true;
//   } catch (e) {
//     handleException(
//         exception: e, navigation: false, methodName: "synchronizeAllItem");
//     return false;
//   }
// }

getLocalInstanceType<T>({T? type}) {
  GeneralLocalDB<dynamic>? instance;
  switch (type ?? T) {
    case Requests:
      instance =
          GeneralLocalDB.getInstance<Requests>(fromJsonFun: Requests.fromJson);
      break;
    case Car:
      instance = GeneralLocalDB.getInstance<Car>(fromJsonFun: Car.fromJson);
      break;
    case SourcePath:
      instance = GeneralLocalDB.getInstance<SourcePath>(
          fromJsonFun: SourcePath.fromJson);
      break;
    // case PosCategory:
    //   instance = GeneralLocalDB.getInstance<PosCategory>(
    //       fromJsonFun: PosCategory.fromJson);
    //   break;
    // case Customer:
    //   instance =
    //       GeneralLocalDB.getInstance<Customer>(fromJsonFun: Customer.fromJson);
    //   break;
    // case ProductUnit:
    //   instance = GeneralLocalDB.getInstance<ProductUnit>(
    //       fromJsonFun: ProductUnit.fromJson);
    //   break;

    default:
  }
  return instance;
}

String getOdooModels<T>() {
  String typeNameX = '';
  if (T == Requests) {
    typeNameX = OdooModels.requests;
  }
  //  else if (T == PosCategory) {
  //   typeNameX = OdooModels.posCategory;
  // } else if (T == Customer) {
  //   typeNameX = OdooModels.customer;
  // } else if (T == ProductUnit) {
  //   typeNameX = OdooModels.uomUomMain;
  // }
  return typeNameX;
}

getLocalInstanceTypeByName({required String name}) {
  Type typeX = getModelClass(name);
  return getLocalInstanceType(type: typeX);
}
