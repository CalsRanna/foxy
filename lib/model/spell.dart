/// 法术（技能）简要模型 - 列表展示用
class BriefSpell {
  int id = 0;
  String name = '';
  String subtext = '';
  String description = '';
  String auraDescription = '';
  String duration = '';
  String textureFilename = '';

  BriefSpell();

  factory BriefSpell.fromJson(Map<String, dynamic> json) {
    return BriefSpell()
      ..id = json['ID'] ?? 0
      ..name = json['Name_lang_zhCN'] ?? json['Name_Lang_zhCN'] ?? ''
      ..subtext =
          json['NameSubtext_lang_zhCN'] ?? json['NameSubtext_Lang_zhCN'] ?? ''
      ..description =
          json['Description_lang_zhCN'] ?? json['Description_Lang_zhCN'] ?? ''
      ..auraDescription =
          json['AuraDescription_lang_zhCN'] ??
          json['AuraDescription_Lang_zhCN'] ??
          ''
      ..duration = '${json['Duration'] ?? ''}'
      ..textureFilename = json['TextureFilename'] ?? '';
  }

  String get displayName => name;
  String get displaySubtext => subtext;
}

/// 法术（技能）完整模型 - 对应 foxy.dbc_spell 表
class Spell {
  // === 编号 ===
  int id = 0;

  // === 基础文本 ===
  String nameLangZhCN = '';
  String nameSubtextLangZhCN = '';
  String descriptionLangZhCN = '';
  String auraDescriptionLangZhCN = '';
  int nameLangFlags = 0;
  int nameSubtextLangFlags = 0;
  int descriptionLangFlags = 0;
  int auraDescriptionLangFlags = 0;

  // === 图标/视觉 ===
  int spellIconID = 0;
  int activeIconID = 0;
  int spellVisualID0 = 0;
  int spellVisualID1 = 0;

  // === 分类/类型 ===
  int category = 0;
  int schoolMask = 0;
  int mechanic = 0;
  int defenseType = 0;
  int dispelType = 0;
  int preventionType = 0;

  // === 施法参数 ===
  int castingTimeIndex = 0;
  int durationIndex = 0;
  int rangeIndex = 0;
  int spellDescriptionVariableID = 0;

  // === 等级 ===
  int baseLevel = 0;
  int spellLevel = 0;
  int maxLevel = 0;
  int spellDifficultyID = 0;

  // === 冷却/恢复 ===
  int startRecoveryCategory = 0;
  int startRecoveryTime = 0;
  int recoveryTime = 0;
  int categoryRecoveryTime = 0;

  // === 目标 ===
  int targetCreatureType = 0;
  int targets = 0;
  int maxTargets = 0;
  int maxTargetLevel = 0;

  // === 状态 ===
  int casterAuraState = 0;
  int targetAuraState = 0;
  int spellMissileID = 0;
  double speed = 0;

  // === 需求 ===
  int requiredAreasID = 0;
  int requiresSpellFocus = 0;
  int facingCasterFlags = 0;

  // === 能量消耗 ===
  int powerDisplayID = 0;
  int powerType = 0;
  int runeCostID = 0;
  int manaCost = 0;
  int manaCostPct = 0;
  int manaCostPerLevel = 0;
  int manaPerSecond = 0;
  int manaPerSecondPerLevel = 0;

  // === 标志位 ===
  int interruptFlags = 0;
  int auraInterruptFlags = 0;
  int channelInterruptFlags = 0;
  int attributes = 0;
  int attributesEx = 0;
  int attributesExB = 0;
  int attributesExC = 0;
  int attributesExD = 0;
  int attributesExE = 0;
  int attributesExF = 0;
  int attributesExG = 0;

  // === 触发 ===
  int procTypeMask = 0;
  int procChance = 0;
  int procCharges = 0;

  // === 法术分类 ===
  int spellClassSet = 0;
  int spellClassMask0 = 0;
  int spellClassMask1 = 0;
  int spellClassMask2 = 0;

