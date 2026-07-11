class SpellDurationFilterEntity {
  final String id;

  const SpellDurationFilterEntity({this.id = ''});

  factory SpellDurationFilterEntity.fromJson(Map<String, dynamic> json) {
    return SpellDurationFilterEntity(id: json['id'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }

  SpellDurationFilterEntity copyWith({String? id}) {
    return SpellDurationFilterEntity(id: id ?? this.id);
  }
}
