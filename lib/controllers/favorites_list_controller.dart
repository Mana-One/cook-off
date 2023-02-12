import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/repositories/favorites_repository.dart';
import '../providers/favorites.dart';
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

  Future<void> delete(Recipe recipe) async {
    recipe.isFavorite = false;
    await repository.delete(recipe.id);
    ref.invalidate(favoritesProvider);
  }
}
