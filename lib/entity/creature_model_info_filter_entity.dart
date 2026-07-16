class CreatureModelInfoFilterEntity {
  final String id;

  const CreatureModelInfoFilterEntity({this.id = ''});

  factory CreatureModelInfoFilterEntity.fromJson(Map<String, dynamic> json) {
    return CreatureModelInfoFilterEntity(id: json['id'] ?? '');
  }

  CreatureModelInfoFilterEntity copyWith({String? id}) {
    return CreatureModelInfoFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
