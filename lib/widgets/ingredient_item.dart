import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/ingredient_added_dialog.dart';
import '../controllers/shopping_list_controller.dart';
import '../models/ingredient.dart';

class IngredientItem extends ConsumerWidget {
  final Ingredient ingredient;

  const IngredientItem({
    super.key,
    required this.ingredient,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ingredient.name;
    String subtitle = '';
    if (ingredient.quantity > 0 && ingredient.measure != null) {
      subtitle = '${ingredient.quantity} ${ingredient.measure}';
    }

    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: IconButton(
        onPressed: () => _addIngredient(context, ref, ingredient),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addIngredient(
    BuildContext context,
    WidgetRef ref,
    Ingredient ingredient,
  ) async {
    ref.read(shoppingListController).addOrUpdate(ingredient);
    showDialog(
      context: context,
      builder: (ctx) => const IngredientAddedDialog(),
    );
  }
}
