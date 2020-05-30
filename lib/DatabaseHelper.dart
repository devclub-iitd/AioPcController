import 'package:flutter/material.dart';
import 'dart:math';
import 'package:path/path.dart'; 
import 'package:sqflite/sqflite.dart'; 
class DatabaseHelper {
  //Create a private constructor
  DatabaseHelper._();
 
  static const databaseName = 'customlayouts_database.db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database _database;
 
  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database;
  }
 
  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE customButtons(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, type TEXT, layoutId INTEGER, x REAL, y REAL, sz REAL)");
    });
  }
}

Future<bool> createTable(tableName) async {
  var db = await openDatabase('customLayouts.db');
  try{
    List<Map<String, dynamic>> records = await db.query(tableName);
    print(records);
    db.close();
    return false;
  }
  on DatabaseException{
    await db.execute(
      'CREATE TABLE [$tableName] (id INTEGER PRIMARY KEY, type TEXT, x REAL, y REAL, sz REAL)');
    db.close();
    return true;
  }
}

Future<List<String> > getTables() async{
  var db = await openDatabase('customLayouts.db');
  var tables = await db.rawQuery(
  'SELECT name FROM sqlite_master WHERE type="table" ORDER BY name');
  List<String> tableList = [];
  for(var obj in tables){
    if(obj['name'] != 'android_metadata')
      tableList.add(obj['name']);
  }
  db.close();
  return tableList;
}

void deleteTable(String tableName) async{
  var db = await openDatabase('customLayouts.db');
  await db.execute(
    'DROP TABLE IF EXISTS [$tableName]'
  );
  db.close();
}

void saveButtons(List<Map<String,dynamic>> buttonList, String layoutName) async{
  var db = await openDatabase('customLayouts.db');
  
  await db.execute(
    'DELETE FROM [$layoutName]'
  );
  await db.transaction((txn) async {
    for(int i=0;i<buttonList.length;i++){
      if(buttonList[i]['x']>=-50){
        await txn.rawInsert(
          'INSERT INTO [$layoutName](type, x, y, sz) VALUES("${buttonList[i]['type']}", ${buttonList[i]['x']}, ${buttonList[i]['y']}, ${buttonList[i]['sz']})');
        }
    } 
  });
  db.close();
}

Future<List<Map<String,dynamic>>> getLayoutData(String layoutName) async{
  var db = await openDatabase('customLayouts.db');
  List<Map<String,dynamic>> buttonONList = await db.rawQuery('SELECT * FROM [$layoutName]');
  return buttonONList;
}