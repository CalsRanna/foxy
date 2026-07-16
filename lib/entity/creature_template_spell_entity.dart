/// 生物模板技能
class CreatureTemplateSpellEntity {
  final int creatureID;
  final int index;
  final int spell;
  final int verifiedBuild;

  // 关联字段（技能信息）
  final String spellName;
  final String spellSubtext;

  const CreatureTemplateSpellEntity({
    this.creatureID = 0,
    this.index = 0,
    this.spell = 0,
    this.verifiedBuild = 0,
    this.spellName = '',
    this.spellSubtext = '',
  });

  factory CreatureTemplateSpellEntity.fromJson(Map<String, dynamic> json) {
    return CreatureTemplateSpellEntity(
      creatureID: json['CreatureID'] ?? json['creatureID'] ?? 0,
      index: json['Index'] ?? json['index'] ?? 0,
      spell: json['Spell'] ?? json['spell'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0,
      spellName: json['spellName'] ?? '',
      spellSubtext: json['spellSubtext'] ?? '',
    );
  }

  CreatureTemplateSpellEntity copyWith({
    int? creatureID,
    int? index,
    int? spell,
    int? verifiedBuild,
    String? spellName,
    String? spellSubtext,
  }) {
    return CreatureTemplateSpellEntity(
      creatureID: creatureID ?? this.creatureID,
      index: index ?? this.index,
      spell: spell ?? this.spell,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
      spellName: spellName ?? this.spellName,
      spellSubtext: spellSubtext ?? this.spellSubtext,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CreatureID': creatureID,
      'Index': index,
      'Spell': spell,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
