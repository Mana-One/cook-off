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
  final dbHelper = ShoppingListDB.instance;
  List<Ingredient> ingredients = [];

  @override
  void initState() {
    super.initState();
    dbHelper.upsert(Ingredient(
        id: 1,
        name: "chicken",
        quantity: 2.0,
        imageUrl:
            "https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg",
        measure: "gram",
        weight: 1000.0));

    dbHelper.upsert(Ingredient(
        id: 1,
        name: "chicken",
        quantity: 2.0,
        imageUrl:
            "https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg",
        measure: "gram",
        weight: 10.0));

    dbHelper.upsert(Ingredient(
        id: 1,
        name: "chicken",
        quantity: 3.0,
        imageUrl:
            "https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg",
        measure: "gram",
        weight: 10.0));

    _retrieveIngredients();
  }

  @override
  Widget build(BuildContext context) {
    if (ingredients.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) =>
            ShoppingItem(ingredient: ingredients[index]),
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

  void addIngredient(Ingredient ingredient) {
    dbHelper.insert(ingredient);
  }
}

/*
 floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
*/