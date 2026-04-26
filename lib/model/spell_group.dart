/// 法术技能组
class SpellGroup {
  int id = 0;
  int spellId = 0;
  int specialFlag = 0;

  // 关联字段
  int stackRule = 0;
  String description = '';

  SpellGroup();

  SpellGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    spellId = json['spell_id'] ?? 0;
    specialFlag = json['special_flag'] ?? 0;
    stackRule = json['stack_rule'] ?? 0;
    description = json['description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'spell_id': spellId};
  }
}
