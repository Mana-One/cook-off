import 'package:cook_off/models/ingredient.dart';
import 'package:cook_off/repository/shopping_list_repository.dart';
import 'package:cook_off/widgets/shopping_item.dart';
import 'package:flutter/material.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final shoppingListRepository = ShoppingListRepository();
  List<Ingredient> ingredients = [];

  @override
  void initState() {
    super.initState();
    shoppingListRepository.upsert(Ingredient(
        id: "food_a1vgrj1bs8rd1majvmd9ubz8ttkg",
        name: "chicken",
        quantity: 1.0,
        imageUrl:
            "https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg",
        measure: "tablespoon",
        weight: 14.562499999753793));

    shoppingListRepository.upsert(Ingredient(
        id: "food_bmyxrshbfao9s1amjrvhoauob6mo",
        name: "chicken",
        quantity: 1.0,
        imageUrl:
            "https://www.edamam.com/food-img/d33/d338229d774a743f7858f6764e095878.jpg",
        measure: "",
        weight: 1200.0));

    shoppingListRepository.upsert(Ingredient(
        id: "food_bmyxrshbfao9s1amjrvhoauob6mo",
        name: "chicken",
        quantity: 1.0,
        imageUrl:
            "https://www.edamam.com/food-img/d33/d338229d774a743f7858f6764e095878.jpg",
        measure: "",
        weight: 800.0));

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
    List<Ingredient> ingredientsFromDb = await shoppingListRepository.getAll();
    setState(() {
      ingredients = ingredientsFromDb;
    });
  }

  void addIngredient(Ingredient ingredient) async {
    await shoppingListRepository.upsert(ingredient);
  }

  Future<void> _removeIngredient(Ingredient ingredient) async {
    await shoppingListRepository.delete(ingredient.id);
  }
}
