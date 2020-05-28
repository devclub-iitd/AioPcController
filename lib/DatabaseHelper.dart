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