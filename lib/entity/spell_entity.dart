/// 法术（技能）简要模型 - 列表展示用
class BriefSpellEntity {
  final int id;
  final String name;
  final String subtext;
  final String description;
  final String auraDescription;
  final String duration;
  final String textureFilename;

  const BriefSpellEntity({
    this.id = 0,
    this.name = '',
    this.subtext = '',
    this.description = '',
    this.auraDescription = '',
    this.duration = '',
    this.textureFilename = '',
  });

  factory BriefSpellEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellEntity(
      id: json['ID'] ?? 0,
      name: json['Name_lang_zhCN'] ?? json['Name_Lang_zhCN'] ?? '',
      subtext:
          json['NameSubtext_lang_zhCN'] ?? json['NameSubtext_Lang_zhCN'] ?? '',
      description:
          json['Description_lang_zhCN'] ?? json['Description_Lang_zhCN'] ?? '',
      auraDescription:
          json['AuraDescription_lang_zhCN'] ??
          json['AuraDescription_Lang_zhCN'] ??
          '',
      duration: '${json['Duration'] ?? ''}',
      textureFilename: json['TextureFilename'] ?? '',
    );
  }

  String get displayName => name;
  String get displaySubtext => subtext;

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name_lang_zhCN': name,
      'NameSubtext_lang_zhCN': subtext,
      'Description_lang_zhCN': description,
      'AuraDescription_lang_zhCN': auraDescription,
      'Duration': duration,
      'TextureFilename': textureFilename,
    };
  }
}

/// 法术（技能）完整模型 - 对应 foxy.dbc_spell 表
class SpellEntity {
  // === 编号 ===
  final int id;

  // === 基础文本 ===
  final String nameLangZhCN;
  final String nameSubtextLangZhCN;
  final String descriptionLangZhCN;
  final String auraDescriptionLangZhCN;
  final int nameLangFlags;
  final int nameSubtextLangFlags;
  final int descriptionLangFlags;
  final int auraDescriptionLangFlags;

  // === 图标/视觉 ===
  final int spellIconID;
  final int activeIconID;
  final int spellVisualID0;
  final int spellVisualID1;

  // === 分类/类型 ===
  final int category;
  final int schoolMask;
  final int mechanic;
  final int defenseType;
  final int dispelType;
  final int preventionType;

  // === 施法参数 ===
  final int castingTimeIndex;
  final int durationIndex;
  final int rangeIndex;
  final int spellDescriptionVariableID;

  // === 等级 ===
  final int baseLevel;
  final int spellLevel;
  final int maxLevel;
  final int spellDifficultyID;

  // === 冷却/恢复 ===
  final int startRecoveryCategory;
  final int startRecoveryTime;
  final int recoveryTime;
  final int categoryRecoveryTime;

  // === 目标 ===
  final int targetCreatureType;
  final int targets;
  final int maxTargets;
  final int maxTargetLevel;

  // === 状态 ===
  final int casterAuraState;
  final int targetAuraState;
  final int spellMissileID;
  final double speed;

  // === 需求 ===
  final int requiredAreasID;
  final int requiresSpellFocus;
  final int facingCasterFlags;

  // === 能量消耗 ===
  final int powerDisplayID;
  final int powerType;
  final int runeCostID;
  final int manaCost;
  final int manaCostPct;
  final int manaCostPerLevel;
  final int manaPerSecond;
  final int manaPerSecondPerLevel;

  // === 标志位 ===
  final int interruptFlags;
  final int auraInterruptFlags;
  final int channelInterruptFlags;
  final int attributes;
  final int attributesEx;
  final int attributesExB;
  final int attributesExC;
  final int attributesExD;
  final int attributesExE;
  final int attributesExF;
  final int attributesExG;

  // === 触发 ===
  final int procTypeMask;
  final int procChance;
  final int procCharges;

  // === 法术分类 ===
  final int spellClassSet;
  final int spellClassMask0;
  final int spellClassMask1;
  final int spellClassMask2;

