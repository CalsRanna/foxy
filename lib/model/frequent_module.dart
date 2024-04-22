class FrequentModule {
  String name = '';
  String description = '';
  DateTime updatedAt = DateTime.now();

  FrequentModule();

  FrequentModule.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    updatedAt = DateTime.parse(json['updated_at']);
  }
}
