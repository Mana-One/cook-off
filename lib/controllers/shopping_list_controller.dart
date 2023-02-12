import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ingredient.dart';
import '../providers/shopping_list.dart';
import '../data/local/repositories/shopping_repository.dart';

final shoppingListController = Provider((ref) {
  final repository = ref.read(shoppingRepositoryProvider);
  return ShoppingListController(ref: ref, repository: repository);
});

class ShoppingListController {
  final ProviderRef ref;
  final ShoppingRepository repository;

  const ShoppingListController({
    required this.ref,
    required this.repository,
  });

  Future<void> addOrUpdate(Ingredient ingredient) async {
    await repository.upsert(ingredient);
    ref.invalidate(shoppingListProvider);
  }

  Future<void> delete(Ingredient ingredient) async {
    await repository.delete(ingredient.id);
    ref.invalidate(shoppingListProvider);
  }
}
