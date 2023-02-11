import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/shopping_list_controller.dart';
import '../models/ingredient.dart';
import '../providers/shopping_list.dart';
import '../widgets/shopping_item.dart';

class ShoppingListScreen extends ConsumerWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingredients = ref.watch(shoppingListProvider);

    return ingredients.when(
      data: (data) {
        if (data.isEmpty) {
          return const Center(child: Text('Your shopping list is empty..'));
        }
        return ListView.builder(
          itemBuilder: (context, index) => Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            onDismissed: (direction) => _onDismissed(
              direction,
              ref,
              data[index],
            ),
            child: ShoppingItem(ingredient: data[index]),
          ),
          itemCount: data.length,
        );
      },
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
      skipLoadingOnRefresh: false,
    );
  }
  //   return FutureBuilder(
  //     future: ingredients.when(data: data, error: error, loading: loading),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         final ingredientList = snapshot.data;
  //         if (ingredientList == null || ingredientList.isEmpty) {
  //           return const Center(child: Text('Your shopping list is empty..'));
  //         }

  //         return ListView.builder(
  //           itemBuilder: (context, index) => Dismissible(
  //             key: UniqueKey(),
  //             onDismissed: (direction) => _onDismissed(
  //               direction,
  //               ref,
  //               ingredientList[index],
  //             ),
  //             child: ShoppingItem(ingredient: ingredientList[index]),
  //           ),
  //           itemCount: ingredientList.length,
  //         );
  //       }
  //       if (snapshot.hasError) {
  //         return Center(
  //           child: Text(snapshot.error.toString()),
  //         );
  //       }

  //       return const Center(child: CircularProgressIndicator());
  //     },
  //   );
  // }

  void _onDismissed(
    DismissDirection dismissDirection,
    WidgetRef ref,
    Ingredient ingredient,
  ) {
    ref.read(shoppingListController).delete(ingredient);
  }
}
