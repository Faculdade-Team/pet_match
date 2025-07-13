import 'package:sqflite/sqflite.dart';

class DBHelper {
  static late Database _instance;
  static const String dbName = 'pet_match.db';
  static const int dbVersion = 2;

  static Future<Database> getInstance() async {
    String databasesPath = await getDatabasesPath();
    var path = databasesPath + dbName;

    _instance = await openDatabase(
      path,
      onCreate: _onCreate,
      version: dbVersion,
      onOpen: _onOpen,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
    );

    return _instance;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        cellphone TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE adoptions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        name TEXT NOT NULL,
        healthStatus TEXT NOT NULL,
        breed TEXT NOT NULL,
        age TEXT NOT NULL,
        size TEXT NOT NULL,
        imagePath TEXT
      )
    ''');
  }

  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS adoptions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        name TEXT NOT NULL,
        healthStatus TEXT NOT NULL,
        breed TEXT NOT NULL,
        age TEXT NOT NULL,
        size TEXT NOT NULL,
        imagePath TEXT
      )
    ''');
  }

  static Future<void> _onDowngrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {}

  static Future<void> _onOpen(Database db) async {
    print('Database opened: ${db.path}');
  }
}
