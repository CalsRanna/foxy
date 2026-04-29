/// 法术技能排行
class SpellRankEntity {
  final int firstSpellId;
  final int spellId;
  final int rank;

  // 关联字段
  final String firstSpellName;
  final String firstSpellSubtext;
  final String spellName;
  final String spellSubtext;

  const SpellRankEntity({
    this.firstSpellId = 0,
    this.spellId = 0,
    this.rank = 0,
    this.firstSpellName = '',
    this.firstSpellSubtext = '',
    this.spellName = '',
    this.spellSubtext = '',
  });

  factory SpellRankEntity.fromJson(Map<String, dynamic> json) {
    return SpellRankEntity(
      firstSpellId: json['first_spell_id'] ?? 0,
      spellId: json['spell_id'] ?? 0,
      rank: json['rank'] ?? 0,
      firstSpellName: json['First_Spell_Name_Lang_zhCN'] ?? '',
      firstSpellSubtext: json['First_Spell_NameSubtext_Lang_zhCN'] ?? '',
      spellName: json['Spell_Name_Lang_zhCN'] ?? '',
      spellSubtext: json['Spell_NameSubtext_Lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'first_spell_id': firstSpellId, 'spell_id': spellId, 'rank': rank};
  }
}
