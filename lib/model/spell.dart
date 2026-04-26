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

  BriefSpell.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    name = json['Name_Lang_zhCN'] ?? '';
    subtext = json['NameSubtext_Lang_zhCN'] ?? '';
    description = json['Description_Lang_zhCN'] ?? '';
    auraDescription = json['AuraDescription_Lang_zhCN'] ?? '';
    duration = json['Duration'] ?? '';
    textureFilename = json['TextureFilename'] ?? '';
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
  int nameLangMask = 0;
  int nameSubtextLangMask = 0;
  int descriptionLangMask = 0;
  int auraDescriptionLangMask = 0;

  // === 图标/视觉 ===
  int spellIconID = 0;
  int activeIconID = 0;
  int spellVisualID1 = 0;
  int spellVisualID2 = 0;

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
  double manaPerSecondPerLevel = 0;

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
  int spellClassMask1 = 0;
  int spellClassMask2 = 0;
  int spellClassMask3 = 0;

  // === 效果1 ===
  int effect1 = 0;
  int effectBasePoints1 = 0;
  int effectDieSides1 = 0;
  double effectRealPointsPerLevel1 = 0;
  int effectMechanic1 = 0;
  int effectChainTargets1 = 0;
  int effectAura1 = 0;
  double effectAuraPeriod1 = 0;
  int implicitTargetA1 = 0;
  int implicitTargetB1 = 0;
  int effectMiscValue1 = 0;
  int effectMiscValueB1 = 0;
  int effectRadiusIndex1 = 0;
  double effectMultipleValue1 = 0;
  double effectBonusMultiplier1 = 0;
  double effectChainAmplitude1 = 0;
  int effectItemType1 = 0;
  int effectTriggerSpell1 = 0;
  int effectPointsPerCombo1 = 0;
  int effectSpellClassMaskA1 = 0;
  int effectSpellClassMaskA2 = 0;
  int effectSpellClassMaskA3 = 0;
  int effectSpellClassMaskB1 = 0;
  int effectSpellClassMaskB2 = 0;
  int effectSpellClassMaskB3 = 0;

  // === 效果2 ===
  int effect2 = 0;
  int effectBasePoints2 = 0;
  int effectDieSides2 = 0;
  double effectRealPointsPerLevel2 = 0;
  int effectMechanic2 = 0;
  int effectChainTargets2 = 0;
  int effectAura2 = 0;
  double effectAuraPeriod2 = 0;
  int implicitTargetA2 = 0;
  int implicitTargetB2 = 0;
  int effectMiscValue2 = 0;
  int effectMiscValueB2 = 0;
  int effectRadiusIndex2 = 0;
  double effectMultipleValue2 = 0;
  double effectBonusMultiplier2 = 0;
  double effectChainAmplitude2 = 0;
  int effectItemType2 = 0;
  int effectTriggerSpell2 = 0;
  int effectPointsPerCombo2 = 0;
  int effectSpellClassMaskC1 = 0;
  int effectSpellClassMaskC2 = 0;
  int effectSpellClassMaskC3 = 0;

  // === 效果3 ===
  int effect3 = 0;
  int effectBasePoints3 = 0;
  int effectDieSides3 = 0;
  double effectRealPointsPerLevel3 = 0;
  int effectMechanic3 = 0;
  int effectChainTargets3 = 0;
  int effectAura3 = 0;
  double effectAuraPeriod3 = 0;
  int implicitTargetA3 = 0;
  int implicitTargetB3 = 0;
  int effectMiscValue3 = 0;
  int effectMiscValueB3 = 0;
  int effectRadiusIndex3 = 0;
  double effectMultipleValue3 = 0;
  double effectBonusMultiplier3 = 0;
  double effectChainAmplitude3 = 0;
  int effectItemType3 = 0;
  int effectTriggerSpell3 = 0;
  int effectPointsPerCombo3 = 0;

  // === 装备限制 ===
  int equippedItemClass = 0;
  int equippedItemSubclass = 0;
  int equippedItemInvTypes = 0;

  // === 图腾/施法材料 ===
  int requiredTotemCategoryID1 = 0;
  int totem1 = 0;
  int requiredTotemCategoryID2 = 0;
  int totem2 = 0;
  int reagent1 = 0;
  int reagent2 = 0;
  int reagent3 = 0;
  int reagent4 = 0;
  int reagent5 = 0;
  int reagent6 = 0;
  int reagent7 = 0;
  int reagent8 = 0;
  int reagentCount1 = 0;
  int reagentCount2 = 0;
  int reagentCount3 = 0;
  int reagentCount4 = 0;
  int reagentCount5 = 0;
  int reagentCount6 = 0;
  int reagentCount7 = 0;
  int reagentCount8 = 0;

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
  int shapeshiftMask = 0;
  int shapeshiftExclude = 0;
  int unk13 = 0;
  int unk15 = 0;

  Spell();

  Spell.fromJson(Map<String, dynamic> json) {
    // === 编号 ===
    id = json['ID'] ?? 0;

    // === 基础文本 ===
    nameLangZhCN = json['Name_Lang_zhCN'] ?? '';
    nameSubtextLangZhCN = json['NameSubtext_Lang_zhCN'] ?? '';
    descriptionLangZhCN = json['Description_Lang_zhCN'] ?? '';
    auraDescriptionLangZhCN = json['AuraDescription_Lang_zhCN'] ?? '';
    nameLangMask = json['Name_Lang_Mask'] ?? 0;
    nameSubtextLangMask = json['NameSubtext_Lang_Mask'] ?? 0;
    descriptionLangMask = json['Description_Lang_Mask'] ?? 0;
    auraDescriptionLangMask = json['AuraDescription_Lang_Mask'] ?? 0;

    // === 图标/视觉 ===
    spellIconID = json['SpellIconID'] ?? 0;
    activeIconID = json['ActiveIconID'] ?? 0;
    spellVisualID1 = json['SpellVisualID_1'] ?? 0;
    spellVisualID2 = json['SpellVisualID_2'] ?? 0;

    // === 分类/类型 ===
    category = json['Category'] ?? 0;
    schoolMask = json['SchoolMask'] ?? 0;
    mechanic = json['Mechanic'] ?? 0;
    defenseType = json['DefenseType'] ?? 0;
    dispelType = json['DispelType'] ?? 0;
    preventionType = json['PreventionType'] ?? 0;

    // === 施法参数 ===
    castingTimeIndex = json['CastingTimeIndex'] ?? 0;
    durationIndex = json['DurationIndex'] ?? 0;
    rangeIndex = json['RangeIndex'] ?? 0;
    spellDescriptionVariableID = json['SpellDescriptionVariableID'] ?? 0;

    // === 等级 ===
    baseLevel = json['BaseLevel'] ?? 0;
    spellLevel = json['SpellLevel'] ?? 0;
    maxLevel = json['MaxLevel'] ?? 0;
    spellDifficultyID = json['SpellDifficultyID'] ?? 0;

    // === 冷却/恢复 ===
    startRecoveryCategory = json['StartRecoveryCategory'] ?? 0;
    startRecoveryTime = json['StartRecoveryTime'] ?? 0;
    recoveryTime = json['RecoveryTime'] ?? 0;
    categoryRecoveryTime = json['CategoryRecoveryTime'] ?? 0;

    // === 目标 ===
    targetCreatureType = json['TargetCreatureType'] ?? 0;
    targets = json['Targets'] ?? 0;
    maxTargets = json['MaxTargets'] ?? 0;
    maxTargetLevel = json['MaxTargetLevel'] ?? 0;

    // === 状态 ===
    casterAuraState = json['CasterAuraState'] ?? 0;
    targetAuraState = json['TargetAuraState'] ?? 0;
    spellMissileID = json['SpellMissileID'] ?? 0;
    speed = json['Speed'] ?? 0;

    // === 需求 ===
    requiredAreasID = json['RequiredAreasID'] ?? 0;
    requiresSpellFocus = json['RequiresSpellFocus'] ?? 0;
    facingCasterFlags = json['FacingCasterFlags'] ?? 0;

    // === 能量消耗 ===
    powerDisplayID = json['PowerDisplayID'] ?? 0;
    powerType = json['PowerType'] ?? 0;
    runeCostID = json['RuneCostID'] ?? 0;
    manaCost = json['ManaCost'] ?? 0;
    manaCostPct = json['ManaCostPct'] ?? 0;
    manaCostPerLevel = json['ManaCostPerLevel'] ?? 0;
    manaPerSecond = json['ManaPerSecond'] ?? 0;
    manaPerSecondPerLevel = json['ManaPerSecondPerLevel'] ?? 0;

    // === 标志位 ===
    interruptFlags = json['InterruptFlags'] ?? 0;
    auraInterruptFlags = json['AuraInterruptFlags'] ?? 0;
    channelInterruptFlags = json['ChannelInterruptFlags'] ?? 0;
    attributes = json['Attributes'] ?? 0;
    attributesEx = json['AttributesEx'] ?? 0;
    attributesExB = json['AttributesExB'] ?? 0;
    attributesExC = json['AttributesExC'] ?? 0;
    attributesExD = json['AttributesExD'] ?? 0;
    attributesExE = json['AttributesExE'] ?? 0;
    attributesExF = json['AttributesExF'] ?? 0;
    attributesExG = json['AttributesExG'] ?? 0;

    // === 触发 ===
    procTypeMask = json['ProcTypeMask'] ?? 0;
    procChance = json['ProcChance'] ?? 0;
    procCharges = json['ProcCharges'] ?? 0;

    // === 法术分类 ===
    spellClassSet = json['SpellClassSet'] ?? 0;
    spellClassMask1 = json['SpellClassMask_1'] ?? 0;
    spellClassMask2 = json['SpellClassMask_2'] ?? 0;
    spellClassMask3 = json['SpellClassMask_3'] ?? 0;

    // === 效果1 ===
    effect1 = json['Effect_1'] ?? 0;
    effectBasePoints1 = json['EffectBasePoints_1'] ?? 0;
    effectDieSides1 = json['EffectDieSides_1'] ?? 0;
    effectRealPointsPerLevel1 = json['EffectRealPointsPerLevel_1'] ?? 0;
    effectMechanic1 = json['EffectMechanic_1'] ?? 0;
    effectChainTargets1 = json['EffectChainTargets_1'] ?? 0;
    effectAura1 = json['EffectAura_1'] ?? 0;
    effectAuraPeriod1 = json['EffectAuraPeriod_1'] ?? 0;
    implicitTargetA1 = json['ImplicitTargetA_1'] ?? 0;
    implicitTargetB1 = json['ImplicitTargetB_1'] ?? 0;
    effectMiscValue1 = json['EffectMiscValue_1'] ?? 0;
    effectMiscValueB1 = json['EffectMiscValueB_1'] ?? 0;
    effectRadiusIndex1 = json['EffectRadiusIndex_1'] ?? 0;
    effectMultipleValue1 = json['EffectMultipleValue_1'] ?? 0;
    effectBonusMultiplier1 = json['EffectBonusMultiplier_1'] ?? 0;
    effectChainAmplitude1 = json['EffectChainAmplitude_1'] ?? 0;
    effectItemType1 = json['EffectItemType_1'] ?? 0;
    effectTriggerSpell1 = json['EffectTriggerSpell_1'] ?? 0;
    effectPointsPerCombo1 = json['EffectPointsPerCombo_1'] ?? 0;
    effectSpellClassMaskA1 = json['EffectSpellClassMaskA_1'] ?? 0;
    effectSpellClassMaskA2 = json['EffectSpellClassMaskA_2'] ?? 0;
    effectSpellClassMaskA3 = json['EffectSpellClassMaskA_3'] ?? 0;
    effectSpellClassMaskB1 = json['EffectSpellClassMaskB_1'] ?? 0;
    effectSpellClassMaskB2 = json['EffectSpellClassMaskB_2'] ?? 0;
    effectSpellClassMaskB3 = json['EffectSpellClassMaskB_3'] ?? 0;

    // === 效果2 ===
    effect2 = json['Effect_2'] ?? 0;
    effectBasePoints2 = json['EffectBasePoints_2'] ?? 0;
    effectDieSides2 = json['EffectDieSides_2'] ?? 0;
    effectRealPointsPerLevel2 = json['EffectRealPointsPerLevel_2'] ?? 0;
    effectMechanic2 = json['EffectMechanic_2'] ?? 0;
    effectChainTargets2 = json['EffectChainTargets_2'] ?? 0;
    effectAura2 = json['EffectAura_2'] ?? 0;
    effectAuraPeriod2 = json['EffectAuraPeriod_2'] ?? 0;
    implicitTargetA2 = json['ImplicitTargetA_2'] ?? 0;
    implicitTargetB2 = json['ImplicitTargetB_2'] ?? 0;
    effectMiscValue2 = json['EffectMiscValue_2'] ?? 0;
    effectMiscValueB2 = json['EffectMiscValueB_2'] ?? 0;
    effectRadiusIndex2 = json['EffectRadiusIndex_2'] ?? 0;
    effectMultipleValue2 = json['EffectMultipleValue_2'] ?? 0;
    effectBonusMultiplier2 = json['EffectBonusMultiplier_2'] ?? 0;
    effectChainAmplitude2 = json['EffectChainAmplitude_2'] ?? 0;
    effectItemType2 = json['EffectItemType_2'] ?? 0;
    effectTriggerSpell2 = json['EffectTriggerSpell_2'] ?? 0;
    effectPointsPerCombo2 = json['EffectPointsPerCombo_2'] ?? 0;
    effectSpellClassMaskC1 = json['EffectSpellClassMaskC_1'] ?? 0;
    effectSpellClassMaskC2 = json['EffectSpellClassMaskC_2'] ?? 0;
    effectSpellClassMaskC3 = json['EffectSpellClassMaskC_3'] ?? 0;

    // === 效果3 ===
    effect3 = json['Effect_3'] ?? 0;
    effectBasePoints3 = json['EffectBasePoints_3'] ?? 0;
    effectDieSides3 = json['EffectDieSides_3'] ?? 0;
    effectRealPointsPerLevel3 = json['EffectRealPointsPerLevel_3'] ?? 0;
    effectMechanic3 = json['EffectMechanic_3'] ?? 0;
    effectChainTargets3 = json['EffectChainTargets_3'] ?? 0;
    effectAura3 = json['EffectAura_3'] ?? 0;
    effectAuraPeriod3 = json['EffectAuraPeriod_3'] ?? 0;
    implicitTargetA3 = json['ImplicitTargetA_3'] ?? 0;
    implicitTargetB3 = json['ImplicitTargetB_3'] ?? 0;
    effectMiscValue3 = json['EffectMiscValue_3'] ?? 0;
    effectMiscValueB3 = json['EffectMiscValueB_3'] ?? 0;
    effectRadiusIndex3 = json['EffectRadiusIndex_3'] ?? 0;
    effectMultipleValue3 = json['EffectMultipleValue_3'] ?? 0;
    effectBonusMultiplier3 = json['EffectBonusMultiplier_3'] ?? 0;
    effectChainAmplitude3 = json['EffectChainAmplitude_3'] ?? 0;
    effectItemType3 = json['EffectItemType_3'] ?? 0;
    effectTriggerSpell3 = json['EffectTriggerSpell_3'] ?? 0;
    effectPointsPerCombo3 = json['EffectPointsPerCombo_3'] ?? 0;

    // === 装备限制 ===
    equippedItemClass = json['EquippedItemClass'] ?? 0;
    equippedItemSubclass = json['EquippedItemSubclass'] ?? 0;
    equippedItemInvTypes = json['EquippedItemInvTypes'] ?? 0;

    // === 图腾/施法材料 ===
    requiredTotemCategoryID1 = json['RequiredTotemCategoryID_1'] ?? 0;
    totem1 = json['Totem_1'] ?? 0;
    requiredTotemCategoryID2 = json['RequiredTotemCategoryID_2'] ?? 0;
    totem2 = json['Totem_2'] ?? 0;
    reagent1 = json['Reagent_1'] ?? 0;
    reagent2 = json['Reagent_2'] ?? 0;
    reagent3 = json['Reagent_3'] ?? 0;
    reagent4 = json['Reagent_4'] ?? 0;
    reagent5 = json['Reagent_5'] ?? 0;
    reagent6 = json['Reagent_6'] ?? 0;
    reagent7 = json['Reagent_7'] ?? 0;
    reagent8 = json['Reagent_8'] ?? 0;
    reagentCount1 = json['ReagentCount_1'] ?? 0;
    reagentCount2 = json['ReagentCount_2'] ?? 0;
    reagentCount3 = json['ReagentCount_3'] ?? 0;
    reagentCount4 = json['ReagentCount_4'] ?? 0;
    reagentCount5 = json['ReagentCount_5'] ?? 0;
    reagentCount6 = json['ReagentCount_6'] ?? 0;
    reagentCount7 = json['ReagentCount_7'] ?? 0;
    reagentCount8 = json['ReagentCount_8'] ?? 0;

    // === 其他高级属性 ===
    casterAuraSpell = json['CasterAuraSpell'] ?? 0;
    cumulativeAura = json['CumulativeAura'] ?? 0;
    minFactionID = json['MinFactionID'] ?? 0;
    minReputation = json['MinReputation'] ?? 0;
    excludeCasterAuraSpell = json['ExcludeCasterAuraSpell'] ?? 0;
    excludeCasterAuraState = json['ExcludeCasterAuraState'] ?? 0;
    excludeTargetAuraSpell = json['ExcludeTargetAuraSpell'] ?? 0;
    excludeTargetAuraState = json['ExcludeTargetAuraState'] ?? 0;
    spellPriority = json['SpellPriority'] ?? 0;
    modalNextSpell = json['ModalNextSpell'] ?? 0;
    requiredAuraVision = json['RequiredAuraVision'] ?? 0;
    targetAuraSpell = json['TargetAuraSpell'] ?? 0;
    stanceBarOrder = json['StanceBarOrder'] ?? 0;
    shapeshiftMask = json['ShapeshiftMask'] ?? 0;
    shapeshiftExclude = json['ShapeshiftExclude'] ?? 0;
    unk13 = json['Unk_13'] ?? 0;
    unk15 = json['Unk_15'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      // === 编号 ===
      'ID': id,

      // === 基础文本 ===
      'Name_Lang_zhCN': nameLangZhCN,
      'NameSubtext_Lang_zhCN': nameSubtextLangZhCN,
      'Description_Lang_zhCN': descriptionLangZhCN,
      'AuraDescription_Lang_zhCN': auraDescriptionLangZhCN,
      'Name_Lang_Mask': nameLangMask,
      'NameSubtext_Lang_Mask': nameSubtextLangMask,
      'Description_Lang_Mask': descriptionLangMask,
      'AuraDescription_Lang_Mask': auraDescriptionLangMask,

      // === 图标/视觉 ===
      'SpellIconID': spellIconID,
      'ActiveIconID': activeIconID,
      'SpellVisualID_1': spellVisualID1,
      'SpellVisualID_2': spellVisualID2,

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
      'SpellDescriptionVariableID': spellDescriptionVariableID,

      // === 等级 ===
      'BaseLevel': baseLevel,
      'SpellLevel': spellLevel,
      'MaxLevel': maxLevel,
      'SpellDifficultyID': spellDifficultyID,

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
      'SpellClassMask_1': spellClassMask1,
      'SpellClassMask_2': spellClassMask2,
      'SpellClassMask_3': spellClassMask3,

      // === 效果1 ===
      'Effect_1': effect1,
      'EffectBasePoints_1': effectBasePoints1,
      'EffectDieSides_1': effectDieSides1,
      'EffectRealPointsPerLevel_1': effectRealPointsPerLevel1,
      'EffectMechanic_1': effectMechanic1,
      'EffectChainTargets_1': effectChainTargets1,
      'EffectAura_1': effectAura1,
      'EffectAuraPeriod_1': effectAuraPeriod1,
      'ImplicitTargetA_1': implicitTargetA1,
      'ImplicitTargetB_1': implicitTargetB1,
      'EffectMiscValue_1': effectMiscValue1,
      'EffectMiscValueB_1': effectMiscValueB1,
      'EffectRadiusIndex_1': effectRadiusIndex1,
      'EffectMultipleValue_1': effectMultipleValue1,
      'EffectBonusMultiplier_1': effectBonusMultiplier1,
      'EffectChainAmplitude_1': effectChainAmplitude1,
      'EffectItemType_1': effectItemType1,
      'EffectTriggerSpell_1': effectTriggerSpell1,
      'EffectPointsPerCombo_1': effectPointsPerCombo1,
      'EffectSpellClassMaskA_1': effectSpellClassMaskA1,
      'EffectSpellClassMaskA_2': effectSpellClassMaskA2,
      'EffectSpellClassMaskA_3': effectSpellClassMaskA3,
      'EffectSpellClassMaskB_1': effectSpellClassMaskB1,
      'EffectSpellClassMaskB_2': effectSpellClassMaskB2,
      'EffectSpellClassMaskB_3': effectSpellClassMaskB3,

      // === 效果2 ===
      'Effect_2': effect2,
      'EffectBasePoints_2': effectBasePoints2,
      'EffectDieSides_2': effectDieSides2,
      'EffectRealPointsPerLevel_2': effectRealPointsPerLevel2,
      'EffectMechanic_2': effectMechanic2,
      'EffectChainTargets_2': effectChainTargets2,
      'EffectAura_2': effectAura2,
      'EffectAuraPeriod_2': effectAuraPeriod2,
      'ImplicitTargetA_2': implicitTargetA2,
      'ImplicitTargetB_2': implicitTargetB2,
      'EffectMiscValue_2': effectMiscValue2,
      'EffectMiscValueB_2': effectMiscValueB2,
      'EffectRadiusIndex_2': effectRadiusIndex2,
      'EffectMultipleValue_2': effectMultipleValue2,
      'EffectBonusMultiplier_2': effectBonusMultiplier2,
      'EffectChainAmplitude_2': effectChainAmplitude2,
      'EffectItemType_2': effectItemType2,
      'EffectTriggerSpell_2': effectTriggerSpell2,
      'EffectPointsPerCombo_2': effectPointsPerCombo2,
      'EffectSpellClassMaskC_1': effectSpellClassMaskC1,
      'EffectSpellClassMaskC_2': effectSpellClassMaskC2,
      'EffectSpellClassMaskC_3': effectSpellClassMaskC3,

      // === 效果3 ===
      'Effect_3': effect3,
      'EffectBasePoints_3': effectBasePoints3,
      'EffectDieSides_3': effectDieSides3,
      'EffectRealPointsPerLevel_3': effectRealPointsPerLevel3,
      'EffectMechanic_3': effectMechanic3,
      'EffectChainTargets_3': effectChainTargets3,
      'EffectAura_3': effectAura3,
      'EffectAuraPeriod_3': effectAuraPeriod3,
      'ImplicitTargetA_3': implicitTargetA3,
      'ImplicitTargetB_3': implicitTargetB3,
      'EffectMiscValue_3': effectMiscValue3,
      'EffectMiscValueB_3': effectMiscValueB3,
      'EffectRadiusIndex_3': effectRadiusIndex3,
      'EffectMultipleValue_3': effectMultipleValue3,
      'EffectBonusMultiplier_3': effectBonusMultiplier3,
      'EffectChainAmplitude_3': effectChainAmplitude3,
      'EffectItemType_3': effectItemType3,
      'EffectTriggerSpell_3': effectTriggerSpell3,
      'EffectPointsPerCombo_3': effectPointsPerCombo3,

      // === 装备限制 ===
      'EquippedItemClass': equippedItemClass,
      'EquippedItemSubclass': equippedItemSubclass,
      'EquippedItemInvTypes': equippedItemInvTypes,

      // === 图腾/施法材料 ===
      'RequiredTotemCategoryID_1': requiredTotemCategoryID1,
      'Totem_1': totem1,
      'RequiredTotemCategoryID_2': requiredTotemCategoryID2,
      'Totem_2': totem2,
      'Reagent_1': reagent1,
      'Reagent_2': reagent2,
      'Reagent_3': reagent3,
      'Reagent_4': reagent4,
      'Reagent_5': reagent5,
      'Reagent_6': reagent6,
      'Reagent_7': reagent7,
      'Reagent_8': reagent8,
      'ReagentCount_1': reagentCount1,
      'ReagentCount_2': reagentCount2,
      'ReagentCount_3': reagentCount3,
      'ReagentCount_4': reagentCount4,
      'ReagentCount_5': reagentCount5,
      'ReagentCount_6': reagentCount6,
      'ReagentCount_7': reagentCount7,
      'ReagentCount_8': reagentCount8,

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
      'ShapeshiftMask': shapeshiftMask,
      'ShapeshiftExclude': shapeshiftExclude,
      'Unk_13': unk13,
      'Unk_15': unk15,
    };
  }

  Spell copyWith({int? id}) {
    return Spell()..id = id ?? this.id;
  }
}
