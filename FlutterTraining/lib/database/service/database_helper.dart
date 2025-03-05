import 'package:flutter_training/database/models/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user.dart';

class DatabaseHelper {
  static final _dbVersion = 3;

  static final _dbName = 'flutter_students.db';

  // tables
  static final _tableUser = 'user_table';
  static final _tableTask = 'task_table';

  // columns
  static final _colId = 'id';
  static final _colName = 'name';
  static final _colEmail = 'email';

  static final _colUserId = 'userId';
  static final _colTitle = 'title';
  static final _colDesc = 'description';
  static final _colCreatedAt = 'createdAt';

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
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < _dbVersion) {
          await _createTaskTable(db);
        }
      },
      onCreate: (db, version) async {
        await _createUserTable(db);
        await _createTaskTable(db);
      },
    );
  }

  _createUserTable(Database db) async {
    await db.execute(
      'CREATE TABLE $_tableUser ('
      '$_colId INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$_colName TEXT NOT NULL,'
      '$_colEmail TEXT NOT NULL'
      ')',
    );
  }

  _createTaskTable(Database db) async {
    await db.execute(
      'CREATE TABLE $_tableTask ('
      '$_colId INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$_colTitle TEXT NOT NULL,'
      '$_colDesc TEXT NOT NULL,'
      '$_colUserId INTEGER NOT NULL,'
      '$_colCreatedAt TEXT NOT NULL,'
      'FOREIGN KEY ($_colUserId) REFERENCES $_tableUser ($_colId)'
      ')',
    );
  }

  /*Future<int> addUser(User user) async {
    try {
      var db = await getDatabase();
      return await db.insert(_tableUser, user.toMap());
    } catch (e) {
      // throw exception
      return -1;
    }
  }*/

  /// ****** USER TABLE **********

  Future<void> addUser({
    required User user,
    required Function(User) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      var db = await getDatabase();

      int id = await db.insert(_tableUser, user.toMap());
      user.id = id;

      // function calling
      onSuccess(user);
    } catch (e) {
      // throw exception
      onError('Error : ${e.toString()}');
    }
  }

  Future<int> deleteUser(int id) async {
    // delete from user_table where id = 2

    var db = await getDatabase();
    return await db.delete(_tableUser, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateUser(User user) async {
    var db = await getDatabase();
    return await db.update(
      _tableUser,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<List<User>> getUsers() async {
    try {
      var db = await getDatabase();
      var mapList = await db.query(_tableUser);

      List<User> userList =
          mapList.map((element) => User.fromMap(element)).toList();

      return userList;
    } catch (e) {
      return [];
    }
  }

  /// ********** TASK TABLE ***********

  Future<int> addTask(Task task) async {
    try {
      var db = await getDatabase();
      return await db.insert(_tableTask, task.toMap());
    } catch (e) {
      // throw exception
      return -1;
    }
  }

  Future<List<Task>> getTasks(int userId) async {
    try {
      var db = await getDatabase();
      var mapList = await db.query(
        _tableTask,
        where: '$_colUserId = ?',
        whereArgs: [userId],
      );

      List<Task> taskList =
          mapList.map((element) => Task.fromMap(element)).toList();

      return taskList;
    } catch (e) {
      return [];
    }
  }
}
