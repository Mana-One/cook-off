import 'dart:async';
import 'package:cook_off/models/ingredient.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ShoppingListDB {
  final String _databaseName = "CookOffDatabase.db";
  final int _databaseVersion = 1;
  final String _table = 'shopping_list';
  final String _columnId = 'id';
  final String _columnName = 'name';
  final String _columnQuantity = 'quantity';
  final String _columnImageUrl = 'image_url';
  final String _columnMeasure = 'measure';
  final String _columnWeight = 'weight';

  ShoppingListDB._privateConstructor();
  static final ShoppingListDB instance = ShoppingListDB._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await initDatabase();

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_table (
            $_columnId INTEGER PRIMARY KEY,
            $_columnName TEXT NOT NULL,
            $_columnQuantity REAL NOT NULL,
            $_columnImageUrl TEXT NOT NULL,
            $_columnMeasure TEXT NULLABLE,
            $_columnWeight REAL
          )
          ''');
  }

  Future<int> insert(Ingredient ingredient) async {
    Database db = await instance.database;
    return await db.insert(
      _table,
      ingredient.toMap(),
    );
  }

  Future<void> upsert(Ingredient ingredient) async {
    Database db = await instance.database;
    // return db.execute('''
    // INSERT INTO $_table ($_columnId, $_columnName, $_columnQuantity, $_columnImageUrl, $_columnMeasure, $_columnWeight)
    // VALUES (${ingredient.id}, ${ingredient.name}, ${ingredient.quantity}, '"${ingredient.imageUrl}"', ${ingredient.measure}, ${ingredient.weight})
    // ON CONFLICT (id) DO UPDATE
    // SET quantity=$_table.quantity + excluded.quantity''');

    await db.transaction((txn) async {
      int count = await txn.rawUpdate(
        'UPDATE $_table SET quantity=$_table.quantity + ? WHERE id = ?',
        [ingredient.quantity, ingredient.id],
      );

      if (count == 0) {
        await txn.insert(_table, ingredient.toMap());
      }
    });
  }

  Future<List<Ingredient>> getAll() async {
    Database db = await instance.database;
    List<Map> maps = await db.query(_table);

    return List<Ingredient>.generate(maps.length, (i) {
      return Ingredient(
        id: maps[i][_columnId],
        name: maps[i][_columnName],
        quantity: maps[i][_columnQuantity],
        imageUrl: maps[i][_columnImageUrl],
        measure: maps[i][_columnMeasure],
        weight: maps[i][_columnWeight],
      );
    });
  }

  Future<int> update(Ingredient ingredient) async {
    Database db = await instance.database;
    return db.update(
      _table,
      ingredient.toMap(),
      where: 'id = ?',
      whereArgs: [ingredient.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
