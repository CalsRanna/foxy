class GlyphPropertyFilterEntity {
  String id = '';

  GlyphPropertyFilterEntity();

  factory GlyphPropertyFilterEntity.fromJson(Map<String, dynamic> json) {
    return GlyphPropertyFilterEntity()
      ..id = json['id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
