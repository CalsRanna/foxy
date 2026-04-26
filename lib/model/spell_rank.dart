/// 法术技能排行
class SpellRank {
  int firstSpellId = 0;
  int spellId = 0;
  int rank = 0;

  // 关联字段
  String firstSpellName = '';
  String firstSpellSubtext = '';
  String spellName = '';
  String spellSubtext = '';

  SpellRank();

  SpellRank.fromJson(Map<String, dynamic> json) {
    firstSpellId = json['first_spell_id'] ?? 0;
    spellId = json['spell_id'] ?? 0;
    rank = json['rank'] ?? 0;
    firstSpellName = json['First_Spell_Name_Lang_zhCN'] ?? '';
    firstSpellSubtext = json['First_Spell_NameSubtext_Lang_zhCN'] ?? '';
    spellName = json['Spell_Name_Lang_zhCN'] ?? '';
    spellSubtext = json['Spell_NameSubtext_Lang_zhCN'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'first_spell_id': firstSpellId,
      'spell_id': spellId,
      'rank': rank,
    };
  }
}
