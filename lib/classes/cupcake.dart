// class Cupcake {
//   final String id;
//   final String name;
//   final String description;
//   final double price; // Example additional field for cupcakes
//   final String categoryId; // Example additional field for cupcakes

//   Cupcake({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.categoryId,
//   });

//   factory Cupcake.fromJson(Map<String, dynamic> json, String id) {
//     return Cupcake(
//       id: id,
//       name: json['name'],
//       description: json['description'],
//       price: json['price'] as double, // Example price field
//       categoryId: json['categoryId'], // Example price field
//     );
//   }
// }

class Cupcake {
  final String id;
  final String name;
  final String description;
  final double price; // Example additional field for cupcakes
  final String categoryId;

  Cupcake({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
  });

  // Converts a Cupcake instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'categoryId': categoryId,
    };
  }

  // Creates a Cupcake instance from a map
  factory Cupcake.fromJson(Map<String, dynamic> json, String id) {
    return Cupcake(
      id: id,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as double,
      categoryId: json['categoryId'] as String,
    );
  }
}
