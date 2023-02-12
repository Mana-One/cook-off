import 'package:cook_off/data/local/repositories/favorites_repository.dart';
import 'package:cook_off/providers/favorites.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/recipe.dart';

final favoritesListController = Provider((ref) {
  final repository = ref.read(favoritesRepositoryProvider);
  return FavoritesListController(ref: ref, repository: repository);
});

class FavoritesListController {
  final ProviderRef ref;
  final FavoritesRepository repository;

  const FavoritesListController({
    required this.ref,
    required this.repository,
  });

  Future<void> insert(Recipe recipe) async {
    recipe.isFavorite = true;
    await repository.insert(recipe);
    ref.invalidate(favoritesProvider);
  }

  Future<Recipe> _getOne(String recipeId) async {
    return await repository.getOne(recipeId);
  }

  Future<bool> isFavorite(String recipeId) async {
    Recipe recipe = await _getOne(recipeId);
    return recipe.id == '' ? false : recipe.isFavorite;
  }

  Future<void> delete(Recipe recipe) async {
    recipe.isFavorite = false;
    await repository.delete(recipe.id);
    ref.invalidate(favoritesProvider);
  }
}
