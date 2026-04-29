class GemPropertyFilterEntity {
  final String id;

  const GemPropertyFilterEntity({this.id = ''});

  factory GemPropertyFilterEntity.fromJson(Map<String, dynamic> json) {
    return GemPropertyFilterEntity(
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
