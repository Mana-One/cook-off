import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/current_recipe_details.dart';
import '../widgets/recipe_details.dart';

class RecipeDetailsScreen extends ConsumerWidget {
  static const String routeName = '/details';

  const RecipeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailedRecipe = ref.watch(currentRecipeDetailsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: detailedRecipe.when(
        data: (data) => RecipeDetails(detailedRecipe: data),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
