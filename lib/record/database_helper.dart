import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import './record.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String recordTable = 'record_table';
  String colId = 'id';
  String colName = 'name';
  String colDescription = 'description';
  String colDate = 'date';
  //List<String> colScore = ['s1', 's2', 's3', 's4', 's5', 's6', 's7', 's8', 's9', 's10', 's11', 's12'];
  String colScore_01 = 's1'; //used as map in record.dart
  String colScore_02 = 's2';
  String colScore_03 = 's3';
  String colScore_04 = 's4';
  String colScore_05 = 's5';
  String colScore_06 = 's6';
  String colScore_07 = 's7';
  String colScore_08 = 's8';
  String colScore_09 = 's9';
  String colScore_10 = 's10';
  String colScore_11 = 's11';
  String colScore_12 = 's12';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
  if (_database == null) {
    _database = await initializeDatabase();}
  return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get database directory
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'records.db';
    // Open/create db at path
    var recordsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return recordsDatabase;
  }

  void _createDb (Database db, int newVersion) async {
    //await db.execute('CREATE TABLE $recordTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colDescription TEXT, ${colScore[0]} INT, ${colScore[1]} INT, ${colScore[2]} INT, ${colScore[3]} INT, ${colScore[4]} INT, ${colScore[5]} INT, ${colScore[6]} INT, ${colScore[7]} INT, ${colScore[8]} INT, ${colScore[9]} INT, ${colScore[10]} INT, ${colScore[11]} INT, $colDate TEXT');
        await db.execute('CREATE TABLE $recordTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colDescription TEXT,'
        '$colScore_01 INT, $colScore_02 INT, $colScore_03 INT, $colScore_04 INT, $colScore_05 INT,'
        '$colScore_06 INT, $colScore_07 INT, $colScore_08 INT, $colScore_09 INT, $colScore_10 INT,'
        '$colScore_11 INT, $colScore_12 INT, $colDate TEXT)');

  }

  Future<int> insertRecord (Record record) async {
    Database db = await this.database;
    var result = await db.insert(recordTable, record.toMap());
    return result;
  }

  Future<int> updateRecord (Record record) async {
    Database db = await this.database;
    var result = await db.update(recordTable, record.toMap(), where: '$colId = ?', whereArgs: [record.id]);
    return result;
  }

  Future<int> deleteRecord (int id) async {
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $recordTable WHERE $colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $recordTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Record>> getRecordList() async { //convert map list into record list
    var recordMapList = await getRecordMapList();
    int count = recordMapList.length;
    List<Record> recordList = List<Record>();

    for (int i=0; i< count; i++){
      recordList.add(Record.fromMapObject(recordMapList[i]));
    }
    return recordList;
  }

  Future<List<Map<String,dynamic>>> getRecordMapList() async { //obtain data in database in map list
    Database db = await this.database;
    var result = await db.query(recordTable, orderBy: '$colId ASC');
    return result;
  }


}