  // === 变形 ===
  final int shapeshiftMask0;
  final int shapeshiftMask1;
  final int shapeshiftExclude0;
  final int shapeshiftExclude1;

  // === 效果0 ===
  final int effect0;
  final int effectDieSides0;
  final double effectRealPointsPerLevel0;
  final int effectBasePoints0;
  final int effectMechanic0;
  final int effectAura0;
  final int effectAuraPeriod0;
  final double effectAmplitude0;
  final int effectChainTargets0;
  final int effectItemType0;
  final int effectMiscValue0;
  final int effectMiscValueB0;
  final int effectRadiusIndex0;
  final int implicitTargetA0;
  final int implicitTargetB0;
  final int effectTriggerSpell0;
  final double effectPointsPerCombo0;
  final int effectSpellClassMaskA0;
  final int effectSpellClassMaskB0;
  final int effectSpellClassMaskC0;
  final double effectChainAmplitude0;
  final double effectBonusCoefficient0;

  // === 效果1 ===
  final int effect1;
  final int effectDieSides1;
  final double effectRealPointsPerLevel1;
  final int effectBasePoints1;
  final int effectMechanic1;
  final int effectAura1;
  final int effectAuraPeriod1;
  final double effectAmplitude1;
  final int effectChainTargets1;
  final int effectItemType1;
  final int effectMiscValue1;
  final int effectMiscValueB1;
  final int effectRadiusIndex1;
  final int implicitTargetA1;
  final int implicitTargetB1;
  final int effectTriggerSpell1;
  final double effectPointsPerCombo1;
  final int effectSpellClassMaskA1;
  final int effectSpellClassMaskB1;
  final int effectSpellClassMaskC1;
  final double effectChainAmplitude1;
  final double effectBonusCoefficient1;

  // === 效果2 ===
  final int effect2;
  final int effectDieSides2;
  final double effectRealPointsPerLevel2;
  final int effectBasePoints2;
  final int effectMechanic2;
  final int effectAura2;
  final int effectAuraPeriod2;
  final double effectAmplitude2;
  final int effectChainTargets2;
  final int effectItemType2;
  final int effectMiscValue2;
  final int effectMiscValueB2;
  final int effectRadiusIndex2;
  final int implicitTargetA2;
  final int implicitTargetB2;
  final int effectTriggerSpell2;
  final double effectPointsPerCombo2;
  final int effectSpellClassMaskA2;
  final int effectSpellClassMaskB2;
  final int effectSpellClassMaskC2;
  final double effectChainAmplitude2;
  final double effectBonusCoefficient2;

  // === 装备限制 ===
  final int equippedItemClass;
  final int equippedItemSubclass;
  final int equippedItemInvTypes;

  // === 图腾/施法材料 ===
  final int requiredTotemCategoryID0;
  final int totem0;
  final int requiredTotemCategoryID1;
  final int totem1;
  final int reagent0;
  final int reagent1;
  final int reagent2;
  final int reagent3;
  final int reagent4;
  final int reagent5;
  final int reagent6;
  final int reagent7;
  final int reagentCount0;
  final int reagentCount1;
  final int reagentCount2;
  final int reagentCount3;
  final int reagentCount4;
  final int reagentCount5;
  final int reagentCount6;
  final int reagentCount7;

  // === 其他高级属性 ===
  final int casterAuraSpell;
  final int cumulativeAura;
  final int minFactionID;
  final int minReputation;
  final int excludeCasterAuraSpell;
  final int excludeCasterAuraState;
  final int excludeTargetAuraSpell;
  final int excludeTargetAuraState;
  final int spellPriority;
  final int modalNextSpell;
  final int requiredAuraVision;
  final int targetAuraSpell;
  final int stanceBarOrder;

