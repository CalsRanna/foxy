class GemPropertyFilterEntity {
  String id = '';
  GemPropertyFilterEntity();

  GemPropertyFilterEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
