// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_entity.dart';

mixin _TalentEntityMixin {
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
    final self = this as TalentEntity;
    return TalentEntity(
      id: id ?? self.id,
      tabId: tabId ?? self.tabId,
      tierId: tierId ?? self.tierId,
      columnIndex: columnIndex ?? self.columnIndex,
      spellRank0: spellRank0 ?? self.spellRank0,
      spellRank1: spellRank1 ?? self.spellRank1,
      spellRank2: spellRank2 ?? self.spellRank2,
      spellRank3: spellRank3 ?? self.spellRank3,
      spellRank4: spellRank4 ?? self.spellRank4,
      spellRank5: spellRank5 ?? self.spellRank5,
      spellRank6: spellRank6 ?? self.spellRank6,
      spellRank7: spellRank7 ?? self.spellRank7,
      spellRank8: spellRank8 ?? self.spellRank8,
      prereqTalent0: prereqTalent0 ?? self.prereqTalent0,
      prereqTalent1: prereqTalent1 ?? self.prereqTalent1,
      prereqTalent2: prereqTalent2 ?? self.prereqTalent2,
      prereqRank0: prereqRank0 ?? self.prereqRank0,
      prereqRank1: prereqRank1 ?? self.prereqRank1,
      prereqRank2: prereqRank2 ?? self.prereqRank2,
      flags: flags ?? self.flags,
      requiredSpellId: requiredSpellId ?? self.requiredSpellId,
      categoryMask0: categoryMask0 ?? self.categoryMask0,
      categoryMask1: categoryMask1 ?? self.categoryMask1,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as TalentEntity;
    return {
      'ID': self.id,
      'TabID': self.tabId,
      'TierID': self.tierId,
      'ColumnIndex': self.columnIndex,
      'SpellRank0': self.spellRank0,
      'SpellRank1': self.spellRank1,
      'SpellRank2': self.spellRank2,
      'SpellRank3': self.spellRank3,
      'SpellRank4': self.spellRank4,
      'SpellRank5': self.spellRank5,
      'SpellRank6': self.spellRank6,
      'SpellRank7': self.spellRank7,
      'SpellRank8': self.spellRank8,
      'PrereqTalent0': self.prereqTalent0,
      'PrereqTalent1': self.prereqTalent1,
      'PrereqTalent2': self.prereqTalent2,
      'PrereqRank0': self.prereqRank0,
      'PrereqRank1': self.prereqRank1,
      'PrereqRank2': self.prereqRank2,
      'Flags': self.flags,
      'RequiredSpellID': self.requiredSpellId,
      'CategoryMask0': self.categoryMask0,
      'CategoryMask1': self.categoryMask1,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as TalentEntity;
    return identical(self, other) ||
        other is TalentEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.tabId == other.tabId &&
            self.tierId == other.tierId &&
            self.columnIndex == other.columnIndex &&
            self.spellRank0 == other.spellRank0 &&
            self.spellRank1 == other.spellRank1 &&
            self.spellRank2 == other.spellRank2 &&
            self.spellRank3 == other.spellRank3 &&
            self.spellRank4 == other.spellRank4 &&
            self.spellRank5 == other.spellRank5 &&
            self.spellRank6 == other.spellRank6 &&
            self.spellRank7 == other.spellRank7 &&
            self.spellRank8 == other.spellRank8 &&
            self.prereqTalent0 == other.prereqTalent0 &&
            self.prereqTalent1 == other.prereqTalent1 &&
            self.prereqTalent2 == other.prereqTalent2 &&
            self.prereqRank0 == other.prereqRank0 &&
            self.prereqRank1 == other.prereqRank1 &&
            self.prereqRank2 == other.prereqRank2 &&
            self.flags == other.flags &&
            self.requiredSpellId == other.requiredSpellId &&
            self.categoryMask0 == other.categoryMask0 &&
            self.categoryMask1 == other.categoryMask1;
  }

  @override
  int get hashCode {
    final self = this as TalentEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.tabId,
      self.tierId,
      self.columnIndex,
      self.spellRank0,
      self.spellRank1,
      self.spellRank2,
      self.spellRank3,
      self.spellRank4,
      self.spellRank5,
      self.spellRank6,
      self.spellRank7,
      self.spellRank8,
      self.prereqTalent0,
      self.prereqTalent1,
      self.prereqTalent2,
      self.prereqRank0,
      self.prereqRank1,
      self.prereqRank2,
      self.flags,
      self.requiredSpellId,
      self.categoryMask0,
      self.categoryMask1,
    ]);
  }

  @override
  String toString() {
    final self = this as TalentEntity;
    return 'TalentEntity('
        'id: ${self.id}, '
        'tabId: ${self.tabId}, '
        'tierId: ${self.tierId}, '
        'columnIndex: ${self.columnIndex}, '
        'spellRank0: ${self.spellRank0}, '
        'spellRank1: ${self.spellRank1}, '
        'spellRank2: ${self.spellRank2}, '
        'spellRank3: ${self.spellRank3}, '
        'spellRank4: ${self.spellRank4}, '
        'spellRank5: ${self.spellRank5}, '
        'spellRank6: ${self.spellRank6}, '
        'spellRank7: ${self.spellRank7}, '
        'spellRank8: ${self.spellRank8}, '
        'prereqTalent0: ${self.prereqTalent0}, '
        'prereqTalent1: ${self.prereqTalent1}, '
        'prereqTalent2: ${self.prereqTalent2}, '
        'prereqRank0: ${self.prereqRank0}, '
        'prereqRank1: ${self.prereqRank1}, '
        'prereqRank2: ${self.prereqRank2}, '
        'flags: ${self.flags}, '
        'requiredSpellId: ${self.requiredSpellId}, '
        'categoryMask0: ${self.categoryMask0}, '
        'categoryMask1: ${self.categoryMask1}'
        ')';
  }
}
