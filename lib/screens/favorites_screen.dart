import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/favorites.dart';
import '../providers/favorites_notifier.dart';
import '../widgets/recipe_item.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteRecipes = ref.watch(favoritesDataProvider.future);

    return FutureBuilder(
      future: favoriteRecipes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var favoriteRecipeList = snapshot.data;
          if (favoriteRecipeList == null || favoriteRecipeList.isEmpty) {
            return const Center(child: Text('You have no favorite recipes.'));
          }

          return ListView.builder(
            itemBuilder: (context, index) => Dismissible(
              key: UniqueKey(),
              onDismissed: (DismissDirection direction) {
                ref
                    .read(favoritesProvider.notifier)
                    .removeFavorite(favoriteRecipeList[index]);
                ref.invalidate(favoritesDataProvider);
              },
              child: RecipeItem(recipe: favoriteRecipeList[index]),
            ),
            itemCount: favoriteRecipeList.length,
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
