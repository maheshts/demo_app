

import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';


class DatabaseHelper {

  static final _databaseName = "MyDatabase.db";
  static final _databaseName1 = "MyDatabase1.db";
  static final _databaseVersion = 1;

  static final table = 'my_table';
  static final listTable = 'list_table';


  static final columnId = '_id';
  static final albumId = 'albumId';
  static final columnName = 'details';
  static final columnBody = 'body';
  static final columnUrl = 'url';


  static final email = 'email';
  static final userName = 'name';
  static final userPhone = 'phonenumber';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Batch batch;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }



  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);


  }



  Future<void> _onCreate(Database db, int version) async {

    await db.execute('''
    CREATE TABLE $table(
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnBody TEXT NOT NULL
    )
    ''');


  }



//#"date INTEGER DEFAULT (cast(strftime('%s','now') as int))",
  Future<int> insert(Map<String, dynamic> row)async{
    Database db = await instance.database;
    return await db.insert(table, row);
  }

Future<int> inserts(Map<String, dynamic> row)async{
    Database db = await instance.database;
    return await db.insert(listTable, row);
  }



  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
   // return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> queryRowCountData() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $listTable'));
    // return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<List<Map<String, dynamic>>> getAllRecords() async {
    Database db = await instance.database;
    return await db.query(table);
  }




}