import 'package:cook_off/database/shopping_list_database.dart';
import 'package:cook_off/models/ingredient.dart';
import 'package:cook_off/widgets/shopping_item.dart';
import 'package:flutter/material.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final dbHelper = ShoppingListDB();
  List<Ingredient> ingredients = [];

  @override
  void initState() {
    super.initState();

    _retrieveIngredients();
  }

  @override
  Widget build(BuildContext context) {
    if (ingredients.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) => Dismissible(
          key: UniqueKey(),
          onDismissed: (DismissDirection direction) {
            setState(() {
              _removeIngredient(ingredients[index]);
              ingredients.removeAt(index);
            });
          },
          child: ShoppingItem(ingredient: ingredients[index]),
        ),
        itemCount: ingredients.length,
      );
    }
    if (ingredients.isEmpty) {
      return const Center(child: Text('Your shopping list is empty.'));
    }

    return const Center(child: CircularProgressIndicator());
  }

  void _retrieveIngredients() async {
    List<Ingredient> ingredientsFromDb = await dbHelper.getAll();
    setState(() {
      ingredients = ingredientsFromDb;
    });
  }

  void addIngredient(Ingredient ingredient) async {
    await dbHelper.insert(ingredient);
  }

  Future<void> _removeIngredient(Ingredient ingredient) async {
    int res = await dbHelper.delete(ingredient.id);
    print(res);
  }
}
