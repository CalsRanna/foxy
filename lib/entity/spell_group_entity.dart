/// 法术技能组
class SpellGroupEntity {
  final int id;
  final int spellId;

  const SpellGroupEntity({this.id = 0, this.spellId = 0});

  factory SpellGroupEntity.fromJson(Map<String, dynamic> json) {
    return SpellGroupEntity(
      id: json['id'] ?? 0,
      spellId: json['spell_id'] ?? 0,
    );
  }

  SpellGroupEntity copyWith({int? id, int? spellId}) {
    return SpellGroupEntity(
      id: id ?? this.id,
      spellId: spellId ?? this.spellId,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'spell_id': spellId};
  }
}
