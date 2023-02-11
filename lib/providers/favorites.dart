import 'package:cook_off/repository/favorites_list_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/recipe.dart';

final favoritesDBProvider = Provider((ref) => FavoritesListRepository());

final favoritesDataProvider = FutureProvider<List<Recipe>>((ref) async {
  final repository = ref.read(favoritesDBProvider);

  return repository.getAll();
});
