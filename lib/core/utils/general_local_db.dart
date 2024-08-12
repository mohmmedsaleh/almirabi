import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../../features/authentication/utils/handle_exception_helper.dart';
import 'db_helper.dart';

class GeneralLocalDB<T> {
  static late String tableName;
  late T Function(Map<String, dynamic> data) fromJson;
  static GeneralLocalDB? _instance;
  GeneralLocalDB._({required this.fromJson}) {
    tableName = T.toString().toLowerCase();
  }

  static GeneralLocalDB? getInstance<T>({required fromJsonFun}) {
    if (_instance != null && _instance!.getType() != T.toString()) {
      _instance = null;
    }
    // if (kDebugMode) {
    //   print(
    //       "====================================== [ CHANGE TYPE ] ============================================");
    // }
    _instance = _instance ?? GeneralLocalDB<T>._(fromJson: fromJsonFun);

    // if (kDebugMode) {
    //   print(_instance.runtimeType);
    //
    //   print(
    //       "====================================== [ CHANGE TYPE ] ============================================");
    // }

    // if(_instance.runtimeType != T)
    // _instance = _instance ?? GeneralLocalDB<T>._(fromJson: fromJsonFun);
    // _instance = GeneralLocalDB<T>._(fromJson: fromJsonFun);

    // if (kDebugMode) {
    //   print('INSIDE GET INSTANCE : $getInstance');
    //   print('tableName : $tableName');
    //   print('LocalDB _instance : ${_instance.runtimeType}');
    //   print(_instance.runtimeType != T);
    //   print(_instance!.getType());
    //   print(T.toString());
    //   print(_instance!.getType() != T.toString());
    // }
    return _instance;
  }

  Future createTable({required String structure}) async {
    try {
      await DbHelper.db!.execute('''
      CREATE TABLE IF NOT EXISTS $tableName ( $structure )
      ''');
    } catch (e) {
      return handleException(
          exception: e,
          navigation: false,
          methodName: "GeneralLocalDB createTable");
    }
  }

  Future<int> checkIfThereIsRowsInTable() async {
    try {
      final result = await DbHelper.db!.query(tableName, columns: ['COUNT(*)']);
      int count = result.first['COUNT(*)'] as int;
      return count;
    } catch (e) {
      throw handleException(
          exception: e,
          navigation: false,
          methodName: "GeneralLocalDB checkIfThereIsRowsInTable");
    }
  }

  Future<List<T>> index(
      {int? offset, int? limit, bool fromLocal = true}) async {
    try {
      List<Map<String, dynamic>> result;
      if (offset != null) {
        result =
            await DbHelper.db!.query(tableName, offset: offset, limit: limit);
      } else {
        result = await DbHelper.db!.query(tableName);
      }
      if (kDebugMode) {
        print('$tableName index');
        print('$tableName result : $result');
      }
      return result.map((e) => fromJson(e)).toList();
    } catch (e) {
      throw handleException(
          exception: e, navigation: false, methodName: "GeneralLocalDB index");

      // throw Exception(e.toString());
    }
  }

  Future<T> show({required dynamic val, required whereArg}) async {
    try {
      List<Map<String, dynamic>> result = await DbHelper.db!
          .query(tableName, limit: 1, where: '$whereArg = ?', whereArgs: [val]);
      return fromJson(result.first);
    } catch (e) {
      throw handleException(
          exception: e, navigation: false, methodName: "GeneralLocalDB show");
    }
  }

