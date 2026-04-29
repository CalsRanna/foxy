class GemPropertyFilterEntity {
  String id = '';
  GemPropertyFilterEntity();

  factory GemPropertyFilterEntity.fromJson(Map<String, dynamic> json) {
    return GemPropertyFilterEntity()
      ..id = json['id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
