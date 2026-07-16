/// 法术（技能）简要模型 - 列表展示用
class BriefSpellEntity {
  final int id;
  final String name;
  final String subtext;
  final String localeName;
  final String localeSubtext;
  final String description;
  final String localeDescription;
  final String auraDescription;
  final String localeAuraDescription;
  final String textureFilename;

  const BriefSpellEntity({
    this.id = 0,
    this.name = '',
    this.subtext = '',
    this.localeName = '',
    this.localeSubtext = '',
    this.description = '',
    this.localeDescription = '',
    this.auraDescription = '',
    this.localeAuraDescription = '',
    this.textureFilename = '',
  });

  factory BriefSpellEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellEntity(
      id: json['ID'] ?? 0,
      name: json['Name_lang_enUS'] ?? '',
      subtext: json['NameSubtext_lang_enUS'] ?? '',
      localeName: json['Name_lang_zhCN'] ?? '',
      localeSubtext: json['NameSubtext_lang_zhCN'] ?? '',
      description: json['Description_lang_enUS'] ?? '',
      localeDescription: json['Description_lang_zhCN'] ?? '',
      auraDescription: json['AuraDescription_lang_enUS'] ?? '',
      localeAuraDescription: json['AuraDescription_lang_zhCN'] ?? '',
      textureFilename: json['TextureFilename'] ?? '',
    );
  }

  String get displayAuraDescription => localeAuraDescription.isNotEmpty
      ? localeAuraDescription
      : auraDescription;
  String get displayDescription =>
      localeDescription.isNotEmpty ? localeDescription : description;
  String get displayName => localeName.isNotEmpty ? localeName : name;
  String get displaySubtext =>
      localeSubtext.isNotEmpty ? localeSubtext : subtext;

  BriefSpellEntity copyWith({
    int? id,
    String? name,
    String? subtext,
    String? localeName,
    String? localeSubtext,
    String? description,
    String? localeDescription,
    String? auraDescription,
    String? localeAuraDescription,
    String? textureFilename,
  }) {
    return BriefSpellEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      subtext: subtext ?? this.subtext,
      localeName: localeName ?? this.localeName,
      localeSubtext: localeSubtext ?? this.localeSubtext,
      description: description ?? this.description,
      localeDescription: localeDescription ?? this.localeDescription,
      auraDescription: auraDescription ?? this.auraDescription,
      localeAuraDescription:
          localeAuraDescription ?? this.localeAuraDescription,
      textureFilename: textureFilename ?? this.textureFilename,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name_lang_enUS': name,
      'NameSubtext_lang_enUS': subtext,
      'Name_lang_zhCN': localeName,
      'NameSubtext_lang_zhCN': localeSubtext,
      'Description_lang_enUS': description,
      'Description_lang_zhCN': localeDescription,
      'AuraDescription_lang_enUS': auraDescription,
      'AuraDescription_lang_zhCN': localeAuraDescription,
      'TextureFilename': textureFilename,
    };
  }
}

/// 法术（技能）完整模型 - 对应 foxy.dbc_spell 表
class SpellEntity {
  final int id;
  final int category;
  final int dispelType;
  final int mechanic;
  final int attributes;
  final int attributesEx;
  final int attributesExB;
  final int attributesExC;
  final int attributesExD;
  final int attributesExE;
  final int attributesExF;
  final int attributesExG;
  final int shapeshiftMask0;
  final int shapeshiftMask1;
  final int shapeshiftExclude0;
  final int shapeshiftExclude1;
  final int targets;
  final int targetCreatureType;
  final int requiresSpellFocus;
  final int facingCasterFlags;
  final int casterAuraState;
  final int targetAuraState;
  final int excludeCasterAuraState;
  final int excludeTargetAuraState;
  final int casterAuraSpell;
  final int targetAuraSpell;
  final int excludeCasterAuraSpell;
  final int excludeTargetAuraSpell;
  final int castingTimeIndex;
  final int recoveryTime;
  final int categoryRecoveryTime;
  final int interruptFlags;
  final int auraInterruptFlags;
  final int channelInterruptFlags;
  final int procTypeMask;
  final int procChance;
  final int procCharges;
  final int maxLevel;
  final int baseLevel;
  final int spellLevel;
  final int durationIndex;
  final int powerType;
  final int manaCost;
  final int manaCostPerLevel;
  final int manaPerSecond;
  final int manaPerSecondPerLevel;
  final int rangeIndex;
  final double speed;
  final int modalNextSpell;
  final int cumulativeAura;
  final int totem0;
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
  final int equippedItemClass;
  final int equippedItemSubclass;
  final int equippedItemInvTypes;
  final int effect0;
  final int effect1;
  final int effect2;
  final int effectDieSides0;
  final int effectDieSides1;
  final int effectDieSides2;
  final double effectRealPointsPerLevel0;
  final double effectRealPointsPerLevel1;
  final double effectRealPointsPerLevel2;
  final int effectBasePoints0;
  final int effectBasePoints1;
  final int effectBasePoints2;
  final int effectMechanic0;
  final int effectMechanic1;
  final int effectMechanic2;
  final int implicitTargetA0;
  final int implicitTargetA1;
  final int implicitTargetA2;
  final int implicitTargetB0;
  final int implicitTargetB1;
  final int implicitTargetB2;
  final int effectRadiusIndex0;
  final int effectRadiusIndex1;
  final int effectRadiusIndex2;
  final int effectAura0;
  final int effectAura1;
  final int effectAura2;
  final int effectAuraPeriod0;
  final int effectAuraPeriod1;
  final int effectAuraPeriod2;
  final double effectAmplitude0;
  final double effectAmplitude1;
  final double effectAmplitude2;
  final int effectChainTargets0;
  final int effectChainTargets1;
  final int effectChainTargets2;
  final int effectItemType0;
  final int effectItemType1;
  final int effectItemType2;
  final int effectMiscValue0;
  final int effectMiscValue1;
  final int effectMiscValue2;
  final int effectMiscValueB0;
  final int effectMiscValueB1;
  final int effectMiscValueB2;
  final int effectTriggerSpell0;
  final int effectTriggerSpell1;
  final int effectTriggerSpell2;
  final double effectPointsPerCombo0;
  final double effectPointsPerCombo1;
  final double effectPointsPerCombo2;
  final int effectSpellClassMaskA0;
  final int effectSpellClassMaskA1;
  final int effectSpellClassMaskA2;
  final int effectSpellClassMaskB0;
  final int effectSpellClassMaskB1;
  final int effectSpellClassMaskB2;
  final int effectSpellClassMaskC0;
  final int effectSpellClassMaskC1;
  final int effectSpellClassMaskC2;
  final int spellVisualID0;
  final int spellVisualID1;
  final int spellIconID;
  final int activeIconID;
  final int spellPriority;
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
  final String nameSubtextLangEnUS;
  final String nameSubtextLangKoKR;
  final String nameSubtextLangFrFR;
  final String nameSubtextLangDeDE;
  final String nameSubtextLangZhCN;
  final String nameSubtextLangZhTW;
  final String nameSubtextLangEsES;
  final String nameSubtextLangEsMX;
  final String nameSubtextLangRuRU;
  final String nameSubtextLangJaJP;
  final String nameSubtextLangPtPT;
  final String nameSubtextLangPtBR;
  final String nameSubtextLangItIT;
  final String nameSubtextLangUnk1;
  final String nameSubtextLangUnk2;
  final String nameSubtextLangUnk3;
  final int nameSubtextLangFlags;
  final String descriptionLangEnUS;
  final String descriptionLangKoKR;
  final String descriptionLangFrFR;
  final String descriptionLangDeDE;
  final String descriptionLangZhCN;
  final String descriptionLangZhTW;
  final String descriptionLangEsES;
  final String descriptionLangEsMX;
  final String descriptionLangRuRU;
  final String descriptionLangJaJP;
  final String descriptionLangPtPT;
  final String descriptionLangPtBR;
  final String descriptionLangItIT;
  final String descriptionLangUnk1;
  final String descriptionLangUnk2;
  final String descriptionLangUnk3;
  final int descriptionLangFlags;
  final String auraDescriptionLangEnUS;
  final String auraDescriptionLangKoKR;
  final String auraDescriptionLangFrFR;
  final String auraDescriptionLangDeDE;
  final String auraDescriptionLangZhCN;
  final String auraDescriptionLangZhTW;
  final String auraDescriptionLangEsES;
  final String auraDescriptionLangEsMX;
  final String auraDescriptionLangRuRU;
  final String auraDescriptionLangJaJP;
  final String auraDescriptionLangPtPT;
  final String auraDescriptionLangPtBR;
  final String auraDescriptionLangItIT;
  final String auraDescriptionLangUnk1;
  final String auraDescriptionLangUnk2;
  final String auraDescriptionLangUnk3;
  final int auraDescriptionLangFlags;
  final int manaCostPct;
  final int startRecoveryCategory;
  final int startRecoveryTime;
  final int maxTargetLevel;
  final int spellClassSet;
  final int spellClassMask0;
  final int spellClassMask1;
  final int spellClassMask2;
  final int maxTargets;
  final int defenseType;
  final int preventionType;
  final int stanceBarOrder;
  final double effectChainAmplitude0;
  final double effectChainAmplitude1;
  final double effectChainAmplitude2;
  final int minFactionID;
  final int minReputation;
  final int requiredAuraVision;
  final int requiredTotemCategoryID0;
  final int requiredTotemCategoryID1;
  final int requiredAreasID;
  final int schoolMask;
  final int runeCostID;
  final int spellMissileID;
  final int powerDisplayID;
  final double effectBonusCoefficient0;
  final double effectBonusCoefficient1;
  final double effectBonusCoefficient2;
  final int spellDescriptionVariableID;
  final int spellDifficultyID;

