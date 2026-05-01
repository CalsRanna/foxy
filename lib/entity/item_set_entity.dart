class ItemSetEntity {
  final int id;
  final String nameLangEnUS;
  final String nameLangKoKR;
  final String nameLangFrFR;
  final String nameLangDeDE;
  final String nameLangZhCN;
  final String nameLangZhTW;
  final String nameLangEsES;
  final String nameLangEsMX;
  final String nameLangRuRU;
  final String nameLangJaJP;
  final String nameLangPtPT;
  final String nameLangPtBR;
  final String nameLangItIT;
  final String nameLangUnk1;
  final String nameLangUnk2;
  final String nameLangUnk3;
  final int nameLangFlags;
  final int itemId0;
  final int itemId1;
  final int itemId2;
  final int itemId3;
  final int itemId4;
  final int itemId5;
  final int itemId6;
  final int itemId7;
  final int itemId8;
  final int itemId9;
  final int itemId10;
  final int itemId11;
  final int itemId12;
  final int itemId13;
  final int itemId14;
  final int itemId15;
  final int itemId16;
  final int setSpellId0;
  final int setSpellId1;
  final int setSpellId2;
  final int setSpellId3;
  final int setSpellId4;
  final int setSpellId5;
  final int setSpellId6;
  final int setSpellId7;
  final int setThreshold0;
  final int setThreshold1;
  final int setThreshold2;
  final int setThreshold3;
  final int setThreshold4;
  final int setThreshold5;
  final int setThreshold6;
  final int setThreshold7;
  final int requiredSkill;
  final int requiredSkillRank;

  const ItemSetEntity({
    this.id = 0,
    this.nameLangEnUS = '',
    this.nameLangKoKR = '',
    this.nameLangFrFR = '',
    this.nameLangDeDE = '',
    this.nameLangZhCN = '',
    this.nameLangZhTW = '',
    this.nameLangEsES = '',
    this.nameLangEsMX = '',
    this.nameLangRuRU = '',
    this.nameLangJaJP = '',
    this.nameLangPtPT = '',
    this.nameLangPtBR = '',
    this.nameLangItIT = '',
    this.nameLangUnk1 = '',
    this.nameLangUnk2 = '',
    this.nameLangUnk3 = '',
    this.nameLangFlags = 0,
    this.itemId0 = 0,
    this.itemId1 = 0,
    this.itemId2 = 0,
    this.itemId3 = 0,
    this.itemId4 = 0,
    this.itemId5 = 0,
    this.itemId6 = 0,
    this.itemId7 = 0,
    this.itemId8 = 0,
    this.itemId9 = 0,
    this.itemId10 = 0,
    this.itemId11 = 0,
    this.itemId12 = 0,
    this.itemId13 = 0,
    this.itemId14 = 0,
    this.itemId15 = 0,
    this.itemId16 = 0,
    this.setSpellId0 = 0,
    this.setSpellId1 = 0,
    this.setSpellId2 = 0,
    this.setSpellId3 = 0,
    this.setSpellId4 = 0,
    this.setSpellId5 = 0,
    this.setSpellId6 = 0,
    this.setSpellId7 = 0,
    this.setThreshold0 = 0,
    this.setThreshold1 = 0,
    this.setThreshold2 = 0,
    this.setThreshold3 = 0,
    this.setThreshold4 = 0,
    this.setThreshold5 = 0,
    this.setThreshold6 = 0,
    this.setThreshold7 = 0,
    this.requiredSkill = 0,
    this.requiredSkillRank = 0,
  });

  factory ItemSetEntity.fromJson(Map<String, dynamic> json) {
    return ItemSetEntity(
      id: json['ID'] ?? 0,
      nameLangEnUS: json['Name_lang_enUS'] ?? '',
      nameLangKoKR: json['Name_lang_koKR'] ?? '',
      nameLangFrFR: json['Name_lang_frFR'] ?? '',
      nameLangDeDE: json['Name_lang_deDE'] ?? '',
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      nameLangZhTW: json['Name_lang_zhTW'] ?? '',
      nameLangEsES: json['Name_lang_esES'] ?? '',
      nameLangEsMX: json['Name_lang_esMX'] ?? '',
      nameLangRuRU: json['Name_lang_ruRU'] ?? '',
      nameLangJaJP: json['Name_lang_jaJP'] ?? '',
      nameLangPtPT: json['Name_lang_ptPT'] ?? '',
      nameLangPtBR: json['Name_lang_ptBR'] ?? '',
      nameLangItIT: json['Name_lang_itIT'] ?? '',
      nameLangUnk1: json['Name_lang_unk1'] ?? '',
      nameLangUnk2: json['Name_lang_unk2'] ?? '',
      nameLangUnk3: json['Name_lang_unk3'] ?? '',
      nameLangFlags: json['Name_lang_Flags'] ?? 0,
      itemId0: json['ItemID0'] ?? 0,
      itemId1: json['ItemID1'] ?? 0,
      itemId2: json['ItemID2'] ?? 0,
      itemId3: json['ItemID3'] ?? 0,
      itemId4: json['ItemID4'] ?? 0,
      itemId5: json['ItemID5'] ?? 0,
      itemId6: json['ItemID6'] ?? 0,
      itemId7: json['ItemID7'] ?? 0,
      itemId8: json['ItemID8'] ?? 0,
      itemId9: json['ItemID9'] ?? 0,
      itemId10: json['ItemID10'] ?? 0,
      itemId11: json['ItemID11'] ?? 0,
      itemId12: json['ItemID12'] ?? 0,
      itemId13: json['ItemID13'] ?? 0,
      itemId14: json['ItemID14'] ?? 0,
      itemId15: json['ItemID15'] ?? 0,
      itemId16: json['ItemID16'] ?? 0,
      setSpellId0: json['SetSpellID0'] ?? 0,
      setSpellId1: json['SetSpellID1'] ?? 0,
      setSpellId2: json['SetSpellID2'] ?? 0,
      setSpellId3: json['SetSpellID3'] ?? 0,
      setSpellId4: json['SetSpellID4'] ?? 0,
      setSpellId5: json['SetSpellID5'] ?? 0,
      setSpellId6: json['SetSpellID6'] ?? 0,
      setSpellId7: json['SetSpellID7'] ?? 0,
      setThreshold0: json['SetThreshold0'] ?? 0,
      setThreshold1: json['SetThreshold1'] ?? 0,
      setThreshold2: json['SetThreshold2'] ?? 0,
      setThreshold3: json['SetThreshold3'] ?? 0,
      setThreshold4: json['SetThreshold4'] ?? 0,
      setThreshold5: json['SetThreshold5'] ?? 0,
      setThreshold6: json['SetThreshold6'] ?? 0,
      setThreshold7: json['SetThreshold7'] ?? 0,
      requiredSkill: json['RequiredSkill'] ?? 0,
      requiredSkillRank: json['RequiredSkillRank'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name_lang_enUS': nameLangEnUS,
      'Name_lang_koKR': nameLangKoKR,
      'Name_lang_frFR': nameLangFrFR,
      'Name_lang_deDE': nameLangDeDE,
      'Name_lang_zhCN': nameLangZhCN,
      'Name_lang_zhTW': nameLangZhTW,
      'Name_lang_esES': nameLangEsES,
      'Name_lang_esMX': nameLangEsMX,
      'Name_lang_ruRU': nameLangRuRU,
      'Name_lang_jaJP': nameLangJaJP,
      'Name_lang_ptPT': nameLangPtPT,
      'Name_lang_ptBR': nameLangPtBR,
      'Name_lang_itIT': nameLangItIT,
      'Name_lang_unk1': nameLangUnk1,
      'Name_lang_unk2': nameLangUnk2,
      'Name_lang_unk3': nameLangUnk3,
      'Name_lang_Flags': nameLangFlags,
      'ItemID0': itemId0,
      'ItemID1': itemId1,
      'ItemID2': itemId2,
      'ItemID3': itemId3,
      'ItemID4': itemId4,
      'ItemID5': itemId5,
      'ItemID6': itemId6,
      'ItemID7': itemId7,
      'ItemID8': itemId8,
      'ItemID9': itemId9,
      'ItemID10': itemId10,
      'ItemID11': itemId11,
      'ItemID12': itemId12,
      'ItemID13': itemId13,
      'ItemID14': itemId14,
      'ItemID15': itemId15,
      'ItemID16': itemId16,
      'SetSpellID0': setSpellId0,
      'SetSpellID1': setSpellId1,
      'SetSpellID2': setSpellId2,
      'SetSpellID3': setSpellId3,
      'SetSpellID4': setSpellId4,
      'SetSpellID5': setSpellId5,
      'SetSpellID6': setSpellId6,
      'SetSpellID7': setSpellId7,
      'SetThreshold0': setThreshold0,
      'SetThreshold1': setThreshold1,
      'SetThreshold2': setThreshold2,
      'SetThreshold3': setThreshold3,
      'SetThreshold4': setThreshold4,
      'SetThreshold5': setThreshold5,
      'SetThreshold6': setThreshold6,
      'SetThreshold7': setThreshold7,
      'RequiredSkill': requiredSkill,
      'RequiredSkillRank': requiredSkillRank,
    };
  }
}

class BriefItemSetEntity {
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
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      requiredSkill: json['RequiredSkill'] ?? 0,
      requiredSkillRank: json['RequiredSkillRank'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name_lang_zhCN': nameLangZhCN,
      'RequiredSkill': requiredSkill,
      'RequiredSkillRank': requiredSkillRank,
    };
  }
}
