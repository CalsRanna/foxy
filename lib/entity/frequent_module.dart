class FrequentModule {
  final String name;
  final String description;
  final DateTime updatedAt;

  const FrequentModule({
    this.name = '',
    this.description = '',
    required this.updatedAt,
  });

  factory FrequentModule.fromJson(Map<String, dynamic> json) {
    return FrequentModule(
      name: json['name'],
      description: json['description'],
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