  // === 变形 ===
  int shapeshiftMask0 = 0;
  int shapeshiftMask1 = 0;
  int shapeshiftExclude0 = 0;
  int shapeshiftExclude1 = 0;

  // === 效果0 ===
  int effect0 = 0;
  int effectDieSides0 = 0;
  double effectRealPointsPerLevel0 = 0;
  int effectBasePoints0 = 0;
  int effectMechanic0 = 0;
  int effectAura0 = 0;
  int effectAuraPeriod0 = 0;
  double effectAmplitude0 = 0;
  int effectChainTargets0 = 0;
  int effectItemType0 = 0;
  int effectMiscValue0 = 0;
  int effectMiscValueB0 = 0;
  int effectRadiusIndex0 = 0;
  int implicitTargetA0 = 0;
  int implicitTargetB0 = 0;
  int effectTriggerSpell0 = 0;
  double effectPointsPerCombo0 = 0;
  int effectSpellClassMaskA0 = 0;
  int effectSpellClassMaskB0 = 0;
  int effectSpellClassMaskC0 = 0;
  double effectChainAmplitude0 = 0;
  double effectBonusCoefficient0 = 0;

  // === 效果1 ===
  int effect1 = 0;
  int effectDieSides1 = 0;
  double effectRealPointsPerLevel1 = 0;
  int effectBasePoints1 = 0;
  int effectMechanic1 = 0;
  int effectAura1 = 0;
  int effectAuraPeriod1 = 0;
  double effectAmplitude1 = 0;
  int effectChainTargets1 = 0;
  int effectItemType1 = 0;
  int effectMiscValue1 = 0;
  int effectMiscValueB1 = 0;
  int effectRadiusIndex1 = 0;
  int implicitTargetA1 = 0;
  int implicitTargetB1 = 0;
  int effectTriggerSpell1 = 0;
  double effectPointsPerCombo1 = 0;
  int effectSpellClassMaskA1 = 0;
  int effectSpellClassMaskB1 = 0;
  int effectSpellClassMaskC1 = 0;
  double effectChainAmplitude1 = 0;
  double effectBonusCoefficient1 = 0;

  // === 效果2 ===
  int effect2 = 0;
  int effectDieSides2 = 0;
  double effectRealPointsPerLevel2 = 0;
  int effectBasePoints2 = 0;
  int effectMechanic2 = 0;
  int effectAura2 = 0;
  int effectAuraPeriod2 = 0;
  double effectAmplitude2 = 0;
  int effectChainTargets2 = 0;
  int effectItemType2 = 0;
  int effectMiscValue2 = 0;
  int effectMiscValueB2 = 0;
  int effectRadiusIndex2 = 0;
  int implicitTargetA2 = 0;
  int implicitTargetB2 = 0;
  int effectTriggerSpell2 = 0;
  double effectPointsPerCombo2 = 0;
  int effectSpellClassMaskA2 = 0;
  int effectSpellClassMaskB2 = 0;
  int effectSpellClassMaskC2 = 0;
  double effectChainAmplitude2 = 0;
  double effectBonusCoefficient2 = 0;

  // === 装备限制 ===
  int equippedItemClass = 0;
  int equippedItemSubclass = 0;
  int equippedItemInvTypes = 0;

  // === 图腾/施法材料 ===
  int requiredTotemCategoryID0 = 0;
  int totem0 = 0;
  int requiredTotemCategoryID1 = 0;
  int totem1 = 0;
  int reagent0 = 0;
  int reagent1 = 0;
  int reagent2 = 0;
  int reagent3 = 0;
  int reagent4 = 0;
  int reagent5 = 0;
  int reagent6 = 0;
  int reagent7 = 0;
  int reagentCount0 = 0;
  int reagentCount1 = 0;
  int reagentCount2 = 0;
  int reagentCount3 = 0;
  int reagentCount4 = 0;
  int reagentCount5 = 0;
  int reagentCount6 = 0;
  int reagentCount7 = 0;

