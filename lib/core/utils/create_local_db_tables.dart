import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'dart:io' as io;

import 'package:path_provider/path_provider.dart' as path_provider;

class DBHelper {
  static createDBTables() async {
    // await NotificationService.getInstance().createNotificationTable();
    // await CustomerService.getInstance().createTable();
    // await PosCategoryService.getInstance().createTable();
    // await ProductService.getInstance().createTable();
    // await ProductUnitService.getInstance().createTable();
    // await SessionService.getInstance().createTable();
  }

  static dropDBData({isDeleteBasicData = false}) async {
    // await NotificationService.getInstance().dropTable();
    // await CustomerService.getInstance().deleteData();
    // await PosCategoryService.getInstance().deleteData();
    // await ProductService.getInstance().deleteData();
    // await ProductUnitService.getInstance().deleteData();
    // if (!isDeleteBasicData) {
    //   await AuthenticationService.getInstance().deleteData();
    // }
    // await SessionService.getInstance().deleteData();
  }
  static dropDBTable({isDeleteBasicData = false}) async {
    // await NotificationService.getInstance().dropTable();
    // await CustomerService.getInstance().dropTable();
    // await PosCategoryService.getInstance().dropTable();
    // await ProductService.getInstance().dropTable();
    // await ProductUnitService.getInstance().dropTable();
    // if (!isDeleteBasicData) {
    //   await AuthenticationService.getInstance().dropTable();
    // }
    // await SessionService.getInstance().dropTable();
  }

  static deleteFile() async {
    final io.Directory directory =
        await path_provider.getApplicationSupportDirectory();
    // final directory = Directory(path.join(Platform.environment['APPDATA']!, 'com.example', 'pos_desktop', 'databases'));
    final filePath = path.join(directory.path, "databases", "mydb.db");
    final file = File(filePath);

    if (file.existsSync()) {
      try {
        file.deleteSync();
        if (kDebugMode) {
          print('File deleted successfully.');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error deleting file: $e');
        }
      }
    } else {
      if (kDebugMode) {
        print('File does not exist.');
      }
    }
  }
}
