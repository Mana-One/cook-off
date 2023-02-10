class Recipe {
  final String id;
  final String name;
  final String imageUrl;
  final bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isFavorite = false,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    final String uri = json['_links']?['self']?['href'] as String? ?? '';
    final id = Uri.tryParse(uri)?.pathSegments.last ?? '';

    final String name = json['recipe']?['label'] as String? ?? '';
    final String imageUrl = json['recipe']?['image'] as String? ?? '';

    return Recipe(
      id: id,
      name: name,
      imageUrl: imageUrl,
    );
  }
}
