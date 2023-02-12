import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqlite_api.dart';

import '../db_helper.dart';
import '../../../models/recipe.dart';

final favoritesRepositoryProvider = Provider((ref) {
  final dbHelper = ref.read(databaseProvider);
  return FavoritesRepository(dbHelper: dbHelper);
});

class FavoritesRepository {
  final String _table = 'favorites';
  final DbHelper dbHelper;

  const FavoritesRepository({required this.dbHelper});

  Future<List<Recipe>> getAll() async {
    Database db = await dbHelper.database;
    List<Map> maps = await db.query(_table);
    return maps.map((e) => Recipe.fromMap(e)).toList();
  }

  // Future<Recipe> getOne(String id) async {
  //   Database db = await dbHelper.database;
  //   List<Map> maps = await db.query(
  //     _table,
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  //   return Recipe.fromMap(maps.first);
  // }

  // Future<void> upsert(Recipe recipe) async {
  //   Database db = await dbHelper.database;

  //   await db.transaction((txn) async {
  //     int count = await txn.update(
  //       _table,
  //       recipe.toMap(),
  //       where: 'id = ?',
  //       whereArgs: [recipe.id],
  //     );

  //     if (count == 0) {
  //       await txn.insert(_table, recipe.toMap());
  //     }
  //   });
  // }

  Future<void> insert(Recipe recipe) async {
    final Database db = await dbHelper.database;

    await db.insert(
      _table,
      recipe.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> delete(String id) async {
    final Database db = await dbHelper.database;

    await db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Recipe> getOne(String id) async {
    final Database db = await dbHelper.database;
    List<Map> maps = await db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      return Recipe(
        id: '',
        name: '',
        ingredients: [],
        isFavorite: false,
        imageUrl: '',
      );
    }
    return Recipe.fromMap(maps.first);
  }
}
