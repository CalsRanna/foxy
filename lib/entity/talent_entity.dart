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

  TalentEntity copyWith({
    int? id,
    int? tabId,
    int? tierId,
    int? columnIndex,
    int? spellRank0,
    int? spellRank1,
    int? spellRank2,
    int? spellRank3,
    int? spellRank4,
    int? spellRank5,
    int? spellRank6,
    int? spellRank7,
    int? spellRank8,
    int? prereqTalent0,
    int? prereqTalent1,
    int? prereqTalent2,
    int? prereqRank0,
    int? prereqRank1,
    int? prereqRank2,
    int? flags,
    int? requiredSpellId,
    int? categoryMask0,
    int? categoryMask1,
  }) {
    return TalentEntity(
      id: id ?? this.id,
      tabId: tabId ?? this.tabId,
      tierId: tierId ?? this.tierId,
      columnIndex: columnIndex ?? this.columnIndex,
      spellRank0: spellRank0 ?? this.spellRank0,
      spellRank1: spellRank1 ?? this.spellRank1,
      spellRank2: spellRank2 ?? this.spellRank2,
      spellRank3: spellRank3 ?? this.spellRank3,
      spellRank4: spellRank4 ?? this.spellRank4,
      spellRank5: spellRank5 ?? this.spellRank5,
      spellRank6: spellRank6 ?? this.spellRank6,
      spellRank7: spellRank7 ?? this.spellRank7,
      spellRank8: spellRank8 ?? this.spellRank8,
      prereqTalent0: prereqTalent0 ?? this.prereqTalent0,
      prereqTalent1: prereqTalent1 ?? this.prereqTalent1,
      prereqTalent2: prereqTalent2 ?? this.prereqTalent2,
      prereqRank0: prereqRank0 ?? this.prereqRank0,
      prereqRank1: prereqRank1 ?? this.prereqRank1,
      prereqRank2: prereqRank2 ?? this.prereqRank2,
      flags: flags ?? this.flags,
      requiredSpellId: requiredSpellId ?? this.requiredSpellId,
      categoryMask0: categoryMask0 ?? this.categoryMask0,
      categoryMask1: categoryMask1 ?? this.categoryMask1,
    );
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

  BriefTalentEntity copyWith({
    int? id,
    int? tabId,
    int? tierId,
    int? columnIndex,
    int? spellRank0,
  }) {
    return BriefTalentEntity(
      id: id ?? this.id,
      tabId: tabId ?? this.tabId,
      tierId: tierId ?? this.tierId,
      columnIndex: columnIndex ?? this.columnIndex,
      spellRank0: spellRank0 ?? this.spellRank0,
    );
  }
}
