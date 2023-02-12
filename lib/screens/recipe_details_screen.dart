import 'package:cached_network_image/cached_network_image.dart';
import 'package:cook_off/widgets/ingredient_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/recipe.dart';
import '../widgets/favorite_button.dart';

class RecipeDetailsScreen extends ConsumerWidget {
  static const String routeName = '/details';
  static void navigateTo(BuildContext context, {required Recipe recipe}) {
    Navigator.of(context).pushNamed(routeName, arguments: recipe);
  }

  final Recipe recipe;

  const RecipeDetailsScreen({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe.name,
          style:
              Theme.of(context).textTheme.headline6?.apply(color: Colors.white),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
      body: Padding(
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
                    imageUrl: recipe.imageUrl,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: const [

            //   ],
            // ),
            Expanded(
              child: IngredientList(ingredients: recipe.ingredients),
            )
          ],
        ),
      ),
    );
  }
}
