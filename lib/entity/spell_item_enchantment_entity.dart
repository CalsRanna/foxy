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
}