  const SpellEntity({
    this.id = 0,
    this.category = 0,
    this.dispelType = 0,
    this.mechanic = 0,
    this.attributes = 0,
    this.attributesEx = 0,
    this.attributesExB = 0,
    this.attributesExC = 0,
    this.attributesExD = 0,
    this.attributesExE = 0,
    this.attributesExF = 0,
    this.attributesExG = 0,
    this.shapeshiftMask0 = 0,
    this.shapeshiftMask1 = 0,
    this.shapeshiftExclude0 = 0,
    this.shapeshiftExclude1 = 0,
    this.targets = 0,
    this.targetCreatureType = 0,
    this.requiresSpellFocus = 0,
    this.facingCasterFlags = 0,
    this.casterAuraState = 0,
    this.targetAuraState = 0,
    this.excludeCasterAuraState = 0,
    this.excludeTargetAuraState = 0,
    this.casterAuraSpell = 0,
    this.targetAuraSpell = 0,
    this.excludeCasterAuraSpell = 0,
    this.excludeTargetAuraSpell = 0,
    this.castingTimeIndex = 0,
    this.recoveryTime = 0,
    this.categoryRecoveryTime = 0,
    this.interruptFlags = 0,
    this.auraInterruptFlags = 0,
    this.channelInterruptFlags = 0,
    this.procTypeMask = 0,
    this.procChance = 0,
    this.procCharges = 0,
    this.maxLevel = 0,
    this.baseLevel = 0,
    this.spellLevel = 0,
    this.durationIndex = 0,
    this.powerType = 0,
    this.manaCost = 0,
    this.manaCostPerLevel = 0,
    this.manaPerSecond = 0,
    this.manaPerSecondPerLevel = 0,
    this.rangeIndex = 0,
    this.speed = 0.0,
    this.modalNextSpell = 0,
    this.cumulativeAura = 0,
    this.totem0 = 0,
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
    this.equippedItemClass = 0,
    this.equippedItemSubclass = 0,
    this.equippedItemInvTypes = 0,
    this.effect0 = 0,
    this.effect1 = 0,
    this.effect2 = 0,
    this.effectDieSides0 = 0,
    this.effectDieSides1 = 0,
    this.effectDieSides2 = 0,
    this.effectRealPointsPerLevel0 = 0.0,
    this.effectRealPointsPerLevel1 = 0.0,
    this.effectRealPointsPerLevel2 = 0.0,
    this.effectBasePoints0 = 0,
    this.effectBasePoints1 = 0,
    this.effectBasePoints2 = 0,
    this.effectMechanic0 = 0,
    this.effectMechanic1 = 0,
    this.effectMechanic2 = 0,
    this.implicitTargetA0 = 0,
    this.implicitTargetA1 = 0,
    this.implicitTargetA2 = 0,
    this.implicitTargetB0 = 0,
    this.implicitTargetB1 = 0,
    this.implicitTargetB2 = 0,
    this.effectRadiusIndex0 = 0,
    this.effectRadiusIndex1 = 0,
    this.effectRadiusIndex2 = 0,
    this.effectAura0 = 0,
    this.effectAura1 = 0,
    this.effectAura2 = 0,
    this.effectAuraPeriod0 = 0,
    this.effectAuraPeriod1 = 0,
    this.effectAuraPeriod2 = 0,
    this.effectAmplitude0 = 0.0,
    this.effectAmplitude1 = 0.0,
    this.effectAmplitude2 = 0.0,
    this.effectChainTargets0 = 0,
    this.effectChainTargets1 = 0,
    this.effectChainTargets2 = 0,
    this.effectItemType0 = 0,
    this.effectItemType1 = 0,
    this.effectItemType2 = 0,
    this.effectMiscValue0 = 0,
    this.effectMiscValue1 = 0,
    this.effectMiscValue2 = 0,
    this.effectMiscValueB0 = 0,
    this.effectMiscValueB1 = 0,
    this.effectMiscValueB2 = 0,
    this.effectTriggerSpell0 = 0,
    this.effectTriggerSpell1 = 0,
    this.effectTriggerSpell2 = 0,
    this.effectPointsPerCombo0 = 0.0,
    this.effectPointsPerCombo1 = 0.0,
    this.effectPointsPerCombo2 = 0.0,
    this.effectSpellClassMaskA0 = 0,
    this.effectSpellClassMaskA1 = 0,
    this.effectSpellClassMaskA2 = 0,
    this.effectSpellClassMaskB0 = 0,
    this.effectSpellClassMaskB1 = 0,
    this.effectSpellClassMaskB2 = 0,
    this.effectSpellClassMaskC0 = 0,
    this.effectSpellClassMaskC1 = 0,
    this.effectSpellClassMaskC2 = 0,
    this.spellVisualID0 = 0,
    this.spellVisualID1 = 0,
    this.spellIconID = 0,
    this.activeIconID = 0,
    this.spellPriority = 0,
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
    this.nameSubtextLangEnUS = '',
    this.nameSubtextLangKoKR = '',
    this.nameSubtextLangFrFR = '',
    this.nameSubtextLangDeDE = '',
    this.nameSubtextLangZhCN = '',
    this.nameSubtextLangZhTW = '',
    this.nameSubtextLangEsES = '',
    this.nameSubtextLangEsMX = '',
    this.nameSubtextLangRuRU = '',
    this.nameSubtextLangJaJP = '',
    this.nameSubtextLangPtPT = '',
    this.nameSubtextLangPtBR = '',
    this.nameSubtextLangItIT = '',
    this.nameSubtextLangUnk1 = '',
    this.nameSubtextLangUnk2 = '',
    this.nameSubtextLangUnk3 = '',
    this.nameSubtextLangFlags = 0,
    this.descriptionLangEnUS = '',
    this.descriptionLangKoKR = '',
    this.descriptionLangFrFR = '',
    this.descriptionLangDeDE = '',
    this.descriptionLangZhCN = '',
    this.descriptionLangZhTW = '',
    this.descriptionLangEsES = '',
    this.descriptionLangEsMX = '',
    this.descriptionLangRuRU = '',
    this.descriptionLangJaJP = '',
    this.descriptionLangPtPT = '',
    this.descriptionLangPtBR = '',
    this.descriptionLangItIT = '',
    this.descriptionLangUnk1 = '',
    this.descriptionLangUnk2 = '',
    this.descriptionLangUnk3 = '',
    this.descriptionLangFlags = 0,
    this.auraDescriptionLangEnUS = '',
    this.auraDescriptionLangKoKR = '',
    this.auraDescriptionLangFrFR = '',
    this.auraDescriptionLangDeDE = '',
    this.auraDescriptionLangZhCN = '',
    this.auraDescriptionLangZhTW = '',
    this.auraDescriptionLangEsES = '',
    this.auraDescriptionLangEsMX = '',
    this.auraDescriptionLangRuRU = '',
    this.auraDescriptionLangJaJP = '',
    this.auraDescriptionLangPtPT = '',
    this.auraDescriptionLangPtBR = '',
    this.auraDescriptionLangItIT = '',
    this.auraDescriptionLangUnk1 = '',
    this.auraDescriptionLangUnk2 = '',
    this.auraDescriptionLangUnk3 = '',
    this.auraDescriptionLangFlags = 0,
    this.manaCostPct = 0,
    this.startRecoveryCategory = 0,
    this.startRecoveryTime = 0,
    this.maxTargetLevel = 0,
    this.spellClassSet = 0,
    this.spellClassMask0 = 0,
    this.spellClassMask1 = 0,
    this.spellClassMask2 = 0,
    this.maxTargets = 0,
    this.defenseType = 0,
    this.preventionType = 0,
    this.stanceBarOrder = 0,
    this.effectChainAmplitude0 = 0.0,
    this.effectChainAmplitude1 = 0.0,
    this.effectChainAmplitude2 = 0.0,
    this.minFactionID = 0,
    this.minReputation = 0,
    this.requiredAuraVision = 0,
    this.requiredTotemCategoryID0 = 0,
    this.requiredTotemCategoryID1 = 0,
    this.requiredAreasID = 0,
    this.schoolMask = 0,
    this.runeCostID = 0,
    this.spellMissileID = 0,
    this.powerDisplayID = 0,
    this.effectBonusCoefficient0 = 0.0,
    this.effectBonusCoefficient1 = 0.0,
    this.effectBonusCoefficient2 = 0.0,
    this.spellDescriptionVariableID = 0,
    this.spellDifficultyID = 0,
  });

