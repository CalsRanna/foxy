// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_item_enchantment_entity.dart';

mixin _SpellItemEnchantmentEntityMixin {
  int get id;
  int get charges;
  int get effect0;
  int get effect1;
  int get effect2;
  int get effectPointsMin0;
  int get effectPointsMin1;
  int get effectPointsMin2;
  int get effectPointsMax0;
  int get effectPointsMax1;
  int get effectPointsMax2;
  int get effectArg0;
  int get effectArg1;
  int get effectArg2;
  String get nameLangEnUS;
  String get nameLangKoKR;
  String get nameLangFrFR;
  String get nameLangDeDE;
  String get nameLangZhCN;
  String get nameLangZhTW;
  String get nameLangEsES;
  String get nameLangEsMX;
  String get nameLangRuRU;
  String get nameLangJaJP;
  String get nameLangPtPT;
  String get nameLangPtBR;
  String get nameLangItIT;
  String get nameLangUnk1;
  String get nameLangUnk2;
  String get nameLangUnk3;
  int get nameLangFlags;
  int get itemVisual;
  int get flags;
  int get srcItemId;
  int get conditionId;
  int get requiredSkillId;
  int get requiredSkillRank;
  int get minLevel;

  static SpellItemEnchantmentEntity fromJson(Map<String, dynamic> json) {
    return SpellItemEnchantmentEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      charges: (json['Charges'] as num?)?.toInt() ?? 0,
      effect0: (json['Effect0'] as num?)?.toInt() ?? 0,
      effect1: (json['Effect1'] as num?)?.toInt() ?? 0,
      effect2: (json['Effect2'] as num?)?.toInt() ?? 0,
      effectPointsMin0: (json['EffectPointsMin0'] as num?)?.toInt() ?? 0,
      effectPointsMin1: (json['EffectPointsMin1'] as num?)?.toInt() ?? 0,
      effectPointsMin2: (json['EffectPointsMin2'] as num?)?.toInt() ?? 0,
      effectPointsMax0: (json['EffectPointsMax0'] as num?)?.toInt() ?? 0,
      effectPointsMax1: (json['EffectPointsMax1'] as num?)?.toInt() ?? 0,
      effectPointsMax2: (json['EffectPointsMax2'] as num?)?.toInt() ?? 0,
      effectArg0: (json['EffectArg0'] as num?)?.toInt() ?? 0,
      effectArg1: (json['EffectArg1'] as num?)?.toInt() ?? 0,
      effectArg2: (json['EffectArg2'] as num?)?.toInt() ?? 0,
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
      itemVisual: (json['ItemVisual'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      srcItemId: (json['Src_itemID'] as num?)?.toInt() ?? 0,
      conditionId: (json['Condition_ID'] as num?)?.toInt() ?? 0,
      requiredSkillId: (json['RequiredSkillID'] as num?)?.toInt() ?? 0,
      requiredSkillRank: (json['RequiredSkillRank'] as num?)?.toInt() ?? 0,
      minLevel: (json['MinLevel'] as num?)?.toInt() ?? 0,
    );
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellItemEnchantmentEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            charges == other.charges &&
            effect0 == other.effect0 &&
            effect1 == other.effect1 &&
            effect2 == other.effect2 &&
            effectPointsMin0 == other.effectPointsMin0 &&
            effectPointsMin1 == other.effectPointsMin1 &&
            effectPointsMin2 == other.effectPointsMin2 &&
            effectPointsMax0 == other.effectPointsMax0 &&
            effectPointsMax1 == other.effectPointsMax1 &&
            effectPointsMax2 == other.effectPointsMax2 &&
            effectArg0 == other.effectArg0 &&
            effectArg1 == other.effectArg1 &&
            effectArg2 == other.effectArg2 &&
            nameLangEnUS == other.nameLangEnUS &&
            nameLangKoKR == other.nameLangKoKR &&
            nameLangFrFR == other.nameLangFrFR &&
            nameLangDeDE == other.nameLangDeDE &&
            nameLangZhCN == other.nameLangZhCN &&
            nameLangZhTW == other.nameLangZhTW &&
            nameLangEsES == other.nameLangEsES &&
            nameLangEsMX == other.nameLangEsMX &&
            nameLangRuRU == other.nameLangRuRU &&
            nameLangJaJP == other.nameLangJaJP &&
            nameLangPtPT == other.nameLangPtPT &&
            nameLangPtBR == other.nameLangPtBR &&
            nameLangItIT == other.nameLangItIT &&
            nameLangUnk1 == other.nameLangUnk1 &&
            nameLangUnk2 == other.nameLangUnk2 &&
            nameLangUnk3 == other.nameLangUnk3 &&
            nameLangFlags == other.nameLangFlags &&
            itemVisual == other.itemVisual &&
            flags == other.flags &&
            srcItemId == other.srcItemId &&
            conditionId == other.conditionId &&
            requiredSkillId == other.requiredSkillId &&
            requiredSkillRank == other.requiredSkillRank &&
            minLevel == other.minLevel;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      charges,
      effect0,
      effect1,
      effect2,
      effectPointsMin0,
      effectPointsMin1,
      effectPointsMin2,
      effectPointsMax0,
      effectPointsMax1,
      effectPointsMax2,
      effectArg0,
      effectArg1,
      effectArg2,
      nameLangEnUS,
      nameLangKoKR,
      nameLangFrFR,
      nameLangDeDE,
      nameLangZhCN,
      nameLangZhTW,
      nameLangEsES,
      nameLangEsMX,
      nameLangRuRU,
      nameLangJaJP,
      nameLangPtPT,
      nameLangPtBR,
      nameLangItIT,
      nameLangUnk1,
      nameLangUnk2,
      nameLangUnk3,
      nameLangFlags,
      itemVisual,
      flags,
      srcItemId,
      conditionId,
      requiredSkillId,
      requiredSkillRank,
      minLevel,
    ]);
  }

  @override
  String toString() {
    return 'SpellItemEnchantmentEntity('
        'id: $id, '
        'charges: $charges, '
        'effect0: $effect0, '
        'effect1: $effect1, '
        'effect2: $effect2, '
        'effectPointsMin0: $effectPointsMin0, '
        'effectPointsMin1: $effectPointsMin1, '
        'effectPointsMin2: $effectPointsMin2, '
        'effectPointsMax0: $effectPointsMax0, '
        'effectPointsMax1: $effectPointsMax1, '
        'effectPointsMax2: $effectPointsMax2, '
        'effectArg0: $effectArg0, '
        'effectArg1: $effectArg1, '
        'effectArg2: $effectArg2, '
        'nameLangEnUS: $nameLangEnUS, '
        'nameLangKoKR: $nameLangKoKR, '
        'nameLangFrFR: $nameLangFrFR, '
        'nameLangDeDE: $nameLangDeDE, '
        'nameLangZhCN: $nameLangZhCN, '
        'nameLangZhTW: $nameLangZhTW, '
        'nameLangEsES: $nameLangEsES, '
        'nameLangEsMX: $nameLangEsMX, '
        'nameLangRuRU: $nameLangRuRU, '
        'nameLangJaJP: $nameLangJaJP, '
        'nameLangPtPT: $nameLangPtPT, '
        'nameLangPtBR: $nameLangPtBR, '
        'nameLangItIT: $nameLangItIT, '
        'nameLangUnk1: $nameLangUnk1, '
        'nameLangUnk2: $nameLangUnk2, '
        'nameLangUnk3: $nameLangUnk3, '
        'nameLangFlags: $nameLangFlags, '
        'itemVisual: $itemVisual, '
        'flags: $flags, '
        'srcItemId: $srcItemId, '
        'conditionId: $conditionId, '
        'requiredSkillId: $requiredSkillId, '
        'requiredSkillRank: $requiredSkillRank, '
        'minLevel: $minLevel'
        ')';
  }
}
