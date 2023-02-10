import 'package:cook_off/providers/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeList extends ConsumerWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputFuture = ref.watch(searchInputProvider.future);

    return FutureBuilder(
      future: inputFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final currentInput = snapshot.data;
          if (currentInput == null || currentInput.isEmpty()) {
            return const Center(child: Text('Empty input !'));
          }
          return Center(
            child: Text(
              '${currentInput.query} | filters: ${currentInput.filters.length}',
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
