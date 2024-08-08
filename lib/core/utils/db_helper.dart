import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'create_local_db_tables.dart';

class DbHelper {
  static DbHelper? _instance;
  static Database? db;

  DbHelper._();

  static Future<DbHelper> getInstance() async {
    db = await _openDatabase();
    _instance ??= DbHelper._();
    return _instance!;
  }

  static Future<String> dbPath() async {
    String path = join(await getDatabasesPath(), "mydb.db");
    // String path = join(await getDatabasesPath(), SharedPr.subscriptionDetailsObj!.db);
    return path;
  }
  //
  // static DatabaseFactory databaseFactory() {
  //   return databaseFactoryFfi;
  // }

  static Future<Database> _openDatabase() async {
    final io.Directory appDocumentsDir =
        await path_provider.getApplicationSupportDirectory();
    // String dbPath = path.join(appDocumentsDir.path, "databases", SharedPr.subscriptionDetailsObj!.db);
    String dbPath = path.join(appDocumentsDir.path, "databases", "mydb.db");

    return await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
          version: 3,
          onCreate: (Database dbx, int version) async {
            db = dbx;
            await DBHelper.createDBTables();
          }),
    );
  }

  static Future<void> deleteDatabase() async {
    // await io.File(databasePath).delete();
  }

  static Future<void> closeDatabase() async {
    //var db = await openDatabase();
    db!.close;
  }
}
