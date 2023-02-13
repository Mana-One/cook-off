import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/ref_debounce.dart';
import '../data/remote/services/recipes_service.dart';
import '../providers/current_recipe.dart';
import '../models/detailed_recipe.dart';

final currentRecipeDetailsProvider = FutureProvider<DetailedRecipe>((ref) {
  final repository = ref.read(recipesServiceProvider);
  final currentRecipe = ref.watch(currentRecipeProvider.notifier).current;
  if (currentRecipe == null) {
    throw Exception('Invalid recipe id.');
  }

  final cancelToken = ref.createCancelToken();
  return repository.find(currentRecipe.id, cancelToken);
});
