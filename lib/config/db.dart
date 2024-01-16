import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDB {
  static const String dbName = 'db_name.db';
  static const String dbVersion = '1.0';
  static const String dbDescription = 'db_description';
  static const int dbSize = 2000000;

  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDB();
    return _db!;
  }

  static initDB() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  static void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS table_name (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)',
    );
    log('Table is created', name: 'SQLiteDB-> _onCreate');
  }

  static Future<int> save(String table, Map<String, dynamic> values) async {
    var dbClient = await db;
    int res = await dbClient.insert(table, values);
    log('Item saved $res', name: 'SQLiteDB-> save');
    return res;
  }

  static Future<List<Map<String, dynamic>>> getAll(String table) async {
    var dbClient = await db;
    List<Map<String, dynamic>> res = await dbClient.query(table);
    log('Items fetched', name: 'SQLiteDB-> getAll');
    return res;
  }

  static Future<int> delete(String table, int id) async {
    var dbClient = await db;
    int res = await dbClient.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    log('Item deleted $res', name: 'SQLiteDB-> delete');
    return res;
  }

  static Future<int> update(String table, Map<String, dynamic> values) async {
    var dbClient = await db;
    int res = await dbClient.update(
      table,
      values,
      where: 'id = ?',
      whereArgs: [values['id']],
    );
    log('Item updated $res', name: 'SQLiteDB-> update');
    return res;
  }

  static Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}

// usage
// import 'package:sqlite_db/db.dart';
//
// SQLiteDB.save('table_name', {'name': 'name', 'value': 1, 'num': 1.1});
// SQLiteDB.getAll('table_name');
// SQLiteDB.delete('table_name', 1);
// SQLiteDB.update('table_name', {'id': 1, 'name': 'name', 'value': 1, 'num': 1.1});
// SQLiteDB.close();
