import 'package:cook_off/providers/search_input.dart';
import 'package:cook_off/services/recipes_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/recipe.dart';

final recipesServiceProvider = Provider((ref) => const RecipesService());

final recipesProvider = FutureProvider<List<Recipe>>((ref) async {
  final repository = ref.read(recipesServiceProvider);
  final searchInput = await ref.watch(searchInputProvider.future);

  return repository.fetchRecipes(searchInput);
});
