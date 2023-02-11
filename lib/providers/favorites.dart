import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/repositories/favorites_repository.dart';
import '../models/recipe.dart';

final favoritesProvider = FutureProvider<List<Recipe>>((ref) async {
  final repository = ref.read(favoritesRepositoryProvider);
  return repository.getAll();
});
