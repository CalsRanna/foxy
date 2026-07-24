// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_entity.dart';

mixin _SpellEntityMixin {
  static SpellEntity fromJson(Map<String, dynamic> json) {
    return SpellEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      category: (json['Category'] as num?)?.toInt() ?? 0,
      dispelType: (json['DispelType'] as num?)?.toInt() ?? 0,
      mechanic: (json['Mechanic'] as num?)?.toInt() ?? 0,
      attributes: (json['Attributes'] as num?)?.toInt() ?? 0,
      attributesEx: (json['AttributesEx'] as num?)?.toInt() ?? 0,
      attributesExB: (json['AttributesExB'] as num?)?.toInt() ?? 0,
      attributesExC: (json['AttributesExC'] as num?)?.toInt() ?? 0,
      attributesExD: (json['AttributesExD'] as num?)?.toInt() ?? 0,
      attributesExE: (json['AttributesExE'] as num?)?.toInt() ?? 0,
      attributesExF: (json['AttributesExF'] as num?)?.toInt() ?? 0,
      attributesExG: (json['AttributesExG'] as num?)?.toInt() ?? 0,
      shapeshiftMask0: (json['ShapeshiftMask0'] as num?)?.toInt() ?? 0,
      shapeshiftMask1: (json['ShapeshiftMask1'] as num?)?.toInt() ?? 0,
      shapeshiftExclude0: (json['ShapeshiftExclude0'] as num?)?.toInt() ?? 0,
      shapeshiftExclude1: (json['ShapeshiftExclude1'] as num?)?.toInt() ?? 0,
      targets: (json['Targets'] as num?)?.toInt() ?? 0,
      targetCreatureType: (json['TargetCreatureType'] as num?)?.toInt() ?? 0,
      requiresSpellFocus: (json['RequiresSpellFocus'] as num?)?.toInt() ?? 0,
      facingCasterFlags: (json['FacingCasterFlags'] as num?)?.toInt() ?? 0,
      casterAuraState: (json['CasterAuraState'] as num?)?.toInt() ?? 0,
      targetAuraState: (json['TargetAuraState'] as num?)?.toInt() ?? 0,
      excludeCasterAuraState:
          (json['ExcludeCasterAuraState'] as num?)?.toInt() ?? 0,
      excludeTargetAuraState:
          (json['ExcludeTargetAuraState'] as num?)?.toInt() ?? 0,
      casterAuraSpell: (json['CasterAuraSpell'] as num?)?.toInt() ?? 0,
      targetAuraSpell: (json['TargetAuraSpell'] as num?)?.toInt() ?? 0,
      excludeCasterAuraSpell:
          (json['ExcludeCasterAuraSpell'] as num?)?.toInt() ?? 0,
      excludeTargetAuraSpell:
          (json['ExcludeTargetAuraSpell'] as num?)?.toInt() ?? 0,
      castingTimeIndex: (json['CastingTimeIndex'] as num?)?.toInt() ?? 0,
      recoveryTime: (json['RecoveryTime'] as num?)?.toInt() ?? 0,
      categoryRecoveryTime:
          (json['CategoryRecoveryTime'] as num?)?.toInt() ?? 0,
      interruptFlags: (json['InterruptFlags'] as num?)?.toInt() ?? 0,
      auraInterruptFlags: (json['AuraInterruptFlags'] as num?)?.toInt() ?? 0,
      channelInterruptFlags:
          (json['ChannelInterruptFlags'] as num?)?.toInt() ?? 0,
      procTypeMask: (json['ProcTypeMask'] as num?)?.toInt() ?? 0,
      procChance: (json['ProcChance'] as num?)?.toInt() ?? 0,
      procCharges: (json['ProcCharges'] as num?)?.toInt() ?? 0,
      maxLevel: (json['MaxLevel'] as num?)?.toInt() ?? 0,
      baseLevel: (json['BaseLevel'] as num?)?.toInt() ?? 0,
      spellLevel: (json['SpellLevel'] as num?)?.toInt() ?? 0,
      durationIndex: (json['DurationIndex'] as num?)?.toInt() ?? 0,
      powerType: (json['PowerType'] as num?)?.toInt() ?? 0,
      manaCost: (json['ManaCost'] as num?)?.toInt() ?? 0,
      manaCostPerLevel: (json['ManaCostPerLevel'] as num?)?.toInt() ?? 0,
      manaPerSecond: (json['ManaPerSecond'] as num?)?.toInt() ?? 0,
      manaPerSecondPerLevel:
          (json['ManaPerSecondPerLevel'] as num?)?.toInt() ?? 0,
      rangeIndex: (json['RangeIndex'] as num?)?.toInt() ?? 0,
      speed: (json['Speed'] as num?)?.toDouble() ?? 0.0,
      modalNextSpell: (json['ModalNextSpell'] as num?)?.toInt() ?? 0,
      cumulativeAura: (json['CumulativeAura'] as num?)?.toInt() ?? 0,
      totem0: (json['Totem0'] as num?)?.toInt() ?? 0,
      totem1: (json['Totem1'] as num?)?.toInt() ?? 0,
      reagent0: (json['Reagent0'] as num?)?.toInt() ?? 0,
      reagent1: (json['Reagent1'] as num?)?.toInt() ?? 0,
      reagent2: (json['Reagent2'] as num?)?.toInt() ?? 0,
      reagent3: (json['Reagent3'] as num?)?.toInt() ?? 0,
      reagent4: (json['Reagent4'] as num?)?.toInt() ?? 0,
      reagent5: (json['Reagent5'] as num?)?.toInt() ?? 0,
      reagent6: (json['Reagent6'] as num?)?.toInt() ?? 0,
      reagent7: (json['Reagent7'] as num?)?.toInt() ?? 0,
      reagentCount0: (json['ReagentCount0'] as num?)?.toInt() ?? 0,
      reagentCount1: (json['ReagentCount1'] as num?)?.toInt() ?? 0,
      reagentCount2: (json['ReagentCount2'] as num?)?.toInt() ?? 0,
      reagentCount3: (json['ReagentCount3'] as num?)?.toInt() ?? 0,
      reagentCount4: (json['ReagentCount4'] as num?)?.toInt() ?? 0,
      reagentCount5: (json['ReagentCount5'] as num?)?.toInt() ?? 0,
      reagentCount6: (json['ReagentCount6'] as num?)?.toInt() ?? 0,
      reagentCount7: (json['ReagentCount7'] as num?)?.toInt() ?? 0,
      equippedItemClass: (json['EquippedItemClass'] as num?)?.toInt() ?? 0,
      equippedItemSubclass:
          (json['EquippedItemSubclass'] as num?)?.toInt() ?? 0,
      equippedItemInvTypes:
          (json['EquippedItemInvTypes'] as num?)?.toInt() ?? 0,
      effect0: (json['Effect0'] as num?)?.toInt() ?? 0,
      effect1: (json['Effect1'] as num?)?.toInt() ?? 0,
      effect2: (json['Effect2'] as num?)?.toInt() ?? 0,
      effectDieSides0: (json['EffectDieSides0'] as num?)?.toInt() ?? 0,
      effectDieSides1: (json['EffectDieSides1'] as num?)?.toInt() ?? 0,
      effectDieSides2: (json['EffectDieSides2'] as num?)?.toInt() ?? 0,
      effectRealPointsPerLevel0:
          (json['EffectRealPointsPerLevel0'] as num?)?.toDouble() ?? 0.0,
      effectRealPointsPerLevel1:
          (json['EffectRealPointsPerLevel1'] as num?)?.toDouble() ?? 0.0,
      effectRealPointsPerLevel2:
          (json['EffectRealPointsPerLevel2'] as num?)?.toDouble() ?? 0.0,
      effectBasePoints0: (json['EffectBasePoints0'] as num?)?.toInt() ?? 0,
      effectBasePoints1: (json['EffectBasePoints1'] as num?)?.toInt() ?? 0,
      effectBasePoints2: (json['EffectBasePoints2'] as num?)?.toInt() ?? 0,
      effectMechanic0: (json['EffectMechanic0'] as num?)?.toInt() ?? 0,
      effectMechanic1: (json['EffectMechanic1'] as num?)?.toInt() ?? 0,
      effectMechanic2: (json['EffectMechanic2'] as num?)?.toInt() ?? 0,
      implicitTargetA0: (json['ImplicitTargetA0'] as num?)?.toInt() ?? 0,
      implicitTargetA1: (json['ImplicitTargetA1'] as num?)?.toInt() ?? 0,
      implicitTargetA2: (json['ImplicitTargetA2'] as num?)?.toInt() ?? 0,
      implicitTargetB0: (json['ImplicitTargetB0'] as num?)?.toInt() ?? 0,
      implicitTargetB1: (json['ImplicitTargetB1'] as num?)?.toInt() ?? 0,
      implicitTargetB2: (json['ImplicitTargetB2'] as num?)?.toInt() ?? 0,
      effectRadiusIndex0: (json['EffectRadiusIndex0'] as num?)?.toInt() ?? 0,
      effectRadiusIndex1: (json['EffectRadiusIndex1'] as num?)?.toInt() ?? 0,
      effectRadiusIndex2: (json['EffectRadiusIndex2'] as num?)?.toInt() ?? 0,
      effectAura0: (json['EffectAura0'] as num?)?.toInt() ?? 0,
      effectAura1: (json['EffectAura1'] as num?)?.toInt() ?? 0,
      effectAura2: (json['EffectAura2'] as num?)?.toInt() ?? 0,
      effectAuraPeriod0: (json['EffectAuraPeriod0'] as num?)?.toInt() ?? 0,
      effectAuraPeriod1: (json['EffectAuraPeriod1'] as num?)?.toInt() ?? 0,
      effectAuraPeriod2: (json['EffectAuraPeriod2'] as num?)?.toInt() ?? 0,
      effectAmplitude0: (json['EffectAmplitude0'] as num?)?.toDouble() ?? 0.0,
      effectAmplitude1: (json['EffectAmplitude1'] as num?)?.toDouble() ?? 0.0,
      effectAmplitude2: (json['EffectAmplitude2'] as num?)?.toDouble() ?? 0.0,
      effectChainTargets0: (json['EffectChainTargets0'] as num?)?.toInt() ?? 0,
      effectChainTargets1: (json['EffectChainTargets1'] as num?)?.toInt() ?? 0,
      effectChainTargets2: (json['EffectChainTargets2'] as num?)?.toInt() ?? 0,
      effectItemType0: (json['EffectItemType0'] as num?)?.toInt() ?? 0,
      effectItemType1: (json['EffectItemType1'] as num?)?.toInt() ?? 0,
      effectItemType2: (json['EffectItemType2'] as num?)?.toInt() ?? 0,
      effectMiscValue0: (json['EffectMiscValue0'] as num?)?.toInt() ?? 0,
      effectMiscValue1: (json['EffectMiscValue1'] as num?)?.toInt() ?? 0,
      effectMiscValue2: (json['EffectMiscValue2'] as num?)?.toInt() ?? 0,
      effectMiscValueB0: (json['EffectMiscValueB0'] as num?)?.toInt() ?? 0,
      effectMiscValueB1: (json['EffectMiscValueB1'] as num?)?.toInt() ?? 0,
      effectMiscValueB2: (json['EffectMiscValueB2'] as num?)?.toInt() ?? 0,
      effectTriggerSpell0: (json['EffectTriggerSpell0'] as num?)?.toInt() ?? 0,
      effectTriggerSpell1: (json['EffectTriggerSpell1'] as num?)?.toInt() ?? 0,
      effectTriggerSpell2: (json['EffectTriggerSpell2'] as num?)?.toInt() ?? 0,
      effectPointsPerCombo0:
          (json['EffectPointsPerCombo0'] as num?)?.toDouble() ?? 0.0,
      effectPointsPerCombo1:
          (json['EffectPointsPerCombo1'] as num?)?.toDouble() ?? 0.0,
      effectPointsPerCombo2:
          (json['EffectPointsPerCombo2'] as num?)?.toDouble() ?? 0.0,
      effectSpellClassMaskA0:
          (json['EffectSpellClassMaskA0'] as num?)?.toInt() ?? 0,
      effectSpellClassMaskA1:
          (json['EffectSpellClassMaskA1'] as num?)?.toInt() ?? 0,
      effectSpellClassMaskA2:
          (json['EffectSpellClassMaskA2'] as num?)?.toInt() ?? 0,
      effectSpellClassMaskB0:
          (json['EffectSpellClassMaskB0'] as num?)?.toInt() ?? 0,
      effectSpellClassMaskB1:
          (json['EffectSpellClassMaskB1'] as num?)?.toInt() ?? 0,
      effectSpellClassMaskB2:
          (json['EffectSpellClassMaskB2'] as num?)?.toInt() ?? 0,
      effectSpellClassMaskC0:
          (json['EffectSpellClassMaskC0'] as num?)?.toInt() ?? 0,
      effectSpellClassMaskC1:
          (json['EffectSpellClassMaskC1'] as num?)?.toInt() ?? 0,
      effectSpellClassMaskC2:
          (json['EffectSpellClassMaskC2'] as num?)?.toInt() ?? 0,
      spellVisualID0: (json['SpellVisualID0'] as num?)?.toInt() ?? 0,
      spellVisualID1: (json['SpellVisualID1'] as num?)?.toInt() ?? 0,
      spellIconID: (json['SpellIconID'] as num?)?.toInt() ?? 0,
      activeIconID: (json['ActiveIconID'] as num?)?.toInt() ?? 0,
      spellPriority: (json['SpellPriority'] as num?)?.toInt() ?? 0,
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
      nameSubtextLangEnUS: json['NameSubtext_lang_enUS']?.toString() ?? '',
      nameSubtextLangKoKR: json['NameSubtext_lang_koKR']?.toString() ?? '',
      nameSubtextLangFrFR: json['NameSubtext_lang_frFR']?.toString() ?? '',
      nameSubtextLangDeDE: json['NameSubtext_lang_deDE']?.toString() ?? '',
      nameSubtextLangZhCN: json['NameSubtext_lang_zhCN']?.toString() ?? '',
      nameSubtextLangZhTW: json['NameSubtext_lang_zhTW']?.toString() ?? '',
      nameSubtextLangEsES: json['NameSubtext_lang_esES']?.toString() ?? '',
      nameSubtextLangEsMX: json['NameSubtext_lang_esMX']?.toString() ?? '',
      nameSubtextLangRuRU: json['NameSubtext_lang_ruRU']?.toString() ?? '',
      nameSubtextLangJaJP: json['NameSubtext_lang_jaJP']?.toString() ?? '',
      nameSubtextLangPtPT: json['NameSubtext_lang_ptPT']?.toString() ?? '',
      nameSubtextLangPtBR: json['NameSubtext_lang_ptBR']?.toString() ?? '',
      nameSubtextLangItIT: json['NameSubtext_lang_itIT']?.toString() ?? '',
      nameSubtextLangUnk1: json['NameSubtext_lang_unk1']?.toString() ?? '',
      nameSubtextLangUnk2: json['NameSubtext_lang_unk2']?.toString() ?? '',
      nameSubtextLangUnk3: json['NameSubtext_lang_unk3']?.toString() ?? '',
      nameSubtextLangFlags:
          (json['NameSubtext_lang_Flags'] as num?)?.toInt() ?? 0,
      descriptionLangEnUS: json['Description_lang_enUS']?.toString() ?? '',
      descriptionLangKoKR: json['Description_lang_koKR']?.toString() ?? '',
      descriptionLangFrFR: json['Description_lang_frFR']?.toString() ?? '',
      descriptionLangDeDE: json['Description_lang_deDE']?.toString() ?? '',
      descriptionLangZhCN: json['Description_lang_zhCN']?.toString() ?? '',
      descriptionLangZhTW: json['Description_lang_zhTW']?.toString() ?? '',
      descriptionLangEsES: json['Description_lang_esES']?.toString() ?? '',
      descriptionLangEsMX: json['Description_lang_esMX']?.toString() ?? '',
      descriptionLangRuRU: json['Description_lang_ruRU']?.toString() ?? '',
      descriptionLangJaJP: json['Description_lang_jaJP']?.toString() ?? '',
      descriptionLangPtPT: json['Description_lang_ptPT']?.toString() ?? '',
      descriptionLangPtBR: json['Description_lang_ptBR']?.toString() ?? '',
      descriptionLangItIT: json['Description_lang_itIT']?.toString() ?? '',
      descriptionLangUnk1: json['Description_lang_unk1']?.toString() ?? '',
      descriptionLangUnk2: json['Description_lang_unk2']?.toString() ?? '',
      descriptionLangUnk3: json['Description_lang_unk3']?.toString() ?? '',
      descriptionLangFlags:
          (json['Description_lang_Flags'] as num?)?.toInt() ?? 0,
      auraDescriptionLangEnUS:
          json['AuraDescription_lang_enUS']?.toString() ?? '',
      auraDescriptionLangKoKR:
          json['AuraDescription_lang_koKR']?.toString() ?? '',
      auraDescriptionLangFrFR:
          json['AuraDescription_lang_frFR']?.toString() ?? '',
      auraDescriptionLangDeDE:
          json['AuraDescription_lang_deDE']?.toString() ?? '',
      auraDescriptionLangZhCN:
          json['AuraDescription_lang_zhCN']?.toString() ?? '',
      auraDescriptionLangZhTW:
          json['AuraDescription_lang_zhTW']?.toString() ?? '',
      auraDescriptionLangEsES:
          json['AuraDescription_lang_esES']?.toString() ?? '',
      auraDescriptionLangEsMX:
          json['AuraDescription_lang_esMX']?.toString() ?? '',
      auraDescriptionLangRuRU:
          json['AuraDescription_lang_ruRU']?.toString() ?? '',
      auraDescriptionLangJaJP:
          json['AuraDescription_lang_jaJP']?.toString() ?? '',
      auraDescriptionLangPtPT:
          json['AuraDescription_lang_ptPT']?.toString() ?? '',
      auraDescriptionLangPtBR:
          json['AuraDescription_lang_ptBR']?.toString() ?? '',
      auraDescriptionLangItIT:
          json['AuraDescription_lang_itIT']?.toString() ?? '',
      auraDescriptionLangUnk1:
          json['AuraDescription_lang_unk1']?.toString() ?? '',
      auraDescriptionLangUnk2:
          json['AuraDescription_lang_unk2']?.toString() ?? '',
      auraDescriptionLangUnk3:
          json['AuraDescription_lang_unk3']?.toString() ?? '',
      auraDescriptionLangFlags:
          (json['AuraDescription_lang_Flags'] as num?)?.toInt() ?? 0,
      manaCostPct: (json['ManaCostPct'] as num?)?.toInt() ?? 0,
      startRecoveryCategory:
          (json['StartRecoveryCategory'] as num?)?.toInt() ?? 0,
      startRecoveryTime: (json['StartRecoveryTime'] as num?)?.toInt() ?? 0,
      maxTargetLevel: (json['MaxTargetLevel'] as num?)?.toInt() ?? 0,
      spellClassSet: (json['SpellClassSet'] as num?)?.toInt() ?? 0,
      spellClassMask0: (json['SpellClassMask0'] as num?)?.toInt() ?? 0,
      spellClassMask1: (json['SpellClassMask1'] as num?)?.toInt() ?? 0,
      spellClassMask2: (json['SpellClassMask2'] as num?)?.toInt() ?? 0,
      maxTargets: (json['MaxTargets'] as num?)?.toInt() ?? 0,
      defenseType: (json['DefenseType'] as num?)?.toInt() ?? 0,
      preventionType: (json['PreventionType'] as num?)?.toInt() ?? 0,
      stanceBarOrder: (json['StanceBarOrder'] as num?)?.toInt() ?? 0,
      effectChainAmplitude0:
          (json['EffectChainAmplitude0'] as num?)?.toDouble() ?? 0.0,
      effectChainAmplitude1:
          (json['EffectChainAmplitude1'] as num?)?.toDouble() ?? 0.0,
      effectChainAmplitude2:
          (json['EffectChainAmplitude2'] as num?)?.toDouble() ?? 0.0,
      minFactionID: (json['MinFactionID'] as num?)?.toInt() ?? 0,
      minReputation: (json['MinReputation'] as num?)?.toInt() ?? 0,
      requiredAuraVision: (json['RequiredAuraVision'] as num?)?.toInt() ?? 0,
      requiredTotemCategoryID0:
          (json['RequiredTotemCategoryID0'] as num?)?.toInt() ?? 0,
      requiredTotemCategoryID1:
          (json['RequiredTotemCategoryID1'] as num?)?.toInt() ?? 0,
      requiredAreasID: (json['RequiredAreasID'] as num?)?.toInt() ?? 0,
      schoolMask: (json['SchoolMask'] as num?)?.toInt() ?? 0,
      runeCostID: (json['RuneCostID'] as num?)?.toInt() ?? 0,
      spellMissileID: (json['SpellMissileID'] as num?)?.toInt() ?? 0,
      powerDisplayID: (json['PowerDisplayID'] as num?)?.toInt() ?? 0,
      effectBonusCoefficient0:
          (json['EffectBonusCoefficient0'] as num?)?.toDouble() ?? 0.0,
      effectBonusCoefficient1:
          (json['EffectBonusCoefficient1'] as num?)?.toDouble() ?? 0.0,
      effectBonusCoefficient2:
          (json['EffectBonusCoefficient2'] as num?)?.toDouble() ?? 0.0,
      spellDescriptionVariableID:
          (json['DescriptionVariablesID'] as num?)?.toInt() ?? 0,
      spellDifficultyID: (json['Difficulty'] as num?)?.toInt() ?? 0,
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
    final self = this as SpellEntity;
    return SpellEntity(
      id: id ?? self.id,
      category: category ?? self.category,
      dispelType: dispelType ?? self.dispelType,
      mechanic: mechanic ?? self.mechanic,
      attributes: attributes ?? self.attributes,
      attributesEx: attributesEx ?? self.attributesEx,
      attributesExB: attributesExB ?? self.attributesExB,
      attributesExC: attributesExC ?? self.attributesExC,
      attributesExD: attributesExD ?? self.attributesExD,
      attributesExE: attributesExE ?? self.attributesExE,
      attributesExF: attributesExF ?? self.attributesExF,
      attributesExG: attributesExG ?? self.attributesExG,
      shapeshiftMask0: shapeshiftMask0 ?? self.shapeshiftMask0,
      shapeshiftMask1: shapeshiftMask1 ?? self.shapeshiftMask1,
      shapeshiftExclude0: shapeshiftExclude0 ?? self.shapeshiftExclude0,
      shapeshiftExclude1: shapeshiftExclude1 ?? self.shapeshiftExclude1,
      targets: targets ?? self.targets,
      targetCreatureType: targetCreatureType ?? self.targetCreatureType,
      requiresSpellFocus: requiresSpellFocus ?? self.requiresSpellFocus,
      facingCasterFlags: facingCasterFlags ?? self.facingCasterFlags,
      casterAuraState: casterAuraState ?? self.casterAuraState,
      targetAuraState: targetAuraState ?? self.targetAuraState,
      excludeCasterAuraState:
          excludeCasterAuraState ?? self.excludeCasterAuraState,
      excludeTargetAuraState:
          excludeTargetAuraState ?? self.excludeTargetAuraState,
      casterAuraSpell: casterAuraSpell ?? self.casterAuraSpell,
      targetAuraSpell: targetAuraSpell ?? self.targetAuraSpell,
      excludeCasterAuraSpell:
          excludeCasterAuraSpell ?? self.excludeCasterAuraSpell,
      excludeTargetAuraSpell:
          excludeTargetAuraSpell ?? self.excludeTargetAuraSpell,
      castingTimeIndex: castingTimeIndex ?? self.castingTimeIndex,
      recoveryTime: recoveryTime ?? self.recoveryTime,
      categoryRecoveryTime: categoryRecoveryTime ?? self.categoryRecoveryTime,
      interruptFlags: interruptFlags ?? self.interruptFlags,
      auraInterruptFlags: auraInterruptFlags ?? self.auraInterruptFlags,
      channelInterruptFlags:
          channelInterruptFlags ?? self.channelInterruptFlags,
      procTypeMask: procTypeMask ?? self.procTypeMask,
      procChance: procChance ?? self.procChance,
      procCharges: procCharges ?? self.procCharges,
      maxLevel: maxLevel ?? self.maxLevel,
      baseLevel: baseLevel ?? self.baseLevel,
      spellLevel: spellLevel ?? self.spellLevel,
      durationIndex: durationIndex ?? self.durationIndex,
      powerType: powerType ?? self.powerType,
      manaCost: manaCost ?? self.manaCost,
      manaCostPerLevel: manaCostPerLevel ?? self.manaCostPerLevel,
      manaPerSecond: manaPerSecond ?? self.manaPerSecond,
      manaPerSecondPerLevel:
          manaPerSecondPerLevel ?? self.manaPerSecondPerLevel,
      rangeIndex: rangeIndex ?? self.rangeIndex,
      speed: speed ?? self.speed,
      modalNextSpell: modalNextSpell ?? self.modalNextSpell,
      cumulativeAura: cumulativeAura ?? self.cumulativeAura,
      totem0: totem0 ?? self.totem0,
      totem1: totem1 ?? self.totem1,
      reagent0: reagent0 ?? self.reagent0,
      reagent1: reagent1 ?? self.reagent1,
      reagent2: reagent2 ?? self.reagent2,
      reagent3: reagent3 ?? self.reagent3,
      reagent4: reagent4 ?? self.reagent4,
      reagent5: reagent5 ?? self.reagent5,
      reagent6: reagent6 ?? self.reagent6,
      reagent7: reagent7 ?? self.reagent7,
      reagentCount0: reagentCount0 ?? self.reagentCount0,
      reagentCount1: reagentCount1 ?? self.reagentCount1,
      reagentCount2: reagentCount2 ?? self.reagentCount2,
      reagentCount3: reagentCount3 ?? self.reagentCount3,
      reagentCount4: reagentCount4 ?? self.reagentCount4,
      reagentCount5: reagentCount5 ?? self.reagentCount5,
      reagentCount6: reagentCount6 ?? self.reagentCount6,
      reagentCount7: reagentCount7 ?? self.reagentCount7,
      equippedItemClass: equippedItemClass ?? self.equippedItemClass,
      equippedItemSubclass: equippedItemSubclass ?? self.equippedItemSubclass,
      equippedItemInvTypes: equippedItemInvTypes ?? self.equippedItemInvTypes,
      effect0: effect0 ?? self.effect0,
      effect1: effect1 ?? self.effect1,
      effect2: effect2 ?? self.effect2,
      effectDieSides0: effectDieSides0 ?? self.effectDieSides0,
      effectDieSides1: effectDieSides1 ?? self.effectDieSides1,
      effectDieSides2: effectDieSides2 ?? self.effectDieSides2,
      effectRealPointsPerLevel0:
          effectRealPointsPerLevel0 ?? self.effectRealPointsPerLevel0,
      effectRealPointsPerLevel1:
          effectRealPointsPerLevel1 ?? self.effectRealPointsPerLevel1,
      effectRealPointsPerLevel2:
          effectRealPointsPerLevel2 ?? self.effectRealPointsPerLevel2,
      effectBasePoints0: effectBasePoints0 ?? self.effectBasePoints0,
      effectBasePoints1: effectBasePoints1 ?? self.effectBasePoints1,
      effectBasePoints2: effectBasePoints2 ?? self.effectBasePoints2,
      effectMechanic0: effectMechanic0 ?? self.effectMechanic0,
      effectMechanic1: effectMechanic1 ?? self.effectMechanic1,
      effectMechanic2: effectMechanic2 ?? self.effectMechanic2,
      implicitTargetA0: implicitTargetA0 ?? self.implicitTargetA0,
      implicitTargetA1: implicitTargetA1 ?? self.implicitTargetA1,
      implicitTargetA2: implicitTargetA2 ?? self.implicitTargetA2,
      implicitTargetB0: implicitTargetB0 ?? self.implicitTargetB0,
      implicitTargetB1: implicitTargetB1 ?? self.implicitTargetB1,
      implicitTargetB2: implicitTargetB2 ?? self.implicitTargetB2,
      effectRadiusIndex0: effectRadiusIndex0 ?? self.effectRadiusIndex0,
      effectRadiusIndex1: effectRadiusIndex1 ?? self.effectRadiusIndex1,
      effectRadiusIndex2: effectRadiusIndex2 ?? self.effectRadiusIndex2,
      effectAura0: effectAura0 ?? self.effectAura0,
      effectAura1: effectAura1 ?? self.effectAura1,
      effectAura2: effectAura2 ?? self.effectAura2,
      effectAuraPeriod0: effectAuraPeriod0 ?? self.effectAuraPeriod0,
      effectAuraPeriod1: effectAuraPeriod1 ?? self.effectAuraPeriod1,
      effectAuraPeriod2: effectAuraPeriod2 ?? self.effectAuraPeriod2,
      effectAmplitude0: effectAmplitude0 ?? self.effectAmplitude0,
      effectAmplitude1: effectAmplitude1 ?? self.effectAmplitude1,
      effectAmplitude2: effectAmplitude2 ?? self.effectAmplitude2,
      effectChainTargets0: effectChainTargets0 ?? self.effectChainTargets0,
      effectChainTargets1: effectChainTargets1 ?? self.effectChainTargets1,
      effectChainTargets2: effectChainTargets2 ?? self.effectChainTargets2,
      effectItemType0: effectItemType0 ?? self.effectItemType0,
      effectItemType1: effectItemType1 ?? self.effectItemType1,
      effectItemType2: effectItemType2 ?? self.effectItemType2,
      effectMiscValue0: effectMiscValue0 ?? self.effectMiscValue0,
      effectMiscValue1: effectMiscValue1 ?? self.effectMiscValue1,
      effectMiscValue2: effectMiscValue2 ?? self.effectMiscValue2,
      effectMiscValueB0: effectMiscValueB0 ?? self.effectMiscValueB0,
      effectMiscValueB1: effectMiscValueB1 ?? self.effectMiscValueB1,
      effectMiscValueB2: effectMiscValueB2 ?? self.effectMiscValueB2,
      effectTriggerSpell0: effectTriggerSpell0 ?? self.effectTriggerSpell0,
      effectTriggerSpell1: effectTriggerSpell1 ?? self.effectTriggerSpell1,
      effectTriggerSpell2: effectTriggerSpell2 ?? self.effectTriggerSpell2,
      effectPointsPerCombo0:
          effectPointsPerCombo0 ?? self.effectPointsPerCombo0,
      effectPointsPerCombo1:
          effectPointsPerCombo1 ?? self.effectPointsPerCombo1,
      effectPointsPerCombo2:
          effectPointsPerCombo2 ?? self.effectPointsPerCombo2,
      effectSpellClassMaskA0:
          effectSpellClassMaskA0 ?? self.effectSpellClassMaskA0,
      effectSpellClassMaskA1:
          effectSpellClassMaskA1 ?? self.effectSpellClassMaskA1,
      effectSpellClassMaskA2:
          effectSpellClassMaskA2 ?? self.effectSpellClassMaskA2,
      effectSpellClassMaskB0:
          effectSpellClassMaskB0 ?? self.effectSpellClassMaskB0,
      effectSpellClassMaskB1:
          effectSpellClassMaskB1 ?? self.effectSpellClassMaskB1,
      effectSpellClassMaskB2:
          effectSpellClassMaskB2 ?? self.effectSpellClassMaskB2,
      effectSpellClassMaskC0:
          effectSpellClassMaskC0 ?? self.effectSpellClassMaskC0,
      effectSpellClassMaskC1:
          effectSpellClassMaskC1 ?? self.effectSpellClassMaskC1,
      effectSpellClassMaskC2:
          effectSpellClassMaskC2 ?? self.effectSpellClassMaskC2,
      spellVisualID0: spellVisualID0 ?? self.spellVisualID0,
      spellVisualID1: spellVisualID1 ?? self.spellVisualID1,
      spellIconID: spellIconID ?? self.spellIconID,
      activeIconID: activeIconID ?? self.activeIconID,
      spellPriority: spellPriority ?? self.spellPriority,
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
      nameSubtextLangEnUS: nameSubtextLangEnUS ?? self.nameSubtextLangEnUS,
      nameSubtextLangKoKR: nameSubtextLangKoKR ?? self.nameSubtextLangKoKR,
      nameSubtextLangFrFR: nameSubtextLangFrFR ?? self.nameSubtextLangFrFR,
      nameSubtextLangDeDE: nameSubtextLangDeDE ?? self.nameSubtextLangDeDE,
      nameSubtextLangZhCN: nameSubtextLangZhCN ?? self.nameSubtextLangZhCN,
      nameSubtextLangZhTW: nameSubtextLangZhTW ?? self.nameSubtextLangZhTW,
      nameSubtextLangEsES: nameSubtextLangEsES ?? self.nameSubtextLangEsES,
      nameSubtextLangEsMX: nameSubtextLangEsMX ?? self.nameSubtextLangEsMX,
      nameSubtextLangRuRU: nameSubtextLangRuRU ?? self.nameSubtextLangRuRU,
      nameSubtextLangJaJP: nameSubtextLangJaJP ?? self.nameSubtextLangJaJP,
      nameSubtextLangPtPT: nameSubtextLangPtPT ?? self.nameSubtextLangPtPT,
      nameSubtextLangPtBR: nameSubtextLangPtBR ?? self.nameSubtextLangPtBR,
      nameSubtextLangItIT: nameSubtextLangItIT ?? self.nameSubtextLangItIT,
      nameSubtextLangUnk1: nameSubtextLangUnk1 ?? self.nameSubtextLangUnk1,
      nameSubtextLangUnk2: nameSubtextLangUnk2 ?? self.nameSubtextLangUnk2,
      nameSubtextLangUnk3: nameSubtextLangUnk3 ?? self.nameSubtextLangUnk3,
      nameSubtextLangFlags: nameSubtextLangFlags ?? self.nameSubtextLangFlags,
      descriptionLangEnUS: descriptionLangEnUS ?? self.descriptionLangEnUS,
      descriptionLangKoKR: descriptionLangKoKR ?? self.descriptionLangKoKR,
      descriptionLangFrFR: descriptionLangFrFR ?? self.descriptionLangFrFR,
      descriptionLangDeDE: descriptionLangDeDE ?? self.descriptionLangDeDE,
      descriptionLangZhCN: descriptionLangZhCN ?? self.descriptionLangZhCN,
      descriptionLangZhTW: descriptionLangZhTW ?? self.descriptionLangZhTW,
      descriptionLangEsES: descriptionLangEsES ?? self.descriptionLangEsES,
      descriptionLangEsMX: descriptionLangEsMX ?? self.descriptionLangEsMX,
      descriptionLangRuRU: descriptionLangRuRU ?? self.descriptionLangRuRU,
      descriptionLangJaJP: descriptionLangJaJP ?? self.descriptionLangJaJP,
      descriptionLangPtPT: descriptionLangPtPT ?? self.descriptionLangPtPT,
      descriptionLangPtBR: descriptionLangPtBR ?? self.descriptionLangPtBR,
      descriptionLangItIT: descriptionLangItIT ?? self.descriptionLangItIT,
      descriptionLangUnk1: descriptionLangUnk1 ?? self.descriptionLangUnk1,
      descriptionLangUnk2: descriptionLangUnk2 ?? self.descriptionLangUnk2,
      descriptionLangUnk3: descriptionLangUnk3 ?? self.descriptionLangUnk3,
      descriptionLangFlags: descriptionLangFlags ?? self.descriptionLangFlags,
      auraDescriptionLangEnUS:
          auraDescriptionLangEnUS ?? self.auraDescriptionLangEnUS,
      auraDescriptionLangKoKR:
          auraDescriptionLangKoKR ?? self.auraDescriptionLangKoKR,
      auraDescriptionLangFrFR:
          auraDescriptionLangFrFR ?? self.auraDescriptionLangFrFR,
      auraDescriptionLangDeDE:
          auraDescriptionLangDeDE ?? self.auraDescriptionLangDeDE,
      auraDescriptionLangZhCN:
          auraDescriptionLangZhCN ?? self.auraDescriptionLangZhCN,
      auraDescriptionLangZhTW:
          auraDescriptionLangZhTW ?? self.auraDescriptionLangZhTW,
      auraDescriptionLangEsES:
          auraDescriptionLangEsES ?? self.auraDescriptionLangEsES,
      auraDescriptionLangEsMX:
          auraDescriptionLangEsMX ?? self.auraDescriptionLangEsMX,
      auraDescriptionLangRuRU:
          auraDescriptionLangRuRU ?? self.auraDescriptionLangRuRU,
      auraDescriptionLangJaJP:
          auraDescriptionLangJaJP ?? self.auraDescriptionLangJaJP,
      auraDescriptionLangPtPT:
          auraDescriptionLangPtPT ?? self.auraDescriptionLangPtPT,
      auraDescriptionLangPtBR:
          auraDescriptionLangPtBR ?? self.auraDescriptionLangPtBR,
      auraDescriptionLangItIT:
          auraDescriptionLangItIT ?? self.auraDescriptionLangItIT,
      auraDescriptionLangUnk1:
          auraDescriptionLangUnk1 ?? self.auraDescriptionLangUnk1,
      auraDescriptionLangUnk2:
          auraDescriptionLangUnk2 ?? self.auraDescriptionLangUnk2,
      auraDescriptionLangUnk3:
          auraDescriptionLangUnk3 ?? self.auraDescriptionLangUnk3,
      auraDescriptionLangFlags:
          auraDescriptionLangFlags ?? self.auraDescriptionLangFlags,
      manaCostPct: manaCostPct ?? self.manaCostPct,
      startRecoveryCategory:
          startRecoveryCategory ?? self.startRecoveryCategory,
      startRecoveryTime: startRecoveryTime ?? self.startRecoveryTime,
      maxTargetLevel: maxTargetLevel ?? self.maxTargetLevel,
      spellClassSet: spellClassSet ?? self.spellClassSet,
      spellClassMask0: spellClassMask0 ?? self.spellClassMask0,
      spellClassMask1: spellClassMask1 ?? self.spellClassMask1,
      spellClassMask2: spellClassMask2 ?? self.spellClassMask2,
      maxTargets: maxTargets ?? self.maxTargets,
      defenseType: defenseType ?? self.defenseType,
      preventionType: preventionType ?? self.preventionType,
      stanceBarOrder: stanceBarOrder ?? self.stanceBarOrder,
      effectChainAmplitude0:
          effectChainAmplitude0 ?? self.effectChainAmplitude0,
      effectChainAmplitude1:
          effectChainAmplitude1 ?? self.effectChainAmplitude1,
      effectChainAmplitude2:
          effectChainAmplitude2 ?? self.effectChainAmplitude2,
      minFactionID: minFactionID ?? self.minFactionID,
      minReputation: minReputation ?? self.minReputation,
      requiredAuraVision: requiredAuraVision ?? self.requiredAuraVision,
      requiredTotemCategoryID0:
          requiredTotemCategoryID0 ?? self.requiredTotemCategoryID0,
      requiredTotemCategoryID1:
          requiredTotemCategoryID1 ?? self.requiredTotemCategoryID1,
      requiredAreasID: requiredAreasID ?? self.requiredAreasID,
      schoolMask: schoolMask ?? self.schoolMask,
      runeCostID: runeCostID ?? self.runeCostID,
      spellMissileID: spellMissileID ?? self.spellMissileID,
      powerDisplayID: powerDisplayID ?? self.powerDisplayID,
      effectBonusCoefficient0:
          effectBonusCoefficient0 ?? self.effectBonusCoefficient0,
      effectBonusCoefficient1:
          effectBonusCoefficient1 ?? self.effectBonusCoefficient1,
      effectBonusCoefficient2:
          effectBonusCoefficient2 ?? self.effectBonusCoefficient2,
      spellDescriptionVariableID:
          spellDescriptionVariableID ?? self.spellDescriptionVariableID,
      spellDifficultyID: spellDifficultyID ?? self.spellDifficultyID,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SpellEntity;
    return {
      'ID': self.id,
      'Category': self.category,
      'DispelType': self.dispelType,
      'Mechanic': self.mechanic,
      'Attributes': self.attributes,
      'AttributesEx': self.attributesEx,
      'AttributesExB': self.attributesExB,
      'AttributesExC': self.attributesExC,
      'AttributesExD': self.attributesExD,
      'AttributesExE': self.attributesExE,
      'AttributesExF': self.attributesExF,
      'AttributesExG': self.attributesExG,
      'ShapeshiftMask0': self.shapeshiftMask0,
      'ShapeshiftMask1': self.shapeshiftMask1,
      'ShapeshiftExclude0': self.shapeshiftExclude0,
      'ShapeshiftExclude1': self.shapeshiftExclude1,
      'Targets': self.targets,
      'TargetCreatureType': self.targetCreatureType,
      'RequiresSpellFocus': self.requiresSpellFocus,
      'FacingCasterFlags': self.facingCasterFlags,
      'CasterAuraState': self.casterAuraState,
      'TargetAuraState': self.targetAuraState,
      'ExcludeCasterAuraState': self.excludeCasterAuraState,
      'ExcludeTargetAuraState': self.excludeTargetAuraState,
      'CasterAuraSpell': self.casterAuraSpell,
      'TargetAuraSpell': self.targetAuraSpell,
      'ExcludeCasterAuraSpell': self.excludeCasterAuraSpell,
      'ExcludeTargetAuraSpell': self.excludeTargetAuraSpell,
      'CastingTimeIndex': self.castingTimeIndex,
      'RecoveryTime': self.recoveryTime,
      'CategoryRecoveryTime': self.categoryRecoveryTime,
      'InterruptFlags': self.interruptFlags,
      'AuraInterruptFlags': self.auraInterruptFlags,
      'ChannelInterruptFlags': self.channelInterruptFlags,
      'ProcTypeMask': self.procTypeMask,
      'ProcChance': self.procChance,
      'ProcCharges': self.procCharges,
      'MaxLevel': self.maxLevel,
      'BaseLevel': self.baseLevel,
      'SpellLevel': self.spellLevel,
      'DurationIndex': self.durationIndex,
      'PowerType': self.powerType,
      'ManaCost': self.manaCost,
      'ManaCostPerLevel': self.manaCostPerLevel,
      'ManaPerSecond': self.manaPerSecond,
      'ManaPerSecondPerLevel': self.manaPerSecondPerLevel,
      'RangeIndex': self.rangeIndex,
      'Speed': self.speed,
      'ModalNextSpell': self.modalNextSpell,
      'CumulativeAura': self.cumulativeAura,
      'Totem0': self.totem0,
      'Totem1': self.totem1,
      'Reagent0': self.reagent0,
      'Reagent1': self.reagent1,
      'Reagent2': self.reagent2,
      'Reagent3': self.reagent3,
      'Reagent4': self.reagent4,
      'Reagent5': self.reagent5,
      'Reagent6': self.reagent6,
      'Reagent7': self.reagent7,
      'ReagentCount0': self.reagentCount0,
      'ReagentCount1': self.reagentCount1,
      'ReagentCount2': self.reagentCount2,
      'ReagentCount3': self.reagentCount3,
      'ReagentCount4': self.reagentCount4,
      'ReagentCount5': self.reagentCount5,
      'ReagentCount6': self.reagentCount6,
      'ReagentCount7': self.reagentCount7,
      'EquippedItemClass': self.equippedItemClass,
      'EquippedItemSubclass': self.equippedItemSubclass,
      'EquippedItemInvTypes': self.equippedItemInvTypes,
      'Effect0': self.effect0,
      'Effect1': self.effect1,
      'Effect2': self.effect2,
      'EffectDieSides0': self.effectDieSides0,
      'EffectDieSides1': self.effectDieSides1,
      'EffectDieSides2': self.effectDieSides2,
      'EffectRealPointsPerLevel0': self.effectRealPointsPerLevel0,
      'EffectRealPointsPerLevel1': self.effectRealPointsPerLevel1,
      'EffectRealPointsPerLevel2': self.effectRealPointsPerLevel2,
      'EffectBasePoints0': self.effectBasePoints0,
      'EffectBasePoints1': self.effectBasePoints1,
      'EffectBasePoints2': self.effectBasePoints2,
      'EffectMechanic0': self.effectMechanic0,
      'EffectMechanic1': self.effectMechanic1,
      'EffectMechanic2': self.effectMechanic2,
      'ImplicitTargetA0': self.implicitTargetA0,
      'ImplicitTargetA1': self.implicitTargetA1,
      'ImplicitTargetA2': self.implicitTargetA2,
      'ImplicitTargetB0': self.implicitTargetB0,
      'ImplicitTargetB1': self.implicitTargetB1,
      'ImplicitTargetB2': self.implicitTargetB2,
      'EffectRadiusIndex0': self.effectRadiusIndex0,
      'EffectRadiusIndex1': self.effectRadiusIndex1,
      'EffectRadiusIndex2': self.effectRadiusIndex2,
      'EffectAura0': self.effectAura0,
      'EffectAura1': self.effectAura1,
      'EffectAura2': self.effectAura2,
      'EffectAuraPeriod0': self.effectAuraPeriod0,
      'EffectAuraPeriod1': self.effectAuraPeriod1,
      'EffectAuraPeriod2': self.effectAuraPeriod2,
      'EffectAmplitude0': self.effectAmplitude0,
      'EffectAmplitude1': self.effectAmplitude1,
      'EffectAmplitude2': self.effectAmplitude2,
      'EffectChainTargets0': self.effectChainTargets0,
      'EffectChainTargets1': self.effectChainTargets1,
      'EffectChainTargets2': self.effectChainTargets2,
      'EffectItemType0': self.effectItemType0,
      'EffectItemType1': self.effectItemType1,
      'EffectItemType2': self.effectItemType2,
      'EffectMiscValue0': self.effectMiscValue0,
      'EffectMiscValue1': self.effectMiscValue1,
      'EffectMiscValue2': self.effectMiscValue2,
      'EffectMiscValueB0': self.effectMiscValueB0,
      'EffectMiscValueB1': self.effectMiscValueB1,
      'EffectMiscValueB2': self.effectMiscValueB2,
      'EffectTriggerSpell0': self.effectTriggerSpell0,
      'EffectTriggerSpell1': self.effectTriggerSpell1,
      'EffectTriggerSpell2': self.effectTriggerSpell2,
      'EffectPointsPerCombo0': self.effectPointsPerCombo0,
      'EffectPointsPerCombo1': self.effectPointsPerCombo1,
      'EffectPointsPerCombo2': self.effectPointsPerCombo2,
      'EffectSpellClassMaskA0': self.effectSpellClassMaskA0,
      'EffectSpellClassMaskA1': self.effectSpellClassMaskA1,
      'EffectSpellClassMaskA2': self.effectSpellClassMaskA2,
      'EffectSpellClassMaskB0': self.effectSpellClassMaskB0,
      'EffectSpellClassMaskB1': self.effectSpellClassMaskB1,
      'EffectSpellClassMaskB2': self.effectSpellClassMaskB2,
      'EffectSpellClassMaskC0': self.effectSpellClassMaskC0,
      'EffectSpellClassMaskC1': self.effectSpellClassMaskC1,
      'EffectSpellClassMaskC2': self.effectSpellClassMaskC2,
      'SpellVisualID0': self.spellVisualID0,
      'SpellVisualID1': self.spellVisualID1,
      'SpellIconID': self.spellIconID,
      'ActiveIconID': self.activeIconID,
      'SpellPriority': self.spellPriority,
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
      'NameSubtext_lang_enUS': self.nameSubtextLangEnUS,
      'NameSubtext_lang_koKR': self.nameSubtextLangKoKR,
      'NameSubtext_lang_frFR': self.nameSubtextLangFrFR,
      'NameSubtext_lang_deDE': self.nameSubtextLangDeDE,
      'NameSubtext_lang_zhCN': self.nameSubtextLangZhCN,
      'NameSubtext_lang_zhTW': self.nameSubtextLangZhTW,
      'NameSubtext_lang_esES': self.nameSubtextLangEsES,
      'NameSubtext_lang_esMX': self.nameSubtextLangEsMX,
      'NameSubtext_lang_ruRU': self.nameSubtextLangRuRU,
      'NameSubtext_lang_jaJP': self.nameSubtextLangJaJP,
      'NameSubtext_lang_ptPT': self.nameSubtextLangPtPT,
      'NameSubtext_lang_ptBR': self.nameSubtextLangPtBR,
      'NameSubtext_lang_itIT': self.nameSubtextLangItIT,
      'NameSubtext_lang_unk1': self.nameSubtextLangUnk1,
      'NameSubtext_lang_unk2': self.nameSubtextLangUnk2,
      'NameSubtext_lang_unk3': self.nameSubtextLangUnk3,
      'NameSubtext_lang_Flags': self.nameSubtextLangFlags,
      'Description_lang_enUS': self.descriptionLangEnUS,
      'Description_lang_koKR': self.descriptionLangKoKR,
      'Description_lang_frFR': self.descriptionLangFrFR,
      'Description_lang_deDE': self.descriptionLangDeDE,
      'Description_lang_zhCN': self.descriptionLangZhCN,
      'Description_lang_zhTW': self.descriptionLangZhTW,
      'Description_lang_esES': self.descriptionLangEsES,
      'Description_lang_esMX': self.descriptionLangEsMX,
      'Description_lang_ruRU': self.descriptionLangRuRU,
      'Description_lang_jaJP': self.descriptionLangJaJP,
      'Description_lang_ptPT': self.descriptionLangPtPT,
      'Description_lang_ptBR': self.descriptionLangPtBR,
      'Description_lang_itIT': self.descriptionLangItIT,
      'Description_lang_unk1': self.descriptionLangUnk1,
      'Description_lang_unk2': self.descriptionLangUnk2,
      'Description_lang_unk3': self.descriptionLangUnk3,
      'Description_lang_Flags': self.descriptionLangFlags,
      'AuraDescription_lang_enUS': self.auraDescriptionLangEnUS,
      'AuraDescription_lang_koKR': self.auraDescriptionLangKoKR,
      'AuraDescription_lang_frFR': self.auraDescriptionLangFrFR,
      'AuraDescription_lang_deDE': self.auraDescriptionLangDeDE,
      'AuraDescription_lang_zhCN': self.auraDescriptionLangZhCN,
      'AuraDescription_lang_zhTW': self.auraDescriptionLangZhTW,
      'AuraDescription_lang_esES': self.auraDescriptionLangEsES,
      'AuraDescription_lang_esMX': self.auraDescriptionLangEsMX,
      'AuraDescription_lang_ruRU': self.auraDescriptionLangRuRU,
      'AuraDescription_lang_jaJP': self.auraDescriptionLangJaJP,
      'AuraDescription_lang_ptPT': self.auraDescriptionLangPtPT,
      'AuraDescription_lang_ptBR': self.auraDescriptionLangPtBR,
      'AuraDescription_lang_itIT': self.auraDescriptionLangItIT,
      'AuraDescription_lang_unk1': self.auraDescriptionLangUnk1,
      'AuraDescription_lang_unk2': self.auraDescriptionLangUnk2,
      'AuraDescription_lang_unk3': self.auraDescriptionLangUnk3,
      'AuraDescription_lang_Flags': self.auraDescriptionLangFlags,
      'ManaCostPct': self.manaCostPct,
      'StartRecoveryCategory': self.startRecoveryCategory,
      'StartRecoveryTime': self.startRecoveryTime,
      'MaxTargetLevel': self.maxTargetLevel,
      'SpellClassSet': self.spellClassSet,
      'SpellClassMask0': self.spellClassMask0,
      'SpellClassMask1': self.spellClassMask1,
      'SpellClassMask2': self.spellClassMask2,
      'MaxTargets': self.maxTargets,
      'DefenseType': self.defenseType,
      'PreventionType': self.preventionType,
      'StanceBarOrder': self.stanceBarOrder,
      'EffectChainAmplitude0': self.effectChainAmplitude0,
      'EffectChainAmplitude1': self.effectChainAmplitude1,
      'EffectChainAmplitude2': self.effectChainAmplitude2,
      'MinFactionID': self.minFactionID,
      'MinReputation': self.minReputation,
      'RequiredAuraVision': self.requiredAuraVision,
      'RequiredTotemCategoryID0': self.requiredTotemCategoryID0,
      'RequiredTotemCategoryID1': self.requiredTotemCategoryID1,
      'RequiredAreasID': self.requiredAreasID,
      'SchoolMask': self.schoolMask,
      'RuneCostID': self.runeCostID,
      'SpellMissileID': self.spellMissileID,
      'PowerDisplayID': self.powerDisplayID,
      'EffectBonusCoefficient0': self.effectBonusCoefficient0,
      'EffectBonusCoefficient1': self.effectBonusCoefficient1,
      'EffectBonusCoefficient2': self.effectBonusCoefficient2,
      'DescriptionVariablesID': self.spellDescriptionVariableID,
      'Difficulty': self.spellDifficultyID,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as SpellEntity;
    return identical(self, other) ||
        other is SpellEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.category == other.category &&
            self.dispelType == other.dispelType &&
            self.mechanic == other.mechanic &&
            self.attributes == other.attributes &&
            self.attributesEx == other.attributesEx &&
            self.attributesExB == other.attributesExB &&
            self.attributesExC == other.attributesExC &&
            self.attributesExD == other.attributesExD &&
            self.attributesExE == other.attributesExE &&
            self.attributesExF == other.attributesExF &&
            self.attributesExG == other.attributesExG &&
            self.shapeshiftMask0 == other.shapeshiftMask0 &&
            self.shapeshiftMask1 == other.shapeshiftMask1 &&
            self.shapeshiftExclude0 == other.shapeshiftExclude0 &&
            self.shapeshiftExclude1 == other.shapeshiftExclude1 &&
            self.targets == other.targets &&
            self.targetCreatureType == other.targetCreatureType &&
            self.requiresSpellFocus == other.requiresSpellFocus &&
            self.facingCasterFlags == other.facingCasterFlags &&
            self.casterAuraState == other.casterAuraState &&
            self.targetAuraState == other.targetAuraState &&
            self.excludeCasterAuraState == other.excludeCasterAuraState &&
            self.excludeTargetAuraState == other.excludeTargetAuraState &&
            self.casterAuraSpell == other.casterAuraSpell &&
            self.targetAuraSpell == other.targetAuraSpell &&
            self.excludeCasterAuraSpell == other.excludeCasterAuraSpell &&
            self.excludeTargetAuraSpell == other.excludeTargetAuraSpell &&
            self.castingTimeIndex == other.castingTimeIndex &&
            self.recoveryTime == other.recoveryTime &&
            self.categoryRecoveryTime == other.categoryRecoveryTime &&
            self.interruptFlags == other.interruptFlags &&
            self.auraInterruptFlags == other.auraInterruptFlags &&
            self.channelInterruptFlags == other.channelInterruptFlags &&
            self.procTypeMask == other.procTypeMask &&
            self.procChance == other.procChance &&
            self.procCharges == other.procCharges &&
            self.maxLevel == other.maxLevel &&
            self.baseLevel == other.baseLevel &&
            self.spellLevel == other.spellLevel &&
            self.durationIndex == other.durationIndex &&
            self.powerType == other.powerType &&
            self.manaCost == other.manaCost &&
            self.manaCostPerLevel == other.manaCostPerLevel &&
            self.manaPerSecond == other.manaPerSecond &&
            self.manaPerSecondPerLevel == other.manaPerSecondPerLevel &&
            self.rangeIndex == other.rangeIndex &&
            self.speed == other.speed &&
            self.modalNextSpell == other.modalNextSpell &&
            self.cumulativeAura == other.cumulativeAura &&
            self.totem0 == other.totem0 &&
            self.totem1 == other.totem1 &&
            self.reagent0 == other.reagent0 &&
            self.reagent1 == other.reagent1 &&
            self.reagent2 == other.reagent2 &&
            self.reagent3 == other.reagent3 &&
            self.reagent4 == other.reagent4 &&
            self.reagent5 == other.reagent5 &&
            self.reagent6 == other.reagent6 &&
            self.reagent7 == other.reagent7 &&
            self.reagentCount0 == other.reagentCount0 &&
            self.reagentCount1 == other.reagentCount1 &&
            self.reagentCount2 == other.reagentCount2 &&
            self.reagentCount3 == other.reagentCount3 &&
            self.reagentCount4 == other.reagentCount4 &&
            self.reagentCount5 == other.reagentCount5 &&
            self.reagentCount6 == other.reagentCount6 &&
            self.reagentCount7 == other.reagentCount7 &&
            self.equippedItemClass == other.equippedItemClass &&
            self.equippedItemSubclass == other.equippedItemSubclass &&
            self.equippedItemInvTypes == other.equippedItemInvTypes &&
            self.effect0 == other.effect0 &&
            self.effect1 == other.effect1 &&
            self.effect2 == other.effect2 &&
            self.effectDieSides0 == other.effectDieSides0 &&
            self.effectDieSides1 == other.effectDieSides1 &&
            self.effectDieSides2 == other.effectDieSides2 &&
            self.effectRealPointsPerLevel0 == other.effectRealPointsPerLevel0 &&
            self.effectRealPointsPerLevel1 == other.effectRealPointsPerLevel1 &&
            self.effectRealPointsPerLevel2 == other.effectRealPointsPerLevel2 &&
            self.effectBasePoints0 == other.effectBasePoints0 &&
            self.effectBasePoints1 == other.effectBasePoints1 &&
            self.effectBasePoints2 == other.effectBasePoints2 &&
            self.effectMechanic0 == other.effectMechanic0 &&
            self.effectMechanic1 == other.effectMechanic1 &&
            self.effectMechanic2 == other.effectMechanic2 &&
            self.implicitTargetA0 == other.implicitTargetA0 &&
            self.implicitTargetA1 == other.implicitTargetA1 &&
            self.implicitTargetA2 == other.implicitTargetA2 &&
            self.implicitTargetB0 == other.implicitTargetB0 &&
            self.implicitTargetB1 == other.implicitTargetB1 &&
            self.implicitTargetB2 == other.implicitTargetB2 &&
            self.effectRadiusIndex0 == other.effectRadiusIndex0 &&
            self.effectRadiusIndex1 == other.effectRadiusIndex1 &&
            self.effectRadiusIndex2 == other.effectRadiusIndex2 &&
            self.effectAura0 == other.effectAura0 &&
            self.effectAura1 == other.effectAura1 &&
            self.effectAura2 == other.effectAura2 &&
            self.effectAuraPeriod0 == other.effectAuraPeriod0 &&
            self.effectAuraPeriod1 == other.effectAuraPeriod1 &&
            self.effectAuraPeriod2 == other.effectAuraPeriod2 &&
            self.effectAmplitude0 == other.effectAmplitude0 &&
            self.effectAmplitude1 == other.effectAmplitude1 &&
            self.effectAmplitude2 == other.effectAmplitude2 &&
            self.effectChainTargets0 == other.effectChainTargets0 &&
            self.effectChainTargets1 == other.effectChainTargets1 &&
            self.effectChainTargets2 == other.effectChainTargets2 &&
            self.effectItemType0 == other.effectItemType0 &&
            self.effectItemType1 == other.effectItemType1 &&
            self.effectItemType2 == other.effectItemType2 &&
            self.effectMiscValue0 == other.effectMiscValue0 &&
            self.effectMiscValue1 == other.effectMiscValue1 &&
            self.effectMiscValue2 == other.effectMiscValue2 &&
            self.effectMiscValueB0 == other.effectMiscValueB0 &&
            self.effectMiscValueB1 == other.effectMiscValueB1 &&
            self.effectMiscValueB2 == other.effectMiscValueB2 &&
            self.effectTriggerSpell0 == other.effectTriggerSpell0 &&
            self.effectTriggerSpell1 == other.effectTriggerSpell1 &&
            self.effectTriggerSpell2 == other.effectTriggerSpell2 &&
            self.effectPointsPerCombo0 == other.effectPointsPerCombo0 &&
            self.effectPointsPerCombo1 == other.effectPointsPerCombo1 &&
            self.effectPointsPerCombo2 == other.effectPointsPerCombo2 &&
            self.effectSpellClassMaskA0 == other.effectSpellClassMaskA0 &&
            self.effectSpellClassMaskA1 == other.effectSpellClassMaskA1 &&
            self.effectSpellClassMaskA2 == other.effectSpellClassMaskA2 &&
            self.effectSpellClassMaskB0 == other.effectSpellClassMaskB0 &&
            self.effectSpellClassMaskB1 == other.effectSpellClassMaskB1 &&
            self.effectSpellClassMaskB2 == other.effectSpellClassMaskB2 &&
            self.effectSpellClassMaskC0 == other.effectSpellClassMaskC0 &&
            self.effectSpellClassMaskC1 == other.effectSpellClassMaskC1 &&
            self.effectSpellClassMaskC2 == other.effectSpellClassMaskC2 &&
            self.spellVisualID0 == other.spellVisualID0 &&
            self.spellVisualID1 == other.spellVisualID1 &&
            self.spellIconID == other.spellIconID &&
            self.activeIconID == other.activeIconID &&
            self.spellPriority == other.spellPriority &&
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
            self.nameSubtextLangEnUS == other.nameSubtextLangEnUS &&
            self.nameSubtextLangKoKR == other.nameSubtextLangKoKR &&
            self.nameSubtextLangFrFR == other.nameSubtextLangFrFR &&
            self.nameSubtextLangDeDE == other.nameSubtextLangDeDE &&
            self.nameSubtextLangZhCN == other.nameSubtextLangZhCN &&
            self.nameSubtextLangZhTW == other.nameSubtextLangZhTW &&
            self.nameSubtextLangEsES == other.nameSubtextLangEsES &&
            self.nameSubtextLangEsMX == other.nameSubtextLangEsMX &&
            self.nameSubtextLangRuRU == other.nameSubtextLangRuRU &&
            self.nameSubtextLangJaJP == other.nameSubtextLangJaJP &&
            self.nameSubtextLangPtPT == other.nameSubtextLangPtPT &&
            self.nameSubtextLangPtBR == other.nameSubtextLangPtBR &&
            self.nameSubtextLangItIT == other.nameSubtextLangItIT &&
            self.nameSubtextLangUnk1 == other.nameSubtextLangUnk1 &&
            self.nameSubtextLangUnk2 == other.nameSubtextLangUnk2 &&
            self.nameSubtextLangUnk3 == other.nameSubtextLangUnk3 &&
            self.nameSubtextLangFlags == other.nameSubtextLangFlags &&
            self.descriptionLangEnUS == other.descriptionLangEnUS &&
            self.descriptionLangKoKR == other.descriptionLangKoKR &&
            self.descriptionLangFrFR == other.descriptionLangFrFR &&
            self.descriptionLangDeDE == other.descriptionLangDeDE &&
            self.descriptionLangZhCN == other.descriptionLangZhCN &&
            self.descriptionLangZhTW == other.descriptionLangZhTW &&
            self.descriptionLangEsES == other.descriptionLangEsES &&
            self.descriptionLangEsMX == other.descriptionLangEsMX &&
            self.descriptionLangRuRU == other.descriptionLangRuRU &&
            self.descriptionLangJaJP == other.descriptionLangJaJP &&
            self.descriptionLangPtPT == other.descriptionLangPtPT &&
            self.descriptionLangPtBR == other.descriptionLangPtBR &&
            self.descriptionLangItIT == other.descriptionLangItIT &&
            self.descriptionLangUnk1 == other.descriptionLangUnk1 &&
            self.descriptionLangUnk2 == other.descriptionLangUnk2 &&
            self.descriptionLangUnk3 == other.descriptionLangUnk3 &&
            self.descriptionLangFlags == other.descriptionLangFlags &&
            self.auraDescriptionLangEnUS == other.auraDescriptionLangEnUS &&
            self.auraDescriptionLangKoKR == other.auraDescriptionLangKoKR &&
            self.auraDescriptionLangFrFR == other.auraDescriptionLangFrFR &&
            self.auraDescriptionLangDeDE == other.auraDescriptionLangDeDE &&
            self.auraDescriptionLangZhCN == other.auraDescriptionLangZhCN &&
            self.auraDescriptionLangZhTW == other.auraDescriptionLangZhTW &&
            self.auraDescriptionLangEsES == other.auraDescriptionLangEsES &&
            self.auraDescriptionLangEsMX == other.auraDescriptionLangEsMX &&
            self.auraDescriptionLangRuRU == other.auraDescriptionLangRuRU &&
            self.auraDescriptionLangJaJP == other.auraDescriptionLangJaJP &&
            self.auraDescriptionLangPtPT == other.auraDescriptionLangPtPT &&
            self.auraDescriptionLangPtBR == other.auraDescriptionLangPtBR &&
            self.auraDescriptionLangItIT == other.auraDescriptionLangItIT &&
            self.auraDescriptionLangUnk1 == other.auraDescriptionLangUnk1 &&
            self.auraDescriptionLangUnk2 == other.auraDescriptionLangUnk2 &&
            self.auraDescriptionLangUnk3 == other.auraDescriptionLangUnk3 &&
            self.auraDescriptionLangFlags == other.auraDescriptionLangFlags &&
            self.manaCostPct == other.manaCostPct &&
            self.startRecoveryCategory == other.startRecoveryCategory &&
            self.startRecoveryTime == other.startRecoveryTime &&
            self.maxTargetLevel == other.maxTargetLevel &&
            self.spellClassSet == other.spellClassSet &&
            self.spellClassMask0 == other.spellClassMask0 &&
            self.spellClassMask1 == other.spellClassMask1 &&
            self.spellClassMask2 == other.spellClassMask2 &&
            self.maxTargets == other.maxTargets &&
            self.defenseType == other.defenseType &&
            self.preventionType == other.preventionType &&
            self.stanceBarOrder == other.stanceBarOrder &&
            self.effectChainAmplitude0 == other.effectChainAmplitude0 &&
            self.effectChainAmplitude1 == other.effectChainAmplitude1 &&
            self.effectChainAmplitude2 == other.effectChainAmplitude2 &&
            self.minFactionID == other.minFactionID &&
            self.minReputation == other.minReputation &&
            self.requiredAuraVision == other.requiredAuraVision &&
            self.requiredTotemCategoryID0 == other.requiredTotemCategoryID0 &&
            self.requiredTotemCategoryID1 == other.requiredTotemCategoryID1 &&
            self.requiredAreasID == other.requiredAreasID &&
            self.schoolMask == other.schoolMask &&
            self.runeCostID == other.runeCostID &&
            self.spellMissileID == other.spellMissileID &&
            self.powerDisplayID == other.powerDisplayID &&
            self.effectBonusCoefficient0 == other.effectBonusCoefficient0 &&
            self.effectBonusCoefficient1 == other.effectBonusCoefficient1 &&
            self.effectBonusCoefficient2 == other.effectBonusCoefficient2 &&
            self.spellDescriptionVariableID ==
                other.spellDescriptionVariableID &&
            self.spellDifficultyID == other.spellDifficultyID;
  }

  @override
  int get hashCode {
    final self = this as SpellEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.category,
      self.dispelType,
      self.mechanic,
      self.attributes,
      self.attributesEx,
      self.attributesExB,
      self.attributesExC,
      self.attributesExD,
      self.attributesExE,
      self.attributesExF,
      self.attributesExG,
      self.shapeshiftMask0,
      self.shapeshiftMask1,
      self.shapeshiftExclude0,
      self.shapeshiftExclude1,
      self.targets,
      self.targetCreatureType,
      self.requiresSpellFocus,
      self.facingCasterFlags,
      self.casterAuraState,
      self.targetAuraState,
      self.excludeCasterAuraState,
      self.excludeTargetAuraState,
      self.casterAuraSpell,
      self.targetAuraSpell,
      self.excludeCasterAuraSpell,
      self.excludeTargetAuraSpell,
      self.castingTimeIndex,
      self.recoveryTime,
      self.categoryRecoveryTime,
      self.interruptFlags,
      self.auraInterruptFlags,
      self.channelInterruptFlags,
      self.procTypeMask,
      self.procChance,
      self.procCharges,
      self.maxLevel,
      self.baseLevel,
      self.spellLevel,
      self.durationIndex,
      self.powerType,
      self.manaCost,
      self.manaCostPerLevel,
      self.manaPerSecond,
      self.manaPerSecondPerLevel,
      self.rangeIndex,
      self.speed,
      self.modalNextSpell,
      self.cumulativeAura,
      self.totem0,
      self.totem1,
      self.reagent0,
      self.reagent1,
      self.reagent2,
      self.reagent3,
      self.reagent4,
      self.reagent5,
      self.reagent6,
      self.reagent7,
      self.reagentCount0,
      self.reagentCount1,
      self.reagentCount2,
      self.reagentCount3,
      self.reagentCount4,
      self.reagentCount5,
      self.reagentCount6,
      self.reagentCount7,
      self.equippedItemClass,
      self.equippedItemSubclass,
      self.equippedItemInvTypes,
      self.effect0,
      self.effect1,
      self.effect2,
      self.effectDieSides0,
      self.effectDieSides1,
      self.effectDieSides2,
      self.effectRealPointsPerLevel0,
      self.effectRealPointsPerLevel1,
      self.effectRealPointsPerLevel2,
      self.effectBasePoints0,
      self.effectBasePoints1,
      self.effectBasePoints2,
      self.effectMechanic0,
      self.effectMechanic1,
      self.effectMechanic2,
      self.implicitTargetA0,
      self.implicitTargetA1,
      self.implicitTargetA2,
      self.implicitTargetB0,
      self.implicitTargetB1,
      self.implicitTargetB2,
      self.effectRadiusIndex0,
      self.effectRadiusIndex1,
      self.effectRadiusIndex2,
      self.effectAura0,
      self.effectAura1,
      self.effectAura2,
      self.effectAuraPeriod0,
      self.effectAuraPeriod1,
      self.effectAuraPeriod2,
      self.effectAmplitude0,
      self.effectAmplitude1,
      self.effectAmplitude2,
      self.effectChainTargets0,
      self.effectChainTargets1,
      self.effectChainTargets2,
      self.effectItemType0,
      self.effectItemType1,
      self.effectItemType2,
      self.effectMiscValue0,
      self.effectMiscValue1,
      self.effectMiscValue2,
      self.effectMiscValueB0,
      self.effectMiscValueB1,
      self.effectMiscValueB2,
      self.effectTriggerSpell0,
      self.effectTriggerSpell1,
      self.effectTriggerSpell2,
      self.effectPointsPerCombo0,
      self.effectPointsPerCombo1,
      self.effectPointsPerCombo2,
      self.effectSpellClassMaskA0,
      self.effectSpellClassMaskA1,
      self.effectSpellClassMaskA2,
      self.effectSpellClassMaskB0,
      self.effectSpellClassMaskB1,
      self.effectSpellClassMaskB2,
      self.effectSpellClassMaskC0,
      self.effectSpellClassMaskC1,
      self.effectSpellClassMaskC2,
      self.spellVisualID0,
      self.spellVisualID1,
      self.spellIconID,
      self.activeIconID,
      self.spellPriority,
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
      self.nameSubtextLangEnUS,
      self.nameSubtextLangKoKR,
      self.nameSubtextLangFrFR,
      self.nameSubtextLangDeDE,
      self.nameSubtextLangZhCN,
      self.nameSubtextLangZhTW,
      self.nameSubtextLangEsES,
      self.nameSubtextLangEsMX,
      self.nameSubtextLangRuRU,
      self.nameSubtextLangJaJP,
      self.nameSubtextLangPtPT,
      self.nameSubtextLangPtBR,
      self.nameSubtextLangItIT,
      self.nameSubtextLangUnk1,
      self.nameSubtextLangUnk2,
      self.nameSubtextLangUnk3,
      self.nameSubtextLangFlags,
      self.descriptionLangEnUS,
      self.descriptionLangKoKR,
      self.descriptionLangFrFR,
      self.descriptionLangDeDE,
      self.descriptionLangZhCN,
      self.descriptionLangZhTW,
      self.descriptionLangEsES,
      self.descriptionLangEsMX,
      self.descriptionLangRuRU,
      self.descriptionLangJaJP,
      self.descriptionLangPtPT,
      self.descriptionLangPtBR,
      self.descriptionLangItIT,
      self.descriptionLangUnk1,
      self.descriptionLangUnk2,
      self.descriptionLangUnk3,
      self.descriptionLangFlags,
      self.auraDescriptionLangEnUS,
      self.auraDescriptionLangKoKR,
      self.auraDescriptionLangFrFR,
      self.auraDescriptionLangDeDE,
      self.auraDescriptionLangZhCN,
      self.auraDescriptionLangZhTW,
      self.auraDescriptionLangEsES,
      self.auraDescriptionLangEsMX,
      self.auraDescriptionLangRuRU,
      self.auraDescriptionLangJaJP,
      self.auraDescriptionLangPtPT,
      self.auraDescriptionLangPtBR,
      self.auraDescriptionLangItIT,
      self.auraDescriptionLangUnk1,
      self.auraDescriptionLangUnk2,
      self.auraDescriptionLangUnk3,
      self.auraDescriptionLangFlags,
      self.manaCostPct,
      self.startRecoveryCategory,
      self.startRecoveryTime,
      self.maxTargetLevel,
      self.spellClassSet,
      self.spellClassMask0,
      self.spellClassMask1,
      self.spellClassMask2,
      self.maxTargets,
      self.defenseType,
      self.preventionType,
      self.stanceBarOrder,
      self.effectChainAmplitude0,
      self.effectChainAmplitude1,
      self.effectChainAmplitude2,
      self.minFactionID,
      self.minReputation,
      self.requiredAuraVision,
      self.requiredTotemCategoryID0,
      self.requiredTotemCategoryID1,
      self.requiredAreasID,
      self.schoolMask,
      self.runeCostID,
      self.spellMissileID,
      self.powerDisplayID,
      self.effectBonusCoefficient0,
      self.effectBonusCoefficient1,
      self.effectBonusCoefficient2,
      self.spellDescriptionVariableID,
      self.spellDifficultyID,
    ]);
  }

  @override
  String toString() {
    final self = this as SpellEntity;
    return 'SpellEntity('
        'id: ${self.id}, '
        'category: ${self.category}, '
        'dispelType: ${self.dispelType}, '
        'mechanic: ${self.mechanic}, '
        'attributes: ${self.attributes}, '
        'attributesEx: ${self.attributesEx}, '
        'attributesExB: ${self.attributesExB}, '
        'attributesExC: ${self.attributesExC}, '
        'attributesExD: ${self.attributesExD}, '
        'attributesExE: ${self.attributesExE}, '
        'attributesExF: ${self.attributesExF}, '
        'attributesExG: ${self.attributesExG}, '
        'shapeshiftMask0: ${self.shapeshiftMask0}, '
        'shapeshiftMask1: ${self.shapeshiftMask1}, '
        'shapeshiftExclude0: ${self.shapeshiftExclude0}, '
        'shapeshiftExclude1: ${self.shapeshiftExclude1}, '
        'targets: ${self.targets}, '
        'targetCreatureType: ${self.targetCreatureType}, '
        'requiresSpellFocus: ${self.requiresSpellFocus}, '
        'facingCasterFlags: ${self.facingCasterFlags}, '
        'casterAuraState: ${self.casterAuraState}, '
        'targetAuraState: ${self.targetAuraState}, '
        'excludeCasterAuraState: ${self.excludeCasterAuraState}, '
        'excludeTargetAuraState: ${self.excludeTargetAuraState}, '
        'casterAuraSpell: ${self.casterAuraSpell}, '
        'targetAuraSpell: ${self.targetAuraSpell}, '
        'excludeCasterAuraSpell: ${self.excludeCasterAuraSpell}, '
        'excludeTargetAuraSpell: ${self.excludeTargetAuraSpell}, '
        'castingTimeIndex: ${self.castingTimeIndex}, '
        'recoveryTime: ${self.recoveryTime}, '
        'categoryRecoveryTime: ${self.categoryRecoveryTime}, '
        'interruptFlags: ${self.interruptFlags}, '
        'auraInterruptFlags: ${self.auraInterruptFlags}, '
        'channelInterruptFlags: ${self.channelInterruptFlags}, '
        'procTypeMask: ${self.procTypeMask}, '
        'procChance: ${self.procChance}, '
        'procCharges: ${self.procCharges}, '
        'maxLevel: ${self.maxLevel}, '
        'baseLevel: ${self.baseLevel}, '
        'spellLevel: ${self.spellLevel}, '
        'durationIndex: ${self.durationIndex}, '
        'powerType: ${self.powerType}, '
        'manaCost: ${self.manaCost}, '
        'manaCostPerLevel: ${self.manaCostPerLevel}, '
        'manaPerSecond: ${self.manaPerSecond}, '
        'manaPerSecondPerLevel: ${self.manaPerSecondPerLevel}, '
        'rangeIndex: ${self.rangeIndex}, '
        'speed: ${self.speed}, '
        'modalNextSpell: ${self.modalNextSpell}, '
        'cumulativeAura: ${self.cumulativeAura}, '
        'totem0: ${self.totem0}, '
        'totem1: ${self.totem1}, '
        'reagent0: ${self.reagent0}, '
        'reagent1: ${self.reagent1}, '
        'reagent2: ${self.reagent2}, '
        'reagent3: ${self.reagent3}, '
        'reagent4: ${self.reagent4}, '
        'reagent5: ${self.reagent5}, '
        'reagent6: ${self.reagent6}, '
        'reagent7: ${self.reagent7}, '
        'reagentCount0: ${self.reagentCount0}, '
        'reagentCount1: ${self.reagentCount1}, '
        'reagentCount2: ${self.reagentCount2}, '
        'reagentCount3: ${self.reagentCount3}, '
        'reagentCount4: ${self.reagentCount4}, '
        'reagentCount5: ${self.reagentCount5}, '
        'reagentCount6: ${self.reagentCount6}, '
        'reagentCount7: ${self.reagentCount7}, '
        'equippedItemClass: ${self.equippedItemClass}, '
        'equippedItemSubclass: ${self.equippedItemSubclass}, '
        'equippedItemInvTypes: ${self.equippedItemInvTypes}, '
        'effect0: ${self.effect0}, '
        'effect1: ${self.effect1}, '
        'effect2: ${self.effect2}, '
        'effectDieSides0: ${self.effectDieSides0}, '
        'effectDieSides1: ${self.effectDieSides1}, '
        'effectDieSides2: ${self.effectDieSides2}, '
        'effectRealPointsPerLevel0: ${self.effectRealPointsPerLevel0}, '
        'effectRealPointsPerLevel1: ${self.effectRealPointsPerLevel1}, '
        'effectRealPointsPerLevel2: ${self.effectRealPointsPerLevel2}, '
        'effectBasePoints0: ${self.effectBasePoints0}, '
        'effectBasePoints1: ${self.effectBasePoints1}, '
        'effectBasePoints2: ${self.effectBasePoints2}, '
        'effectMechanic0: ${self.effectMechanic0}, '
        'effectMechanic1: ${self.effectMechanic1}, '
        'effectMechanic2: ${self.effectMechanic2}, '
        'implicitTargetA0: ${self.implicitTargetA0}, '
        'implicitTargetA1: ${self.implicitTargetA1}, '
        'implicitTargetA2: ${self.implicitTargetA2}, '
        'implicitTargetB0: ${self.implicitTargetB0}, '
        'implicitTargetB1: ${self.implicitTargetB1}, '
        'implicitTargetB2: ${self.implicitTargetB2}, '
        'effectRadiusIndex0: ${self.effectRadiusIndex0}, '
        'effectRadiusIndex1: ${self.effectRadiusIndex1}, '
        'effectRadiusIndex2: ${self.effectRadiusIndex2}, '
        'effectAura0: ${self.effectAura0}, '
        'effectAura1: ${self.effectAura1}, '
        'effectAura2: ${self.effectAura2}, '
        'effectAuraPeriod0: ${self.effectAuraPeriod0}, '
        'effectAuraPeriod1: ${self.effectAuraPeriod1}, '
        'effectAuraPeriod2: ${self.effectAuraPeriod2}, '
        'effectAmplitude0: ${self.effectAmplitude0}, '
        'effectAmplitude1: ${self.effectAmplitude1}, '
        'effectAmplitude2: ${self.effectAmplitude2}, '
        'effectChainTargets0: ${self.effectChainTargets0}, '
        'effectChainTargets1: ${self.effectChainTargets1}, '
        'effectChainTargets2: ${self.effectChainTargets2}, '
        'effectItemType0: ${self.effectItemType0}, '
        'effectItemType1: ${self.effectItemType1}, '
        'effectItemType2: ${self.effectItemType2}, '
        'effectMiscValue0: ${self.effectMiscValue0}, '
        'effectMiscValue1: ${self.effectMiscValue1}, '
        'effectMiscValue2: ${self.effectMiscValue2}, '
        'effectMiscValueB0: ${self.effectMiscValueB0}, '
        'effectMiscValueB1: ${self.effectMiscValueB1}, '
        'effectMiscValueB2: ${self.effectMiscValueB2}, '
        'effectTriggerSpell0: ${self.effectTriggerSpell0}, '
        'effectTriggerSpell1: ${self.effectTriggerSpell1}, '
        'effectTriggerSpell2: ${self.effectTriggerSpell2}, '
        'effectPointsPerCombo0: ${self.effectPointsPerCombo0}, '
        'effectPointsPerCombo1: ${self.effectPointsPerCombo1}, '
        'effectPointsPerCombo2: ${self.effectPointsPerCombo2}, '
        'effectSpellClassMaskA0: ${self.effectSpellClassMaskA0}, '
        'effectSpellClassMaskA1: ${self.effectSpellClassMaskA1}, '
        'effectSpellClassMaskA2: ${self.effectSpellClassMaskA2}, '
        'effectSpellClassMaskB0: ${self.effectSpellClassMaskB0}, '
        'effectSpellClassMaskB1: ${self.effectSpellClassMaskB1}, '
        'effectSpellClassMaskB2: ${self.effectSpellClassMaskB2}, '
        'effectSpellClassMaskC0: ${self.effectSpellClassMaskC0}, '
        'effectSpellClassMaskC1: ${self.effectSpellClassMaskC1}, '
        'effectSpellClassMaskC2: ${self.effectSpellClassMaskC2}, '
        'spellVisualID0: ${self.spellVisualID0}, '
        'spellVisualID1: ${self.spellVisualID1}, '
        'spellIconID: ${self.spellIconID}, '
        'activeIconID: ${self.activeIconID}, '
        'spellPriority: ${self.spellPriority}, '
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
        'nameSubtextLangEnUS: ${self.nameSubtextLangEnUS}, '
        'nameSubtextLangKoKR: ${self.nameSubtextLangKoKR}, '
        'nameSubtextLangFrFR: ${self.nameSubtextLangFrFR}, '
        'nameSubtextLangDeDE: ${self.nameSubtextLangDeDE}, '
        'nameSubtextLangZhCN: ${self.nameSubtextLangZhCN}, '
        'nameSubtextLangZhTW: ${self.nameSubtextLangZhTW}, '
        'nameSubtextLangEsES: ${self.nameSubtextLangEsES}, '
        'nameSubtextLangEsMX: ${self.nameSubtextLangEsMX}, '
        'nameSubtextLangRuRU: ${self.nameSubtextLangRuRU}, '
        'nameSubtextLangJaJP: ${self.nameSubtextLangJaJP}, '
        'nameSubtextLangPtPT: ${self.nameSubtextLangPtPT}, '
        'nameSubtextLangPtBR: ${self.nameSubtextLangPtBR}, '
        'nameSubtextLangItIT: ${self.nameSubtextLangItIT}, '
        'nameSubtextLangUnk1: ${self.nameSubtextLangUnk1}, '
        'nameSubtextLangUnk2: ${self.nameSubtextLangUnk2}, '
        'nameSubtextLangUnk3: ${self.nameSubtextLangUnk3}, '
        'nameSubtextLangFlags: ${self.nameSubtextLangFlags}, '
        'descriptionLangEnUS: ${self.descriptionLangEnUS}, '
        'descriptionLangKoKR: ${self.descriptionLangKoKR}, '
        'descriptionLangFrFR: ${self.descriptionLangFrFR}, '
        'descriptionLangDeDE: ${self.descriptionLangDeDE}, '
        'descriptionLangZhCN: ${self.descriptionLangZhCN}, '
        'descriptionLangZhTW: ${self.descriptionLangZhTW}, '
        'descriptionLangEsES: ${self.descriptionLangEsES}, '
        'descriptionLangEsMX: ${self.descriptionLangEsMX}, '
        'descriptionLangRuRU: ${self.descriptionLangRuRU}, '
        'descriptionLangJaJP: ${self.descriptionLangJaJP}, '
        'descriptionLangPtPT: ${self.descriptionLangPtPT}, '
        'descriptionLangPtBR: ${self.descriptionLangPtBR}, '
        'descriptionLangItIT: ${self.descriptionLangItIT}, '
        'descriptionLangUnk1: ${self.descriptionLangUnk1}, '
        'descriptionLangUnk2: ${self.descriptionLangUnk2}, '
        'descriptionLangUnk3: ${self.descriptionLangUnk3}, '
        'descriptionLangFlags: ${self.descriptionLangFlags}, '
        'auraDescriptionLangEnUS: ${self.auraDescriptionLangEnUS}, '
        'auraDescriptionLangKoKR: ${self.auraDescriptionLangKoKR}, '
        'auraDescriptionLangFrFR: ${self.auraDescriptionLangFrFR}, '
        'auraDescriptionLangDeDE: ${self.auraDescriptionLangDeDE}, '
        'auraDescriptionLangZhCN: ${self.auraDescriptionLangZhCN}, '
        'auraDescriptionLangZhTW: ${self.auraDescriptionLangZhTW}, '
        'auraDescriptionLangEsES: ${self.auraDescriptionLangEsES}, '
        'auraDescriptionLangEsMX: ${self.auraDescriptionLangEsMX}, '
        'auraDescriptionLangRuRU: ${self.auraDescriptionLangRuRU}, '
        'auraDescriptionLangJaJP: ${self.auraDescriptionLangJaJP}, '
        'auraDescriptionLangPtPT: ${self.auraDescriptionLangPtPT}, '
        'auraDescriptionLangPtBR: ${self.auraDescriptionLangPtBR}, '
        'auraDescriptionLangItIT: ${self.auraDescriptionLangItIT}, '
        'auraDescriptionLangUnk1: ${self.auraDescriptionLangUnk1}, '
        'auraDescriptionLangUnk2: ${self.auraDescriptionLangUnk2}, '
        'auraDescriptionLangUnk3: ${self.auraDescriptionLangUnk3}, '
        'auraDescriptionLangFlags: ${self.auraDescriptionLangFlags}, '
        'manaCostPct: ${self.manaCostPct}, '
        'startRecoveryCategory: ${self.startRecoveryCategory}, '
        'startRecoveryTime: ${self.startRecoveryTime}, '
        'maxTargetLevel: ${self.maxTargetLevel}, '
        'spellClassSet: ${self.spellClassSet}, '
        'spellClassMask0: ${self.spellClassMask0}, '
        'spellClassMask1: ${self.spellClassMask1}, '
        'spellClassMask2: ${self.spellClassMask2}, '
        'maxTargets: ${self.maxTargets}, '
        'defenseType: ${self.defenseType}, '
        'preventionType: ${self.preventionType}, '
        'stanceBarOrder: ${self.stanceBarOrder}, '
        'effectChainAmplitude0: ${self.effectChainAmplitude0}, '
        'effectChainAmplitude1: ${self.effectChainAmplitude1}, '
        'effectChainAmplitude2: ${self.effectChainAmplitude2}, '
        'minFactionID: ${self.minFactionID}, '
        'minReputation: ${self.minReputation}, '
        'requiredAuraVision: ${self.requiredAuraVision}, '
        'requiredTotemCategoryID0: ${self.requiredTotemCategoryID0}, '
        'requiredTotemCategoryID1: ${self.requiredTotemCategoryID1}, '
        'requiredAreasID: ${self.requiredAreasID}, '
        'schoolMask: ${self.schoolMask}, '
        'runeCostID: ${self.runeCostID}, '
        'spellMissileID: ${self.spellMissileID}, '
        'powerDisplayID: ${self.powerDisplayID}, '
        'effectBonusCoefficient0: ${self.effectBonusCoefficient0}, '
        'effectBonusCoefficient1: ${self.effectBonusCoefficient1}, '
        'effectBonusCoefficient2: ${self.effectBonusCoefficient2}, '
        'spellDescriptionVariableID: ${self.spellDescriptionVariableID}, '
        'spellDifficultyID: ${self.spellDifficultyID}'
        ')';
  }
}

final class BriefSpellEntity {
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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      subtext: json['subtext']?.toString() ?? '',
      localeName: json['localeName']?.toString() ?? '',
      localeSubtext: json['localeSubtext']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      localeDescription: json['localeDescription']?.toString() ?? '',
      auraDescription: json['auraDescription']?.toString() ?? '',
      localeAuraDescription: json['localeAuraDescription']?.toString() ?? '',
      textureFilename: json['textureFilename']?.toString() ?? '',
    );
  }

  int get key => id;
}
