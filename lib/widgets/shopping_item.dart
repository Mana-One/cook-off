import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ingredient.dart';

class ShoppingItem extends ConsumerWidget {
  final Ingredient ingredient;

  const ShoppingItem({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: ingredient.imageUrl,
              placeholder: (context, url) {
                return const Center(child: CircularProgressIndicator());
              },
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: 100,
              height: 100,
            ),
            const SizedBox(width: 20),
            Text(ingredient.name),
            const SizedBox(width: 10),
            _showQuantity(context, ingredient),
          ],
        )
      ],
    );
  }

  Widget _showQuantity(BuildContext context, Ingredient ingredient) {
    if (ingredient.quantity == 0.0) {
      return const Text('');
    }
    return Text('${ingredient.quantity} ${ingredient.measure ?? ''}');
  }
}
