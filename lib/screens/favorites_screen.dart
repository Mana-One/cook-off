import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/favorites_list_controller.dart';
import '../models/recipe.dart';
import '../providers/favorites.dart';
import '../widgets/recipe_item.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return favorites.when(
      data: (data) {
        if (data.isEmpty) {
          return const Center(
            child: Text('You have no favorite recipes.'),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          itemBuilder: (context, index) => Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            onDismissed: (direction) => _onDismissed(
              direction,
              ref,
              data[index],
            ),
            child: RecipeItem(recipe: data[index]),
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemCount: data.length,
        );
      },
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
      skipLoadingOnRefresh: false,
    );
  }

  void _onDismissed(
    DismissDirection dismissDirection,
    WidgetRef ref,
    Recipe recipe,
  ) {
    ref.read(favoritesListController).delete(recipe);
  }
}
