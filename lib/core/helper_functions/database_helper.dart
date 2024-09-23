import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'questions_database.db');
    return await openDatabase(
      path,
      version: 2, // Increment version to force recreation
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Added to handle database upgrade
    );
  }

  // This will only be called if the database is being created for the first time
  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE questions (
        id TEXT PRIMARY KEY,
        question TEXT,
        answer TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE tips (
        id TEXT PRIMARY KEY,
        tip TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT,
        email TEXT
      );
    ''');


  }

  // This method is called if the database version is increased
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Optionally drop and recreate tables if necessary
      await db.execute('DROP TABLE IF EXISTS questions');
      await db.execute('DROP TABLE IF EXISTS tips');
      await db.execute('DROP TABLE IF EXISTS users');
      _onCreate(db, newVersion); // Recreate tables and reinsert default data
    }
  }
}
