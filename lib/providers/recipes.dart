import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/ref_debounce.dart';
import '../providers/search_input.dart';
import '../data/remote/services/recipes_service.dart';
import '../models/recipe.dart';

final recipesProvider = FutureProvider<List<Recipe>>((ref) async {
  final repository = ref.read(recipesServiceProvider);
  final searchInput = await ref.watch(searchInputProvider.future);

  final cancelToken = ref.createCancelToken();
  return repository.fetchRecipes(
    searchInput,
    cancelToken,
  );
});
