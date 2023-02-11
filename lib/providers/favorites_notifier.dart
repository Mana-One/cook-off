import 'package:cook_off/models/recipe.dart';
import 'package:cook_off/repository/favorites_list_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<List<Recipe>> {
  FavoritesNotifier() : super([]);
  final favoritesListRepository = FavoritesListRepository();

  List<Recipe> get favorites => state;

  void addFavorite(Recipe recipe) {
    recipe.isFavorite = true;
    favoritesListRepository.upsert(recipe);
    state = [
      ...state,
      recipe,
    ];
  }

  void removeFavorite(Recipe recipe) {
    recipe.isFavorite = false;
    favoritesListRepository.upsert(recipe);
    state = state.where((element) => element.id != recipe.id).toList();
  }

  bool isFavorite(Recipe recipe) {
    return state.any((element) => element.id == recipe.id);
  }

  bool isEmpty() => state.isEmpty;
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Recipe>>(
  (ref) => FavoritesNotifier(),
);
