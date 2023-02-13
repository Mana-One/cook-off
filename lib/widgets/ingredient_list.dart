import 'package:cook_off/widgets/ingredient_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/current_recipe_details.dart';
import '../controllers/shopping_list_controller.dart';
import '../models/ingredient.dart';
import 'ingredient_added_dialog.dart';

class IngredientList extends ConsumerWidget {
  const IngredientList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailedRecipe = ref.watch(currentRecipeDetailsProvider);

    return detailedRecipe.when(
      data: (data) {
        final ingredients = data.ingredients;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ingredients: ',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    IconButton(
                      onPressed: () =>
                          _addAllIngredients(context, ref, ingredients),
                      icon: const Icon(Icons.add_shopping_cart),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => IngredientItem(
                  ingredient: ingredients[index],
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                itemCount: ingredients.length,
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _addAllIngredients(
    BuildContext context,
    WidgetRef ref,
    List<Ingredient> ingredients,
  ) async {
    for (var ingredient in ingredients) {
      await ref.read(shoppingListController).addOrUpdate(ingredient);
    }
    showDialog(
      context: context,
      builder: (context) => const IngredientAddedDialog(),
    );
  }
}
