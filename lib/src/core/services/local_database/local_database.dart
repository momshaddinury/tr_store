import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  // Private constructor
  LocalDatabase._privateConstructor();

  // Static instance variable
  static final LocalDatabase _instance = LocalDatabase._privateConstructor();

  // Factory constructor that returns the singleton instance
  factory LocalDatabase() {
    return _instance;
  }

  String? _databaseName;
  Database? _db;

  static const String productsTable = 'products';
  static const String categoriesTable = 'categories';
  static const String cartTable = 'cart';

  Future<bool> init(String databaseName) async {
    _databaseName = databaseName;
    final result = await _open();
    log('LocalDatabase: $result');
    return result;
  }

  Future<bool> _open() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$_databaseName';

    try {
      _db = await openDatabase(path);
      await _createTables(_db!);
    } catch (e, stacktrace) {
      log('LocalDatabase: ${e.toString()}');
      log('LocalDatabase: $stacktrace');
      return false;
    }

    return true;
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $productsTable (
      id INTEGER PRIMARY KEY,
      title TEXT,
      price REAL,
      description TEXT,
      category TEXT,
      image TEXT,
      FOREIGN KEY (category) REFERENCES $categoriesTable (name)
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $categoriesTable (
      name TEXT PRIMARY KEY
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $cartTable (
      product_id INTEGER PRIMARY KEY,
      quantity INTEGER,
      FOREIGN KEY (product_id) REFERENCES $productsTable (id)
    )
    ''');
  }

  Future<List<Map<String, Object?>>> read(String table, {dynamic id}) async {
    if (id != null) {
      return await _db!.query(table, where: 'id = ?', whereArgs: [id]);
    }
    return await _db!.query(table);
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    await _db!.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
      nullColumnHack: null,
    );
  }

  Future<void> update(String table, Map<String, dynamic> data) async {
    await _db!.update(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(String table, int id) async {
    await _db!.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    await _db?.close();
  }
}
