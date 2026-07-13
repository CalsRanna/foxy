class CreatureMovementInfoFilterEntity {
  final String id;

  const CreatureMovementInfoFilterEntity({this.id = ''});

  factory CreatureMovementInfoFilterEntity.fromJson(Map<String, dynamic> json) {
    return CreatureMovementInfoFilterEntity(id: json['id'] ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  CreatureMovementInfoFilterEntity copyWith({String? id}) {
    return CreatureMovementInfoFilterEntity(id: id ?? this.id);
  }
}
