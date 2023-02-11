import 'package:cook_off/models/recipe.dart';
import 'package:cook_off/repository/favorites_list_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<List<Recipe>> {
  FavoritesNotifier() : super([]);
  final favoritesListRepository = FavoritesListRepository();

  List<Recipe> get favorites => state;

  Future<void> addFavorite(Recipe recipe) async {
    recipe.isFavorite = true;
    await favoritesListRepository.upsert(recipe);
    state = [
      ...state,
      recipe,
    ];
  }

  Future<void> removeFavorite(Recipe recipe) async {
    recipe.isFavorite = false;
    await favoritesListRepository.upsert(recipe);
    state = state.where((element) => element.id != recipe.id).toList();
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Recipe>>(
  (ref) => FavoritesNotifier(),
);
