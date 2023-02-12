import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/recipe.dart';

class CurrentRecipeNotifer extends StateNotifier<Recipe?> {
  CurrentRecipeNotifer() : super(null);

  Recipe? get current => state;

  void replaceCurrentRecipe(Recipe recipe) {
    state = recipe;
  }
}

final currentRecipeProvider =
    StateNotifierProvider<CurrentRecipeNotifer, Recipe?>(
  (ref) => CurrentRecipeNotifer(),
);
