class TalentEntity {
  final int id;
  final int tabId;
  final int tierId;
  final int columnIndex;
  final int spellRank0;
  final int spellRank1;
  final int spellRank2;
  final int spellRank3;
  final int spellRank4;
  final int spellRank5;
  final int spellRank6;
  final int spellRank7;
  final int spellRank8;
  final int prereqTalent0;
  final int prereqTalent1;
  final int prereqTalent2;
  final int prereqRank0;
  final int prereqRank1;
  final int prereqRank2;
  final int flags;
  final int requiredSpellId;
  final int categoryMask0;
  final int categoryMask1;

  const TalentEntity({
    this.id = 0,
    this.tabId = 0,
    this.tierId = 0,
    this.columnIndex = 0,
    this.spellRank0 = 0,
    this.spellRank1 = 0,
    this.spellRank2 = 0,
    this.spellRank3 = 0,
    this.spellRank4 = 0,
    this.spellRank5 = 0,
    this.spellRank6 = 0,
    this.spellRank7 = 0,
    this.spellRank8 = 0,
    this.prereqTalent0 = 0,
    this.prereqTalent1 = 0,
    this.prereqTalent2 = 0,
    this.prereqRank0 = 0,
    this.prereqRank1 = 0,
    this.prereqRank2 = 0,
    this.flags = 0,
    this.requiredSpellId = 0,
    this.categoryMask0 = 0,
    this.categoryMask1 = 0,
  });

  factory TalentEntity.fromJson(Map<String, dynamic> json) {
    return TalentEntity(
      id: json['ID'] ?? 0,
      tabId: json['TabID'] ?? 0,
      tierId: json['TierID'] ?? 0,
      columnIndex: json['ColumnIndex'] ?? 0,
      spellRank0: json['SpellRank0'] ?? 0,
      spellRank1: json['SpellRank1'] ?? 0,
      spellRank2: json['SpellRank2'] ?? 0,
      spellRank3: json['SpellRank3'] ?? 0,
      spellRank4: json['SpellRank4'] ?? 0,
      spellRank5: json['SpellRank5'] ?? 0,
      spellRank6: json['SpellRank6'] ?? 0,
      spellRank7: json['SpellRank7'] ?? 0,
      spellRank8: json['SpellRank8'] ?? 0,
      prereqTalent0: json['PrereqTalent0'] ?? 0,
      prereqTalent1: json['PrereqTalent1'] ?? 0,
      prereqTalent2: json['PrereqTalent2'] ?? 0,
      prereqRank0: json['PrereqRank0'] ?? 0,
      prereqRank1: json['PrereqRank1'] ?? 0,
      prereqRank2: json['PrereqRank2'] ?? 0,
      flags: json['Flags'] ?? 0,
      requiredSpellId: json['RequiredSpellID'] ?? 0,
      categoryMask0: json['CategoryMask0'] ?? 0,
      categoryMask1: json['CategoryMask1'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'TabID': tabId,
      'TierID': tierId,
      'ColumnIndex': columnIndex,
      'SpellRank0': spellRank0,
      'SpellRank1': spellRank1,
      'SpellRank2': spellRank2,
      'SpellRank3': spellRank3,
      'SpellRank4': spellRank4,
      'SpellRank5': spellRank5,
      'SpellRank6': spellRank6,
      'SpellRank7': spellRank7,
      'SpellRank8': spellRank8,
      'PrereqTalent0': prereqTalent0,
      'PrereqTalent1': prereqTalent1,
      'PrereqTalent2': prereqTalent2,
      'PrereqRank0': prereqRank0,
      'PrereqRank1': prereqRank1,
      'PrereqRank2': prereqRank2,
      'Flags': flags,
      'RequiredSpellID': requiredSpellId,
      'CategoryMask0': categoryMask0,
      'CategoryMask1': categoryMask1,
    };
  }
}

class BriefTalentEntity {
  final int id;
  final int tabId;
  final int tierId;
  final int columnIndex;
  final int spellRank0;

  const BriefTalentEntity({
    this.id = 0,
    this.tabId = 0,
    this.tierId = 0,
    this.columnIndex = 0,
    this.spellRank0 = 0,
  });

  factory BriefTalentEntity.fromJson(Map<String, dynamic> json) {
    return BriefTalentEntity(
      id: json['ID'] ?? 0,
      tabId: json['TabID'] ?? 0,
      tierId: json['TierID'] ?? 0,
      columnIndex: json['ColumnIndex'] ?? 0,
      spellRank0: json['SpellRank0'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'TabID': tabId,
      'TierID': tierId,
      'ColumnIndex': columnIndex,
      'SpellRank0': spellRank0,
    };
  }
}
