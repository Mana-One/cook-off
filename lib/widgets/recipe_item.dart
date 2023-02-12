import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/current_recipe_details.dart';
import '../providers/current_recipe.dart';
import '../models/recipe.dart';
import '../screens/recipe_details_screen.dart';

class RecipeItem extends ConsumerWidget {
  final Recipe recipe;
  const RecipeItem({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _goToDetails(context, ref, recipe),
      child: Card(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Text(
                        recipe.name,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToDetails(
    BuildContext context,
    WidgetRef ref,
    Recipe recipe,
  ) {
    ref.read(currentRecipeProvider.notifier).replaceCurrentRecipe(recipe);
    ref.invalidate(currentRecipeDetailsProvider);
    Navigator.of(context).pushNamed(RecipeDetailsScreen.routeName);
  }
}