  const SpellEntity({
    this.id = 0,
    this.nameLangZhCN = '',
    this.nameSubtextLangZhCN = '',
    this.descriptionLangZhCN = '',
    this.auraDescriptionLangZhCN = '',
    this.nameLangFlags = 0,
    this.nameSubtextLangFlags = 0,
    this.descriptionLangFlags = 0,
    this.auraDescriptionLangFlags = 0,
    this.spellIconID = 0,
    this.activeIconID = 0,
    this.spellVisualID0 = 0,
    this.spellVisualID1 = 0,
    this.category = 0,
    this.schoolMask = 0,
    this.mechanic = 0,
    this.defenseType = 0,
    this.dispelType = 0,
    this.preventionType = 0,
    this.castingTimeIndex = 0,
    this.durationIndex = 0,
    this.rangeIndex = 0,
    this.spellDescriptionVariableID = 0,
    this.baseLevel = 0,
    this.spellLevel = 0,
    this.maxLevel = 0,
    this.spellDifficultyID = 0,
    this.startRecoveryCategory = 0,
    this.startRecoveryTime = 0,
    this.recoveryTime = 0,
    this.categoryRecoveryTime = 0,
    this.targetCreatureType = 0,
    this.targets = 0,
    this.maxTargets = 0,
    this.maxTargetLevel = 0,
    this.casterAuraState = 0,
    this.targetAuraState = 0,
    this.spellMissileID = 0,
    this.speed = 0.0,
    this.requiredAreasID = 0,
    this.requiresSpellFocus = 0,
    this.facingCasterFlags = 0,
    this.powerDisplayID = 0,
    this.powerType = 0,
    this.runeCostID = 0,
    this.manaCost = 0,
    this.manaCostPct = 0,
    this.manaCostPerLevel = 0,
    this.manaPerSecond = 0,
    this.manaPerSecondPerLevel = 0,
    this.interruptFlags = 0,
    this.auraInterruptFlags = 0,
    this.channelInterruptFlags = 0,
    this.attributes = 0,
    this.attributesEx = 0,
    this.attributesExB = 0,
    this.attributesExC = 0,
    this.attributesExD = 0,
    this.attributesExE = 0,
    this.attributesExF = 0,
    this.attributesExG = 0,
    this.procTypeMask = 0,
    this.procChance = 0,
    this.procCharges = 0,
    this.spellClassSet = 0,
    this.spellClassMask0 = 0,
    this.spellClassMask1 = 0,
    this.spellClassMask2 = 0,
    this.shapeshiftMask0 = 0,
    this.shapeshiftMask1 = 0,
    this.shapeshiftExclude0 = 0,
    this.shapeshiftExclude1 = 0,
    this.effect0 = 0,
    this.effectDieSides0 = 0,
    this.effectRealPointsPerLevel0 = 0.0,
    this.effectBasePoints0 = 0,
    this.effectMechanic0 = 0,
    this.effectAura0 = 0,
    this.effectAuraPeriod0 = 0,
    this.effectAmplitude0 = 0.0,
    this.effectChainTargets0 = 0,
    this.effectItemType0 = 0,
    this.effectMiscValue0 = 0,
    this.effectMiscValueB0 = 0,
    this.effectRadiusIndex0 = 0,
    this.implicitTargetA0 = 0,
    this.implicitTargetB0 = 0,
    this.effectTriggerSpell0 = 0,
    this.effectPointsPerCombo0 = 0.0,
    this.effectSpellClassMaskA0 = 0,
    this.effectSpellClassMaskB0 = 0,
    this.effectSpellClassMaskC0 = 0,
    this.effectChainAmplitude0 = 0.0,
    this.effectBonusCoefficient0 = 0.0,
    this.effect1 = 0,
    this.effectDieSides1 = 0,
    this.effectRealPointsPerLevel1 = 0.0,
    this.effectBasePoints1 = 0,
    this.effectMechanic1 = 0,
    this.effectAura1 = 0,
    this.effectAuraPeriod1 = 0,
    this.effectAmplitude1 = 0.0,
    this.effectChainTargets1 = 0,
    this.effectItemType1 = 0,
    this.effectMiscValue1 = 0,
    this.effectMiscValueB1 = 0,
    this.effectRadiusIndex1 = 0,
    this.implicitTargetA1 = 0,
    this.implicitTargetB1 = 0,
    this.effectTriggerSpell1 = 0,
    this.effectPointsPerCombo1 = 0.0,
    this.effectSpellClassMaskA1 = 0,
    this.effectSpellClassMaskB1 = 0,
    this.effectSpellClassMaskC1 = 0,
    this.effectChainAmplitude1 = 0.0,
    this.effectBonusCoefficient1 = 0.0,
    this.effect2 = 0,
    this.effectDieSides2 = 0,
    this.effectRealPointsPerLevel2 = 0.0,
    this.effectBasePoints2 = 0,
    this.effectMechanic2 = 0,
    this.effectAura2 = 0,
    this.effectAuraPeriod2 = 0,
    this.effectAmplitude2 = 0.0,
    this.effectChainTargets2 = 0,
    this.effectItemType2 = 0,
    this.effectMiscValue2 = 0,
    this.effectMiscValueB2 = 0,
    this.effectRadiusIndex2 = 0,
    this.implicitTargetA2 = 0,
    this.implicitTargetB2 = 0,
    this.effectTriggerSpell2 = 0,
    this.effectPointsPerCombo2 = 0.0,
    this.effectSpellClassMaskA2 = 0,
    this.effectSpellClassMaskB2 = 0,
    this.effectSpellClassMaskC2 = 0,
    this.effectChainAmplitude2 = 0.0,
    this.effectBonusCoefficient2 = 0.0,
    this.equippedItemClass = 0,
    this.equippedItemSubclass = 0,
    this.equippedItemInvTypes = 0,
    this.requiredTotemCategoryID0 = 0,
    this.totem0 = 0,
    this.requiredTotemCategoryID1 = 0,
    this.totem1 = 0,
    this.reagent0 = 0,
    this.reagent1 = 0,
    this.reagent2 = 0,
    this.reagent3 = 0,
    this.reagent4 = 0,
    this.reagent5 = 0,
    this.reagent6 = 0,
    this.reagent7 = 0,
    this.reagentCount0 = 0,
    this.reagentCount1 = 0,
    this.reagentCount2 = 0,
    this.reagentCount3 = 0,
    this.reagentCount4 = 0,
    this.reagentCount5 = 0,
    this.reagentCount6 = 0,
    this.reagentCount7 = 0,
    this.casterAuraSpell = 0,
    this.cumulativeAura = 0,
    this.minFactionID = 0,
    this.minReputation = 0,
    this.excludeCasterAuraSpell = 0,
    this.excludeCasterAuraState = 0,
    this.excludeTargetAuraSpell = 0,
    this.excludeTargetAuraState = 0,
    this.spellPriority = 0,
    this.modalNextSpell = 0,
    this.requiredAuraVision = 0,
    this.targetAuraSpell = 0,
    this.stanceBarOrder = 0,
  });

