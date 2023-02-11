import 'package:cook_off/providers/favorites.dart';
import 'package:cook_off/providers/favorites_notifier.dart';
import 'package:cook_off/widgets/recipe_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            favoriteRecipeList.removeWhere((element) => !element.isFavorite);

            return ListView.builder(
              itemBuilder: (context, index) => Dismissible(
                key: UniqueKey(),
                onDismissed: (DismissDirection direction) {
                  ref
                      .read(favoritesProvider.notifier)
                      .removeFavorite(favoriteRecipeList[index]);
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
        });
  }
}
