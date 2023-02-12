class Ingredient {
  final String id;
  final String name;
  final double quantity;
  final String? measure;
  final String imageUrl;
  final double? weight;

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    this.measure,
    required this.imageUrl,
    this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'image_url': imageUrl,
      'measure': measure,
      'weight': weight
    };
  }

  factory Ingredient.fromMap(Map<dynamic, dynamic> map) {
    return Ingredient(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      imageUrl: map['image_url'],
      measure: map['measure'],
      weight: map['weight'],
    );
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    final String id = json['foodId'] as String? ?? '';
    final String name = json['food'] as String? ?? '';
    final double quantity = json['quantity'] as double? ?? 0.0;
    final String? measure = json['measure'] as String?;
    final String imageUrl = json['image'] as String? ?? '';
    final double? weight = json['weight'] as double?;

    return Ingredient(
      id: id,
      name: name,
      quantity: quantity,
      measure: measure,
      imageUrl: imageUrl,
      weight: weight,
    );
  }

  @override
  String toString() {
    return 'Ingredient{id: $id, name: $name, quantity: $quantity, imageUrl: $imageUrl, measure: $measure,weight: $weight}';
  }
}