  // === 其他高级属性 ===
  int casterAuraSpell = 0;
  int cumulativeAura = 0;
  int minFactionID = 0;
  int minReputation = 0;
  int excludeCasterAuraSpell = 0;
  int excludeCasterAuraState = 0;
  int excludeTargetAuraSpell = 0;
  int excludeTargetAuraState = 0;
  int spellPriority = 0;
  int modalNextSpell = 0;
  int requiredAuraVision = 0;
  int targetAuraSpell = 0;
  int stanceBarOrder = 0;

  Spell();

  factory Spell.fromJson(Map<String, dynamic> json) {
    return Spell()
      ..id = json['ID'] ?? 0
      ..nameLangZhCN = json['Name_lang_zhCN'] ?? ''
      ..nameSubtextLangZhCN = json['NameSubtext_lang_zhCN'] ?? ''
      ..descriptionLangZhCN = json['Description_lang_zhCN'] ?? ''
      ..auraDescriptionLangZhCN = json['AuraDescription_lang_zhCN'] ?? ''
      ..nameLangFlags = json['Name_lang_Flags'] ?? 0
      ..nameSubtextLangFlags = json['NameSubtext_lang_Flags'] ?? 0
      ..descriptionLangFlags = json['Description_lang_Flags'] ?? 0
      ..auraDescriptionLangFlags = json['AuraDescription_lang_Flags'] ?? 0
      ..spellIconID = json['SpellIconID'] ?? 0
      ..activeIconID = json['ActiveIconID'] ?? 0
      ..spellVisualID0 = json['SpellVisualID0'] ?? 0
      ..spellVisualID1 = json['SpellVisualID1'] ?? 0
      ..category = json['Category'] ?? 0
      ..schoolMask = json['SchoolMask'] ?? 0
      ..mechanic = json['Mechanic'] ?? 0
      ..defenseType = json['DefenseType'] ?? 0
      ..dispelType = json['DispelType'] ?? 0
      ..preventionType = json['PreventionType'] ?? 0
      ..castingTimeIndex = json['CastingTimeIndex'] ?? 0
      ..durationIndex = json['DurationIndex'] ?? 0
      ..rangeIndex = json['RangeIndex'] ?? 0
      ..spellDescriptionVariableID = json['DescriptionVariablesID'] ?? 0
      ..baseLevel = json['BaseLevel'] ?? 0
      ..spellLevel = json['SpellLevel'] ?? 0
      ..maxLevel = json['MaxLevel'] ?? 0
      ..spellDifficultyID = json['Difficulty'] ?? 0
      ..startRecoveryCategory = json['StartRecoveryCategory'] ?? 0
      ..startRecoveryTime = json['StartRecoveryTime'] ?? 0
      ..recoveryTime = json['RecoveryTime'] ?? 0
      ..categoryRecoveryTime = json['CategoryRecoveryTime'] ?? 0
      ..targetCreatureType = json['TargetCreatureType'] ?? 0
      ..targets = json['Targets'] ?? 0
      ..maxTargets = json['MaxTargets'] ?? 0
      ..maxTargetLevel = json['MaxTargetLevel'] ?? 0
      ..casterAuraState = json['CasterAuraState'] ?? 0
      ..targetAuraState = json['TargetAuraState'] ?? 0
      ..spellMissileID = json['SpellMissileID'] ?? 0
      ..speed = (json['Speed'] as num?)?.toDouble() ?? 0.0
      ..requiredAreasID = json['RequiredAreasID'] ?? 0
      ..requiresSpellFocus = json['RequiresSpellFocus'] ?? 0
      ..facingCasterFlags = json['FacingCasterFlags'] ?? 0
      ..powerDisplayID = json['PowerDisplayID'] ?? 0
      ..powerType = json['PowerType'] ?? 0
      ..runeCostID = json['RuneCostID'] ?? 0
      ..manaCost = json['ManaCost'] ?? 0
      ..manaCostPct = json['ManaCostPct'] ?? 0
      ..manaCostPerLevel = json['ManaCostPerLevel'] ?? 0
      ..manaPerSecond = json['ManaPerSecond'] ?? 0
      ..manaPerSecondPerLevel = json['ManaPerSecondPerLevel'] ?? 0
      ..interruptFlags = json['InterruptFlags'] ?? 0
      ..auraInterruptFlags = json['AuraInterruptFlags'] ?? 0
      ..channelInterruptFlags = json['ChannelInterruptFlags'] ?? 0
      ..attributes = json['Attributes'] ?? 0
      ..attributesEx = json['AttributesEx'] ?? 0
      ..attributesExB = json['AttributesExB'] ?? 0
      ..attributesExC = json['AttributesExC'] ?? 0
      ..attributesExD = json['AttributesExD'] ?? 0
      ..attributesExE = json['AttributesExE'] ?? 0
      ..attributesExF = json['AttributesExF'] ?? 0
      ..attributesExG = json['AttributesExG'] ?? 0
      ..procTypeMask = json['ProcTypeMask'] ?? 0
      ..procChance = json['ProcChance'] ?? 0
      ..procCharges = json['ProcCharges'] ?? 0
      ..spellClassSet = json['SpellClassSet'] ?? 0
      ..spellClassMask0 = json['SpellClassMask0'] ?? 0
      ..spellClassMask1 = json['SpellClassMask1'] ?? 0
      ..spellClassMask2 = json['SpellClassMask2'] ?? 0
      ..shapeshiftMask0 = json['ShapeshiftMask0'] ?? 0
      ..shapeshiftMask1 = json['ShapeshiftMask1'] ?? 0
      ..shapeshiftExclude0 = json['ShapeshiftExclude0'] ?? 0
      ..shapeshiftExclude1 = json['ShapeshiftExclude1'] ?? 0
      ..effect0 = json['Effect0'] ?? 0
      ..effectDieSides0 = json['EffectDieSides0'] ?? 0
      ..effectRealPointsPerLevel0 =
          (json['EffectRealPointsPerLevel0'] as num?)?.toDouble() ?? 0.0
      ..effectBasePoints0 = json['EffectBasePoints0'] ?? 0
      ..effectMechanic0 = json['EffectMechanic0'] ?? 0
      ..effectAura0 = json['EffectAura0'] ?? 0
      ..effectAuraPeriod0 = json['EffectAuraPeriod0'] ?? 0
      ..effectAmplitude0 = (json['EffectAmplitude0'] as num?)?.toDouble() ?? 0.0
      ..effectChainTargets0 = json['EffectChainTargets0'] ?? 0
      ..effectItemType0 = json['EffectItemType0'] ?? 0
      ..effectMiscValue0 = json['EffectMiscValue0'] ?? 0
      ..effectMiscValueB0 = json['EffectMiscValueB0'] ?? 0
      ..effectRadiusIndex0 = json['EffectRadiusIndex0'] ?? 0
      ..implicitTargetA0 = json['ImplicitTargetA0'] ?? 0
      ..implicitTargetB0 = json['ImplicitTargetB0'] ?? 0
      ..effectTriggerSpell0 = json['EffectTriggerSpell0'] ?? 0
      ..effectPointsPerCombo0 =
          (json['EffectPointsPerCombo0'] as num?)?.toDouble() ?? 0.0
      ..effectSpellClassMaskA0 = json['EffectSpellClassMaskA0'] ?? 0
      ..effectSpellClassMaskB0 = json['EffectSpellClassMaskB0'] ?? 0
      ..effectSpellClassMaskC0 = json['EffectSpellClassMaskC0'] ?? 0
      ..effectChainAmplitude0 =
          (json['EffectChainAmplitude0'] as num?)?.toDouble() ?? 0.0
      ..effectBonusCoefficient0 =
          (json['EffectBonusCoefficient0'] as num?)?.toDouble() ?? 0.0
      ..effect1 = json['Effect1'] ?? 0
      ..effectDieSides1 = json['EffectDieSides1'] ?? 0
      ..effectRealPointsPerLevel1 =
          (json['EffectRealPointsPerLevel1'] as num?)?.toDouble() ?? 0.0
      ..effectBasePoints1 = json['EffectBasePoints1'] ?? 0
      ..effectMechanic1 = json['EffectMechanic1'] ?? 0
      ..effectAura1 = json['EffectAura1'] ?? 0
      ..effectAuraPeriod1 = json['EffectAuraPeriod1'] ?? 0
      ..effectAmplitude1 = (json['EffectAmplitude1'] as num?)?.toDouble() ?? 0.0
      ..effectChainTargets1 = json['EffectChainTargets1'] ?? 0
      ..effectItemType1 = json['EffectItemType1'] ?? 0
      ..effectMiscValue1 = json['EffectMiscValue1'] ?? 0
      ..effectMiscValueB1 = json['EffectMiscValueB1'] ?? 0
      ..effectRadiusIndex1 = json['EffectRadiusIndex1'] ?? 0
      ..implicitTargetA1 = json['ImplicitTargetA1'] ?? 0
      ..implicitTargetB1 = json['ImplicitTargetB1'] ?? 0
      ..effectTriggerSpell1 = json['EffectTriggerSpell1'] ?? 0
      ..effectPointsPerCombo1 =
          (json['EffectPointsPerCombo1'] as num?)?.toDouble() ?? 0.0
      ..effectSpellClassMaskA1 = json['EffectSpellClassMaskA1'] ?? 0
      ..effectSpellClassMaskB1 = json['EffectSpellClassMaskB1'] ?? 0
      ..effectSpellClassMaskC1 = json['EffectSpellClassMaskC1'] ?? 0
      ..effectChainAmplitude1 =
          (json['EffectChainAmplitude1'] as num?)?.toDouble() ?? 0.0
      ..effectBonusCoefficient1 =
          (json['EffectBonusCoefficient1'] as num?)?.toDouble() ?? 0.0
      ..effect2 = json['Effect2'] ?? 0
      ..effectDieSides2 = json['EffectDieSides2'] ?? 0
      ..effectRealPointsPerLevel2 =
          (json['EffectRealPointsPerLevel2'] as num?)?.toDouble() ?? 0.0
      ..effectBasePoints2 = json['EffectBasePoints2'] ?? 0
      ..effectMechanic2 = json['EffectMechanic2'] ?? 0
      ..effectAura2 = json['EffectAura2'] ?? 0
      ..effectAuraPeriod2 = json['EffectAuraPeriod2'] ?? 0
      ..effectAmplitude2 = (json['EffectAmplitude2'] as num?)?.toDouble() ?? 0.0
      ..effectChainTargets2 = json['EffectChainTargets2'] ?? 0
      ..effectItemType2 = json['EffectItemType2'] ?? 0
      ..effectMiscValue2 = json['EffectMiscValue2'] ?? 0
      ..effectMiscValueB2 = json['EffectMiscValueB2'] ?? 0
      ..effectRadiusIndex2 = json['EffectRadiusIndex2'] ?? 0
      ..implicitTargetA2 = json['ImplicitTargetA2'] ?? 0
      ..implicitTargetB2 = json['ImplicitTargetB2'] ?? 0
      ..effectTriggerSpell2 = json['EffectTriggerSpell2'] ?? 0
      ..effectPointsPerCombo2 =
          (json['EffectPointsPerCombo2'] as num?)?.toDouble() ?? 0.0
      ..effectSpellClassMaskA2 = json['EffectSpellClassMaskA2'] ?? 0
      ..effectSpellClassMaskB2 = json['EffectSpellClassMaskB2'] ?? 0
      ..effectSpellClassMaskC2 = json['EffectSpellClassMaskC2'] ?? 0
      ..effectChainAmplitude2 =
          (json['EffectChainAmplitude2'] as num?)?.toDouble() ?? 0.0
      ..effectBonusCoefficient2 =
          (json['EffectBonusCoefficient2'] as num?)?.toDouble() ?? 0.0
      ..equippedItemClass = json['EquippedItemClass'] ?? 0
      ..equippedItemSubclass = json['EquippedItemSubclass'] ?? 0
      ..equippedItemInvTypes = json['EquippedItemInvTypes'] ?? 0
      ..requiredTotemCategoryID0 = json['RequiredTotemCategoryID0'] ?? 0
      ..totem0 = json['Totem0'] ?? 0
      ..requiredTotemCategoryID1 = json['RequiredTotemCategoryID1'] ?? 0
      ..totem1 = json['Totem1'] ?? 0
      ..reagent0 = json['Reagent0'] ?? 0
      ..reagent1 = json['Reagent1'] ?? 0
      ..reagent2 = json['Reagent2'] ?? 0
      ..reagent3 = json['Reagent3'] ?? 0
      ..reagent4 = json['Reagent4'] ?? 0
      ..reagent5 = json['Reagent5'] ?? 0
      ..reagent6 = json['Reagent6'] ?? 0
      ..reagent7 = json['Reagent7'] ?? 0
      ..reagentCount0 = json['ReagentCount0'] ?? 0
      ..reagentCount1 = json['ReagentCount1'] ?? 0
      ..reagentCount2 = json['ReagentCount2'] ?? 0
      ..reagentCount3 = json['ReagentCount3'] ?? 0
      ..reagentCount4 = json['ReagentCount4'] ?? 0
      ..reagentCount5 = json['ReagentCount5'] ?? 0
      ..reagentCount6 = json['ReagentCount6'] ?? 0
      ..reagentCount7 = json['ReagentCount7'] ?? 0
      ..casterAuraSpell = json['CasterAuraSpell'] ?? 0
      ..cumulativeAura = json['CumulativeAura'] ?? 0
      ..minFactionID = json['MinFactionID'] ?? 0
      ..minReputation = json['MinReputation'] ?? 0
      ..excludeCasterAuraSpell = json['ExcludeCasterAuraSpell'] ?? 0
      ..excludeCasterAuraState = json['ExcludeCasterAuraState'] ?? 0
      ..excludeTargetAuraSpell = json['ExcludeTargetAuraSpell'] ?? 0
      ..excludeTargetAuraState = json['ExcludeTargetAuraState'] ?? 0
      ..spellPriority = json['SpellPriority'] ?? 0
      ..modalNextSpell = json['ModalNextSpell'] ?? 0
      ..requiredAuraVision = json['RequiredAuraVision'] ?? 0
      ..targetAuraSpell = json['TargetAuraSpell'] ?? 0
      ..stanceBarOrder = json['StanceBarOrder'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      // === 编号 ===
      'ID': id,

      // === 基础文本 ===
      'Name_lang_zhCN': nameLangZhCN,
      'NameSubtext_lang_zhCN': nameSubtextLangZhCN,
      'Description_lang_zhCN': descriptionLangZhCN,
      'AuraDescription_lang_zhCN': auraDescriptionLangZhCN,
      'Name_lang_Flags': nameLangFlags,
      'NameSubtext_lang_Flags': nameSubtextLangFlags,
      'Description_lang_Flags': descriptionLangFlags,
      'AuraDescription_lang_Flags': auraDescriptionLangFlags,

      // === 图标/视觉 ===
      'SpellIconID': spellIconID,
      'ActiveIconID': activeIconID,
      'SpellVisualID0': spellVisualID0,
      'SpellVisualID1': spellVisualID1,

      // === 分类/类型 ===
      'Category': category,
      'SchoolMask': schoolMask,
      'Mechanic': mechanic,
      'DefenseType': defenseType,
      'DispelType': dispelType,
      'PreventionType': preventionType,

      // === 施法参数 ===
      'CastingTimeIndex': castingTimeIndex,
      'DurationIndex': durationIndex,
      'RangeIndex': rangeIndex,
      'DescriptionVariablesID': spellDescriptionVariableID,

      // === 等级 ===
      'BaseLevel': baseLevel,
      'SpellLevel': spellLevel,
      'MaxLevel': maxLevel,
      'Difficulty': spellDifficultyID,

      // === 冷却/恢复 ===
      'StartRecoveryCategory': startRecoveryCategory,
      'StartRecoveryTime': startRecoveryTime,
      'RecoveryTime': recoveryTime,
      'CategoryRecoveryTime': categoryRecoveryTime,

      // === 目标 ===
      'TargetCreatureType': targetCreatureType,
      'Targets': targets,
      'MaxTargets': maxTargets,
      'MaxTargetLevel': maxTargetLevel,

      // === 状态 ===
      'CasterAuraState': casterAuraState,
      'TargetAuraState': targetAuraState,
      'SpellMissileID': spellMissileID,
      'Speed': speed,

      // === 需求 ===
      'RequiredAreasID': requiredAreasID,
      'RequiresSpellFocus': requiresSpellFocus,
      'FacingCasterFlags': facingCasterFlags,

      // === 能量消耗 ===
      'PowerDisplayID': powerDisplayID,
      'PowerType': powerType,
      'RuneCostID': runeCostID,
      'ManaCost': manaCost,
      'ManaCostPct': manaCostPct,
      'ManaCostPerLevel': manaCostPerLevel,
      'ManaPerSecond': manaPerSecond,
      'ManaPerSecondPerLevel': manaPerSecondPerLevel,

      // === 标志位 ===
      'InterruptFlags': interruptFlags,
      'AuraInterruptFlags': auraInterruptFlags,
      'ChannelInterruptFlags': channelInterruptFlags,
      'Attributes': attributes,
      'AttributesEx': attributesEx,
      'AttributesExB': attributesExB,
      'AttributesExC': attributesExC,
      'AttributesExD': attributesExD,
      'AttributesExE': attributesExE,
      'AttributesExF': attributesExF,
      'AttributesExG': attributesExG,

      // === 触发 ===
      'ProcTypeMask': procTypeMask,
      'ProcChance': procChance,
      'ProcCharges': procCharges,

      // === 法术分类 ===
      'SpellClassSet': spellClassSet,
      'SpellClassMask0': spellClassMask0,
      'SpellClassMask1': spellClassMask1,
      'SpellClassMask2': spellClassMask2,

      // === 变形 ===
      'ShapeshiftMask0': shapeshiftMask0,
      'ShapeshiftMask1': shapeshiftMask1,
      'ShapeshiftExclude0': shapeshiftExclude0,
      'ShapeshiftExclude1': shapeshiftExclude1,

      // === 效果0 ===
      'Effect0': effect0,
      'EffectDieSides0': effectDieSides0,
      'EffectRealPointsPerLevel0': effectRealPointsPerLevel0,
      'EffectBasePoints0': effectBasePoints0,
      'EffectMechanic0': effectMechanic0,
      'EffectAura0': effectAura0,
      'EffectAuraPeriod0': effectAuraPeriod0,
      'EffectAmplitude0': effectAmplitude0,
      'EffectChainTargets0': effectChainTargets0,
      'EffectItemType0': effectItemType0,
      'EffectMiscValue0': effectMiscValue0,
      'EffectMiscValueB0': effectMiscValueB0,
      'EffectRadiusIndex0': effectRadiusIndex0,
      'ImplicitTargetA0': implicitTargetA0,
      'ImplicitTargetB0': implicitTargetB0,
      'EffectTriggerSpell0': effectTriggerSpell0,
      'EffectPointsPerCombo0': effectPointsPerCombo0,
      'EffectSpellClassMaskA0': effectSpellClassMaskA0,
      'EffectSpellClassMaskB0': effectSpellClassMaskB0,
      'EffectSpellClassMaskC0': effectSpellClassMaskC0,
      'EffectChainAmplitude0': effectChainAmplitude0,
      'EffectBonusCoefficient0': effectBonusCoefficient0,

      // === 效果1 ===
      'Effect1': effect1,
      'EffectDieSides1': effectDieSides1,
      'EffectRealPointsPerLevel1': effectRealPointsPerLevel1,
      'EffectBasePoints1': effectBasePoints1,
      'EffectMechanic1': effectMechanic1,
      'EffectAura1': effectAura1,
      'EffectAuraPeriod1': effectAuraPeriod1,
      'EffectAmplitude1': effectAmplitude1,
      'EffectChainTargets1': effectChainTargets1,
      'EffectItemType1': effectItemType1,
      'EffectMiscValue1': effectMiscValue1,
      'EffectMiscValueB1': effectMiscValueB1,
      'EffectRadiusIndex1': effectRadiusIndex1,
      'ImplicitTargetA1': implicitTargetA1,
      'ImplicitTargetB1': implicitTargetB1,
      'EffectTriggerSpell1': effectTriggerSpell1,
      'EffectPointsPerCombo1': effectPointsPerCombo1,
      'EffectSpellClassMaskA1': effectSpellClassMaskA1,
      'EffectSpellClassMaskB1': effectSpellClassMaskB1,
      'EffectSpellClassMaskC1': effectSpellClassMaskC1,
      'EffectChainAmplitude1': effectChainAmplitude1,
      'EffectBonusCoefficient1': effectBonusCoefficient1,

      // === 效果2 ===
      'Effect2': effect2,
      'EffectDieSides2': effectDieSides2,
      'EffectRealPointsPerLevel2': effectRealPointsPerLevel2,
      'EffectBasePoints2': effectBasePoints2,
      'EffectMechanic2': effectMechanic2,
      'EffectAura2': effectAura2,
      'EffectAuraPeriod2': effectAuraPeriod2,
      'EffectAmplitude2': effectAmplitude2,
      'EffectChainTargets2': effectChainTargets2,
      'EffectItemType2': effectItemType2,
      'EffectMiscValue2': effectMiscValue2,
      'EffectMiscValueB2': effectMiscValueB2,
      'EffectRadiusIndex2': effectRadiusIndex2,
      'ImplicitTargetA2': implicitTargetA2,
      'ImplicitTargetB2': implicitTargetB2,
      'EffectTriggerSpell2': effectTriggerSpell2,
      'EffectPointsPerCombo2': effectPointsPerCombo2,
      'EffectSpellClassMaskA2': effectSpellClassMaskA2,
      'EffectSpellClassMaskB2': effectSpellClassMaskB2,
      'EffectSpellClassMaskC2': effectSpellClassMaskC2,
      'EffectChainAmplitude2': effectChainAmplitude2,
      'EffectBonusCoefficient2': effectBonusCoefficient2,

      // === 装备限制 ===
      'EquippedItemClass': equippedItemClass,
      'EquippedItemSubclass': equippedItemSubclass,
      'EquippedItemInvTypes': equippedItemInvTypes,

      // === 图腾/施法材料 ===
      'RequiredTotemCategoryID0': requiredTotemCategoryID0,
      'Totem0': totem0,
      'RequiredTotemCategoryID1': requiredTotemCategoryID1,
      'Totem1': totem1,
      'Reagent0': reagent0,
      'Reagent1': reagent1,
      'Reagent2': reagent2,
      'Reagent3': reagent3,
      'Reagent4': reagent4,
      'Reagent5': reagent5,
      'Reagent6': reagent6,
      'Reagent7': reagent7,
      'ReagentCount0': reagentCount0,
      'ReagentCount1': reagentCount1,
      'ReagentCount2': reagentCount2,
      'ReagentCount3': reagentCount3,
      'ReagentCount4': reagentCount4,
      'ReagentCount5': reagentCount5,
      'ReagentCount6': reagentCount6,
      'ReagentCount7': reagentCount7,

      // === 其他高级属性 ===
      'CasterAuraSpell': casterAuraSpell,
      'CumulativeAura': cumulativeAura,
      'MinFactionID': minFactionID,
      'MinReputation': minReputation,
      'ExcludeCasterAuraSpell': excludeCasterAuraSpell,
      'ExcludeCasterAuraState': excludeCasterAuraState,
      'ExcludeTargetAuraSpell': excludeTargetAuraSpell,
      'ExcludeTargetAuraState': excludeTargetAuraState,
      'SpellPriority': spellPriority,
      'ModalNextSpell': modalNextSpell,
      'RequiredAuraVision': requiredAuraVision,
      'TargetAuraSpell': targetAuraSpell,
      'StanceBarOrder': stanceBarOrder,
    };
  }

}
