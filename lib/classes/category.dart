class CupcakeCategory {
  final String id;
  final String title;
  final String subtitle;
  final String description;

  CupcakeCategory({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  factory CupcakeCategory.fromJson(Map<String, dynamic> json, String id) {
    return CupcakeCategory(
      id: id,
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
    );
  }
}
