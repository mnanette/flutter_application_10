// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SqlHelper {
  Database? db;
  SqlHelper() {
    _init();
  }
  // ignore: unused_element
  void _createTables() async {
    try {
      await db!.execute("""
create table if not exists employee (
  id Integer primary key,
  name String ,
  email String ,
  department String ,
  phoneExt String,
)
""");
    } catch (e) {
      print('Error on creating table: $e');
    }
  }

  void _init() async {
    try {
      if (kIsWeb) {
        var factory = databaseFactoryFfiWeb;

        db = await factory.openDatabase('emp.db');
      } else {
        db = await openDatabase(
          'emp.db',
          onCreate: (db, version) {
            print('Database created successfully');
          },
        );
      }
    } catch (e) {
      print('Error on creating database: $e');
    }
  }
}
