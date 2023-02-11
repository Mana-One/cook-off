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

  static Ingredient fromMap(Map<dynamic, dynamic> map) {
    return Ingredient(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      imageUrl: map['image_url'],
      measure: map['measure'],
      weight: map['weight'],
    );
  }

  @override
  String toString() {
    return 'Ingredient{id: $id, name: $name, quantity: $quantity, imageUrl: $imageUrl, measure: $measure,weight: $weight}';
  }
}
