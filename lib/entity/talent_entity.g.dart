// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_entity.dart';

mixin _TalentEntityMixin {
  int get id;
  int get tabId;
  int get tierId;
  int get columnIndex;
  int get spellRank0;
  int get spellRank1;
  int get spellRank2;
  int get spellRank3;
  int get spellRank4;
  int get spellRank5;
  int get spellRank6;
  int get spellRank7;
  int get spellRank8;
  int get prereqTalent0;
  int get prereqTalent1;
  int get prereqTalent2;
  int get prereqRank0;
  int get prereqRank1;
  int get prereqRank2;
  int get flags;
  int get requiredSpellId;
  int get categoryMask0;
  int get categoryMask1;

  static TalentEntity fromJson(Map<String, dynamic> json) {
    return TalentEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      tabId: (json['TabID'] as num?)?.toInt() ?? 0,
      tierId: (json['TierID'] as num?)?.toInt() ?? 0,
      columnIndex: (json['ColumnIndex'] as num?)?.toInt() ?? 0,
      spellRank0: (json['SpellRank0'] as num?)?.toInt() ?? 0,
      spellRank1: (json['SpellRank1'] as num?)?.toInt() ?? 0,
      spellRank2: (json['SpellRank2'] as num?)?.toInt() ?? 0,
      spellRank3: (json['SpellRank3'] as num?)?.toInt() ?? 0,
      spellRank4: (json['SpellRank4'] as num?)?.toInt() ?? 0,
      spellRank5: (json['SpellRank5'] as num?)?.toInt() ?? 0,
      spellRank6: (json['SpellRank6'] as num?)?.toInt() ?? 0,
      spellRank7: (json['SpellRank7'] as num?)?.toInt() ?? 0,
      spellRank8: (json['SpellRank8'] as num?)?.toInt() ?? 0,
      prereqTalent0: (json['PrereqTalent0'] as num?)?.toInt() ?? 0,
      prereqTalent1: (json['PrereqTalent1'] as num?)?.toInt() ?? 0,
      prereqTalent2: (json['PrereqTalent2'] as num?)?.toInt() ?? 0,
      prereqRank0: (json['PrereqRank0'] as num?)?.toInt() ?? 0,
      prereqRank1: (json['PrereqRank1'] as num?)?.toInt() ?? 0,
      prereqRank2: (json['PrereqRank2'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      requiredSpellId: (json['RequiredSpellID'] as num?)?.toInt() ?? 0,
      categoryMask0: (json['CategoryMask0'] as num?)?.toInt() ?? 0,
      categoryMask1: (json['CategoryMask1'] as num?)?.toInt() ?? 0,
    );
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TalentEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            tabId == other.tabId &&
            tierId == other.tierId &&
            columnIndex == other.columnIndex &&
            spellRank0 == other.spellRank0 &&
            spellRank1 == other.spellRank1 &&
            spellRank2 == other.spellRank2 &&
            spellRank3 == other.spellRank3 &&
            spellRank4 == other.spellRank4 &&
            spellRank5 == other.spellRank5 &&
            spellRank6 == other.spellRank6 &&
            spellRank7 == other.spellRank7 &&
            spellRank8 == other.spellRank8 &&
            prereqTalent0 == other.prereqTalent0 &&
            prereqTalent1 == other.prereqTalent1 &&
            prereqTalent2 == other.prereqTalent2 &&
            prereqRank0 == other.prereqRank0 &&
            prereqRank1 == other.prereqRank1 &&
            prereqRank2 == other.prereqRank2 &&
            flags == other.flags &&
            requiredSpellId == other.requiredSpellId &&
            categoryMask0 == other.categoryMask0 &&
            categoryMask1 == other.categoryMask1;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      tabId,
      tierId,
      columnIndex,
      spellRank0,
      spellRank1,
      spellRank2,
      spellRank3,
      spellRank4,
      spellRank5,
      spellRank6,
      spellRank7,
      spellRank8,
      prereqTalent0,
      prereqTalent1,
      prereqTalent2,
      prereqRank0,
      prereqRank1,
      prereqRank2,
      flags,
      requiredSpellId,
      categoryMask0,
      categoryMask1,
    ]);
  }

  @override
  String toString() {
    return 'TalentEntity('
        'id: $id, '
        'tabId: $tabId, '
        'tierId: $tierId, '
        'columnIndex: $columnIndex, '
        'spellRank0: $spellRank0, '
        'spellRank1: $spellRank1, '
        'spellRank2: $spellRank2, '
        'spellRank3: $spellRank3, '
        'spellRank4: $spellRank4, '
        'spellRank5: $spellRank5, '
        'spellRank6: $spellRank6, '
        'spellRank7: $spellRank7, '
        'spellRank8: $spellRank8, '
        'prereqTalent0: $prereqTalent0, '
        'prereqTalent1: $prereqTalent1, '
        'prereqTalent2: $prereqTalent2, '
        'prereqRank0: $prereqRank0, '
        'prereqRank1: $prereqRank1, '
        'prereqRank2: $prereqRank2, '
        'flags: $flags, '
        'requiredSpellId: $requiredSpellId, '
        'categoryMask0: $categoryMask0, '
        'categoryMask1: $categoryMask1'
        ')';
  }
}
