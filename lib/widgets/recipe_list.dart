import 'package:cook_off/providers/recipes.dart';
import 'package:cook_off/widgets/recipe_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeList extends ConsumerWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipesProvider.future);

    return FutureBuilder(
      future: recipes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final recipeList = snapshot.data;
          if (recipeList == null || recipeList.isEmpty) {
            return const Center(child: Text('No match!'));
          }
          return Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) =>
                  RecipeItem(recipe: recipeList[index]),
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              itemCount: recipeList.length,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        return const Center(child: Text('Loading'));
      },
    );
  }
}
