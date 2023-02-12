import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/detailed_recipe.dart';
import 'favorite_button.dart';
import 'ingredient_list.dart';

class RecipeDetails extends ConsumerWidget {
  final DetailedRecipe detailedRecipe;

  const RecipeDetails({
    super.key,
    required this.detailedRecipe,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: detailedRecipe.imageUrl,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  height: 300,
                ),
                const Positioned(
                  bottom: 5,
                  right: 5,
                  child: FavoriteButton(),
                ),
              ],
            ),
          ),
          const Expanded(child: IngredientList()),
        ],
      ),
    );
  }
}
