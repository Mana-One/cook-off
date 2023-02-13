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
          return const Expanded(
            child: Center(child: Text('No match!')),
          );
        }

        return Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            itemBuilder: (context, index) => RecipeItem(recipe: data[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: data.length,
          ),
        );
      },
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
