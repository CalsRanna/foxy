import 'package:foxy/entity/spell_rank_entity.dart';

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

  SpellRankKey get key => SpellRankKey(firstSpellId: firstSpellId, rank: rank);
}
