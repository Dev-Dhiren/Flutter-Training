import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user.dart';



class DatabaseHelper {
  static final _dbVersion = 1;

  static final _dbName = 'flutter_students.db';

  // tables
  static final _tableUser = 'user_table';

  // columns
  static final _colId = 'id';
  static final _colName = 'name';
  static final _colEmail = 'email';

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  // initialize database object
  Future<Database> getDatabase() async {
    database ??= await _initDatabase();
    return database!;
  }

  Future<Database> _initDatabase() async {
    var path = await getDatabasesPath();
    /*print('path : $path');
    print('database name : $_dbName');

    print('database path : ${join(path, _dbName)}');*/

    String dbPath = join(path, _dbName);

    return await openDatabase(
      dbPath,
      version: _dbVersion,
      onUpgrade: (db, oldVersion, newVersion) {},
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $_tableUser ('
          '$_colId INTEGER PRIMARY KEY AUTOINCREMENT,'
          '$_colName TEXT NOT NULL,'
          '$_colEmail TEXT NOT NULL'
          ')',
        );
      },
    );
  }

  Future<void> addUser(User user) async {
    var db = await getDatabase();

  }

  void deleteUser() {}

  void updateUser() {}

  void getUsers() {}
}