  factory SpellEntity.fromJson(Map<String, dynamic> json) {
    return SpellEntity(
      id: json['ID'] ?? 0,
      category: json['Category'] ?? 0,
      dispelType: json['DispelType'] ?? 0,
      mechanic: json['Mechanic'] ?? 0,
      attributes: json['Attributes'] ?? 0,
      attributesEx: json['AttributesEx'] ?? 0,
      attributesExB: json['AttributesExB'] ?? 0,
      attributesExC: json['AttributesExC'] ?? 0,
      attributesExD: json['AttributesExD'] ?? 0,
      attributesExE: json['AttributesExE'] ?? 0,
      attributesExF: json['AttributesExF'] ?? 0,
      attributesExG: json['AttributesExG'] ?? 0,
      shapeshiftMask0: json['ShapeshiftMask0'] ?? 0,
      shapeshiftMask1: json['ShapeshiftMask1'] ?? 0,
      shapeshiftExclude0: json['ShapeshiftExclude0'] ?? 0,
      shapeshiftExclude1: json['ShapeshiftExclude1'] ?? 0,
      targets: json['Targets'] ?? 0,
      targetCreatureType: json['TargetCreatureType'] ?? 0,
      requiresSpellFocus: json['RequiresSpellFocus'] ?? 0,
      facingCasterFlags: json['FacingCasterFlags'] ?? 0,
      casterAuraState: json['CasterAuraState'] ?? 0,
      targetAuraState: json['TargetAuraState'] ?? 0,
      excludeCasterAuraState: json['ExcludeCasterAuraState'] ?? 0,
      excludeTargetAuraState: json['ExcludeTargetAuraState'] ?? 0,
      casterAuraSpell: json['CasterAuraSpell'] ?? 0,
      targetAuraSpell: json['TargetAuraSpell'] ?? 0,
      excludeCasterAuraSpell: json['ExcludeCasterAuraSpell'] ?? 0,
      excludeTargetAuraSpell: json['ExcludeTargetAuraSpell'] ?? 0,
      castingTimeIndex: json['CastingTimeIndex'] ?? 0,
      recoveryTime: json['RecoveryTime'] ?? 0,
      categoryRecoveryTime: json['CategoryRecoveryTime'] ?? 0,
      interruptFlags: json['InterruptFlags'] ?? 0,
      auraInterruptFlags: json['AuraInterruptFlags'] ?? 0,
      channelInterruptFlags: json['ChannelInterruptFlags'] ?? 0,
      procTypeMask: json['ProcTypeMask'] ?? 0,
      procChance: json['ProcChance'] ?? 0,
      procCharges: json['ProcCharges'] ?? 0,
      maxLevel: json['MaxLevel'] ?? 0,
      baseLevel: json['BaseLevel'] ?? 0,
      spellLevel: json['SpellLevel'] ?? 0,
      durationIndex: json['DurationIndex'] ?? 0,
      powerType: json['PowerType'] ?? 0,
      manaCost: json['ManaCost'] ?? 0,
      manaCostPerLevel: json['ManaCostPerLevel'] ?? 0,
      manaPerSecond: json['ManaPerSecond'] ?? 0,
      manaPerSecondPerLevel: json['ManaPerSecondPerLevel'] ?? 0,
      rangeIndex: json['RangeIndex'] ?? 0,
      speed: (json['Speed'] as num?)?.toDouble() ?? 0.0,
      modalNextSpell: json['ModalNextSpell'] ?? 0,
      cumulativeAura: json['CumulativeAura'] ?? 0,
      totem0: json['Totem0'] ?? 0,
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
      equippedItemClass: json['EquippedItemClass'] ?? 0,
      equippedItemSubclass: json['EquippedItemSubclass'] ?? 0,
      equippedItemInvTypes: json['EquippedItemInvTypes'] ?? 0,
      effect0: json['Effect0'] ?? 0,
      effect1: json['Effect1'] ?? 0,
      effect2: json['Effect2'] ?? 0,
      effectDieSides0: json['EffectDieSides0'] ?? 0,
      effectDieSides1: json['EffectDieSides1'] ?? 0,
      effectDieSides2: json['EffectDieSides2'] ?? 0,
      effectRealPointsPerLevel0:
          (json['EffectRealPointsPerLevel0'] as num?)?.toDouble() ?? 0.0,
      effectRealPointsPerLevel1:
          (json['EffectRealPointsPerLevel1'] as num?)?.toDouble() ?? 0.0,
      effectRealPointsPerLevel2:
          (json['EffectRealPointsPerLevel2'] as num?)?.toDouble() ?? 0.0,
      effectBasePoints0: json['EffectBasePoints0'] ?? 0,
      effectBasePoints1: json['EffectBasePoints1'] ?? 0,
      effectBasePoints2: json['EffectBasePoints2'] ?? 0,
      effectMechanic0: json['EffectMechanic0'] ?? 0,
      effectMechanic1: json['EffectMechanic1'] ?? 0,
      effectMechanic2: json['EffectMechanic2'] ?? 0,
      implicitTargetA0: json['ImplicitTargetA0'] ?? 0,
      implicitTargetA1: json['ImplicitTargetA1'] ?? 0,
      implicitTargetA2: json['ImplicitTargetA2'] ?? 0,
      implicitTargetB0: json['ImplicitTargetB0'] ?? 0,
      implicitTargetB1: json['ImplicitTargetB1'] ?? 0,
      implicitTargetB2: json['ImplicitTargetB2'] ?? 0,
      effectRadiusIndex0: json['EffectRadiusIndex0'] ?? 0,
      effectRadiusIndex1: json['EffectRadiusIndex1'] ?? 0,
      effectRadiusIndex2: json['EffectRadiusIndex2'] ?? 0,
      effectAura0: json['EffectAura0'] ?? 0,
      effectAura1: json['EffectAura1'] ?? 0,
      effectAura2: json['EffectAura2'] ?? 0,
      effectAuraPeriod0: json['EffectAuraPeriod0'] ?? 0,
      effectAuraPeriod1: json['EffectAuraPeriod1'] ?? 0,
      effectAuraPeriod2: json['EffectAuraPeriod2'] ?? 0,
      effectAmplitude0: (json['EffectAmplitude0'] as num?)?.toDouble() ?? 0.0,
      effectAmplitude1: (json['EffectAmplitude1'] as num?)?.toDouble() ?? 0.0,
      effectAmplitude2: (json['EffectAmplitude2'] as num?)?.toDouble() ?? 0.0,
      effectChainTargets0: json['EffectChainTargets0'] ?? 0,
      effectChainTargets1: json['EffectChainTargets1'] ?? 0,
      effectChainTargets2: json['EffectChainTargets2'] ?? 0,
      effectItemType0: json['EffectItemType0'] ?? 0,
      effectItemType1: json['EffectItemType1'] ?? 0,
      effectItemType2: json['EffectItemType2'] ?? 0,
      effectMiscValue0: json['EffectMiscValue0'] ?? 0,
      effectMiscValue1: json['EffectMiscValue1'] ?? 0,
      effectMiscValue2: json['EffectMiscValue2'] ?? 0,
      effectMiscValueB0: json['EffectMiscValueB0'] ?? 0,
      effectMiscValueB1: json['EffectMiscValueB1'] ?? 0,
      effectMiscValueB2: json['EffectMiscValueB2'] ?? 0,
      effectTriggerSpell0: json['EffectTriggerSpell0'] ?? 0,
      effectTriggerSpell1: json['EffectTriggerSpell1'] ?? 0,
      effectTriggerSpell2: json['EffectTriggerSpell2'] ?? 0,
      effectPointsPerCombo0:
          (json['EffectPointsPerCombo0'] as num?)?.toDouble() ?? 0.0,
      effectPointsPerCombo1:
          (json['EffectPointsPerCombo1'] as num?)?.toDouble() ?? 0.0,
      effectPointsPerCombo2:
          (json['EffectPointsPerCombo2'] as num?)?.toDouble() ?? 0.0,
      effectSpellClassMaskA0: json['EffectSpellClassMaskA0'] ?? 0,
      effectSpellClassMaskA1: json['EffectSpellClassMaskA1'] ?? 0,
      effectSpellClassMaskA2: json['EffectSpellClassMaskA2'] ?? 0,
      effectSpellClassMaskB0: json['EffectSpellClassMaskB0'] ?? 0,
      effectSpellClassMaskB1: json['EffectSpellClassMaskB1'] ?? 0,
      effectSpellClassMaskB2: json['EffectSpellClassMaskB2'] ?? 0,
      effectSpellClassMaskC0: json['EffectSpellClassMaskC0'] ?? 0,
      effectSpellClassMaskC1: json['EffectSpellClassMaskC1'] ?? 0,
      effectSpellClassMaskC2: json['EffectSpellClassMaskC2'] ?? 0,
      spellVisualID0: json['SpellVisualID0'] ?? 0,
      spellVisualID1: json['SpellVisualID1'] ?? 0,
      spellIconID: json['SpellIconID'] ?? 0,
      activeIconID: json['ActiveIconID'] ?? 0,
      spellPriority: json['SpellPriority'] ?? 0,
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
      nameSubtextLangEnUS: json['NameSubtext_lang_enUS'] ?? '',
      nameSubtextLangKoKR: json['NameSubtext_lang_koKR'] ?? '',
      nameSubtextLangFrFR: json['NameSubtext_lang_frFR'] ?? '',
      nameSubtextLangDeDE: json['NameSubtext_lang_deDE'] ?? '',
      nameSubtextLangZhCN: json['NameSubtext_lang_zhCN'] ?? '',
      nameSubtextLangZhTW: json['NameSubtext_lang_zhTW'] ?? '',
      nameSubtextLangEsES: json['NameSubtext_lang_esES'] ?? '',
      nameSubtextLangEsMX: json['NameSubtext_lang_esMX'] ?? '',
      nameSubtextLangRuRU: json['NameSubtext_lang_ruRU'] ?? '',
      nameSubtextLangJaJP: json['NameSubtext_lang_jaJP'] ?? '',
      nameSubtextLangPtPT: json['NameSubtext_lang_ptPT'] ?? '',
      nameSubtextLangPtBR: json['NameSubtext_lang_ptBR'] ?? '',
      nameSubtextLangItIT: json['NameSubtext_lang_itIT'] ?? '',
      nameSubtextLangUnk1: json['NameSubtext_lang_unk1'] ?? '',
      nameSubtextLangUnk2: json['NameSubtext_lang_unk2'] ?? '',
      nameSubtextLangUnk3: json['NameSubtext_lang_unk3'] ?? '',
      nameSubtextLangFlags: json['NameSubtext_lang_Flags'] ?? 0,
      descriptionLangEnUS: json['Description_lang_enUS'] ?? '',
      descriptionLangKoKR: json['Description_lang_koKR'] ?? '',
      descriptionLangFrFR: json['Description_lang_frFR'] ?? '',
      descriptionLangDeDE: json['Description_lang_deDE'] ?? '',
      descriptionLangZhCN: json['Description_lang_zhCN'] ?? '',
      descriptionLangZhTW: json['Description_lang_zhTW'] ?? '',
      descriptionLangEsES: json['Description_lang_esES'] ?? '',
      descriptionLangEsMX: json['Description_lang_esMX'] ?? '',
      descriptionLangRuRU: json['Description_lang_ruRU'] ?? '',
      descriptionLangJaJP: json['Description_lang_jaJP'] ?? '',
      descriptionLangPtPT: json['Description_lang_ptPT'] ?? '',
      descriptionLangPtBR: json['Description_lang_ptBR'] ?? '',
      descriptionLangItIT: json['Description_lang_itIT'] ?? '',
      descriptionLangUnk1: json['Description_lang_unk1'] ?? '',
      descriptionLangUnk2: json['Description_lang_unk2'] ?? '',
      descriptionLangUnk3: json['Description_lang_unk3'] ?? '',
      descriptionLangFlags: json['Description_lang_Flags'] ?? 0,
      auraDescriptionLangEnUS: json['AuraDescription_lang_enUS'] ?? '',
      auraDescriptionLangKoKR: json['AuraDescription_lang_koKR'] ?? '',
      auraDescriptionLangFrFR: json['AuraDescription_lang_frFR'] ?? '',
      auraDescriptionLangDeDE: json['AuraDescription_lang_deDE'] ?? '',
      auraDescriptionLangZhCN: json['AuraDescription_lang_zhCN'] ?? '',
      auraDescriptionLangZhTW: json['AuraDescription_lang_zhTW'] ?? '',
      auraDescriptionLangEsES: json['AuraDescription_lang_esES'] ?? '',
      auraDescriptionLangEsMX: json['AuraDescription_lang_esMX'] ?? '',
      auraDescriptionLangRuRU: json['AuraDescription_lang_ruRU'] ?? '',
      auraDescriptionLangJaJP: json['AuraDescription_lang_jaJP'] ?? '',
      auraDescriptionLangPtPT: json['AuraDescription_lang_ptPT'] ?? '',
      auraDescriptionLangPtBR: json['AuraDescription_lang_ptBR'] ?? '',
      auraDescriptionLangItIT: json['AuraDescription_lang_itIT'] ?? '',
      auraDescriptionLangUnk1: json['AuraDescription_lang_unk1'] ?? '',
      auraDescriptionLangUnk2: json['AuraDescription_lang_unk2'] ?? '',
      auraDescriptionLangUnk3: json['AuraDescription_lang_unk3'] ?? '',
      auraDescriptionLangFlags: json['AuraDescription_lang_Flags'] ?? 0,
      manaCostPct: json['ManaCostPct'] ?? 0,
      startRecoveryCategory: json['StartRecoveryCategory'] ?? 0,
      startRecoveryTime: json['StartRecoveryTime'] ?? 0,
      maxTargetLevel: json['MaxTargetLevel'] ?? 0,
      spellClassSet: json['SpellClassSet'] ?? 0,
      spellClassMask0: json['SpellClassMask0'] ?? 0,
      spellClassMask1: json['SpellClassMask1'] ?? 0,
      spellClassMask2: json['SpellClassMask2'] ?? 0,
      maxTargets: json['MaxTargets'] ?? 0,
      defenseType: json['DefenseType'] ?? 0,
      preventionType: json['PreventionType'] ?? 0,
      stanceBarOrder: json['StanceBarOrder'] ?? 0,
      effectChainAmplitude0:
          (json['EffectChainAmplitude0'] as num?)?.toDouble() ?? 0.0,
      effectChainAmplitude1:
          (json['EffectChainAmplitude1'] as num?)?.toDouble() ?? 0.0,
      effectChainAmplitude2:
          (json['EffectChainAmplitude2'] as num?)?.toDouble() ?? 0.0,
      minFactionID: json['MinFactionID'] ?? 0,
      minReputation: json['MinReputation'] ?? 0,
      requiredAuraVision: json['RequiredAuraVision'] ?? 0,
      requiredTotemCategoryID0: json['RequiredTotemCategoryID0'] ?? 0,
      requiredTotemCategoryID1: json['RequiredTotemCategoryID1'] ?? 0,
      requiredAreasID: json['RequiredAreasID'] ?? 0,
      schoolMask: json['SchoolMask'] ?? 0,
      runeCostID: json['RuneCostID'] ?? 0,
      spellMissileID: json['SpellMissileID'] ?? 0,
      powerDisplayID: json['PowerDisplayID'] ?? 0,
      effectBonusCoefficient0:
          (json['EffectBonusCoefficient0'] as num?)?.toDouble() ?? 0.0,
      effectBonusCoefficient1:
          (json['EffectBonusCoefficient1'] as num?)?.toDouble() ?? 0.0,
      effectBonusCoefficient2:
          (json['EffectBonusCoefficient2'] as num?)?.toDouble() ?? 0.0,
      spellDescriptionVariableID: json['DescriptionVariablesID'] ?? 0,
      spellDifficultyID: json['Difficulty'] ?? 0,
    );
  }

