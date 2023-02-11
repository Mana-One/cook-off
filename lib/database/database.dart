import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  final String _databaseName = "CookOffDatabase.db";
  final int _databaseVersion = 1;

  DatabaseProvider._privateConstructor();
  static final DatabaseProvider instance =
      DatabaseProvider._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await initDatabase();

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE shopping_list (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            quantity REAL NOT NULL,
            image_url TEXT NOT NULL,
            measure TEXT,
            weight REAL
          )
          ''');
    await db.execute('''
          CREATE TABLE favorites (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            image_url TEXT NOT NULL,
            isFavorite INTEGER NOT NULL
          )
          ''');
  }
}
