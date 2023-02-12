import '../models/ingredient.dart';

class Recipe {
  final String id;
  final String name;
  final String imageUrl;
  final List<Ingredient>? ingredients;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.ingredients,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Recipe.fromMap(Map<dynamic, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      imageUrl: map['image_url'],
      isFavorite: (map['isFavorite'] == 1) ? true : false,
    );
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    final String uri = json['_links']?['self']?['href'] as String? ?? '';
    final id = Uri.tryParse(uri)?.pathSegments.last ?? '';

    final String name = json['recipe']?['label'] as String? ?? '';
    final String imageUrl = json['recipe']?['image'] as String? ?? '';

    final List<dynamic> ingredientsJson =
        json['recipe']?['ingredients'] as List<dynamic>? ?? [];
    final List<Ingredient> ingredients = ingredientsJson
        .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
        .toList();

    return Recipe(
      id: id,
      name: name,
      imageUrl: imageUrl,
      ingredients: ingredients,
    );
  }
}
