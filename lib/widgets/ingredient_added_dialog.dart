import 'package:cook_off/screens/home.dart';
import 'package:flutter/material.dart';

class IngredientAddedDialog extends StatelessWidget {
  const IngredientAddedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ingredient(s) added'),
      content: const Text(
        '''You have successfully added one or more ingredients to your shopping list !''',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () => _gotToShoppingList(context),
          child: const Text('Check Shopping List'),
        )
      ],
    );
  }

  void _gotToShoppingList(BuildContext context) {
    HomeScreen.navigateTo(context, 1);
  }
}
