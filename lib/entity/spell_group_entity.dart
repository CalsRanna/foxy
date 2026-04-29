/// 法术技能组
class SpellGroupEntity {
  final int id;
  final int spellId;
  final int specialFlag;

  // 关联字段
  final int stackRule;
  final String description;

  const SpellGroupEntity({
    this.id = 0,
    this.spellId = 0,
    this.specialFlag = 0,
    this.stackRule = 0,
    this.description = '',
  });

  factory SpellGroupEntity.fromJson(Map<String, dynamic> json) {
    return SpellGroupEntity(
      id: json['id'] ?? 0,
      spellId: json['spell_id'] ?? 0,
      specialFlag: json['special_flag'] ?? 0,
      stackRule: json['stack_rule'] ?? 0,
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'spell_id': spellId};
  }
}
