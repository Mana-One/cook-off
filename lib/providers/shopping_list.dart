import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ingredient.dart';
import '../repository/shopping_list_repository.dart';

final shoppingListDBProvider = Provider((ref) => ShoppingListRepository());

final shoppingListDataProvider = FutureProvider<List<Ingredient>>((ref) async {
  final repository = ref.read(shoppingListDBProvider);

  return repository.getAll();
});
