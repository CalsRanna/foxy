// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_set_entity.dart';

mixin _ItemSetEntityMixin {
  static ItemSetEntity fromJson(Map<String, dynamic> json) {
    return ItemSetEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      nameLangEnUS: json['Name_lang_enUS']?.toString() ?? '',
      nameLangKoKR: json['Name_lang_koKR']?.toString() ?? '',
      nameLangFrFR: json['Name_lang_frFR']?.toString() ?? '',
      nameLangDeDE: json['Name_lang_deDE']?.toString() ?? '',
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
      nameLangZhTW: json['Name_lang_zhTW']?.toString() ?? '',
      nameLangEsES: json['Name_lang_esES']?.toString() ?? '',
      nameLangEsMX: json['Name_lang_esMX']?.toString() ?? '',
      nameLangRuRU: json['Name_lang_ruRU']?.toString() ?? '',
      nameLangJaJP: json['Name_lang_jaJP']?.toString() ?? '',
      nameLangPtPT: json['Name_lang_ptPT']?.toString() ?? '',
      nameLangPtBR: json['Name_lang_ptBR']?.toString() ?? '',
      nameLangItIT: json['Name_lang_itIT']?.toString() ?? '',
      nameLangUnk1: json['Name_lang_unk1']?.toString() ?? '',
      nameLangUnk2: json['Name_lang_unk2']?.toString() ?? '',
      nameLangUnk3: json['Name_lang_unk3']?.toString() ?? '',
      nameLangFlags: (json['Name_lang_Flags'] as num?)?.toInt() ?? 0,
      itemId0: (json['ItemID0'] as num?)?.toInt() ?? 0,
      itemId1: (json['ItemID1'] as num?)?.toInt() ?? 0,
      itemId2: (json['ItemID2'] as num?)?.toInt() ?? 0,
      itemId3: (json['ItemID3'] as num?)?.toInt() ?? 0,
      itemId4: (json['ItemID4'] as num?)?.toInt() ?? 0,
      itemId5: (json['ItemID5'] as num?)?.toInt() ?? 0,
      itemId6: (json['ItemID6'] as num?)?.toInt() ?? 0,
      itemId7: (json['ItemID7'] as num?)?.toInt() ?? 0,
      itemId8: (json['ItemID8'] as num?)?.toInt() ?? 0,
      itemId9: (json['ItemID9'] as num?)?.toInt() ?? 0,
      itemId10: (json['ItemID10'] as num?)?.toInt() ?? 0,
      itemId11: (json['ItemID11'] as num?)?.toInt() ?? 0,
      itemId12: (json['ItemID12'] as num?)?.toInt() ?? 0,
      itemId13: (json['ItemID13'] as num?)?.toInt() ?? 0,
      itemId14: (json['ItemID14'] as num?)?.toInt() ?? 0,
      itemId15: (json['ItemID15'] as num?)?.toInt() ?? 0,
      itemId16: (json['ItemID16'] as num?)?.toInt() ?? 0,
      setSpellId0: (json['SetSpellID0'] as num?)?.toInt() ?? 0,
      setSpellId1: (json['SetSpellID1'] as num?)?.toInt() ?? 0,
      setSpellId2: (json['SetSpellID2'] as num?)?.toInt() ?? 0,
      setSpellId3: (json['SetSpellID3'] as num?)?.toInt() ?? 0,
      setSpellId4: (json['SetSpellID4'] as num?)?.toInt() ?? 0,
      setSpellId5: (json['SetSpellID5'] as num?)?.toInt() ?? 0,
      setSpellId6: (json['SetSpellID6'] as num?)?.toInt() ?? 0,
      setSpellId7: (json['SetSpellID7'] as num?)?.toInt() ?? 0,
      setThreshold0: (json['SetThreshold0'] as num?)?.toInt() ?? 0,
      setThreshold1: (json['SetThreshold1'] as num?)?.toInt() ?? 0,
      setThreshold2: (json['SetThreshold2'] as num?)?.toInt() ?? 0,
      setThreshold3: (json['SetThreshold3'] as num?)?.toInt() ?? 0,
      setThreshold4: (json['SetThreshold4'] as num?)?.toInt() ?? 0,
      setThreshold5: (json['SetThreshold5'] as num?)?.toInt() ?? 0,
      setThreshold6: (json['SetThreshold6'] as num?)?.toInt() ?? 0,
      setThreshold7: (json['SetThreshold7'] as num?)?.toInt() ?? 0,
      requiredSkill: (json['RequiredSkill'] as num?)?.toInt() ?? 0,
      requiredSkillRank: (json['RequiredSkillRank'] as num?)?.toInt() ?? 0,
    );
  }

  ItemSetEntity copyWith({
    int? id,
    String? nameLangEnUS,
    String? nameLangKoKR,
    String? nameLangFrFR,
    String? nameLangDeDE,
    String? nameLangZhCN,
    String? nameLangZhTW,
    String? nameLangEsES,
    String? nameLangEsMX,
    String? nameLangRuRU,
    String? nameLangJaJP,
    String? nameLangPtPT,
    String? nameLangPtBR,
    String? nameLangItIT,
    String? nameLangUnk1,
    String? nameLangUnk2,
    String? nameLangUnk3,
    int? nameLangFlags,
    int? itemId0,
    int? itemId1,
    int? itemId2,
    int? itemId3,
    int? itemId4,
    int? itemId5,
    int? itemId6,
    int? itemId7,
    int? itemId8,
    int? itemId9,
    int? itemId10,
    int? itemId11,
    int? itemId12,
    int? itemId13,
    int? itemId14,
    int? itemId15,
    int? itemId16,
    int? setSpellId0,
    int? setSpellId1,
    int? setSpellId2,
    int? setSpellId3,
    int? setSpellId4,
    int? setSpellId5,
    int? setSpellId6,
    int? setSpellId7,
    int? setThreshold0,
    int? setThreshold1,
    int? setThreshold2,
    int? setThreshold3,
    int? setThreshold4,
    int? setThreshold5,
    int? setThreshold6,
    int? setThreshold7,
    int? requiredSkill,
    int? requiredSkillRank,
  }) {
    final self = this as ItemSetEntity;
    return ItemSetEntity(
      id: id ?? self.id,
      nameLangEnUS: nameLangEnUS ?? self.nameLangEnUS,
      nameLangKoKR: nameLangKoKR ?? self.nameLangKoKR,
      nameLangFrFR: nameLangFrFR ?? self.nameLangFrFR,
      nameLangDeDE: nameLangDeDE ?? self.nameLangDeDE,
      nameLangZhCN: nameLangZhCN ?? self.nameLangZhCN,
      nameLangZhTW: nameLangZhTW ?? self.nameLangZhTW,
      nameLangEsES: nameLangEsES ?? self.nameLangEsES,
      nameLangEsMX: nameLangEsMX ?? self.nameLangEsMX,
      nameLangRuRU: nameLangRuRU ?? self.nameLangRuRU,
      nameLangJaJP: nameLangJaJP ?? self.nameLangJaJP,
      nameLangPtPT: nameLangPtPT ?? self.nameLangPtPT,
      nameLangPtBR: nameLangPtBR ?? self.nameLangPtBR,
      nameLangItIT: nameLangItIT ?? self.nameLangItIT,
      nameLangUnk1: nameLangUnk1 ?? self.nameLangUnk1,
      nameLangUnk2: nameLangUnk2 ?? self.nameLangUnk2,
      nameLangUnk3: nameLangUnk3 ?? self.nameLangUnk3,
      nameLangFlags: nameLangFlags ?? self.nameLangFlags,
      itemId0: itemId0 ?? self.itemId0,
      itemId1: itemId1 ?? self.itemId1,
      itemId2: itemId2 ?? self.itemId2,
      itemId3: itemId3 ?? self.itemId3,
      itemId4: itemId4 ?? self.itemId4,
      itemId5: itemId5 ?? self.itemId5,
      itemId6: itemId6 ?? self.itemId6,
      itemId7: itemId7 ?? self.itemId7,
      itemId8: itemId8 ?? self.itemId8,
      itemId9: itemId9 ?? self.itemId9,
      itemId10: itemId10 ?? self.itemId10,
      itemId11: itemId11 ?? self.itemId11,
      itemId12: itemId12 ?? self.itemId12,
      itemId13: itemId13 ?? self.itemId13,
      itemId14: itemId14 ?? self.itemId14,
      itemId15: itemId15 ?? self.itemId15,
      itemId16: itemId16 ?? self.itemId16,
      setSpellId0: setSpellId0 ?? self.setSpellId0,
      setSpellId1: setSpellId1 ?? self.setSpellId1,
      setSpellId2: setSpellId2 ?? self.setSpellId2,
      setSpellId3: setSpellId3 ?? self.setSpellId3,
      setSpellId4: setSpellId4 ?? self.setSpellId4,
      setSpellId5: setSpellId5 ?? self.setSpellId5,
      setSpellId6: setSpellId6 ?? self.setSpellId6,
      setSpellId7: setSpellId7 ?? self.setSpellId7,
      setThreshold0: setThreshold0 ?? self.setThreshold0,
      setThreshold1: setThreshold1 ?? self.setThreshold1,
      setThreshold2: setThreshold2 ?? self.setThreshold2,
      setThreshold3: setThreshold3 ?? self.setThreshold3,
      setThreshold4: setThreshold4 ?? self.setThreshold4,
      setThreshold5: setThreshold5 ?? self.setThreshold5,
      setThreshold6: setThreshold6 ?? self.setThreshold6,
      setThreshold7: setThreshold7 ?? self.setThreshold7,
      requiredSkill: requiredSkill ?? self.requiredSkill,
      requiredSkillRank: requiredSkillRank ?? self.requiredSkillRank,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ItemSetEntity;
    return {
      'ID': self.id,
      'Name_lang_enUS': self.nameLangEnUS,
      'Name_lang_koKR': self.nameLangKoKR,
      'Name_lang_frFR': self.nameLangFrFR,
      'Name_lang_deDE': self.nameLangDeDE,
      'Name_lang_zhCN': self.nameLangZhCN,
      'Name_lang_zhTW': self.nameLangZhTW,
      'Name_lang_esES': self.nameLangEsES,
      'Name_lang_esMX': self.nameLangEsMX,
      'Name_lang_ruRU': self.nameLangRuRU,
      'Name_lang_jaJP': self.nameLangJaJP,
      'Name_lang_ptPT': self.nameLangPtPT,
      'Name_lang_ptBR': self.nameLangPtBR,
      'Name_lang_itIT': self.nameLangItIT,
      'Name_lang_unk1': self.nameLangUnk1,
      'Name_lang_unk2': self.nameLangUnk2,
      'Name_lang_unk3': self.nameLangUnk3,
      'Name_lang_Flags': self.nameLangFlags,
      'ItemID0': self.itemId0,
      'ItemID1': self.itemId1,
      'ItemID2': self.itemId2,
      'ItemID3': self.itemId3,
      'ItemID4': self.itemId4,
      'ItemID5': self.itemId5,
      'ItemID6': self.itemId6,
      'ItemID7': self.itemId7,
      'ItemID8': self.itemId8,
      'ItemID9': self.itemId9,
      'ItemID10': self.itemId10,
      'ItemID11': self.itemId11,
      'ItemID12': self.itemId12,
      'ItemID13': self.itemId13,
      'ItemID14': self.itemId14,
      'ItemID15': self.itemId15,
      'ItemID16': self.itemId16,
      'SetSpellID0': self.setSpellId0,
      'SetSpellID1': self.setSpellId1,
      'SetSpellID2': self.setSpellId2,
      'SetSpellID3': self.setSpellId3,
      'SetSpellID4': self.setSpellId4,
      'SetSpellID5': self.setSpellId5,
      'SetSpellID6': self.setSpellId6,
      'SetSpellID7': self.setSpellId7,
      'SetThreshold0': self.setThreshold0,
      'SetThreshold1': self.setThreshold1,
      'SetThreshold2': self.setThreshold2,
      'SetThreshold3': self.setThreshold3,
      'SetThreshold4': self.setThreshold4,
      'SetThreshold5': self.setThreshold5,
      'SetThreshold6': self.setThreshold6,
      'SetThreshold7': self.setThreshold7,
      'RequiredSkill': self.requiredSkill,
      'RequiredSkillRank': self.requiredSkillRank,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as ItemSetEntity;
    return identical(self, other) ||
        other is ItemSetEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.nameLangEnUS == other.nameLangEnUS &&
            self.nameLangKoKR == other.nameLangKoKR &&
            self.nameLangFrFR == other.nameLangFrFR &&
            self.nameLangDeDE == other.nameLangDeDE &&
            self.nameLangZhCN == other.nameLangZhCN &&
            self.nameLangZhTW == other.nameLangZhTW &&
            self.nameLangEsES == other.nameLangEsES &&
            self.nameLangEsMX == other.nameLangEsMX &&
            self.nameLangRuRU == other.nameLangRuRU &&
            self.nameLangJaJP == other.nameLangJaJP &&
            self.nameLangPtPT == other.nameLangPtPT &&
            self.nameLangPtBR == other.nameLangPtBR &&
            self.nameLangItIT == other.nameLangItIT &&
            self.nameLangUnk1 == other.nameLangUnk1 &&
            self.nameLangUnk2 == other.nameLangUnk2 &&
            self.nameLangUnk3 == other.nameLangUnk3 &&
            self.nameLangFlags == other.nameLangFlags &&
            self.itemId0 == other.itemId0 &&
            self.itemId1 == other.itemId1 &&
            self.itemId2 == other.itemId2 &&
            self.itemId3 == other.itemId3 &&
            self.itemId4 == other.itemId4 &&
            self.itemId5 == other.itemId5 &&
            self.itemId6 == other.itemId6 &&
            self.itemId7 == other.itemId7 &&
            self.itemId8 == other.itemId8 &&
            self.itemId9 == other.itemId9 &&
            self.itemId10 == other.itemId10 &&
            self.itemId11 == other.itemId11 &&
            self.itemId12 == other.itemId12 &&
            self.itemId13 == other.itemId13 &&
            self.itemId14 == other.itemId14 &&
            self.itemId15 == other.itemId15 &&
            self.itemId16 == other.itemId16 &&
            self.setSpellId0 == other.setSpellId0 &&
            self.setSpellId1 == other.setSpellId1 &&
            self.setSpellId2 == other.setSpellId2 &&
            self.setSpellId3 == other.setSpellId3 &&
            self.setSpellId4 == other.setSpellId4 &&
            self.setSpellId5 == other.setSpellId5 &&
            self.setSpellId6 == other.setSpellId6 &&
            self.setSpellId7 == other.setSpellId7 &&
            self.setThreshold0 == other.setThreshold0 &&
            self.setThreshold1 == other.setThreshold1 &&
            self.setThreshold2 == other.setThreshold2 &&
            self.setThreshold3 == other.setThreshold3 &&
            self.setThreshold4 == other.setThreshold4 &&
            self.setThreshold5 == other.setThreshold5 &&
            self.setThreshold6 == other.setThreshold6 &&
            self.setThreshold7 == other.setThreshold7 &&
            self.requiredSkill == other.requiredSkill &&
            self.requiredSkillRank == other.requiredSkillRank;
  }

  @override
  int get hashCode {
    final self = this as ItemSetEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.nameLangEnUS,
      self.nameLangKoKR,
      self.nameLangFrFR,
      self.nameLangDeDE,
      self.nameLangZhCN,
      self.nameLangZhTW,
      self.nameLangEsES,
      self.nameLangEsMX,
      self.nameLangRuRU,
      self.nameLangJaJP,
      self.nameLangPtPT,
      self.nameLangPtBR,
      self.nameLangItIT,
      self.nameLangUnk1,
      self.nameLangUnk2,
      self.nameLangUnk3,
      self.nameLangFlags,
      self.itemId0,
      self.itemId1,
      self.itemId2,
      self.itemId3,
      self.itemId4,
      self.itemId5,
      self.itemId6,
      self.itemId7,
      self.itemId8,
      self.itemId9,
      self.itemId10,
      self.itemId11,
      self.itemId12,
      self.itemId13,
      self.itemId14,
      self.itemId15,
      self.itemId16,
      self.setSpellId0,
      self.setSpellId1,
      self.setSpellId2,
      self.setSpellId3,
      self.setSpellId4,
      self.setSpellId5,
      self.setSpellId6,
      self.setSpellId7,
      self.setThreshold0,
      self.setThreshold1,
      self.setThreshold2,
      self.setThreshold3,
      self.setThreshold4,
      self.setThreshold5,
      self.setThreshold6,
      self.setThreshold7,
      self.requiredSkill,
      self.requiredSkillRank,
    ]);
  }

  @override
  String toString() {
    final self = this as ItemSetEntity;
    return 'ItemSetEntity('
        'id: ${self.id}, '
        'nameLangEnUS: ${self.nameLangEnUS}, '
        'nameLangKoKR: ${self.nameLangKoKR}, '
        'nameLangFrFR: ${self.nameLangFrFR}, '
        'nameLangDeDE: ${self.nameLangDeDE}, '
        'nameLangZhCN: ${self.nameLangZhCN}, '
        'nameLangZhTW: ${self.nameLangZhTW}, '
        'nameLangEsES: ${self.nameLangEsES}, '
        'nameLangEsMX: ${self.nameLangEsMX}, '
        'nameLangRuRU: ${self.nameLangRuRU}, '
        'nameLangJaJP: ${self.nameLangJaJP}, '
        'nameLangPtPT: ${self.nameLangPtPT}, '
        'nameLangPtBR: ${self.nameLangPtBR}, '
        'nameLangItIT: ${self.nameLangItIT}, '
        'nameLangUnk1: ${self.nameLangUnk1}, '
        'nameLangUnk2: ${self.nameLangUnk2}, '
        'nameLangUnk3: ${self.nameLangUnk3}, '
        'nameLangFlags: ${self.nameLangFlags}, '
        'itemId0: ${self.itemId0}, '
        'itemId1: ${self.itemId1}, '
        'itemId2: ${self.itemId2}, '
        'itemId3: ${self.itemId3}, '
        'itemId4: ${self.itemId4}, '
        'itemId5: ${self.itemId5}, '
        'itemId6: ${self.itemId6}, '
        'itemId7: ${self.itemId7}, '
        'itemId8: ${self.itemId8}, '
        'itemId9: ${self.itemId9}, '
        'itemId10: ${self.itemId10}, '
        'itemId11: ${self.itemId11}, '
        'itemId12: ${self.itemId12}, '
        'itemId13: ${self.itemId13}, '
        'itemId14: ${self.itemId14}, '
        'itemId15: ${self.itemId15}, '
        'itemId16: ${self.itemId16}, '
        'setSpellId0: ${self.setSpellId0}, '
        'setSpellId1: ${self.setSpellId1}, '
        'setSpellId2: ${self.setSpellId2}, '
        'setSpellId3: ${self.setSpellId3}, '
        'setSpellId4: ${self.setSpellId4}, '
        'setSpellId5: ${self.setSpellId5}, '
        'setSpellId6: ${self.setSpellId6}, '
        'setSpellId7: ${self.setSpellId7}, '
        'setThreshold0: ${self.setThreshold0}, '
        'setThreshold1: ${self.setThreshold1}, '
        'setThreshold2: ${self.setThreshold2}, '
        'setThreshold3: ${self.setThreshold3}, '
        'setThreshold4: ${self.setThreshold4}, '
        'setThreshold5: ${self.setThreshold5}, '
        'setThreshold6: ${self.setThreshold6}, '
        'setThreshold7: ${self.setThreshold7}, '
        'requiredSkill: ${self.requiredSkill}, '
        'requiredSkillRank: ${self.requiredSkillRank}'
        ')';
  }
}

final class BriefItemSetEntity {
  final int id;
  final String nameLangZhCN;
  final int requiredSkill;
  final int requiredSkillRank;

  const BriefItemSetEntity({
    this.id = 0,
    this.nameLangZhCN = '',
    this.requiredSkill = 0,
    this.requiredSkillRank = 0,
  });

  factory BriefItemSetEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemSetEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
      requiredSkill: (json['RequiredSkill'] as num?)?.toInt() ?? 0,
      requiredSkillRank: (json['RequiredSkillRank'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
