import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static DatabaseService? _databaseService; //Singleton DatabaseService
  static Database? _database; //Singleton database

  //Database Model
  String usersTable = 'users';
  String colId = 'id';
  String colUuid = 'uuid';
  String colFirstname = 'firstname';
  String colLastname = 'lastname';
  String colGender = 'gender';
  String colEmail = 'email';
  String colStreet = 'street';
  String colCity = 'city';
  String colPicture = 'picture';

  DatabaseService._createInstance();

  factory DatabaseService() {
    _databaseService ??= DatabaseService._createInstance();
    return _databaseService!;
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute("""
     CREATE TABLE IF NOT EXISTS $usersTable (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colUuid TEXT,
      $colFirstname TEXT,
      $colLastname TEXT,
      $colGender TEXT,
      $colEmail TEXT,
      $colStreet TEXT,
      $colCity TEXT,
      $colPicture TEXT
     )
       """);
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'my_database.db';
    final path = await getDatabasesPath();

    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;

    var database = await openDatabase(path,
        version: 5, onCreate: _createDb, singleInstance: true);
    return database;
  }

  static Future<int> insertUser(Map<String, dynamic> data) async {
    final db = await DatabaseService().database;
    return await db.insert('users', data);
  }

  static Future<int> deleteUser(String uuid) async {
    final db = await DatabaseService().database;
    return await db.delete('users', where: 'uuid = ?', whereArgs: [uuid]);
  }

  static Future<int> updateUser(String uuid, Map<String, dynamic> data) async {
    final db = await DatabaseService().database;
    return await db.update('users', data, where: 'uuid = ?', whereArgs: [uuid]);
  }

  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await DatabaseService().database;
    return await db.query('users', limit: 15, orderBy: 'id DESC');
  }
}