  Future<List<T>> filter(
      {required List whereArgs, required String where}) async {
    try {
      var result = await DbHelper.db!
          .query(tableName, where: where, whereArgs: whereArgs);
      var dataFilter = result
          .map(
            (e) => fromJson(e),
          )
          .toList();
      return dataFilter;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Future getAllItemHistory(
  //     {required String tableName, required String tableId}) async {
  //   try {
  //     var query = await DbHelper.db!.rawQuery('''
  //         SELECT  *
  //         FROM $tableName
  //         INNER JOIN itemhistory ON itemhistory.$tableId = $tableName.id;
  //       ''');
  //     return query;
  //   } catch (e) {

  //     return e.toString();
  //   }
  // }

  Future getIdsOnly() async {
    try {
      var query = await DbHelper.db!.rawQuery('''
          SELECT ${tableName != 'product' ? 'id' : 'product_id'}
          FROM $tableName
        ''');
      // if (kDebugMode) {
      //   print('query : $query');
      // }
      return query
          .map((e) => e[tableName != 'product' ? 'id' : 'product_id'])
          .toList();
    } catch (e) {
      throw handleException(
          exception: e,
          navigation: false,
          methodName: "GeneralLocalDB getIdsOnly");
    }
  }

  Future<int> create({required obj, bool isRemotelyAdded = false}) async {
    try {
      return await DbHelper.db!.insert(
          tableName,
          obj is Map<String, dynamic>
              ? obj
              : obj.toJson(isRemotelyAdded: isRemotelyAdded));
    } catch (e) {
      // print("create Exception : $e");
      // throw Exception(e.toString());

      throw handleException(
          exception: e, navigation: false, methodName: "GeneralLocalDB create");
    }
  }

  Future<int> createList({required List recordsList}) async {
    const batchSize = 10; // Adjust this size as needed
    print('hrllo============== $tableName');
    return await DbHelper.db!.transaction((txn) async {
      int affectedRows = 0;
      try {
        for (int i = 0; i < recordsList.length; i += batchSize) {
          final batch = txn.batch();
          final chunk = recordsList.sublist(
              i,
              i + batchSize > recordsList.length
                  ? recordsList.length
                  : i + batchSize);
          for (var item in chunk) {
            batch.insert(tableName, item.toJson(isRemotelyAdded: true));
          }
          // for (var item in chunk) {
          //   _loadingItemsCountController.increaseLoadingItemCount();
          //   batch.insert(tableName, item.toJson(isRemotelyAdded: true));
          // }

          final List<dynamic> result = await batch.commit();
          affectedRows = result.reduce((sum, element) => sum + element);
        }

        return affectedRows;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        throw handleException(
            exception: e,
            navigation: false,
            methodName: "GeneralLocalDB createList");
      }
    });
  }

  Future<int> update(
      {required dynamic id,
      required obj,
      required String whereField,
      // bool isRemotelyAdded = false
      bool isRemotelyAdded = true}) async {
    try {
      return await DbHelper.db!.update(
        tableName,
        obj is Map<String, dynamic>
            ? obj
            : obj.toJson(isRemotelyAdded: isRemotelyAdded),
        where: '$whereField = ?',
        whereArgs: [id],
      );
    } catch (e) {
      // print("create Exception : $e");
      // throw Exception(e.toString());

      throw handleException(
          exception: e, navigation: false, methodName: "GeneralLocalDB update");
    }
  }

  Future<int> updateList(
      {required List recordsList, required String whereKey}) async {
    //   if (kDebugMode) {
    //   print("items to update : ${recordsList.map((e) => e!.toJson()).toList()}");
    // }
    int affectedRows = 0;

    try {
      return await DbHelper.db!.transaction((txn) async {
        final Batch batch = txn.batch();

        for (var item in recordsList) {
          // bool isExists =
          //     await checkRowExists(id: item.id!, whereKey: whereKey);
          // if (isExists) {
          batch.update(tableName, item.toJson(isRemotelyAdded: true),
              where: '$whereKey = ?', whereArgs: [item!.id]);
          // }
        }
        final List<dynamic> result = await batch.commit();
        affectedRows = result.reduce((sum, element) => sum + element);
        // if (kDebugMode) {
        //   print("_instance : ${_instance.runtimeType}");
        //   print("affectedRows : $affectedRows");
        // }
        return affectedRows;
      });
    } catch (e) {
      // print("updateList exception : $e");
      throw handleException(
          exception: e,
          navigation: false,
          methodName: "GeneralLocalDB updateList");
      // return affectedRows;
    }
  }

  Future checkRowExists(
      {required dynamic val, required String whereKey}) async {
    final result = await DbHelper.db!.query(
      tableName,
      where: '$whereKey = ?',
      whereArgs: [val],
    );
    return result.isNotEmpty;
  }

  Future<int> delete({required int id, required String whereField}) async {
    return await DbHelper.db!.delete(
      tableName,
      where: '$whereField = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteList(
      {required List recordsList, required String whereKey}) async {
    int affectedRows = 0;

    try {
      return await DbHelper.db!.transaction((txn) async {
        final Batch batch = txn.batch();

        for (var item in recordsList) {
          batch.delete(tableName, where: '$whereKey = ?', whereArgs: [item]);
        }
        final List<dynamic> result = await batch.commit();
        affectedRows = result.reduce((sum, element) => sum + element);
        if (kDebugMode) {
          print("_instance : ${_instance.runtimeType}");
          print("affectedRows : $affectedRows");
        }
        return affectedRows;
      });
    } catch (e) {
      // print("updateList exception : $e");
      throw handleException(
          exception: e,
          navigation: false,
          methodName: "GeneralLocalDB deleteList");
      // return affectedRows;
    }
  }

  Future<int> deleteData() async {
    return await DbHelper.db!.delete(
      tableName,
    );
  }

  Future<void> dropTable() async {
    await DbHelper.db!.execute('DROP TABLE IF EXISTS $tableName');
  }

  String getType() {
    String runtimeType = this.runtimeType.toString();
    RegExp regExp = RegExp(r'<(.*?)>');
    Match? match = regExp.firstMatch(runtimeType);

    if (match != null) {
      return match.group(1)!;
    } else {
      // throw Exception("No match found");
      throw handleException(
          exception: "No match found",
          navigation: false,
          methodName: "GeneralLocalDB getType");
    }
  }
}
