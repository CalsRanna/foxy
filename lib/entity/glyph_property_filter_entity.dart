class GlyphPropertyFilterEntity {
  final String id;

  const GlyphPropertyFilterEntity({this.id = ''});

  factory GlyphPropertyFilterEntity.fromJson(Map<String, dynamic> json) {
    return GlyphPropertyFilterEntity(id: json['id'] ?? '');
  }

  GlyphPropertyFilterEntity copyWith({String? id}) {
    return GlyphPropertyFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
