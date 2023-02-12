import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/shopping_list_controller.dart';
import '../models/ingredient.dart';

class IngredientList extends ConsumerWidget {
  final List<Ingredient> ingredients;

  const IngredientList({
    super.key,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ingredients: '),
              IconButton(
                onPressed: () => _addAllIngredients(ref, ingredients),
                icon: const Icon(Icons.add_shopping_cart),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) =>
                _buildIngredientTile(ref, ingredients[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            itemCount: ingredients.length,
          ),
        ),
      ],
    );
  }

  Widget _buildIngredientTile(WidgetRef ref, Ingredient ingredient) {
    final title = ingredient.name;
    String subtitle = '';
    if (ingredient.quantity > 0 && ingredient.measure != null) {
      subtitle = '${ingredient.quantity} ${ingredient.measure}';
    }
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: IconButton(
        onPressed: () => _addIngredient(ref, ingredient),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addIngredient(
    WidgetRef ref,
    Ingredient ingredient,
  ) async {
    ref.read(shoppingListController).addOrUpdate(ingredient);
  }

  Future<void> _addAllIngredients(
    WidgetRef ref,
    List<Ingredient> ingredients,
  ) async {
    for (var ingredient in ingredients) {
      ref.read(shoppingListController).addOrUpdate(ingredient);
    }
  }
}
