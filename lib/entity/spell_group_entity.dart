/// 法术技能组
class SpellGroupEntity {
  final int id;
  final int spellId;

  // 关联字段
  final int stackRule;
  final String description;

  const SpellGroupEntity({
    this.id = 0,
    this.spellId = 0,
    this.stackRule = 0,
    this.description = '',
  });

  factory SpellGroupEntity.fromJson(Map<String, dynamic> json) {
    return SpellGroupEntity(
      id: json['id'] ?? 0,
      spellId: json['spell_id'] ?? 0,
      stackRule: json['stack_rule'] ?? 0,
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'spell_id': spellId};
  }

  SpellGroupEntity copyWith({
    int? id,
    int? spellId,
    int? stackRule,
    String? description,
  }) {
    return SpellGroupEntity(
      id: id ?? this.id,
      spellId: spellId ?? this.spellId,
      stackRule: stackRule ?? this.stackRule,
      description: description ?? this.description,
    );
  }
}