  SpellEntity copyWith({
    int? id,
    int? category,
    int? dispelType,
    int? mechanic,
    int? attributes,
    int? attributesEx,
    int? attributesExB,
    int? attributesExC,
    int? attributesExD,
    int? attributesExE,
    int? attributesExF,
    int? attributesExG,
    int? shapeshiftMask0,
    int? shapeshiftMask1,
    int? shapeshiftExclude0,
    int? shapeshiftExclude1,
    int? targets,
    int? targetCreatureType,
    int? requiresSpellFocus,
    int? facingCasterFlags,
    int? casterAuraState,
    int? targetAuraState,
    int? excludeCasterAuraState,
    int? excludeTargetAuraState,
    int? casterAuraSpell,
    int? targetAuraSpell,
    int? excludeCasterAuraSpell,
    int? excludeTargetAuraSpell,
    int? castingTimeIndex,
    int? recoveryTime,
    int? categoryRecoveryTime,
    int? interruptFlags,
    int? auraInterruptFlags,
    int? channelInterruptFlags,
    int? procTypeMask,
    int? procChance,
    int? procCharges,
    int? maxLevel,
    int? baseLevel,
    int? spellLevel,
    int? durationIndex,
    int? powerType,
    int? manaCost,
    int? manaCostPerLevel,
    int? manaPerSecond,
    int? manaPerSecondPerLevel,
    int? rangeIndex,
    double? speed,
    int? modalNextSpell,
    int? cumulativeAura,
    int? totem0,
    int? totem1,
    int? reagent0,
    int? reagent1,
    int? reagent2,
    int? reagent3,
    int? reagent4,
    int? reagent5,
    int? reagent6,
    int? reagent7,
    int? reagentCount0,
    int? reagentCount1,
    int? reagentCount2,
    int? reagentCount3,
    int? reagentCount4,
    int? reagentCount5,
    int? reagentCount6,
    int? reagentCount7,
    int? equippedItemClass,
    int? equippedItemSubclass,
    int? equippedItemInvTypes,
    int? effect0,
    int? effect1,
    int? effect2,
    int? effectDieSides0,
    int? effectDieSides1,
    int? effectDieSides2,
    double? effectRealPointsPerLevel0,
    double? effectRealPointsPerLevel1,
    double? effectRealPointsPerLevel2,
    int? effectBasePoints0,
    int? effectBasePoints1,
    int? effectBasePoints2,
    int? effectMechanic0,
    int? effectMechanic1,
    int? effectMechanic2,
    int? implicitTargetA0,
    int? implicitTargetA1,
    int? implicitTargetA2,
    int? implicitTargetB0,
    int? implicitTargetB1,
    int? implicitTargetB2,
    int? effectRadiusIndex0,
    int? effectRadiusIndex1,
    int? effectRadiusIndex2,
    int? effectAura0,
    int? effectAura1,
    int? effectAura2,
    int? effectAuraPeriod0,
    int? effectAuraPeriod1,
    int? effectAuraPeriod2,
    double? effectAmplitude0,
    double? effectAmplitude1,
    double? effectAmplitude2,
    int? effectChainTargets0,
    int? effectChainTargets1,
    int? effectChainTargets2,
    int? effectItemType0,
    int? effectItemType1,
    int? effectItemType2,
    int? effectMiscValue0,
    int? effectMiscValue1,
    int? effectMiscValue2,
    int? effectMiscValueB0,
    int? effectMiscValueB1,
    int? effectMiscValueB2,
    int? effectTriggerSpell0,
    int? effectTriggerSpell1,
    int? effectTriggerSpell2,
    double? effectPointsPerCombo0,
    double? effectPointsPerCombo1,
    double? effectPointsPerCombo2,
    int? effectSpellClassMaskA0,
    int? effectSpellClassMaskA1,
    int? effectSpellClassMaskA2,
    int? effectSpellClassMaskB0,
    int? effectSpellClassMaskB1,
    int? effectSpellClassMaskB2,
    int? effectSpellClassMaskC0,
    int? effectSpellClassMaskC1,
    int? effectSpellClassMaskC2,
    int? spellVisualID0,
    int? spellVisualID1,
    int? spellIconID,
    int? activeIconID,
    int? spellPriority,
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
    String? nameSubtextLangEnUS,
    String? nameSubtextLangKoKR,
    String? nameSubtextLangFrFR,
    String? nameSubtextLangDeDE,
    String? nameSubtextLangZhCN,
    String? nameSubtextLangZhTW,
    String? nameSubtextLangEsES,
    String? nameSubtextLangEsMX,
    String? nameSubtextLangRuRU,
    String? nameSubtextLangJaJP,
    String? nameSubtextLangPtPT,
    String? nameSubtextLangPtBR,
    String? nameSubtextLangItIT,
    String? nameSubtextLangUnk1,
    String? nameSubtextLangUnk2,
    String? nameSubtextLangUnk3,
    int? nameSubtextLangFlags,
    String? descriptionLangEnUS,
    String? descriptionLangKoKR,
    String? descriptionLangFrFR,
    String? descriptionLangDeDE,
    String? descriptionLangZhCN,
    String? descriptionLangZhTW,
    String? descriptionLangEsES,
    String? descriptionLangEsMX,
    String? descriptionLangRuRU,
    String? descriptionLangJaJP,
    String? descriptionLangPtPT,
    String? descriptionLangPtBR,
    String? descriptionLangItIT,
    String? descriptionLangUnk1,
    String? descriptionLangUnk2,
    String? descriptionLangUnk3,
    int? descriptionLangFlags,
    String? auraDescriptionLangEnUS,
    String? auraDescriptionLangKoKR,
    String? auraDescriptionLangFrFR,
    String? auraDescriptionLangDeDE,
    String? auraDescriptionLangZhCN,
    String? auraDescriptionLangZhTW,
    String? auraDescriptionLangEsES,
    String? auraDescriptionLangEsMX,
    String? auraDescriptionLangRuRU,
    String? auraDescriptionLangJaJP,
    String? auraDescriptionLangPtPT,
    String? auraDescriptionLangPtBR,
    String? auraDescriptionLangItIT,
    String? auraDescriptionLangUnk1,
    String? auraDescriptionLangUnk2,
    String? auraDescriptionLangUnk3,
    int? auraDescriptionLangFlags,
    int? manaCostPct,
    int? startRecoveryCategory,
    int? startRecoveryTime,
    int? maxTargetLevel,
    int? spellClassSet,
    int? spellClassMask0,
    int? spellClassMask1,
    int? spellClassMask2,
    int? maxTargets,
    int? defenseType,
    int? preventionType,
    int? stanceBarOrder,
    double? effectChainAmplitude0,
    double? effectChainAmplitude1,
    double? effectChainAmplitude2,
    int? minFactionID,
    int? minReputation,
    int? requiredAuraVision,
    int? requiredTotemCategoryID0,
    int? requiredTotemCategoryID1,
    int? requiredAreasID,
    int? schoolMask,
    int? runeCostID,
    int? spellMissileID,
    int? powerDisplayID,
    double? effectBonusCoefficient0,
    double? effectBonusCoefficient1,
    double? effectBonusCoefficient2,
    int? spellDescriptionVariableID,
    int? spellDifficultyID,
  }) {
    return SpellEntity(
      id: id ?? this.id,
      category: category ?? this.category,
      dispelType: dispelType ?? this.dispelType,
      mechanic: mechanic ?? this.mechanic,
      attributes: attributes ?? this.attributes,
      attributesEx: attributesEx ?? this.attributesEx,
      attributesExB: attributesExB ?? this.attributesExB,
      attributesExC: attributesExC ?? this.attributesExC,
      attributesExD: attributesExD ?? this.attributesExD,
      attributesExE: attributesExE ?? this.attributesExE,
      attributesExF: attributesExF ?? this.attributesExF,
      attributesExG: attributesExG ?? this.attributesExG,
      shapeshiftMask0: shapeshiftMask0 ?? this.shapeshiftMask0,
      shapeshiftMask1: shapeshiftMask1 ?? this.shapeshiftMask1,
      shapeshiftExclude0: shapeshiftExclude0 ?? this.shapeshiftExclude0,
      shapeshiftExclude1: shapeshiftExclude1 ?? this.shapeshiftExclude1,
      targets: targets ?? this.targets,
      targetCreatureType: targetCreatureType ?? this.targetCreatureType,
      requiresSpellFocus: requiresSpellFocus ?? this.requiresSpellFocus,
      facingCasterFlags: facingCasterFlags ?? this.facingCasterFlags,
      casterAuraState: casterAuraState ?? this.casterAuraState,
      targetAuraState: targetAuraState ?? this.targetAuraState,
      excludeCasterAuraState:
          excludeCasterAuraState ?? this.excludeCasterAuraState,
      excludeTargetAuraState:
          excludeTargetAuraState ?? this.excludeTargetAuraState,
      casterAuraSpell: casterAuraSpell ?? this.casterAuraSpell,
      targetAuraSpell: targetAuraSpell ?? this.targetAuraSpell,
      excludeCasterAuraSpell:
          excludeCasterAuraSpell ?? this.excludeCasterAuraSpell,
      excludeTargetAuraSpell:
          excludeTargetAuraSpell ?? this.excludeTargetAuraSpell,
      castingTimeIndex: castingTimeIndex ?? this.castingTimeIndex,
      recoveryTime: recoveryTime ?? this.recoveryTime,
      categoryRecoveryTime: categoryRecoveryTime ?? this.categoryRecoveryTime,
      interruptFlags: interruptFlags ?? this.interruptFlags,
      auraInterruptFlags: auraInterruptFlags ?? this.auraInterruptFlags,
      channelInterruptFlags:
          channelInterruptFlags ?? this.channelInterruptFlags,
      procTypeMask: procTypeMask ?? this.procTypeMask,
      procChance: procChance ?? this.procChance,
      procCharges: procCharges ?? this.procCharges,
      maxLevel: maxLevel ?? this.maxLevel,
      baseLevel: baseLevel ?? this.baseLevel,
      spellLevel: spellLevel ?? this.spellLevel,
      durationIndex: durationIndex ?? this.durationIndex,
      powerType: powerType ?? this.powerType,
      manaCost: manaCost ?? this.manaCost,
      manaCostPerLevel: manaCostPerLevel ?? this.manaCostPerLevel,
      manaPerSecond: manaPerSecond ?? this.manaPerSecond,
      manaPerSecondPerLevel:
          manaPerSecondPerLevel ?? this.manaPerSecondPerLevel,
      rangeIndex: rangeIndex ?? this.rangeIndex,
      speed: speed ?? this.speed,
      modalNextSpell: modalNextSpell ?? this.modalNextSpell,
      cumulativeAura: cumulativeAura ?? this.cumulativeAura,
      totem0: totem0 ?? this.totem0,
      totem1: totem1 ?? this.totem1,
      reagent0: reagent0 ?? this.reagent0,
      reagent1: reagent1 ?? this.reagent1,
      reagent2: reagent2 ?? this.reagent2,
      reagent3: reagent3 ?? this.reagent3,
      reagent4: reagent4 ?? this.reagent4,
      reagent5: reagent5 ?? this.reagent5,
      reagent6: reagent6 ?? this.reagent6,
      reagent7: reagent7 ?? this.reagent7,
      reagentCount0: reagentCount0 ?? this.reagentCount0,
      reagentCount1: reagentCount1 ?? this.reagentCount1,
      reagentCount2: reagentCount2 ?? this.reagentCount2,
      reagentCount3: reagentCount3 ?? this.reagentCount3,
      reagentCount4: reagentCount4 ?? this.reagentCount4,
      reagentCount5: reagentCount5 ?? this.reagentCount5,
      reagentCount6: reagentCount6 ?? this.reagentCount6,
      reagentCount7: reagentCount7 ?? this.reagentCount7,
      equippedItemClass: equippedItemClass ?? this.equippedItemClass,
      equippedItemSubclass: equippedItemSubclass ?? this.equippedItemSubclass,
      equippedItemInvTypes: equippedItemInvTypes ?? this.equippedItemInvTypes,
      effect0: effect0 ?? this.effect0,
      effect1: effect1 ?? this.effect1,
      effect2: effect2 ?? this.effect2,
      effectDieSides0: effectDieSides0 ?? this.effectDieSides0,
      effectDieSides1: effectDieSides1 ?? this.effectDieSides1,
      effectDieSides2: effectDieSides2 ?? this.effectDieSides2,
      effectRealPointsPerLevel0:
          effectRealPointsPerLevel0 ?? this.effectRealPointsPerLevel0,
      effectRealPointsPerLevel1:
          effectRealPointsPerLevel1 ?? this.effectRealPointsPerLevel1,
      effectRealPointsPerLevel2:
          effectRealPointsPerLevel2 ?? this.effectRealPointsPerLevel2,
      effectBasePoints0: effectBasePoints0 ?? this.effectBasePoints0,
      effectBasePoints1: effectBasePoints1 ?? this.effectBasePoints1,
      effectBasePoints2: effectBasePoints2 ?? this.effectBasePoints2,
      effectMechanic0: effectMechanic0 ?? this.effectMechanic0,
      effectMechanic1: effectMechanic1 ?? this.effectMechanic1,
      effectMechanic2: effectMechanic2 ?? this.effectMechanic2,
      implicitTargetA0: implicitTargetA0 ?? this.implicitTargetA0,
      implicitTargetA1: implicitTargetA1 ?? this.implicitTargetA1,
      implicitTargetA2: implicitTargetA2 ?? this.implicitTargetA2,
      implicitTargetB0: implicitTargetB0 ?? this.implicitTargetB0,
      implicitTargetB1: implicitTargetB1 ?? this.implicitTargetB1,
      implicitTargetB2: implicitTargetB2 ?? this.implicitTargetB2,
      effectRadiusIndex0: effectRadiusIndex0 ?? this.effectRadiusIndex0,
      effectRadiusIndex1: effectRadiusIndex1 ?? this.effectRadiusIndex1,
      effectRadiusIndex2: effectRadiusIndex2 ?? this.effectRadiusIndex2,
      effectAura0: effectAura0 ?? this.effectAura0,
      effectAura1: effectAura1 ?? this.effectAura1,
      effectAura2: effectAura2 ?? this.effectAura2,
      effectAuraPeriod0: effectAuraPeriod0 ?? this.effectAuraPeriod0,
      effectAuraPeriod1: effectAuraPeriod1 ?? this.effectAuraPeriod1,
      effectAuraPeriod2: effectAuraPeriod2 ?? this.effectAuraPeriod2,
      effectAmplitude0: effectAmplitude0 ?? this.effectAmplitude0,
      effectAmplitude1: effectAmplitude1 ?? this.effectAmplitude1,
      effectAmplitude2: effectAmplitude2 ?? this.effectAmplitude2,
      effectChainTargets0: effectChainTargets0 ?? this.effectChainTargets0,
      effectChainTargets1: effectChainTargets1 ?? this.effectChainTargets1,
      effectChainTargets2: effectChainTargets2 ?? this.effectChainTargets2,
      effectItemType0: effectItemType0 ?? this.effectItemType0,
      effectItemType1: effectItemType1 ?? this.effectItemType1,
      effectItemType2: effectItemType2 ?? this.effectItemType2,
      effectMiscValue0: effectMiscValue0 ?? this.effectMiscValue0,
      effectMiscValue1: effectMiscValue1 ?? this.effectMiscValue1,
      effectMiscValue2: effectMiscValue2 ?? this.effectMiscValue2,
      effectMiscValueB0: effectMiscValueB0 ?? this.effectMiscValueB0,
      effectMiscValueB1: effectMiscValueB1 ?? this.effectMiscValueB1,
      effectMiscValueB2: effectMiscValueB2 ?? this.effectMiscValueB2,
      effectTriggerSpell0: effectTriggerSpell0 ?? this.effectTriggerSpell0,
      effectTriggerSpell1: effectTriggerSpell1 ?? this.effectTriggerSpell1,
      effectTriggerSpell2: effectTriggerSpell2 ?? this.effectTriggerSpell2,
      effectPointsPerCombo0:
          effectPointsPerCombo0 ?? this.effectPointsPerCombo0,
      effectPointsPerCombo1:
          effectPointsPerCombo1 ?? this.effectPointsPerCombo1,
      effectPointsPerCombo2:
          effectPointsPerCombo2 ?? this.effectPointsPerCombo2,
      effectSpellClassMaskA0:
          effectSpellClassMaskA0 ?? this.effectSpellClassMaskA0,
      effectSpellClassMaskA1:
          effectSpellClassMaskA1 ?? this.effectSpellClassMaskA1,
      effectSpellClassMaskA2:
          effectSpellClassMaskA2 ?? this.effectSpellClassMaskA2,
      effectSpellClassMaskB0:
          effectSpellClassMaskB0 ?? this.effectSpellClassMaskB0,
      effectSpellClassMaskB1:
          effectSpellClassMaskB1 ?? this.effectSpellClassMaskB1,
      effectSpellClassMaskB2:
          effectSpellClassMaskB2 ?? this.effectSpellClassMaskB2,
      effectSpellClassMaskC0:
          effectSpellClassMaskC0 ?? this.effectSpellClassMaskC0,
      effectSpellClassMaskC1:
          effectSpellClassMaskC1 ?? this.effectSpellClassMaskC1,
      effectSpellClassMaskC2:
          effectSpellClassMaskC2 ?? this.effectSpellClassMaskC2,
      spellVisualID0: spellVisualID0 ?? this.spellVisualID0,
      spellVisualID1: spellVisualID1 ?? this.spellVisualID1,
      spellIconID: spellIconID ?? this.spellIconID,
      activeIconID: activeIconID ?? this.activeIconID,
      spellPriority: spellPriority ?? this.spellPriority,
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
      nameSubtextLangEnUS: nameSubtextLangEnUS ?? this.nameSubtextLangEnUS,
      nameSubtextLangKoKR: nameSubtextLangKoKR ?? this.nameSubtextLangKoKR,
      nameSubtextLangFrFR: nameSubtextLangFrFR ?? this.nameSubtextLangFrFR,
      nameSubtextLangDeDE: nameSubtextLangDeDE ?? this.nameSubtextLangDeDE,
      nameSubtextLangZhCN: nameSubtextLangZhCN ?? this.nameSubtextLangZhCN,
      nameSubtextLangZhTW: nameSubtextLangZhTW ?? this.nameSubtextLangZhTW,
      nameSubtextLangEsES: nameSubtextLangEsES ?? this.nameSubtextLangEsES,
      nameSubtextLangEsMX: nameSubtextLangEsMX ?? this.nameSubtextLangEsMX,
      nameSubtextLangRuRU: nameSubtextLangRuRU ?? this.nameSubtextLangRuRU,
      nameSubtextLangJaJP: nameSubtextLangJaJP ?? this.nameSubtextLangJaJP,
      nameSubtextLangPtPT: nameSubtextLangPtPT ?? this.nameSubtextLangPtPT,
      nameSubtextLangPtBR: nameSubtextLangPtBR ?? this.nameSubtextLangPtBR,
      nameSubtextLangItIT: nameSubtextLangItIT ?? this.nameSubtextLangItIT,
      nameSubtextLangUnk1: nameSubtextLangUnk1 ?? this.nameSubtextLangUnk1,
      nameSubtextLangUnk2: nameSubtextLangUnk2 ?? this.nameSubtextLangUnk2,
      nameSubtextLangUnk3: nameSubtextLangUnk3 ?? this.nameSubtextLangUnk3,
      nameSubtextLangFlags: nameSubtextLangFlags ?? this.nameSubtextLangFlags,
      descriptionLangEnUS: descriptionLangEnUS ?? this.descriptionLangEnUS,
      descriptionLangKoKR: descriptionLangKoKR ?? this.descriptionLangKoKR,
      descriptionLangFrFR: descriptionLangFrFR ?? this.descriptionLangFrFR,
      descriptionLangDeDE: descriptionLangDeDE ?? this.descriptionLangDeDE,
      descriptionLangZhCN: descriptionLangZhCN ?? this.descriptionLangZhCN,
      descriptionLangZhTW: descriptionLangZhTW ?? this.descriptionLangZhTW,
      descriptionLangEsES: descriptionLangEsES ?? this.descriptionLangEsES,
      descriptionLangEsMX: descriptionLangEsMX ?? this.descriptionLangEsMX,
      descriptionLangRuRU: descriptionLangRuRU ?? this.descriptionLangRuRU,
      descriptionLangJaJP: descriptionLangJaJP ?? this.descriptionLangJaJP,
      descriptionLangPtPT: descriptionLangPtPT ?? this.descriptionLangPtPT,
      descriptionLangPtBR: descriptionLangPtBR ?? this.descriptionLangPtBR,
      descriptionLangItIT: descriptionLangItIT ?? this.descriptionLangItIT,
      descriptionLangUnk1: descriptionLangUnk1 ?? this.descriptionLangUnk1,
      descriptionLangUnk2: descriptionLangUnk2 ?? this.descriptionLangUnk2,
      descriptionLangUnk3: descriptionLangUnk3 ?? this.descriptionLangUnk3,
      descriptionLangFlags: descriptionLangFlags ?? this.descriptionLangFlags,
      auraDescriptionLangEnUS:
          auraDescriptionLangEnUS ?? this.auraDescriptionLangEnUS,
      auraDescriptionLangKoKR:
          auraDescriptionLangKoKR ?? this.auraDescriptionLangKoKR,
      auraDescriptionLangFrFR:
          auraDescriptionLangFrFR ?? this.auraDescriptionLangFrFR,
      auraDescriptionLangDeDE:
          auraDescriptionLangDeDE ?? this.auraDescriptionLangDeDE,
      auraDescriptionLangZhCN:
          auraDescriptionLangZhCN ?? this.auraDescriptionLangZhCN,
      auraDescriptionLangZhTW:
          auraDescriptionLangZhTW ?? this.auraDescriptionLangZhTW,
      auraDescriptionLangEsES:
          auraDescriptionLangEsES ?? this.auraDescriptionLangEsES,
      auraDescriptionLangEsMX:
          auraDescriptionLangEsMX ?? this.auraDescriptionLangEsMX,
      auraDescriptionLangRuRU:
          auraDescriptionLangRuRU ?? this.auraDescriptionLangRuRU,
      auraDescriptionLangJaJP:
          auraDescriptionLangJaJP ?? this.auraDescriptionLangJaJP,
      auraDescriptionLangPtPT:
          auraDescriptionLangPtPT ?? this.auraDescriptionLangPtPT,
      auraDescriptionLangPtBR:
          auraDescriptionLangPtBR ?? this.auraDescriptionLangPtBR,
      auraDescriptionLangItIT:
          auraDescriptionLangItIT ?? this.auraDescriptionLangItIT,
      auraDescriptionLangUnk1:
          auraDescriptionLangUnk1 ?? this.auraDescriptionLangUnk1,
      auraDescriptionLangUnk2:
          auraDescriptionLangUnk2 ?? this.auraDescriptionLangUnk2,
      auraDescriptionLangUnk3:
          auraDescriptionLangUnk3 ?? this.auraDescriptionLangUnk3,
      auraDescriptionLangFlags:
          auraDescriptionLangFlags ?? this.auraDescriptionLangFlags,
      manaCostPct: manaCostPct ?? this.manaCostPct,
      startRecoveryCategory:
          startRecoveryCategory ?? this.startRecoveryCategory,
      startRecoveryTime: startRecoveryTime ?? this.startRecoveryTime,
      maxTargetLevel: maxTargetLevel ?? this.maxTargetLevel,
      spellClassSet: spellClassSet ?? this.spellClassSet,
      spellClassMask0: spellClassMask0 ?? this.spellClassMask0,
      spellClassMask1: spellClassMask1 ?? this.spellClassMask1,
      spellClassMask2: spellClassMask2 ?? this.spellClassMask2,
      maxTargets: maxTargets ?? this.maxTargets,
      defenseType: defenseType ?? this.defenseType,
      preventionType: preventionType ?? this.preventionType,
      stanceBarOrder: stanceBarOrder ?? this.stanceBarOrder,
      effectChainAmplitude0:
          effectChainAmplitude0 ?? this.effectChainAmplitude0,
      effectChainAmplitude1:
          effectChainAmplitude1 ?? this.effectChainAmplitude1,
      effectChainAmplitude2:
          effectChainAmplitude2 ?? this.effectChainAmplitude2,
      minFactionID: minFactionID ?? this.minFactionID,
      minReputation: minReputation ?? this.minReputation,
      requiredAuraVision: requiredAuraVision ?? this.requiredAuraVision,
      requiredTotemCategoryID0:
          requiredTotemCategoryID0 ?? this.requiredTotemCategoryID0,
      requiredTotemCategoryID1:
          requiredTotemCategoryID1 ?? this.requiredTotemCategoryID1,
      requiredAreasID: requiredAreasID ?? this.requiredAreasID,
      schoolMask: schoolMask ?? this.schoolMask,
      runeCostID: runeCostID ?? this.runeCostID,
      spellMissileID: spellMissileID ?? this.spellMissileID,
      powerDisplayID: powerDisplayID ?? this.powerDisplayID,
      effectBonusCoefficient0:
          effectBonusCoefficient0 ?? this.effectBonusCoefficient0,
      effectBonusCoefficient1:
          effectBonusCoefficient1 ?? this.effectBonusCoefficient1,
      effectBonusCoefficient2:
          effectBonusCoefficient2 ?? this.effectBonusCoefficient2,
      spellDescriptionVariableID:
          spellDescriptionVariableID ?? this.spellDescriptionVariableID,
      spellDifficultyID: spellDifficultyID ?? this.spellDifficultyID,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Category': category,
      'DispelType': dispelType,
      'Mechanic': mechanic,
      'Attributes': attributes,
      'AttributesEx': attributesEx,
      'AttributesExB': attributesExB,
      'AttributesExC': attributesExC,
      'AttributesExD': attributesExD,
      'AttributesExE': attributesExE,
      'AttributesExF': attributesExF,
      'AttributesExG': attributesExG,
      'ShapeshiftMask0': shapeshiftMask0,
      'ShapeshiftMask1': shapeshiftMask1,
      'ShapeshiftExclude0': shapeshiftExclude0,
      'ShapeshiftExclude1': shapeshiftExclude1,
      'Targets': targets,
      'TargetCreatureType': targetCreatureType,
      'RequiresSpellFocus': requiresSpellFocus,
      'FacingCasterFlags': facingCasterFlags,
      'CasterAuraState': casterAuraState,
      'TargetAuraState': targetAuraState,
      'ExcludeCasterAuraState': excludeCasterAuraState,
      'ExcludeTargetAuraState': excludeTargetAuraState,
      'CasterAuraSpell': casterAuraSpell,
      'TargetAuraSpell': targetAuraSpell,
      'ExcludeCasterAuraSpell': excludeCasterAuraSpell,
      'ExcludeTargetAuraSpell': excludeTargetAuraSpell,
      'CastingTimeIndex': castingTimeIndex,
      'RecoveryTime': recoveryTime,
      'CategoryRecoveryTime': categoryRecoveryTime,
      'InterruptFlags': interruptFlags,
      'AuraInterruptFlags': auraInterruptFlags,
      'ChannelInterruptFlags': channelInterruptFlags,
      'ProcTypeMask': procTypeMask,
      'ProcChance': procChance,
      'ProcCharges': procCharges,
      'MaxLevel': maxLevel,
      'BaseLevel': baseLevel,
      'SpellLevel': spellLevel,
      'DurationIndex': durationIndex,
      'PowerType': powerType,
      'ManaCost': manaCost,
      'ManaCostPerLevel': manaCostPerLevel,
      'ManaPerSecond': manaPerSecond,
      'ManaPerSecondPerLevel': manaPerSecondPerLevel,
      'RangeIndex': rangeIndex,
      'Speed': speed,
      'ModalNextSpell': modalNextSpell,
      'CumulativeAura': cumulativeAura,
      'Totem0': totem0,
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
      'EquippedItemClass': equippedItemClass,
      'EquippedItemSubclass': equippedItemSubclass,
      'EquippedItemInvTypes': equippedItemInvTypes,
      'Effect0': effect0,
      'Effect1': effect1,
      'Effect2': effect2,
      'EffectDieSides0': effectDieSides0,
      'EffectDieSides1': effectDieSides1,
      'EffectDieSides2': effectDieSides2,
      'EffectRealPointsPerLevel0': effectRealPointsPerLevel0,
      'EffectRealPointsPerLevel1': effectRealPointsPerLevel1,
      'EffectRealPointsPerLevel2': effectRealPointsPerLevel2,
      'EffectBasePoints0': effectBasePoints0,
      'EffectBasePoints1': effectBasePoints1,
      'EffectBasePoints2': effectBasePoints2,
      'EffectMechanic0': effectMechanic0,
      'EffectMechanic1': effectMechanic1,
      'EffectMechanic2': effectMechanic2,
      'ImplicitTargetA0': implicitTargetA0,
      'ImplicitTargetA1': implicitTargetA1,
      'ImplicitTargetA2': implicitTargetA2,
      'ImplicitTargetB0': implicitTargetB0,
      'ImplicitTargetB1': implicitTargetB1,
      'ImplicitTargetB2': implicitTargetB2,
      'EffectRadiusIndex0': effectRadiusIndex0,
      'EffectRadiusIndex1': effectRadiusIndex1,
      'EffectRadiusIndex2': effectRadiusIndex2,
      'EffectAura0': effectAura0,
      'EffectAura1': effectAura1,
      'EffectAura2': effectAura2,
      'EffectAuraPeriod0': effectAuraPeriod0,
      'EffectAuraPeriod1': effectAuraPeriod1,
      'EffectAuraPeriod2': effectAuraPeriod2,
      'EffectAmplitude0': effectAmplitude0,
      'EffectAmplitude1': effectAmplitude1,
      'EffectAmplitude2': effectAmplitude2,
      'EffectChainTargets0': effectChainTargets0,
      'EffectChainTargets1': effectChainTargets1,
      'EffectChainTargets2': effectChainTargets2,
      'EffectItemType0': effectItemType0,
      'EffectItemType1': effectItemType1,
      'EffectItemType2': effectItemType2,
      'EffectMiscValue0': effectMiscValue0,
      'EffectMiscValue1': effectMiscValue1,
      'EffectMiscValue2': effectMiscValue2,
      'EffectMiscValueB0': effectMiscValueB0,
      'EffectMiscValueB1': effectMiscValueB1,
      'EffectMiscValueB2': effectMiscValueB2,
      'EffectTriggerSpell0': effectTriggerSpell0,
      'EffectTriggerSpell1': effectTriggerSpell1,
      'EffectTriggerSpell2': effectTriggerSpell2,
      'EffectPointsPerCombo0': effectPointsPerCombo0,
      'EffectPointsPerCombo1': effectPointsPerCombo1,
      'EffectPointsPerCombo2': effectPointsPerCombo2,
      'EffectSpellClassMaskA0': effectSpellClassMaskA0,
      'EffectSpellClassMaskA1': effectSpellClassMaskA1,
      'EffectSpellClassMaskA2': effectSpellClassMaskA2,
      'EffectSpellClassMaskB0': effectSpellClassMaskB0,
      'EffectSpellClassMaskB1': effectSpellClassMaskB1,
      'EffectSpellClassMaskB2': effectSpellClassMaskB2,
      'EffectSpellClassMaskC0': effectSpellClassMaskC0,
      'EffectSpellClassMaskC1': effectSpellClassMaskC1,
      'EffectSpellClassMaskC2': effectSpellClassMaskC2,
      'SpellVisualID0': spellVisualID0,
      'SpellVisualID1': spellVisualID1,
      'SpellIconID': spellIconID,
      'ActiveIconID': activeIconID,
      'SpellPriority': spellPriority,
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
      'NameSubtext_lang_enUS': nameSubtextLangEnUS,
      'NameSubtext_lang_koKR': nameSubtextLangKoKR,
      'NameSubtext_lang_frFR': nameSubtextLangFrFR,
      'NameSubtext_lang_deDE': nameSubtextLangDeDE,
      'NameSubtext_lang_zhCN': nameSubtextLangZhCN,
      'NameSubtext_lang_zhTW': nameSubtextLangZhTW,
      'NameSubtext_lang_esES': nameSubtextLangEsES,
      'NameSubtext_lang_esMX': nameSubtextLangEsMX,
      'NameSubtext_lang_ruRU': nameSubtextLangRuRU,
      'NameSubtext_lang_jaJP': nameSubtextLangJaJP,
      'NameSubtext_lang_ptPT': nameSubtextLangPtPT,
      'NameSubtext_lang_ptBR': nameSubtextLangPtBR,
      'NameSubtext_lang_itIT': nameSubtextLangItIT,
      'NameSubtext_lang_unk1': nameSubtextLangUnk1,
      'NameSubtext_lang_unk2': nameSubtextLangUnk2,
      'NameSubtext_lang_unk3': nameSubtextLangUnk3,
      'NameSubtext_lang_Flags': nameSubtextLangFlags,
      'Description_lang_enUS': descriptionLangEnUS,
      'Description_lang_koKR': descriptionLangKoKR,
      'Description_lang_frFR': descriptionLangFrFR,
      'Description_lang_deDE': descriptionLangDeDE,
      'Description_lang_zhCN': descriptionLangZhCN,
      'Description_lang_zhTW': descriptionLangZhTW,
      'Description_lang_esES': descriptionLangEsES,
      'Description_lang_esMX': descriptionLangEsMX,
      'Description_lang_ruRU': descriptionLangRuRU,
      'Description_lang_jaJP': descriptionLangJaJP,
      'Description_lang_ptPT': descriptionLangPtPT,
      'Description_lang_ptBR': descriptionLangPtBR,
      'Description_lang_itIT': descriptionLangItIT,
      'Description_lang_unk1': descriptionLangUnk1,
      'Description_lang_unk2': descriptionLangUnk2,
      'Description_lang_unk3': descriptionLangUnk3,
      'Description_lang_Flags': descriptionLangFlags,
      'AuraDescription_lang_enUS': auraDescriptionLangEnUS,
      'AuraDescription_lang_koKR': auraDescriptionLangKoKR,
      'AuraDescription_lang_frFR': auraDescriptionLangFrFR,
      'AuraDescription_lang_deDE': auraDescriptionLangDeDE,
      'AuraDescription_lang_zhCN': auraDescriptionLangZhCN,
      'AuraDescription_lang_zhTW': auraDescriptionLangZhTW,
      'AuraDescription_lang_esES': auraDescriptionLangEsES,
      'AuraDescription_lang_esMX': auraDescriptionLangEsMX,
      'AuraDescription_lang_ruRU': auraDescriptionLangRuRU,
      'AuraDescription_lang_jaJP': auraDescriptionLangJaJP,
      'AuraDescription_lang_ptPT': auraDescriptionLangPtPT,
      'AuraDescription_lang_ptBR': auraDescriptionLangPtBR,
      'AuraDescription_lang_itIT': auraDescriptionLangItIT,
      'AuraDescription_lang_unk1': auraDescriptionLangUnk1,
      'AuraDescription_lang_unk2': auraDescriptionLangUnk2,
      'AuraDescription_lang_unk3': auraDescriptionLangUnk3,
      'AuraDescription_lang_Flags': auraDescriptionLangFlags,
      'ManaCostPct': manaCostPct,
      'StartRecoveryCategory': startRecoveryCategory,
      'StartRecoveryTime': startRecoveryTime,
      'MaxTargetLevel': maxTargetLevel,
      'SpellClassSet': spellClassSet,
      'SpellClassMask0': spellClassMask0,
      'SpellClassMask1': spellClassMask1,
      'SpellClassMask2': spellClassMask2,
      'MaxTargets': maxTargets,
      'DefenseType': defenseType,
      'PreventionType': preventionType,
      'StanceBarOrder': stanceBarOrder,
      'EffectChainAmplitude0': effectChainAmplitude0,
      'EffectChainAmplitude1': effectChainAmplitude1,
      'EffectChainAmplitude2': effectChainAmplitude2,
      'MinFactionID': minFactionID,
      'MinReputation': minReputation,
      'RequiredAuraVision': requiredAuraVision,
      'RequiredTotemCategoryID0': requiredTotemCategoryID0,
      'RequiredTotemCategoryID1': requiredTotemCategoryID1,
      'RequiredAreasID': requiredAreasID,
      'SchoolMask': schoolMask,
      'RuneCostID': runeCostID,
      'SpellMissileID': spellMissileID,
      'PowerDisplayID': powerDisplayID,
      'EffectBonusCoefficient0': effectBonusCoefficient0,
      'EffectBonusCoefficient1': effectBonusCoefficient1,
      'EffectBonusCoefficient2': effectBonusCoefficient2,
      'DescriptionVariablesID': spellDescriptionVariableID,
      'Difficulty': spellDifficultyID,
    };
  }
}