  factory SpellEntity.fromJson(Map<String, dynamic> json) {
    return SpellEntity(
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      nameSubtextLangZhCN: json['NameSubtext_lang_zhCN'] ?? '',
      descriptionLangZhCN: json['Description_lang_zhCN'] ?? '',
      auraDescriptionLangZhCN: json['AuraDescription_lang_zhCN'] ?? '',
      nameLangFlags: json['Name_lang_Flags'] ?? 0,
      nameSubtextLangFlags: json['NameSubtext_lang_Flags'] ?? 0,
      descriptionLangFlags: json['Description_lang_Flags'] ?? 0,
      auraDescriptionLangFlags: json['AuraDescription_lang_Flags'] ?? 0,
      spellIconID: json['SpellIconID'] ?? 0,
      activeIconID: json['ActiveIconID'] ?? 0,
      spellVisualID0: json['SpellVisualID0'] ?? 0,
      spellVisualID1: json['SpellVisualID1'] ?? 0,
      category: json['Category'] ?? 0,
      schoolMask: json['SchoolMask'] ?? 0,
      mechanic: json['Mechanic'] ?? 0,
      defenseType: json['DefenseType'] ?? 0,
      dispelType: json['DispelType'] ?? 0,
      preventionType: json['PreventionType'] ?? 0,
      castingTimeIndex: json['CastingTimeIndex'] ?? 0,
      durationIndex: json['DurationIndex'] ?? 0,
      rangeIndex: json['RangeIndex'] ?? 0,
      spellDescriptionVariableID: json['DescriptionVariablesID'] ?? 0,
      baseLevel: json['BaseLevel'] ?? 0,
      spellLevel: json['SpellLevel'] ?? 0,
      maxLevel: json['MaxLevel'] ?? 0,
      spellDifficultyID: json['Difficulty'] ?? 0,
      startRecoveryCategory: json['StartRecoveryCategory'] ?? 0,
      startRecoveryTime: json['StartRecoveryTime'] ?? 0,
      recoveryTime: json['RecoveryTime'] ?? 0,
      categoryRecoveryTime: json['CategoryRecoveryTime'] ?? 0,
      targetCreatureType: json['TargetCreatureType'] ?? 0,
      targets: json['Targets'] ?? 0,
      maxTargets: json['MaxTargets'] ?? 0,
      maxTargetLevel: json['MaxTargetLevel'] ?? 0,
      casterAuraState: json['CasterAuraState'] ?? 0,
      targetAuraState: json['TargetAuraState'] ?? 0,
      spellMissileID: json['SpellMissileID'] ?? 0,
      speed: json['Speed'] ?? 0.0,
      requiredAreasID: json['RequiredAreasID'] ?? 0,
      requiresSpellFocus: json['RequiresSpellFocus'] ?? 0,
      facingCasterFlags: json['FacingCasterFlags'] ?? 0,
      powerDisplayID: json['PowerDisplayID'] ?? 0,
      powerType: json['PowerType'] ?? 0,
      runeCostID: json['RuneCostID'] ?? 0,
      manaCost: json['ManaCost'] ?? 0,
      manaCostPct: json['ManaCostPct'] ?? 0,
      manaCostPerLevel: json['ManaCostPerLevel'] ?? 0,
      manaPerSecond: json['ManaPerSecond'] ?? 0,
      manaPerSecondPerLevel: json['ManaPerSecondPerLevel'] ?? 0,
      interruptFlags: json['InterruptFlags'] ?? 0,
      auraInterruptFlags: json['AuraInterruptFlags'] ?? 0,
      channelInterruptFlags: json['ChannelInterruptFlags'] ?? 0,
      attributes: json['Attributes'] ?? 0,
      attributesEx: json['AttributesEx'] ?? 0,
      attributesExB: json['AttributesExB'] ?? 0,
      attributesExC: json['AttributesExC'] ?? 0,
      attributesExD: json['AttributesExD'] ?? 0,
      attributesExE: json['AttributesExE'] ?? 0,
      attributesExF: json['AttributesExF'] ?? 0,
      attributesExG: json['AttributesExG'] ?? 0,
      procTypeMask: json['ProcTypeMask'] ?? 0,
      procChance: json['ProcChance'] ?? 0,
      procCharges: json['ProcCharges'] ?? 0,
      spellClassSet: json['SpellClassSet'] ?? 0,
      spellClassMask0: json['SpellClassMask0'] ?? 0,
      spellClassMask1: json['SpellClassMask1'] ?? 0,
      spellClassMask2: json['SpellClassMask2'] ?? 0,
      shapeshiftMask0: json['ShapeshiftMask0'] ?? 0,
      shapeshiftMask1: json['ShapeshiftMask1'] ?? 0,
      shapeshiftExclude0: json['ShapeshiftExclude0'] ?? 0,
      shapeshiftExclude1: json['ShapeshiftExclude1'] ?? 0,
      effect0: json['Effect0'] ?? 0,
      effectDieSides0: json['EffectDieSides0'] ?? 0,
      effectRealPointsPerLevel0:
          json['EffectRealPointsPerLevel0'] ?? 0.0,
      effectBasePoints0: json['EffectBasePoints0'] ?? 0,
      effectMechanic0: json['EffectMechanic0'] ?? 0,
      effectAura0: json['EffectAura0'] ?? 0,
      effectAuraPeriod0: json['EffectAuraPeriod0'] ?? 0,
      effectAmplitude0: json['EffectAmplitude0'] ?? 0.0,
      effectChainTargets0: json['EffectChainTargets0'] ?? 0,
      effectItemType0: json['EffectItemType0'] ?? 0,
      effectMiscValue0: json['EffectMiscValue0'] ?? 0,
      effectMiscValueB0: json['EffectMiscValueB0'] ?? 0,
      effectRadiusIndex0: json['EffectRadiusIndex0'] ?? 0,
      implicitTargetA0: json['ImplicitTargetA0'] ?? 0,
      implicitTargetB0: json['ImplicitTargetB0'] ?? 0,
      effectTriggerSpell0: json['EffectTriggerSpell0'] ?? 0,
      effectPointsPerCombo0:
          json['EffectPointsPerCombo0'] ?? 0.0,
      effectSpellClassMaskA0: json['EffectSpellClassMaskA0'] ?? 0,
      effectSpellClassMaskB0: json['EffectSpellClassMaskB0'] ?? 0,
      effectSpellClassMaskC0: json['EffectSpellClassMaskC0'] ?? 0,
      effectChainAmplitude0:
          json['EffectChainAmplitude0'] ?? 0.0,
      effectBonusCoefficient0:
          json['EffectBonusCoefficient0'] ?? 0.0,
      effect1: json['Effect1'] ?? 0,
      effectDieSides1: json['EffectDieSides1'] ?? 0,
      effectRealPointsPerLevel1:
          json['EffectRealPointsPerLevel1'] ?? 0.0,
      effectBasePoints1: json['EffectBasePoints1'] ?? 0,
      effectMechanic1: json['EffectMechanic1'] ?? 0,
      effectAura1: json['EffectAura1'] ?? 0,
      effectAuraPeriod1: json['EffectAuraPeriod1'] ?? 0,
      effectAmplitude1: json['EffectAmplitude1'] ?? 0.0,
      effectChainTargets1: json['EffectChainTargets1'] ?? 0,
      effectItemType1: json['EffectItemType1'] ?? 0,
      effectMiscValue1: json['EffectMiscValue1'] ?? 0,
      effectMiscValueB1: json['EffectMiscValueB1'] ?? 0,
      effectRadiusIndex1: json['EffectRadiusIndex1'] ?? 0,
      implicitTargetA1: json['ImplicitTargetA1'] ?? 0,
      implicitTargetB1: json['ImplicitTargetB1'] ?? 0,
      effectTriggerSpell1: json['EffectTriggerSpell1'] ?? 0,
      effectPointsPerCombo1:
          json['EffectPointsPerCombo1'] ?? 0.0,
      effectSpellClassMaskA1: json['EffectSpellClassMaskA1'] ?? 0,
      effectSpellClassMaskB1: json['EffectSpellClassMaskB1'] ?? 0,
      effectSpellClassMaskC1: json['EffectSpellClassMaskC1'] ?? 0,
      effectChainAmplitude1:
          json['EffectChainAmplitude1'] ?? 0.0,
      effectBonusCoefficient1:
          json['EffectBonusCoefficient1'] ?? 0.0,
      effect2: json['Effect2'] ?? 0,
      effectDieSides2: json['EffectDieSides2'] ?? 0,
      effectRealPointsPerLevel2:
          json['EffectRealPointsPerLevel2'] ?? 0.0,
      effectBasePoints2: json['EffectBasePoints2'] ?? 0,
      effectMechanic2: json['EffectMechanic2'] ?? 0,
      effectAura2: json['EffectAura2'] ?? 0,
      effectAuraPeriod2: json['EffectAuraPeriod2'] ?? 0,
      effectAmplitude2: json['EffectAmplitude2'] ?? 0.0,
      effectChainTargets2: json['EffectChainTargets2'] ?? 0,
      effectItemType2: json['EffectItemType2'] ?? 0,
      effectMiscValue2: json['EffectMiscValue2'] ?? 0,
      effectMiscValueB2: json['EffectMiscValueB2'] ?? 0,
      effectRadiusIndex2: json['EffectRadiusIndex2'] ?? 0,
      implicitTargetA2: json['ImplicitTargetA2'] ?? 0,
      implicitTargetB2: json['ImplicitTargetB2'] ?? 0,
      effectTriggerSpell2: json['EffectTriggerSpell2'] ?? 0,
      effectPointsPerCombo2:
          json['EffectPointsPerCombo2'] ?? 0.0,
      effectSpellClassMaskA2: json['EffectSpellClassMaskA2'] ?? 0,
      effectSpellClassMaskB2: json['EffectSpellClassMaskB2'] ?? 0,
      effectSpellClassMaskC2: json['EffectSpellClassMaskC2'] ?? 0,
      effectChainAmplitude2:
          json['EffectChainAmplitude2'] ?? 0.0,
      effectBonusCoefficient2:
          json['EffectBonusCoefficient2'] ?? 0.0,
      equippedItemClass: json['EquippedItemClass'] ?? 0,
      equippedItemSubclass: json['EquippedItemSubclass'] ?? 0,
      equippedItemInvTypes: json['EquippedItemInvTypes'] ?? 0,
      requiredTotemCategoryID0: json['RequiredTotemCategoryID0'] ?? 0,
      totem0: json['Totem0'] ?? 0,
      requiredTotemCategoryID1: json['RequiredTotemCategoryID1'] ?? 0,
      totem1: json['Totem1'] ?? 0,
      reagent0: json['Reagent0'] ?? 0,
      reagent1: json['Reagent1'] ?? 0,
      reagent2: json['Reagent2'] ?? 0,
      reagent3: json['Reagent3'] ?? 0,
      reagent4: json['Reagent4'] ?? 0,
      reagent5: json['Reagent5'] ?? 0,
      reagent6: json['Reagent6'] ?? 0,
      reagent7: json['Reagent7'] ?? 0,
      reagentCount0: json['ReagentCount0'] ?? 0,
      reagentCount1: json['ReagentCount1'] ?? 0,
      reagentCount2: json['ReagentCount2'] ?? 0,
      reagentCount3: json['ReagentCount3'] ?? 0,
      reagentCount4: json['ReagentCount4'] ?? 0,
      reagentCount5: json['ReagentCount5'] ?? 0,
      reagentCount6: json['ReagentCount6'] ?? 0,
      reagentCount7: json['ReagentCount7'] ?? 0,
      casterAuraSpell: json['CasterAuraSpell'] ?? 0,
      cumulativeAura: json['CumulativeAura'] ?? 0,
      minFactionID: json['MinFactionID'] ?? 0,
      minReputation: json['MinReputation'] ?? 0,
      excludeCasterAuraSpell: json['ExcludeCasterAuraSpell'] ?? 0,
      excludeCasterAuraState: json['ExcludeCasterAuraState'] ?? 0,
      excludeTargetAuraSpell: json['ExcludeTargetAuraSpell'] ?? 0,
      excludeTargetAuraState: json['ExcludeTargetAuraState'] ?? 0,
      spellPriority: json['SpellPriority'] ?? 0,
      modalNextSpell: json['ModalNextSpell'] ?? 0,
      requiredAuraVision: json['RequiredAuraVision'] ?? 0,
      targetAuraSpell: json['TargetAuraSpell'] ?? 0,
      stanceBarOrder: json['StanceBarOrder'] ?? 0,
    );
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
