import 'package:cook_off/screens/recipe_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/recipes.dart';
import '../widgets/recipe_item.dart';

class RecipeList extends ConsumerWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipesProvider);

    return recipes.when(
      data: (data) {
        if (data.isEmpty) {
          return const Center(child: Text('No match!'));
        }
        return Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailsScreen(
                        recipe: data[index],
                      ),
                    ))
              },
              child: RecipeItem(recipe: data[index]),
            ),
            itemCount: data.length,
          ),
        );
      },
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
