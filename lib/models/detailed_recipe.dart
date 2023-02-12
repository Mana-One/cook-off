import 'ingredient.dart';

class DetailedRecipe {
  final String id;
  final String name;
  final String imageUrl;
  final List<Ingredient> ingredients;

  const DetailedRecipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.ingredients,
  });

  factory DetailedRecipe.fromJson(Map<String, dynamic> json) {
    final String uri = json['_links']?['self']?['href'] as String? ?? '';
    final id = Uri.tryParse(uri)?.pathSegments.last ?? '';

    final String name = json['recipe']?['label'] as String? ?? '';
    final String imageUrl = json['recipe']?['image'] as String? ?? '';

    final List<dynamic> ingredientsJson =
        json['recipe']?['ingredients'] as List<dynamic>? ?? [];

    final List<Ingredient> ingredients = ingredientsJson
        .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
        .toList();

    return DetailedRecipe(
      id: id,
      name: name,
      imageUrl: imageUrl,
      ingredients: ingredients,
    );
  }
}
