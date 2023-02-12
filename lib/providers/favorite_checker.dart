import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/repositories/favorites_repository.dart';
import '../providers/current_recipe.dart';

final favoriteCheckerProvider = FutureProvider<bool>((ref) {
  final currentRecipe = ref.watch(currentRecipeProvider);
  if (currentRecipe == null) {
    return false;
  }
  final repository = ref.read(favoritesRepositoryProvider);
  return repository.isFavorite(currentRecipe.id);
});
