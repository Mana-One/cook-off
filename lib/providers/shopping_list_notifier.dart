import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ingredient.dart';
import '../repository/shopping_list_repository.dart';

class ShoppingListNotifier extends StateNotifier<List<Ingredient>> {
  ShoppingListNotifier() : super([]);
  final shoppingListRepository = ShoppingListRepository();

  List<Ingredient> get ingredients => state;

  Future<void> addIngredient(Ingredient ingredient) async {
    await shoppingListRepository.upsert(ingredient);
    state = [
      ...state,
      ingredient,
    ];
  }

  Future<void> removeIngredient(Ingredient ingredient) async {
    await shoppingListRepository.delete(ingredient.id);
    // update the state
    state = state.where((element) => element.id != ingredient.id).toList();
  }
}

final shoppingListProvider =
    StateNotifierProvider<ShoppingListNotifier, List<Ingredient>>(
  (ref) => ShoppingListNotifier(),
);
