import 'package:sqflite/sqlite_api.dart';

import '../database/database.dart';
import '../models/recipe.dart';

class FavoritesListRepository {
  final String _table = 'favorites';
  final DatabaseProvider _provider = DatabaseProvider.instance;

  Future<List<Recipe>> getAll() async {
    Database db = await _provider.database;
    List<Map> maps = await db.query(_table);
    return maps.map((e) => Recipe.fromMap(e)).toList();
  }

  Future<Recipe> getOne(String id) async {
    Database db = await _provider.database;
    List<Map> maps = await db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return Recipe.fromMap(maps.first);
  }

  Future<void> upsert(Recipe recipe) async {
    Database db = await _provider.database;

    await db.transaction((txn) async {
      int count = await txn.update(
        _table,
        recipe.toMap(),
        where: 'id = ?',
        whereArgs: [recipe.id],
      );

      if (count == 0) {
        await txn.insert(_table, recipe.toMap());
      }
    });
  }
}
