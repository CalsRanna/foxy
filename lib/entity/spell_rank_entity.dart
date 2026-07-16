class BriefSpellRankEntity {
  final int firstSpellId;
  final int spellId;
  final int rank;
  final String firstSpellName;
  final String firstSpellSubtext;
  final String spellName;
  final String spellSubtext;

  const BriefSpellRankEntity({
    this.firstSpellId = 0,
    this.spellId = 0,
    this.rank = 0,
    this.firstSpellName = '',
    this.firstSpellSubtext = '',
    this.spellName = '',
    this.spellSubtext = '',
  });

  factory BriefSpellRankEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellRankEntity(
      firstSpellId: json['first_spell_id'] ?? 0,
      spellId: json['spell_id'] ?? 0,
      rank: json['rank'] ?? 0,
      firstSpellName: json['First_Spell_Name_Lang_zhCN'] ?? '',
      firstSpellSubtext: json['First_Spell_NameSubtext_Lang_zhCN'] ?? '',
      spellName: json['Spell_Name_Lang_zhCN'] ?? '',
      spellSubtext: json['Spell_NameSubtext_Lang_zhCN'] ?? '',
    );
  }
}

/// 法术技能排行
class SpellRankEntity {
  final int firstSpellId;
  final int spellId;
  final int rank;

  const SpellRankEntity({
    this.firstSpellId = 0,
    this.spellId = 0,
    this.rank = 0,
  });

  factory SpellRankEntity.fromJson(Map<String, dynamic> json) {
    return SpellRankEntity(
      firstSpellId: json['first_spell_id'] ?? 0,
      spellId: json['spell_id'] ?? 0,
      rank: json['rank'] ?? 0,
    );
  }

  SpellRankEntity copyWith({int? firstSpellId, int? spellId, int? rank}) {
    return SpellRankEntity(
      firstSpellId: firstSpellId ?? this.firstSpellId,
      spellId: spellId ?? this.spellId,
      rank: rank ?? this.rank,
    );
  }

  Map<String, dynamic> toJson() {
    return {'first_spell_id': firstSpellId, 'spell_id': spellId, 'rank': rank};
  }
}
