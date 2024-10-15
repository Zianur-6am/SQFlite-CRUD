import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/tasks.dart';

class DatabaseService {
  //starts ------->setting up database
  //Achieving singleton pattern
  //There will be only one instance of this class in the lifecycle of the app
  static final DatabaseService instance = DatabaseService._privateconstructor();
  //static final DatabaseService instance = DatabaseService.instance; //singleton without private constructor

  static Database? _db;

  final String _taskTableName = "tasks";
  final String _tasksIdColumnName = "id";
  final String _taskTitleColumnName = "title";
  final String _taskDescriptionColumnName = "description";
  final String _taskStatusColumnName = "status";

  //private constructor ---> helps to achieve singleton pattern
  DatabaseService._privateconstructor();

  //factory constructor

  //getter method to get database
  Future<Database?> get database async {
    //if database exists then return it
    if (_db != null)
      return _db;
    else {
      //create and get database
      _db = await getDatabase();
      return _db;
    }
  }

  //create and get database
  Future<Database> getDatabase() async {
    //getting the directory where out database file will be stored
    final databaseDirPath = await getDatabasesPath();
    //creating database path
    final databasePath = join(databaseDirPath, "masterdb.db");

    //opening database by calling openDatabase method which takes path and onCreate callback function
    final database = await openDatabase(
      databasePath,
      version: 1,
      //oncreate takes callback function which takes database and version
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_taskTableName(
          $_tasksIdColumnName INTEGER PRIMARY KEY,
          $_taskTitleColumnName TEXT NOT NULL,
          $_taskDescriptionColumnName TEXT NOT NULL,
          $_taskStatusColumnName INTEGER NOT NULL
          )
          ''');
      },
    );
    //returning the created database
    return database;
  }
  //stop -------------> setting up database

  void addTask(String title, String description) async {
    //getting the database
    final db = await database;

    //operating insert operation
    await db?.insert(_taskTableName,
        {_taskTitleColumnName : title, _taskDescriptionColumnName : description, _taskStatusColumnName : 0});
  }

  Future<List<Tasks>?> getTask() async {
    //getting the database
    final db = await database;

    //query for database
    final data = await db?.query(_taskTableName);

    //converting to list, of Tasks model*************
    List<Tasks>? tasks = data?.map((e) => Tasks(
        id: e["id"] as int,
        title: e["title"] as String,
        status: e["status"] as int,
        description: e['description'] as String),
    ).toList();

    return tasks;
  }

  void updateTaskStatus(int id, String title, String description, int status) async {
    //getting the database
    final db = await database;
    //Query to update table
    await db?.update(
      //table name
        _taskTableName,
      //things to update
        {
          _taskTitleColumnName : title,
          _taskDescriptionColumnName : description,
          _taskStatusColumnName : status
        },
      //if we do not provide specific id then all the row will be updated
      where: 'id = ?',
      whereArgs: [id,],
    );

  }

  void deleteTask (int id) async {
    //getting the database
    final db = await database;
    //Query to delete table
    await db?.delete(
        //table name
        _taskTableName,
        //if we do not provide specific id then all the row will be updated
        where: 'id = ?',
        whereArgs: [id,]
    );
  }
}
