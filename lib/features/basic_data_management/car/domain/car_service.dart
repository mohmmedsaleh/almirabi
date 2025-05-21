
import '../../../../core/config/app_table_structure.dart';
import '../../../../core/utils/general_local_db.dart';
import '../../../authentication/utils/handle_exception_helper.dart';
import '../data/car.dart';
import 'car_repository.dart';

class CarService extends CarRepository {
  GeneralLocalDB<Car>? _generalLocalDBInstance;
  static CarService? carDataServiceInstance;

  CarService._() {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Car>(fromJsonFun: Car.fromJson)
            as GeneralLocalDB<Car>?;
  }

  static CarService getInstance() {
    carDataServiceInstance = carDataServiceInstance ?? CarService._();
    return carDataServiceInstance!;
  }

  @override
  Future createTable() async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Car>(fromJsonFun: Car.fromJson)
            as GeneralLocalDB<Car>?;
    return await _generalLocalDBInstance!
        .createTable(structure: LocalDatabaseStructure.carStructure);
  }

  @override
  Future dropTable() async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Car>(fromJsonFun: Car.fromJson)
            as GeneralLocalDB<Car>?;
    return await _generalLocalDBInstance!.dropTable();
  }

  @override
  Future deleteData() async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Car>(fromJsonFun: Car.fromJson)
            as GeneralLocalDB<Car>?;
    return await _generalLocalDBInstance!.deleteData();
  }

  @override
  Future index({int? offset, int? limit}) async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Car>(fromJsonFun: Car.fromJson)
            as GeneralLocalDB<Car>?;
    return await _generalLocalDBInstance!.index(offset: offset, limit: limit);
  }

  @override
  Future show({required dynamic val}) async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Car>(fromJsonFun: Car.fromJson)
            as GeneralLocalDB<Car>?;
    return await _generalLocalDBInstance!.show(val: val, whereArg: 'id');
  }

  @override
  Future<int> create({required obj, bool isRemotelyAdded = false}) async {
    _generalLocalDBInstance =
        GeneralLocalDB.getInstance<Car>(fromJsonFun: Car.fromJson)
            as GeneralLocalDB<Car>?;
    return await _generalLocalDBInstance!
        .create(obj: obj, isRemotelyAdded: isRemotelyAdded);
  }

  @override
  Future search(String query) async {
    try {
      _generalLocalDBInstance =
          GeneralLocalDB.getInstance<Car>(fromJsonFun: Car.fromJson)
              as GeneralLocalDB<Car>?;
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

  // Future searchByCateg(int query) async {
  //   try {
  //     _generalLocalDBInstance =
  //         GeneralLocalDB.getInstance<Car>(fromJsonFun: Car.fromJson)
  //             as GeneralLocalDB<Car>?;
  //     return await _generalLocalDBInstance!
  //         .filter(whereArgs: [query], where: 'so_pos_categ_id = ?');
  //   } catch (e) {
  //     return handleException(
  //         exception: e, navigation: false, methodName: "searchByCateg");
  //   }
  // }

  // object can be map or class object
  Future createCarRemotely({required obj}) async {
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
        GeneralLocalDB.getInstance<Car>(fromJsonFun: Car.fromJson)
            as GeneralLocalDB<Car>?;
    return await _generalLocalDBInstance!
        .update(id: id, obj: obj, whereField: 'id');
  }

  Future updateCarRemotely({required int id, required obj}) async {
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
