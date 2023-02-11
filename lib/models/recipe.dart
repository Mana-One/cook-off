class Recipe {
  final String id;
  final String name;
  final String imageUrl;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
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

    return Recipe(
      id: id,
      name: name,
      imageUrl: imageUrl,
    );
  }
}
