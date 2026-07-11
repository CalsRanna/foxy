class CreatureSpellDataFilterEntity {
  final String id;
  final String spell;

  const CreatureSpellDataFilterEntity({this.id = '', this.spell = ''});

  factory CreatureSpellDataFilterEntity.fromJson(Map<String, dynamic> json) {
    return CreatureSpellDataFilterEntity(
      id: json['id'] ?? '',
      spell: json['spell'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'spell': spell};
  }

  CreatureSpellDataFilterEntity copyWith({String? id, String? spell}) {
    return CreatureSpellDataFilterEntity(
      id: id ?? this.id,
      spell: spell ?? this.spell,
    );
  }
}
