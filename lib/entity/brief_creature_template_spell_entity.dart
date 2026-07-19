import 'package:foxy/entity/creature_template_spell_key.dart';

/// 生物模板技能列表展示模型。
class BriefCreatureTemplateSpellEntity {
  final int creatureID;
  final int index;
  final int spell;
  final int verifiedBuild;
  final String spellName;
  final String spellSubtext;

  const BriefCreatureTemplateSpellEntity({
    this.creatureID = 0,
    this.index = 0,
    this.spell = 0,
    this.verifiedBuild = 0,
    this.spellName = '',
    this.spellSubtext = '',
  });

  factory BriefCreatureTemplateSpellEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureTemplateSpellEntity(
      creatureID: json['CreatureID'] ?? json['creatureID'] ?? 0,
      index: json['Index'] ?? json['index'] ?? 0,
      spell: json['Spell'] ?? json['spell'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0,
      spellName: json['spellName'] ?? '',
      spellSubtext: json['spellSubtext'] ?? '',
    );
  }

  String get displayName =>
      spellSubtext.isNotEmpty ? '$spellName - $spellSubtext' : spellName;

  CreatureTemplateSpellKey get key =>
      CreatureTemplateSpellKey(creatureID: creatureID, index: index);
}
