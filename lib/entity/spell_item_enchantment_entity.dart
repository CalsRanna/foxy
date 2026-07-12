class SpellItemEnchantmentEntity {
  final int id;
  final int charges;
  final int effect0;
  final int effect1;
  final int effect2;
  final int effectPointsMin0;
  final int effectPointsMin1;
  final int effectPointsMin2;
  final int effectPointsMax0;
  final int effectPointsMax1;
  final int effectPointsMax2;
  final int effectArg0;
  final int effectArg1;
  final int effectArg2;
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
  final int itemVisual;
  final int flags;
  final int srcItemId;
  final int conditionId;
  final int requiredSkillId;
  final int requiredSkillRank;
  final int minLevel;

  const SpellItemEnchantmentEntity({
    this.id = 0,
    this.charges = 0,
    this.effect0 = 0,
    this.effect1 = 0,
    this.effect2 = 0,
    this.effectPointsMin0 = 0,
    this.effectPointsMin1 = 0,
    this.effectPointsMin2 = 0,
    this.effectPointsMax0 = 0,
    this.effectPointsMax1 = 0,
    this.effectPointsMax2 = 0,
    this.effectArg0 = 0,
    this.effectArg1 = 0,
    this.effectArg2 = 0,
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
    this.itemVisual = 0,
    this.flags = 0,
    this.srcItemId = 0,
    this.conditionId = 0,
    this.requiredSkillId = 0,
    this.requiredSkillRank = 0,
    this.minLevel = 0,
  });

  factory SpellItemEnchantmentEntity.fromJson(Map<String, dynamic> json) {
    return SpellItemEnchantmentEntity(
      id: json['ID'] ?? 0,
      charges: json['Charges'] ?? 0,
      effect0: json['Effect0'] ?? 0,
      effect1: json['Effect1'] ?? 0,
      effect2: json['Effect2'] ?? 0,
      effectPointsMin0: json['EffectPointsMin0'] ?? 0,
      effectPointsMin1: json['EffectPointsMin1'] ?? 0,
      effectPointsMin2: json['EffectPointsMin2'] ?? 0,
      effectPointsMax0: json['EffectPointsMax0'] ?? 0,
      effectPointsMax1: json['EffectPointsMax1'] ?? 0,
      effectPointsMax2: json['EffectPointsMax2'] ?? 0,
      effectArg0: json['EffectArg0'] ?? 0,
      effectArg1: json['EffectArg1'] ?? 0,
      effectArg2: json['EffectArg2'] ?? 0,
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
      itemVisual: json['ItemVisual'] ?? 0,
      flags: json['Flags'] ?? 0,
      srcItemId: json['Src_itemID'] ?? 0,
      conditionId: json['Condition_ID'] ?? 0,
      requiredSkillId: json['RequiredSkillID'] ?? 0,
      requiredSkillRank: json['RequiredSkillRank'] ?? 0,
      minLevel: json['MinLevel'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Charges': charges,
      'Effect0': effect0,
      'Effect1': effect1,
      'Effect2': effect2,
      'EffectPointsMin0': effectPointsMin0,
      'EffectPointsMin1': effectPointsMin1,
      'EffectPointsMin2': effectPointsMin2,
      'EffectPointsMax0': effectPointsMax0,
      'EffectPointsMax1': effectPointsMax1,
      'EffectPointsMax2': effectPointsMax2,
      'EffectArg0': effectArg0,
      'EffectArg1': effectArg1,
      'EffectArg2': effectArg2,
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
      'ItemVisual': itemVisual,
      'Flags': flags,
      'Src_itemID': srcItemId,
      'Condition_ID': conditionId,
      'RequiredSkillID': requiredSkillId,
      'RequiredSkillRank': requiredSkillRank,
      'MinLevel': minLevel,
    };
  }

  SpellItemEnchantmentEntity copyWith({
    int? id,
    int? charges,
    int? effect0,
    int? effect1,
    int? effect2,
    int? effectPointsMin0,
    int? effectPointsMin1,
    int? effectPointsMin2,
    int? effectPointsMax0,
    int? effectPointsMax1,
    int? effectPointsMax2,
    int? effectArg0,
    int? effectArg1,
    int? effectArg2,
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
    int? itemVisual,
    int? flags,
    int? srcItemId,
    int? conditionId,
    int? requiredSkillId,
    int? requiredSkillRank,
    int? minLevel,
  }) {
    return SpellItemEnchantmentEntity(
      id: id ?? this.id,
      charges: charges ?? this.charges,
      effect0: effect0 ?? this.effect0,
      effect1: effect1 ?? this.effect1,
      effect2: effect2 ?? this.effect2,
      effectPointsMin0: effectPointsMin0 ?? this.effectPointsMin0,
      effectPointsMin1: effectPointsMin1 ?? this.effectPointsMin1,
      effectPointsMin2: effectPointsMin2 ?? this.effectPointsMin2,
      effectPointsMax0: effectPointsMax0 ?? this.effectPointsMax0,
      effectPointsMax1: effectPointsMax1 ?? this.effectPointsMax1,
      effectPointsMax2: effectPointsMax2 ?? this.effectPointsMax2,
      effectArg0: effectArg0 ?? this.effectArg0,
      effectArg1: effectArg1 ?? this.effectArg1,
      effectArg2: effectArg2 ?? this.effectArg2,
      nameLangEnUS: nameLangEnUS ?? this.nameLangEnUS,
      nameLangKoKR: nameLangKoKR ?? this.nameLangKoKR,
      nameLangFrFR: nameLangFrFR ?? this.nameLangFrFR,
      nameLangDeDE: nameLangDeDE ?? this.nameLangDeDE,
      nameLangZhCN: nameLangZhCN ?? this.nameLangZhCN,
      nameLangZhTW: nameLangZhTW ?? this.nameLangZhTW,
      nameLangEsES: nameLangEsES ?? this.nameLangEsES,
      nameLangEsMX: nameLangEsMX ?? this.nameLangEsMX,
      nameLangRuRU: nameLangRuRU ?? this.nameLangRuRU,
      nameLangJaJP: nameLangJaJP ?? this.nameLangJaJP,
      nameLangPtPT: nameLangPtPT ?? this.nameLangPtPT,
      nameLangPtBR: nameLangPtBR ?? this.nameLangPtBR,
      nameLangItIT: nameLangItIT ?? this.nameLangItIT,
      nameLangUnk1: nameLangUnk1 ?? this.nameLangUnk1,
      nameLangUnk2: nameLangUnk2 ?? this.nameLangUnk2,
      nameLangUnk3: nameLangUnk3 ?? this.nameLangUnk3,
      nameLangFlags: nameLangFlags ?? this.nameLangFlags,
      itemVisual: itemVisual ?? this.itemVisual,
      flags: flags ?? this.flags,
      srcItemId: srcItemId ?? this.srcItemId,
      conditionId: conditionId ?? this.conditionId,
      requiredSkillId: requiredSkillId ?? this.requiredSkillId,
      requiredSkillRank: requiredSkillRank ?? this.requiredSkillRank,
      minLevel: minLevel ?? this.minLevel,
    );
  }
}

/// 法术附魔列表展示模型
class BriefSpellItemEnchantmentEntity {
  final int id;
  final String nameLangZhCN;
  final int charges;
  final int effect0;
  final int effect1;
  final int effect2;

  const BriefSpellItemEnchantmentEntity({
    this.id = 0,
    this.nameLangZhCN = '',
    this.charges = 0,
    this.effect0 = 0,
    this.effect1 = 0,
    this.effect2 = 0,
  });

  factory BriefSpellItemEnchantmentEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellItemEnchantmentEntity(
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      charges: json['Charges'] ?? 0,
      effect0: json['Effect0'] ?? 0,
      effect1: json['Effect1'] ?? 0,
      effect2: json['Effect2'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name_lang_zhCN': nameLangZhCN,
      'Charges': charges,
      'Effect0': effect0,
      'Effect1': effect1,
      'Effect2': effect2,
    };
  }

  BriefSpellItemEnchantmentEntity copyWith({
    int? id,
    String? nameLangZhCN,
    int? charges,
    int? effect0,
    int? effect1,
    int? effect2,
  }) {
    return BriefSpellItemEnchantmentEntity(
      id: id ?? this.id,
      nameLangZhCN: nameLangZhCN ?? this.nameLangZhCN,
      charges: charges ?? this.charges,
      effect0: effect0 ?? this.effect0,
      effect1: effect1 ?? this.effect1,
      effect2: effect2 ?? this.effect2,
    );
  }
}
