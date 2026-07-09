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
  final String nameLangZhCn;
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
    this.nameLangZhCn = '',
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
      nameLangZhCn: json['Name_lang_zhCN'] ?? '',
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
      'Name_lang_zhCN': nameLangZhCn,
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
    String? nameLangZhCn,
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
      nameLangZhCn: nameLangZhCn ?? this.nameLangZhCn,
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
  final String nameLangZhCn;
  final int charges;
  final int effect0;
  final int effect1;
  final int effect2;

  const BriefSpellItemEnchantmentEntity({
    this.id = 0,
    this.nameLangZhCn = '',
    this.charges = 0,
    this.effect0 = 0,
    this.effect1 = 0,
    this.effect2 = 0,
  });

  factory BriefSpellItemEnchantmentEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellItemEnchantmentEntity(
      id: json['ID'] ?? 0,
      nameLangZhCn: json['Name_lang_zhCN'] ?? '',
      charges: json['Charges'] ?? 0,
      effect0: json['Effect0'] ?? 0,
      effect1: json['Effect1'] ?? 0,
      effect2: json['Effect2'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name_lang_zhCN': nameLangZhCn,
      'Charges': charges,
      'Effect0': effect0,
      'Effect1': effect1,
      'Effect2': effect2,
    };
  }

  BriefSpellItemEnchantmentEntity copyWith({
    int? id,
    String? nameLangZhCn,
    int? charges,
    int? effect0,
    int? effect1,
    int? effect2,
  }) {
    return BriefSpellItemEnchantmentEntity(
      id: id ?? this.id,
      nameLangZhCn: nameLangZhCn ?? this.nameLangZhCn,
      charges: charges ?? this.charges,
      effect0: effect0 ?? this.effect0,
      effect1: effect1 ?? this.effect1,
      effect2: effect2 ?? this.effect2,
    );
  }
}
