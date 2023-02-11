import 'package:cook_off/models/ingredient.dart';
import 'package:cook_off/repository/shopping_list_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shoppingListDBProvider = Provider((ref) => ShoppingListRepository());

final shoppingListDataProvider = FutureProvider<List<Ingredient>>((ref) async {
  final repository = ref.read(shoppingListDBProvider);

  return repository.getAll();
});
