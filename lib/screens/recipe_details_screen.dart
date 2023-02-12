import 'package:cached_network_image/cached_network_image.dart';
import 'package:cook_off/controllers/favorites_list_controller.dart';
import 'package:cook_off/controllers/shopping_list_controller.dart';
import 'package:cook_off/models/ingredient.dart';
import 'package:cook_off/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeDetailsScreen extends ConsumerWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(favoritesListController);
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            margin: const EdgeInsets.only(top: 20, left: 40, right: 40),
            child: Row(
              children: [
                Expanded(
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: recipe.imageUrl,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Text(
                                recipe.name,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            IconButton(
                              onPressed: () async =>
                                  _toggleLikeButton(ref, recipe.id),
                              icon: Icon(recipe.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                            ),
                            IconButton(
                                onPressed: () =>
                                    _addAllIngredients(ref, recipe.ingredients),
                                icon: const Icon(Icons.add_shopping_cart)),
                          ],
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                              itemCount: recipe.ingredients?.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(recipe.ingredients?[index].name ??
                                            'No ingredients found'),
                                        Text(recipe.ingredients?[index].quantity
                                                .toString() ??
                                            'No quantity found'),
                                        IconButton(
                                          onPressed: () async => _addIngredient(
                                            ref,
                                            recipe.ingredients?[index],
                                          ),
                                          icon: const Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleLikeButton(
    WidgetRef ref,
    String recipeId,
  ) async {
    final isFavorite =
        await ref.read(favoritesListController).isFavorite(recipeId);
    (isFavorite)
        ? await ref.read(favoritesListController).delete(recipe)
        : await ref.read(favoritesListController).insert(recipe);
  }
}

Future<void> _addIngredient(WidgetRef ref, Ingredient? ingredient) async {
  if (ingredient != null) {
    ref.read(shoppingListController).addOrUpdate(ingredient);
  }
}

Future<void> _addAllIngredients(
    WidgetRef ref, List<Ingredient>? ingredients) async {
  if (ingredients != null) {
    for (var ingredient in ingredients) {
      ref.read(shoppingListController).addOrUpdate(ingredient);
    }
  }
}
