import 'dart:async';
import 'package:cook_off/database/database.dart';
import 'package:cook_off/models/ingredient.dart';
import 'package:sqflite/sqflite.dart';

class ShoppingListDB {
  final String _table = 'shopping_list';
  final DatabaseProvider _provider = DatabaseProvider.instance;

  ShoppingListDB();

  Future<int> insert(Ingredient ingredient) async {
    Database db = await _provider.database;
    return await db.insert(
      _table,
      ingredient.toMap(),
    );
  }

  Future<void> upsert(Ingredient ingredient) async {
    Database db = await _provider.database;

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
    Database db = await _provider.database;
    List<Map> maps = await db.query(_table);
    return maps.map((e) => Ingredient.fromMap(e)).toList();
  }

  Future<int> update(Ingredient ingredient) async {
    Database db = await _provider.database;
    return db.update(
      _table,
      ingredient.toMap(),
      where: 'id = ?',
      whereArgs: [ingredient.id],
    );
  }

  Future<int> delete(String id) async {
    Database db = await _provider.database;
    return db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
