import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ingredient.dart';
import '../data/local/repositories/shopping_repository.dart';

final shoppingListProvider = FutureProvider<List<Ingredient>>((ref) async {
  final repository = ref.read(shoppingRepositoryProvider);
  return repository.getAll();
});
