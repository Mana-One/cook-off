import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/current_recipe.dart';
import '../providers/favorites.dart';
import '../data/local/repositories/favorites_repository.dart';
import '../providers/favorite_checker.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteStatus = ref.watch(favoriteCheckerProvider);

    return favoriteStatus.when(
      data: (data) {
        if (data) {
          return IconButton(
            color: Theme.of(context).primaryColorDark,
            onPressed: () => _unmarkAsFavorite(ref),
            icon: const Icon(
              Icons.favorite,
              size: 40,
            ),
          );
        }
        return IconButton(
          color: Theme.of(context).primaryColorDark,
          onPressed: () => _markAsFavorite(ref),
          icon: const Icon(
            Icons.favorite_border,
            size: 40,
          ),
        );
      },
      error: (error, stackTrace) => const Icon(Icons.error),
      loading: () => const CircularProgressIndicator(),
    );
  }

  void _markAsFavorite(WidgetRef ref) {
    final currentRecipe = ref.read(currentRecipeProvider.notifier).current;
    if (currentRecipe == null) {
      return;
    }
    ref.read(favoritesRepositoryProvider).insert(currentRecipe);
    ref.invalidate(favoriteCheckerProvider);
    ref.invalidate(favoritesProvider);
  }

  void _unmarkAsFavorite(WidgetRef ref) {
    final currentRecipe = ref.read(currentRecipeProvider.notifier).current;
    if (currentRecipe == null) {
      return;
    }
    ref.read(favoritesRepositoryProvider).delete(currentRecipe.id);
    ref.invalidate(favoriteCheckerProvider);
    ref.invalidate(favoritesProvider);
  }
}
