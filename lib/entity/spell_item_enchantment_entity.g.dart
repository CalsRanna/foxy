// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_item_enchantment_entity.dart';

mixin _SpellItemEnchantmentEntityMixin {
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
    final self = this as SpellItemEnchantmentEntity;
    return SpellItemEnchantmentEntity(
      id: id ?? self.id,
      charges: charges ?? self.charges,
      effect0: effect0 ?? self.effect0,
      effect1: effect1 ?? self.effect1,
      effect2: effect2 ?? self.effect2,
      effectPointsMin0: effectPointsMin0 ?? self.effectPointsMin0,
      effectPointsMin1: effectPointsMin1 ?? self.effectPointsMin1,
      effectPointsMin2: effectPointsMin2 ?? self.effectPointsMin2,
      effectPointsMax0: effectPointsMax0 ?? self.effectPointsMax0,
      effectPointsMax1: effectPointsMax1 ?? self.effectPointsMax1,
      effectPointsMax2: effectPointsMax2 ?? self.effectPointsMax2,
      effectArg0: effectArg0 ?? self.effectArg0,
      effectArg1: effectArg1 ?? self.effectArg1,
      effectArg2: effectArg2 ?? self.effectArg2,
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
      itemVisual: itemVisual ?? self.itemVisual,
      flags: flags ?? self.flags,
      srcItemId: srcItemId ?? self.srcItemId,
      conditionId: conditionId ?? self.conditionId,
      requiredSkillId: requiredSkillId ?? self.requiredSkillId,
      requiredSkillRank: requiredSkillRank ?? self.requiredSkillRank,
      minLevel: minLevel ?? self.minLevel,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SpellItemEnchantmentEntity;
    return {
      'ID': self.id,
      'Charges': self.charges,
      'Effect0': self.effect0,
      'Effect1': self.effect1,
      'Effect2': self.effect2,
      'EffectPointsMin0': self.effectPointsMin0,
      'EffectPointsMin1': self.effectPointsMin1,
      'EffectPointsMin2': self.effectPointsMin2,
      'EffectPointsMax0': self.effectPointsMax0,
      'EffectPointsMax1': self.effectPointsMax1,
      'EffectPointsMax2': self.effectPointsMax2,
      'EffectArg0': self.effectArg0,
      'EffectArg1': self.effectArg1,
      'EffectArg2': self.effectArg2,
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
      'ItemVisual': self.itemVisual,
      'Flags': self.flags,
      'Src_itemID': self.srcItemId,
      'Condition_ID': self.conditionId,
      'RequiredSkillID': self.requiredSkillId,
      'RequiredSkillRank': self.requiredSkillRank,
      'MinLevel': self.minLevel,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as SpellItemEnchantmentEntity;
    return identical(self, other) ||
        other is SpellItemEnchantmentEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.charges == other.charges &&
            self.effect0 == other.effect0 &&
            self.effect1 == other.effect1 &&
            self.effect2 == other.effect2 &&
            self.effectPointsMin0 == other.effectPointsMin0 &&
            self.effectPointsMin1 == other.effectPointsMin1 &&
            self.effectPointsMin2 == other.effectPointsMin2 &&
            self.effectPointsMax0 == other.effectPointsMax0 &&
            self.effectPointsMax1 == other.effectPointsMax1 &&
            self.effectPointsMax2 == other.effectPointsMax2 &&
            self.effectArg0 == other.effectArg0 &&
            self.effectArg1 == other.effectArg1 &&
            self.effectArg2 == other.effectArg2 &&
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
            self.itemVisual == other.itemVisual &&
            self.flags == other.flags &&
            self.srcItemId == other.srcItemId &&
            self.conditionId == other.conditionId &&
            self.requiredSkillId == other.requiredSkillId &&
            self.requiredSkillRank == other.requiredSkillRank &&
            self.minLevel == other.minLevel;
  }

  @override
  int get hashCode {
    final self = this as SpellItemEnchantmentEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.charges,
      self.effect0,
      self.effect1,
      self.effect2,
      self.effectPointsMin0,
      self.effectPointsMin1,
      self.effectPointsMin2,
      self.effectPointsMax0,
      self.effectPointsMax1,
      self.effectPointsMax2,
      self.effectArg0,
      self.effectArg1,
      self.effectArg2,
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
      self.itemVisual,
      self.flags,
      self.srcItemId,
      self.conditionId,
      self.requiredSkillId,
      self.requiredSkillRank,
      self.minLevel,
    ]);
  }

  @override
  String toString() {
    final self = this as SpellItemEnchantmentEntity;
    return 'SpellItemEnchantmentEntity('
        'id: ${self.id}, '
        'charges: ${self.charges}, '
        'effect0: ${self.effect0}, '
        'effect1: ${self.effect1}, '
        'effect2: ${self.effect2}, '
        'effectPointsMin0: ${self.effectPointsMin0}, '
        'effectPointsMin1: ${self.effectPointsMin1}, '
        'effectPointsMin2: ${self.effectPointsMin2}, '
        'effectPointsMax0: ${self.effectPointsMax0}, '
        'effectPointsMax1: ${self.effectPointsMax1}, '
        'effectPointsMax2: ${self.effectPointsMax2}, '
        'effectArg0: ${self.effectArg0}, '
        'effectArg1: ${self.effectArg1}, '
        'effectArg2: ${self.effectArg2}, '
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
        'itemVisual: ${self.itemVisual}, '
        'flags: ${self.flags}, '
        'srcItemId: ${self.srcItemId}, '
        'conditionId: ${self.conditionId}, '
        'requiredSkillId: ${self.requiredSkillId}, '
        'requiredSkillRank: ${self.requiredSkillRank}, '
        'minLevel: ${self.minLevel}'
        ')';
  }
}

final class BriefSpellItemEnchantmentEntity {
  final int id;
  final int charges;
  final int effect0;
  final int effect1;
  final int effect2;
  final String nameLangZhCN;

  const BriefSpellItemEnchantmentEntity({
    this.id = 0,
    this.charges = 0,
    this.effect0 = 0,
    this.effect1 = 0,
    this.effect2 = 0,
    this.nameLangZhCN = '',
  });

  factory BriefSpellItemEnchantmentEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellItemEnchantmentEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      charges: (json['Charges'] as num?)?.toInt() ?? 0,
      effect0: (json['Effect0'] as num?)?.toInt() ?? 0,
      effect1: (json['Effect1'] as num?)?.toInt() ?? 0,
      effect2: (json['Effect2'] as num?)?.toInt() ?? 0,
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
