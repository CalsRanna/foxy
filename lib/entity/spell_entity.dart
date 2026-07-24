import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'spell_entity.g.dart';

/// 法术（技能）完整模型 - 对应 foxy.dbc_spell 表

@FoxyBriefEntity()
@FoxyBriefField.text('name')
@FoxyBriefField.text('subtext')
@FoxyBriefField.text('localeName')
@FoxyBriefField.text('localeSubtext')
@FoxyBriefField.text('description')
@FoxyBriefField.text('localeDescription')
@FoxyBriefField.text('auraDescription')
@FoxyBriefField.text('localeAuraDescription')
@FoxyBriefField.text('textureFilename')
@FoxyFullEntity(table: 'foxy.dbc_spell')
class SpellEntity with _SpellEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('Category')
  final int category;

  @FoxyFullField('DispelType')
  final int dispelType;

  @FoxyFullField('Mechanic')
  final int mechanic;

  @FoxyFullField('Attributes')
  final int attributes;

  @FoxyFullField('AttributesEx')
  final int attributesEx;

  @FoxyFullField('AttributesExB')
  final int attributesExB;

  @FoxyFullField('AttributesExC')
  final int attributesExC;

  @FoxyFullField('AttributesExD')
  final int attributesExD;

  @FoxyFullField('AttributesExE')
  final int attributesExE;

  @FoxyFullField('AttributesExF')
  final int attributesExF;

  @FoxyFullField('AttributesExG')
  final int attributesExG;

  @FoxyFullField('ShapeshiftMask0')
  final int shapeshiftMask0;

  @FoxyFullField('ShapeshiftMask1')
  final int shapeshiftMask1;

  @FoxyFullField('ShapeshiftExclude0')
  final int shapeshiftExclude0;

  @FoxyFullField('ShapeshiftExclude1')
  final int shapeshiftExclude1;

  @FoxyFullField('Targets')
  final int targets;

  @FoxyFullField('TargetCreatureType')
  final int targetCreatureType;

  @FoxyFullField('RequiresSpellFocus')
  final int requiresSpellFocus;

  @FoxyFullField('FacingCasterFlags')
  final int facingCasterFlags;

  @FoxyFullField('CasterAuraState')
  final int casterAuraState;

  @FoxyFullField('TargetAuraState')
  final int targetAuraState;

  @FoxyFullField('ExcludeCasterAuraState')
  final int excludeCasterAuraState;

  @FoxyFullField('ExcludeTargetAuraState')
  final int excludeTargetAuraState;

  @FoxyFullField('CasterAuraSpell')
  final int casterAuraSpell;

  @FoxyFullField('TargetAuraSpell')
  final int targetAuraSpell;

  @FoxyFullField('ExcludeCasterAuraSpell')
  final int excludeCasterAuraSpell;

  @FoxyFullField('ExcludeTargetAuraSpell')
  final int excludeTargetAuraSpell;

  @FoxyFullField('CastingTimeIndex')
  final int castingTimeIndex;

  @FoxyFullField('RecoveryTime')
  final int recoveryTime;

  @FoxyFullField('CategoryRecoveryTime')
  final int categoryRecoveryTime;

  @FoxyFullField('InterruptFlags')
  final int interruptFlags;

  @FoxyFullField('AuraInterruptFlags')
  final int auraInterruptFlags;

  @FoxyFullField('ChannelInterruptFlags')
  final int channelInterruptFlags;

  @FoxyFullField('ProcTypeMask')
  final int procTypeMask;

  @FoxyFullField('ProcChance')
  final int procChance;

  @FoxyFullField('ProcCharges')
  final int procCharges;

  @FoxyFullField('MaxLevel')
  final int maxLevel;

  @FoxyFullField('BaseLevel')
  final int baseLevel;

  @FoxyFullField('SpellLevel')
  final int spellLevel;

  @FoxyFullField('DurationIndex')
  final int durationIndex;

  @FoxyFullField('PowerType')
  final int powerType;

  @FoxyFullField('ManaCost')
  final int manaCost;

  @FoxyFullField('ManaCostPerLevel')
  final int manaCostPerLevel;

  @FoxyFullField('ManaPerSecond')
  final int manaPerSecond;

  @FoxyFullField('ManaPerSecondPerLevel')
  final int manaPerSecondPerLevel;

  @FoxyFullField('RangeIndex')
  final int rangeIndex;

  @FoxyFullField('Speed')
  final double speed;

  @FoxyFullField('ModalNextSpell')
  final int modalNextSpell;

  @FoxyFullField('CumulativeAura')
  final int cumulativeAura;

  @FoxyFullField('Totem0')
  final int totem0;

  @FoxyFullField('Totem1')
  final int totem1;

  @FoxyFullField('Reagent0')
  final int reagent0;

  @FoxyFullField('Reagent1')
  final int reagent1;

  @FoxyFullField('Reagent2')
  final int reagent2;

  @FoxyFullField('Reagent3')
  final int reagent3;

  @FoxyFullField('Reagent4')
  final int reagent4;

  @FoxyFullField('Reagent5')
  final int reagent5;

  @FoxyFullField('Reagent6')
  final int reagent6;

  @FoxyFullField('Reagent7')
  final int reagent7;

  @FoxyFullField('ReagentCount0')
  final int reagentCount0;

  @FoxyFullField('ReagentCount1')
  final int reagentCount1;

  @FoxyFullField('ReagentCount2')
  final int reagentCount2;

  @FoxyFullField('ReagentCount3')
  final int reagentCount3;

  @FoxyFullField('ReagentCount4')
  final int reagentCount4;

  @FoxyFullField('ReagentCount5')
  final int reagentCount5;

  @FoxyFullField('ReagentCount6')
  final int reagentCount6;

  @FoxyFullField('ReagentCount7')
  final int reagentCount7;

  @FoxyFullField('EquippedItemClass')
  final int equippedItemClass;

  @FoxyFullField('EquippedItemSubclass')
  final int equippedItemSubclass;

  @FoxyFullField('EquippedItemInvTypes')
  final int equippedItemInvTypes;

  @FoxyFullField('Effect0')
  final int effect0;

  @FoxyFullField('Effect1')
  final int effect1;

  @FoxyFullField('Effect2')
  final int effect2;

  @FoxyFullField('EffectDieSides0')
  final int effectDieSides0;

  @FoxyFullField('EffectDieSides1')
  final int effectDieSides1;

  @FoxyFullField('EffectDieSides2')
  final int effectDieSides2;

  @FoxyFullField('EffectRealPointsPerLevel0')
  final double effectRealPointsPerLevel0;

  @FoxyFullField('EffectRealPointsPerLevel1')
  final double effectRealPointsPerLevel1;

  @FoxyFullField('EffectRealPointsPerLevel2')
  final double effectRealPointsPerLevel2;

  @FoxyFullField('EffectBasePoints0')
  final int effectBasePoints0;

  @FoxyFullField('EffectBasePoints1')
  final int effectBasePoints1;

  @FoxyFullField('EffectBasePoints2')
  final int effectBasePoints2;

  @FoxyFullField('EffectMechanic0')
  final int effectMechanic0;

  @FoxyFullField('EffectMechanic1')
  final int effectMechanic1;

  @FoxyFullField('EffectMechanic2')
  final int effectMechanic2;

  @FoxyFullField('ImplicitTargetA0')
  final int implicitTargetA0;

  @FoxyFullField('ImplicitTargetA1')
  final int implicitTargetA1;

  @FoxyFullField('ImplicitTargetA2')
  final int implicitTargetA2;

  @FoxyFullField('ImplicitTargetB0')
  final int implicitTargetB0;

  @FoxyFullField('ImplicitTargetB1')
  final int implicitTargetB1;

  @FoxyFullField('ImplicitTargetB2')
  final int implicitTargetB2;

  @FoxyFullField('EffectRadiusIndex0')
  final int effectRadiusIndex0;

  @FoxyFullField('EffectRadiusIndex1')
  final int effectRadiusIndex1;

  @FoxyFullField('EffectRadiusIndex2')
  final int effectRadiusIndex2;

  @FoxyFullField('EffectAura0')
  final int effectAura0;

  @FoxyFullField('EffectAura1')
  final int effectAura1;

  @FoxyFullField('EffectAura2')
  final int effectAura2;

  @FoxyFullField('EffectAuraPeriod0')
  final int effectAuraPeriod0;

  @FoxyFullField('EffectAuraPeriod1')
  final int effectAuraPeriod1;

  @FoxyFullField('EffectAuraPeriod2')
  final int effectAuraPeriod2;

  @FoxyFullField('EffectAmplitude0')
  final double effectAmplitude0;

  @FoxyFullField('EffectAmplitude1')
  final double effectAmplitude1;

  @FoxyFullField('EffectAmplitude2')
  final double effectAmplitude2;

  @FoxyFullField('EffectChainTargets0')
  final int effectChainTargets0;

  @FoxyFullField('EffectChainTargets1')
  final int effectChainTargets1;

  @FoxyFullField('EffectChainTargets2')
  final int effectChainTargets2;

  @FoxyFullField('EffectItemType0')
  final int effectItemType0;

  @FoxyFullField('EffectItemType1')
  final int effectItemType1;

  @FoxyFullField('EffectItemType2')
  final int effectItemType2;

  @FoxyFullField('EffectMiscValue0')
  final int effectMiscValue0;

  @FoxyFullField('EffectMiscValue1')
  final int effectMiscValue1;

  @FoxyFullField('EffectMiscValue2')
  final int effectMiscValue2;

  @FoxyFullField('EffectMiscValueB0')
  final int effectMiscValueB0;

  @FoxyFullField('EffectMiscValueB1')
  final int effectMiscValueB1;

  @FoxyFullField('EffectMiscValueB2')
  final int effectMiscValueB2;

  @FoxyFullField('EffectTriggerSpell0')
  final int effectTriggerSpell0;

  @FoxyFullField('EffectTriggerSpell1')
  final int effectTriggerSpell1;

  @FoxyFullField('EffectTriggerSpell2')
  final int effectTriggerSpell2;

  @FoxyFullField('EffectPointsPerCombo0')
  final double effectPointsPerCombo0;

  @FoxyFullField('EffectPointsPerCombo1')
  final double effectPointsPerCombo1;

  @FoxyFullField('EffectPointsPerCombo2')
  final double effectPointsPerCombo2;

  @FoxyFullField('EffectSpellClassMaskA0')
  final int effectSpellClassMaskA0;

  @FoxyFullField('EffectSpellClassMaskA1')
  final int effectSpellClassMaskA1;

  @FoxyFullField('EffectSpellClassMaskA2')
  final int effectSpellClassMaskA2;

  @FoxyFullField('EffectSpellClassMaskB0')
  final int effectSpellClassMaskB0;

  @FoxyFullField('EffectSpellClassMaskB1')
  final int effectSpellClassMaskB1;

  @FoxyFullField('EffectSpellClassMaskB2')
  final int effectSpellClassMaskB2;

  @FoxyFullField('EffectSpellClassMaskC0')
  final int effectSpellClassMaskC0;

  @FoxyFullField('EffectSpellClassMaskC1')
  final int effectSpellClassMaskC1;

  @FoxyFullField('EffectSpellClassMaskC2')
  final int effectSpellClassMaskC2;

  @FoxyFullField('SpellVisualID0')
  final int spellVisualID0;

  @FoxyFullField('SpellVisualID1')
  final int spellVisualID1;

  @FoxyFullField('SpellIconID')
  final int spellIconID;

  @FoxyFullField('ActiveIconID')
  final int activeIconID;

  @FoxyFullField('SpellPriority')
  final int spellPriority;

  @FoxyFullField('Name_lang_enUS')
  final String nameLangEnUS;

  @FoxyFullField('Name_lang_koKR')
  final String nameLangKoKR;

  @FoxyFullField('Name_lang_frFR')
  final String nameLangFrFR;

  @FoxyFullField('Name_lang_deDE')
  final String nameLangDeDE;

  @FoxyFullField('Name_lang_zhCN')
  final String nameLangZhCN;

  @FoxyFullField('Name_lang_zhTW')
  final String nameLangZhTW;

  @FoxyFullField('Name_lang_esES')
  final String nameLangEsES;

  @FoxyFullField('Name_lang_esMX')
  final String nameLangEsMX;

  @FoxyFullField('Name_lang_ruRU')
  final String nameLangRuRU;

  @FoxyFullField('Name_lang_jaJP')
  final String nameLangJaJP;

  @FoxyFullField('Name_lang_ptPT')
  final String nameLangPtPT;

  @FoxyFullField('Name_lang_ptBR')
  final String nameLangPtBR;

  @FoxyFullField('Name_lang_itIT')
  final String nameLangItIT;

  @FoxyFullField('Name_lang_unk1')
  final String nameLangUnk1;

  @FoxyFullField('Name_lang_unk2')
  final String nameLangUnk2;

  @FoxyFullField('Name_lang_unk3')
  final String nameLangUnk3;

  @FoxyFullField('Name_lang_Flags')
  final int nameLangFlags;

  @FoxyFullField('NameSubtext_lang_enUS')
  final String nameSubtextLangEnUS;

  @FoxyFullField('NameSubtext_lang_koKR')
  final String nameSubtextLangKoKR;

  @FoxyFullField('NameSubtext_lang_frFR')
  final String nameSubtextLangFrFR;

  @FoxyFullField('NameSubtext_lang_deDE')
  final String nameSubtextLangDeDE;

  @FoxyFullField('NameSubtext_lang_zhCN')
  final String nameSubtextLangZhCN;

  @FoxyFullField('NameSubtext_lang_zhTW')
  final String nameSubtextLangZhTW;

  @FoxyFullField('NameSubtext_lang_esES')
  final String nameSubtextLangEsES;

  @FoxyFullField('NameSubtext_lang_esMX')
  final String nameSubtextLangEsMX;

  @FoxyFullField('NameSubtext_lang_ruRU')
  final String nameSubtextLangRuRU;

  @FoxyFullField('NameSubtext_lang_jaJP')
  final String nameSubtextLangJaJP;

  @FoxyFullField('NameSubtext_lang_ptPT')
  final String nameSubtextLangPtPT;

  @FoxyFullField('NameSubtext_lang_ptBR')
  final String nameSubtextLangPtBR;

  @FoxyFullField('NameSubtext_lang_itIT')
  final String nameSubtextLangItIT;

  @FoxyFullField('NameSubtext_lang_unk1')
  final String nameSubtextLangUnk1;

  @FoxyFullField('NameSubtext_lang_unk2')
  final String nameSubtextLangUnk2;

  @FoxyFullField('NameSubtext_lang_unk3')
  final String nameSubtextLangUnk3;

  @FoxyFullField('NameSubtext_lang_Flags')
  final int nameSubtextLangFlags;

  @FoxyFullField('Description_lang_enUS')
  final String descriptionLangEnUS;

  @FoxyFullField('Description_lang_koKR')
  final String descriptionLangKoKR;

  @FoxyFullField('Description_lang_frFR')
  final String descriptionLangFrFR;

  @FoxyFullField('Description_lang_deDE')
  final String descriptionLangDeDE;

  @FoxyFullField('Description_lang_zhCN')
  final String descriptionLangZhCN;

  @FoxyFullField('Description_lang_zhTW')
  final String descriptionLangZhTW;

  @FoxyFullField('Description_lang_esES')
  final String descriptionLangEsES;

  @FoxyFullField('Description_lang_esMX')
  final String descriptionLangEsMX;

  @FoxyFullField('Description_lang_ruRU')
  final String descriptionLangRuRU;

  @FoxyFullField('Description_lang_jaJP')
  final String descriptionLangJaJP;

  @FoxyFullField('Description_lang_ptPT')
  final String descriptionLangPtPT;

  @FoxyFullField('Description_lang_ptBR')
  final String descriptionLangPtBR;

  @FoxyFullField('Description_lang_itIT')
  final String descriptionLangItIT;

  @FoxyFullField('Description_lang_unk1')
  final String descriptionLangUnk1;

  @FoxyFullField('Description_lang_unk2')
  final String descriptionLangUnk2;

  @FoxyFullField('Description_lang_unk3')
  final String descriptionLangUnk3;

  @FoxyFullField('Description_lang_Flags')
  final int descriptionLangFlags;

  @FoxyFullField('AuraDescription_lang_enUS')
  final String auraDescriptionLangEnUS;

  @FoxyFullField('AuraDescription_lang_koKR')
  final String auraDescriptionLangKoKR;

  @FoxyFullField('AuraDescription_lang_frFR')
  final String auraDescriptionLangFrFR;

  @FoxyFullField('AuraDescription_lang_deDE')
  final String auraDescriptionLangDeDE;

  @FoxyFullField('AuraDescription_lang_zhCN')
  final String auraDescriptionLangZhCN;

  @FoxyFullField('AuraDescription_lang_zhTW')
  final String auraDescriptionLangZhTW;

  @FoxyFullField('AuraDescription_lang_esES')
  final String auraDescriptionLangEsES;

  @FoxyFullField('AuraDescription_lang_esMX')
  final String auraDescriptionLangEsMX;

  @FoxyFullField('AuraDescription_lang_ruRU')
  final String auraDescriptionLangRuRU;

  @FoxyFullField('AuraDescription_lang_jaJP')
  final String auraDescriptionLangJaJP;

  @FoxyFullField('AuraDescription_lang_ptPT')
  final String auraDescriptionLangPtPT;

  @FoxyFullField('AuraDescription_lang_ptBR')
  final String auraDescriptionLangPtBR;

  @FoxyFullField('AuraDescription_lang_itIT')
  final String auraDescriptionLangItIT;

  @FoxyFullField('AuraDescription_lang_unk1')
  final String auraDescriptionLangUnk1;

  @FoxyFullField('AuraDescription_lang_unk2')
  final String auraDescriptionLangUnk2;

  @FoxyFullField('AuraDescription_lang_unk3')
  final String auraDescriptionLangUnk3;

  @FoxyFullField('AuraDescription_lang_Flags')
  final int auraDescriptionLangFlags;

  @FoxyFullField('ManaCostPct')
  final int manaCostPct;

  @FoxyFullField('StartRecoveryCategory')
  final int startRecoveryCategory;

  @FoxyFullField('StartRecoveryTime')
  final int startRecoveryTime;

  @FoxyFullField('MaxTargetLevel')
  final int maxTargetLevel;

  @FoxyFullField('SpellClassSet')
  final int spellClassSet;

  @FoxyFullField('SpellClassMask0')
  final int spellClassMask0;

  @FoxyFullField('SpellClassMask1')
  final int spellClassMask1;

  @FoxyFullField('SpellClassMask2')
  final int spellClassMask2;

  @FoxyFullField('MaxTargets')
  final int maxTargets;

  @FoxyFullField('DefenseType')
  final int defenseType;

  @FoxyFullField('PreventionType')
  final int preventionType;

  @FoxyFullField('StanceBarOrder')
  final int stanceBarOrder;

  @FoxyFullField('EffectChainAmplitude0')
  final double effectChainAmplitude0;

  @FoxyFullField('EffectChainAmplitude1')
  final double effectChainAmplitude1;

  @FoxyFullField('EffectChainAmplitude2')
  final double effectChainAmplitude2;

  @FoxyFullField('MinFactionID')
  final int minFactionID;

  @FoxyFullField('MinReputation')
  final int minReputation;

  @FoxyFullField('RequiredAuraVision')
  final int requiredAuraVision;

  @FoxyFullField('RequiredTotemCategoryID0')
  final int requiredTotemCategoryID0;

  @FoxyFullField('RequiredTotemCategoryID1')
  final int requiredTotemCategoryID1;

  @FoxyFullField('RequiredAreasID')
  final int requiredAreasID;

  @FoxyFullField('SchoolMask')
  final int schoolMask;

  @FoxyFullField('RuneCostID')
  final int runeCostID;

  @FoxyFullField('SpellMissileID')
  final int spellMissileID;

  @FoxyFullField('PowerDisplayID')
  final int powerDisplayID;

  @FoxyFullField('EffectBonusCoefficient0')
  final double effectBonusCoefficient0;

  @FoxyFullField('EffectBonusCoefficient1')
  final double effectBonusCoefficient1;

  @FoxyFullField('EffectBonusCoefficient2')
  final double effectBonusCoefficient2;

  @FoxyFullField('DescriptionVariablesID')
  final int spellDescriptionVariableID;

  @FoxyFullField('Difficulty')
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

  factory SpellEntity.fromJson(Map<String, dynamic> json) =>
      _SpellEntityMixin.fromJson(json);
}

extension BriefSpellEntityDisplay on BriefSpellEntity {
  String get displayAuraDescription => localeAuraDescription.isNotEmpty
      ? localeAuraDescription
      : auraDescription;

  String get displayDescription =>
      localeDescription.isNotEmpty ? localeDescription : description;

  String get displayName => localeName.isNotEmpty ? localeName : name;

  String get displaySubtext =>
      localeSubtext.isNotEmpty ? localeSubtext : subtext;
}
