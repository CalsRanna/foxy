class SpellItemEnchantment {
  int id = 0;
  int charges = 0;
  int effect0 = 0;
  int effect1 = 0;
  int effect2 = 0;
  int effectPointsMin0 = 0;
  int effectPointsMin1 = 0;
  int effectPointsMin2 = 0;
  int effectPointsMax0 = 0;
  int effectPointsMax1 = 0;
  int effectPointsMax2 = 0;
  int effectArg0 = 0;
  int effectArg1 = 0;
  int effectArg2 = 0;
  String nameLangZhCn = '';
  int itemVisual = 0;
  int flags = 0;
  int srcItemId = 0;
  int conditionId = 0;
  int requiredSkillId = 0;
  int requiredSkillRank = 0;
  int minLevel = 0;

  SpellItemEnchantment();

  factory SpellItemEnchantment.fromJson(Map<String, dynamic> json) {
    return SpellItemEnchantment()
      ..id = json['ID'] ?? 0
      ..charges = json['Charges'] ?? 0
      ..effect0 = json['Effect0'] ?? 0
      ..effect1 = json['Effect1'] ?? 0
      ..effect2 = json['Effect2'] ?? 0
      ..effectPointsMin0 = json['EffectPointsMin0'] ?? 0
      ..effectPointsMin1 = json['EffectPointsMin1'] ?? 0
      ..effectPointsMin2 = json['EffectPointsMin2'] ?? 0
      ..effectPointsMax0 = json['EffectPointsMax0'] ?? 0
      ..effectPointsMax1 = json['EffectPointsMax1'] ?? 0
      ..effectPointsMax2 = json['EffectPointsMax2'] ?? 0
      ..effectArg0 = json['EffectArg0'] ?? 0
      ..effectArg1 = json['EffectArg1'] ?? 0
      ..effectArg2 = json['EffectArg2'] ?? 0
      ..nameLangZhCn = json['Name_lang_zhCN'] ?? ''
      ..itemVisual = json['ItemVisual'] ?? 0
      ..flags = json['Flags'] ?? 0
      ..srcItemId = json['Src_itemID'] ?? 0
      ..conditionId = json['Condition_ID'] ?? 0
      ..requiredSkillId = json['RequiredSkillID'] ?? 0
      ..requiredSkillRank = json['RequiredSkillRank'] ?? 0
      ..minLevel = json['MinLevel'] ?? 0;
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
