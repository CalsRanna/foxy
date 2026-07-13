/// 法术技能组
class SpellGroupEntity {
  final int id;
  final int spellId;

  const SpellGroupEntity({this.id = 0, this.spellId = 0});

  void validate() {
    if (id <= 0 || (id >= 3 && id <= 1000)) {
      throw ArgumentError.value(id, 'id', '只能使用核心组 1/2 或数据库组 > 1000');
    }
    if (spellId == 0) {
      throw ArgumentError.value(spellId, 'spellId', '不能为 0');
    }
  }

  factory SpellGroupEntity.fromJson(Map<String, dynamic> json) {
    return SpellGroupEntity(
      id: json['id'] ?? 0,
      spellId: json['spell_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'spell_id': spellId};
  }

  SpellGroupEntity copyWith({int? id, int? spellId}) {
    return SpellGroupEntity(
      id: id ?? this.id,
      spellId: spellId ?? this.spellId,
    );
  }
}
