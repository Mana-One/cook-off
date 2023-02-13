import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

final databaseProvider = Provider((ref) => DbHelper());

class DbHelper {
  final String _databaseName = "CookOffDatabase.db";
  final int _databaseVersion = 1;
  Database? _db;

  Future<Database> get database async => _db ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    String path = p.join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE shopping_list (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        quantity REAL NOT NULL,
        image_url TEXT NOT NULL,
        measure TEXT
      )
      ''',
    );
    await db.execute(
      '''CREATE TABLE favorites (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        image_url TEXT NOT NULL
      )
      ''',
    );
  }
}
