class FrequentModule {
  String name = '';
  String description = '';
  DateTime updatedAt = DateTime.now();

  FrequentModule();

  factory FrequentModule.fromJson(Map<String, dynamic> json) {
    return FrequentModule()
      ..name = json['name']
      ..description = json['description']
      ..updatedAt = DateTime.parse(json['updated_at']);
  }
}
