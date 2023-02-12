import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqlite_api.dart';

import '../db_helper.dart';
import '../../../models/ingredient.dart';

final shoppingRepositoryProvider = Provider((ref) {
  final dbHelper = ref.read(databaseProvider);
  return ShoppingRepository(dbHelper: dbHelper);
});

class ShoppingRepository {
  final String _table = 'shopping_list';
  final DbHelper dbHelper;

  const ShoppingRepository({required this.dbHelper});

  Future<void> upsert(Ingredient ingredient) async {
    Database db = await dbHelper.database;

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
    Database db = await dbHelper.database;
    List<Map> maps = await db.query(_table);
    return maps.map((e) => Ingredient.fromMap(e)).toList();
  }

  Future<int> delete(String id) async {
    Database db = await dbHelper.database;
    return db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
