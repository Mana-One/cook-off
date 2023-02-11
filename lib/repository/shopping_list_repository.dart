import 'package:cook_off/database/database.dart';
import 'package:cook_off/models/ingredient.dart';
import 'package:sqflite/sqlite_api.dart';

class ShoppingListRepository {
  final String _table = 'shopping_list';
  final DatabaseProvider _provider = DatabaseProvider.instance;
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

  Future<int> delete(String id) async {
    Database db = await _provider.database;
    return db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
