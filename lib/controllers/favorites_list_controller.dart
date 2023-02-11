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
    await repository.insert(recipe);
    ref.invalidate(favoritesProvider);
  }

  Future<void> delete(Recipe recipe) async {
    await repository.delete(recipe.id);
    ref.invalidate(favoritesProvider);
  }
}
