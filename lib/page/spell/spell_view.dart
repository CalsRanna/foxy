import 'package:flutter/material.dart';
import 'package:foxy/page/spell/spell_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SpellView extends StatefulWidget {
  final int? id;
  const SpellView({super.key, this.id});

  @override
  State<SpellView> createState() => _SpellViewState();
}

class _SpellViewState extends State<SpellView> {
  final viewModel = GetIt.instance.get<SpellDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(id: widget.id);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = viewModel;

    // === 基础文本 ===
    final nameInput = FormItem(
      controller: vm.nameLangZhCNController,
      label: '名称',
      placeholder: 'Name_Lang_zhCN',
    );
    final subtextInput = FormItem(
      controller: vm.nameSubtextLangZhCNController,
      label: '子名称',
      placeholder: 'NameSubtext_Lang_zhCN',
    );
    final descriptionInput = FormItem(
      controller: vm.descriptionLangZhCNController,
      label: '描述',
      placeholder: 'Description_Lang_zhCN',
    );
    final auraDescriptionInput = FormItem(
      controller: vm.auraDescriptionLangZhCNController,
      label: 'Buff描述',
      placeholder: 'AuraDescription_Lang_zhCN',
    );

    // === 图标/视觉 ===
    final spellIconIDInput = FormItem(
      controller: vm.spellIconIDController,
      label: '图标',
      placeholder: 'SpellIconID',
    );
    final activeIconIDInput = FormItem(
      controller: vm.activeIconIDController,
      label: '激活图标',
      placeholder: 'ActiveIconID',
    );
    final spellVisualID0Input = FormItem(
      controller: vm.spellVisualID0Controller,
      label: '视觉效果1',
      placeholder: 'SpellVisualID0',
    );
    final spellVisualID1Input = FormItem(
      controller: vm.spellVisualID1Controller,
      label: '视觉效果2',
      placeholder: 'SpellVisualID1',
    );

    // === 分类/类型 ===
    final categoryInput = FormItem(
      controller: vm.categoryController,
      label: '分类',
      placeholder: 'Category',
    );
    final schoolMaskInput = FormItem(
      controller: vm.schoolMaskController,
      label: '法术类型掩码',
      placeholder: 'SchoolMask',
    );
    final mechanicInput = FormItem(
      controller: vm.mechanicController,
      label: '机制',
      placeholder: 'Mechanic',
    );
    final defenseTypeInput = FormItem(
      controller: vm.defenseTypeController,
      label: '防御类型',
      placeholder: 'DefenseType',
    );
    final dispelTypeInput = FormItem(
      controller: vm.dispelTypeController,
      label: '驱散类型',
      placeholder: 'DispelType',
    );
    final preventionTypeInput = FormItem(
      controller: vm.preventionTypeController,
      label: '防止类型',
      placeholder: 'PreventionType',
    );

    // === 施法参数 ===
    final castingTimeIndexInput = FormItem(
      controller: vm.castingTimeIndexController,
      label: '施法时间',
      placeholder: 'CastingTimeIndex',
    );
    final durationIndexInput = FormItem(
      controller: vm.durationIndexController,
      label: '持续时间',
      placeholder: 'DurationIndex',
    );
    final rangeIndexInput = FormItem(
      controller: vm.rangeIndexController,
      label: '施法范围',
      placeholder: 'RangeIndex',
    );
    final spellDescVarIDInput = FormItem(
      controller: vm.spellDescriptionVariableIDController,
      label: '描述变量',
      placeholder: 'SpellDescriptionVariableID',
    );

    // === 等级 ===
    final baseLevelInput = FormItem(
      controller: vm.baseLevelController,
      label: '基础等级',
      placeholder: 'BaseLevel',
    );
    final spellLevelInput = FormItem(
      controller: vm.spellLevelController,
      label: '法术等级',
      placeholder: 'SpellLevel',
    );
    final maxLevelInput = FormItem(
      controller: vm.maxLevelController,
      label: '最高等级',
      placeholder: 'MaxLevel',
    );
    final spellDifficultyIDInput = FormItem(
      controller: vm.spellDifficultyIDController,
      label: '难度ID',
      placeholder: 'SpellDifficultyID',
    );

    // === 冷却/恢复 ===
    final startRecoveryCategoryInput = FormItem(
      controller: vm.startRecoveryCategoryController,
      label: '冷却分类',
      placeholder: 'StartRecoveryCategory',
    );
    final startRecoveryTimeInput = FormItem(
      controller: vm.startRecoveryTimeController,
      label: '冷却开始时间',
      placeholder: 'StartRecoveryTime',
    );
    final recoveryTimeInput = FormItem(
      controller: vm.recoveryTimeController,
      label: '冷却时间',
      placeholder: 'RecoveryTime',
    );
    final categoryRecoveryTimeInput = FormItem(
      controller: vm.categoryRecoveryTimeController,
      label: '分类冷却时间',
      placeholder: 'CategoryRecoveryTime',
    );

    // === 目标 ===
    final targetCreatureTypeInput = FormItem(
      controller: vm.targetCreatureTypeController,
      label: '目标生物类型',
      placeholder: 'TargetCreatureType',
    );
    final targetsInput = FormItem(
      controller: vm.targetsController,
      label: '目标限制',
      placeholder: 'Targets',
    );
    final maxTargetsInput = FormItem(
      controller: vm.maxTargetsController,
      label: '最大目标数',
      placeholder: 'MaxTargets',
    );
    final maxTargetLevelInput = FormItem(
      controller: vm.maxTargetLevelController,
      label: '最大目标等级',
      placeholder: 'MaxTargetLevel',
    );

    // === 状态 ===
    final casterAuraStateInput = FormItem(
      controller: vm.casterAuraStateController,
      label: '施法者状态',
      placeholder: 'CasterAuraState',
    );
    final targetAuraStateInput = FormItem(
      controller: vm.targetAuraStateController,
      label: '目标状态',
      placeholder: 'TargetAuraState',
    );
    final spellMissileIDInput = FormItem(
      controller: vm.spellMissileIDController,
      label: '弹道',
      placeholder: 'SpellMissileID',
    );
    final speedInput = FormItem(
      controller: vm.speedController,
      label: '弹道速度',
      placeholder: 'Speed',
    );

    // === 需求 ===
    final requiredAreasIDInput = FormItem(
      controller: vm.requiredAreasIDController,
      label: '需求区域',
      placeholder: 'RequiredAreasID',
    );
    final requiresSpellFocusInput = FormItem(
      controller: vm.requiresSpellFocusController,
      label: '需求法术焦点',
      placeholder: 'RequiresSpellFocus',
    );
    final facingCasterFlagsInput = FormItem(
      controller: vm.facingCasterFlagsController,
      label: '施法朝向',
      placeholder: 'FacingCasterFlags',
    );

    // === 能量消耗 ===
    final powerDisplayIDInput = FormItem(
      controller: vm.powerDisplayIDController,
      label: '能量显示',
      placeholder: 'PowerDisplayID',
    );
    final powerTypeInput = FormItem(
      controller: vm.powerTypeController,
      label: '能量类型',
      placeholder: 'PowerType',
    );
    final runeCostIDInput = FormItem(
      controller: vm.runeCostIDController,
      label: '符文消耗',
      placeholder: 'RuneCostID',
    );
    final manaCostInput = FormItem(
      controller: vm.manaCostController,
      label: '法力消耗',
      placeholder: 'ManaCost',
    );
    final manaCostPctInput = FormItem(
      controller: vm.manaCostPctController,
      label: '法力消耗百分比',
      placeholder: 'ManaCostPct',
    );
    final manaCostPerLevelInput = FormItem(
      controller: vm.manaCostPerLevelController,
      label: '每级法力消耗',
      placeholder: 'ManaCostPerLevel',
    );
    final manaPerSecondInput = FormItem(
      controller: vm.manaPerSecondController,
      label: '每秒法力',
      placeholder: 'ManaPerSecond',
    );
    final manaPerSecondPerLevelInput = FormItem(
      controller: vm.manaPerSecondPerLevelController,
      label: '每秒每级法力',
      placeholder: 'ManaPerSecondPerLevel',
    );

    // === 标志位（所有属性标志） ===
    final interruptFlagsInput = FormItem(
      controller: vm.interruptFlagsController,
      label: '打断标志',
      placeholder: 'InterruptFlags',
    );
    final auraInterruptFlagsInput = FormItem(
      controller: vm.auraInterruptFlagsController,
      label: '光环打断标志',
      placeholder: 'AuraInterruptFlags',
    );
    final channelInterruptFlagsInput = FormItem(
      controller: vm.channelInterruptFlagsController,
      label: '引导打断标志',
      placeholder: 'ChannelInterruptFlags',
    );
    final attributesInput = FormItem(
      controller: vm.attributesController,
      label: '属性',
      placeholder: 'Attributes',
    );
    final attributesExInput = FormItem(
      controller: vm.attributesExController,
      label: '属性Ex',
      placeholder: 'AttributesEx',
    );
    final attributesExBInput = FormItem(
      controller: vm.attributesExBController,
      label: '属性ExB',
      placeholder: 'AttributesExB',
    );
    final attributesExCInput = FormItem(
      controller: vm.attributesExCController,
      label: '属性ExC',
      placeholder: 'AttributesExC',
    );
    final attributesExDInput = FormItem(
      controller: vm.attributesExDController,
      label: '属性ExD',
      placeholder: 'AttributesExD',
    );
    final attributesExEInput = FormItem(
      controller: vm.attributesExEController,
      label: '属性ExE',
      placeholder: 'AttributesExE',
    );
    final attributesExFInput = FormItem(
      controller: vm.attributesExFController,
      label: '属性ExF',
      placeholder: 'AttributesExF',
    );
    final attributesExGInput = FormItem(
      controller: vm.attributesExGController,
      label: '属性ExG',
      placeholder: 'AttributesExG',
    );

    // === 触发 ===
    final procTypeMaskInput = FormItem(
      controller: vm.procTypeMaskController,
      label: '触发类型掩码',
      placeholder: 'ProcTypeMask',
    );
    final procChanceInput = FormItem(
      controller: vm.procChanceController,
      label: '触发几率',
      placeholder: 'ProcChance',
    );
    final procChargesInput = FormItem(
      controller: vm.procChargesController,
      label: '触发次数',
      placeholder: 'ProcCharges',
    );

    // === 法术分类掩码 ===
    final spellClassSetInput = FormItem(
      controller: vm.spellClassSetController,
      label: '法术分类集',
      placeholder: 'SpellClassSet',
    );
    final spellClassMask0Input = FormItem(
      controller: vm.spellClassMask0Controller,
      label: '分类掩码1',
      placeholder: 'SpellClassMask0',
    );
    final spellClassMask1Input = FormItem(
      controller: vm.spellClassMask1Controller,
      label: '分类掩码2',
      placeholder: 'SpellClassMask1',
    );
    final spellClassMask2Input = FormItem(
      controller: vm.spellClassMask2Controller,
      label: '分类掩码3',
      placeholder: 'SpellClassMask2',
    );

    // === 效果0 ===
    final effect0Input = FormItem(
      controller: vm.effect0Controller,
      label: '效果0类型',
      placeholder: 'Effect0',
    );
    final effectBasePoints0Input = FormItem(
      controller: vm.effectBasePoints0Controller,
      label: '效果0基础值',
      placeholder: 'EffectBasePoints0',
    );
    final effectDieSides0Input = FormItem(
      controller: vm.effectDieSides0Controller,
      label: '效果0波动值',
      placeholder: 'EffectDieSides0',
    );
    final effectRealPointsPerLevel0Input = FormItem(
      controller: vm.effectRealPointsPerLevel0Controller,
      label: '效果0每级加成',
      placeholder: 'EffectRealPointsPerLevel0',
    );
    final effectMechanic0Input = FormItem(
      controller: vm.effectMechanic0Controller,
      label: '效果0机制',
      placeholder: 'EffectMechanic0',
    );
    final effectAura0Input = FormItem(
      controller: vm.effectAura0Controller,
      label: '效果0光环',
      placeholder: 'EffectAura0',
    );
    final effectAuraPeriod0Input = FormItem(
      controller: vm.effectAuraPeriod0Controller,
      label: '效果0光环周期',
      placeholder: 'EffectAuraPeriod0',
    );
    final effectAmplitude0Input = FormItem(
      controller: vm.effectAmplitude0Controller,
      label: '效果0振幅',
      placeholder: 'EffectAmplitude0',
    );
    final implicitTargetA0Input = FormItem(
      controller: vm.implicitTargetA0Controller,
      label: '效果0目标A',
      placeholder: 'ImplicitTargetA0',
    );
    final implicitTargetB0Input = FormItem(
      controller: vm.implicitTargetB0Controller,
      label: '效果0目标B',
      placeholder: 'ImplicitTargetB0',
    );
    final effectMiscValue0Input = FormItem(
      controller: vm.effectMiscValue0Controller,
      label: '效果0杂项值',
      placeholder: 'EffectMiscValue0',
    );
    final effectMiscValueB0Input = FormItem(
      controller: vm.effectMiscValueB0Controller,
      label: '效果0杂项值B',
      placeholder: 'EffectMiscValueB0',
    );
    final effectRadiusIndex0Input = FormItem(
      controller: vm.effectRadiusIndex0Controller,
      label: '效果0半径',
      placeholder: 'EffectRadiusIndex0',
    );
    final effectChainAmplitude0Input = FormItem(
      controller: vm.effectChainAmplitude0Controller,
      label: '效果0连锁振幅',
      placeholder: 'EffectChainAmplitude0',
    );
    final effectBonusCoefficient0Input = FormItem(
      controller: vm.effectBonusCoefficient0Controller,
      label: '效果0加成系数',
      placeholder: 'EffectBonusCoefficient0',
    );
    final effectItemType0Input = FormItem(
      controller: vm.effectItemType0Controller,
      label: '效果0物品类型',
      placeholder: 'EffectItemType0',
    );
    final effectTriggerSpell0Input = FormItem(
      controller: vm.effectTriggerSpell0Controller,
      label: '效果0触发法术',
      placeholder: 'EffectTriggerSpell0',
    );
    final effectChainTargets0Input = FormItem(
      controller: vm.effectChainTargets0Controller,
      label: '效果0连锁目标',
      placeholder: 'EffectChainTargets0',
    );
    final effectPointsPerCombo0Input = FormItem(
      controller: vm.effectPointsPerCombo0Controller,
      label: '效果0连击点数',
      placeholder: 'EffectPointsPerCombo0',
    );
    final effectSpellClassMaskA0Input = FormItem(
      controller: vm.effectSpellClassMaskA0Controller,
      label: '效果0分类掩码A',
      placeholder: 'EffectSpellClassMaskA0',
    );
    final effectSpellClassMaskB0Input = FormItem(
      controller: vm.effectSpellClassMaskB0Controller,
      label: '效果0分类掩码B',
      placeholder: 'EffectSpellClassMaskB0',
    );
    final effectSpellClassMaskC0Input = FormItem(
      controller: vm.effectSpellClassMaskC0Controller,
      label: '效果0分类掩码C',
      placeholder: 'EffectSpellClassMaskC0',
    );

    // === 效果1 ===
    final effect1Input = FormItem(
      controller: vm.effect1Controller,
      label: '效果1类型',
      placeholder: 'Effect1',
    );
    final effectBasePoints1Input = FormItem(
      controller: vm.effectBasePoints1Controller,
      label: '效果1基础值',
      placeholder: 'EffectBasePoints1',
    );
    final effectDieSides1Input = FormItem(
      controller: vm.effectDieSides1Controller,
      label: '效果1波动值',
      placeholder: 'EffectDieSides1',
    );
    final effectRealPointsPerLevel1Input = FormItem(
      controller: vm.effectRealPointsPerLevel1Controller,
      label: '效果1每级加成',
      placeholder: 'EffectRealPointsPerLevel1',
    );
    final effectMechanic1Input = FormItem(
      controller: vm.effectMechanic1Controller,
      label: '效果1机制',
      placeholder: 'EffectMechanic1',
    );
    final effectAura1Input = FormItem(
      controller: vm.effectAura1Controller,
      label: '效果1光环',
      placeholder: 'EffectAura1',
    );
    final effectAuraPeriod1Input = FormItem(
      controller: vm.effectAuraPeriod1Controller,
      label: '效果1光环周期',
      placeholder: 'EffectAuraPeriod1',
    );
    final effectAmplitude1Input = FormItem(
      controller: vm.effectAmplitude1Controller,
      label: '效果1振幅',
      placeholder: 'EffectAmplitude1',
    );
    final implicitTargetA1Input = FormItem(
      controller: vm.implicitTargetA1Controller,
      label: '效果1目标A',
      placeholder: 'ImplicitTargetA1',
    );
    final implicitTargetB1Input = FormItem(
      controller: vm.implicitTargetB1Controller,
      label: '效果1目标B',
      placeholder: 'ImplicitTargetB1',
    );
    final effectMiscValue1Input = FormItem(
      controller: vm.effectMiscValue1Controller,
      label: '效果1杂项值',
      placeholder: 'EffectMiscValue1',
    );
    final effectMiscValueB1Input = FormItem(
      controller: vm.effectMiscValueB1Controller,
      label: '效果1杂项值B',
      placeholder: 'EffectMiscValueB1',
    );
    final effectRadiusIndex1Input = FormItem(
      controller: vm.effectRadiusIndex1Controller,
      label: '效果1半径',
      placeholder: 'EffectRadiusIndex1',
    );
    final effectChainAmplitude1Input = FormItem(
      controller: vm.effectChainAmplitude1Controller,
      label: '效果1连锁振幅',
      placeholder: 'EffectChainAmplitude1',
    );
    final effectBonusCoefficient1Input = FormItem(
      controller: vm.effectBonusCoefficient1Controller,
      label: '效果1加成系数',
      placeholder: 'EffectBonusCoefficient1',
    );
    final effectItemType1Input = FormItem(
      controller: vm.effectItemType1Controller,
      label: '效果1物品类型',
      placeholder: 'EffectItemType1',
    );
    final effectTriggerSpell1Input = FormItem(
      controller: vm.effectTriggerSpell1Controller,
      label: '效果1触发法术',
      placeholder: 'EffectTriggerSpell1',
    );
    final effectChainTargets1Input = FormItem(
      controller: vm.effectChainTargets1Controller,
      label: '效果1连锁目标',
      placeholder: 'EffectChainTargets1',
    );
    final effectPointsPerCombo1Input = FormItem(
      controller: vm.effectPointsPerCombo1Controller,
      label: '效果1连击点数',
      placeholder: 'EffectPointsPerCombo1',
    );
    final effectSpellClassMaskA1Input = FormItem(
      controller: vm.effectSpellClassMaskA1Controller,
      label: '效果1分类掩码A',
      placeholder: 'EffectSpellClassMaskA1',
    );
    final effectSpellClassMaskB1Input = FormItem(
      controller: vm.effectSpellClassMaskB1Controller,
      label: '效果1分类掩码B',
      placeholder: 'EffectSpellClassMaskB1',
    );
    final effectSpellClassMaskC1Input = FormItem(
      controller: vm.effectSpellClassMaskC1Controller,
      label: '效果1分类掩码C',
      placeholder: 'EffectSpellClassMaskC1',
    );

    // === 效果2 ===
    final effect2Input = FormItem(
      controller: vm.effect2Controller,
      label: '效果2类型',
      placeholder: 'Effect2',
    );
    final effectBasePoints2Input = FormItem(
      controller: vm.effectBasePoints2Controller,
      label: '效果2基础值',
      placeholder: 'EffectBasePoints2',
    );
    final effectDieSides2Input = FormItem(
      controller: vm.effectDieSides2Controller,
      label: '效果2波动值',
      placeholder: 'EffectDieSides2',
    );
    final effectRealPointsPerLevel2Input = FormItem(
      controller: vm.effectRealPointsPerLevel2Controller,
      label: '效果2每级加成',
      placeholder: 'EffectRealPointsPerLevel2',
    );
    final effectMechanic2Input = FormItem(
      controller: vm.effectMechanic2Controller,
      label: '效果2机制',
      placeholder: 'EffectMechanic2',
    );
    final effectAura2Input = FormItem(
      controller: vm.effectAura2Controller,
      label: '效果2光环',
      placeholder: 'EffectAura2',
    );
    final effectAuraPeriod2Input = FormItem(
      controller: vm.effectAuraPeriod2Controller,
      label: '效果2光环周期',
      placeholder: 'EffectAuraPeriod2',
    );
    final effectAmplitude2Input = FormItem(
      controller: vm.effectAmplitude2Controller,
      label: '效果2振幅',
      placeholder: 'EffectAmplitude2',
    );
    final implicitTargetA2Input = FormItem(
      controller: vm.implicitTargetA2Controller,
      label: '效果2目标A',
      placeholder: 'ImplicitTargetA2',
    );
    final implicitTargetB2Input = FormItem(
      controller: vm.implicitTargetB2Controller,
      label: '效果2目标B',
      placeholder: 'ImplicitTargetB2',
    );
    final effectMiscValue2Input = FormItem(
      controller: vm.effectMiscValue2Controller,
      label: '效果2杂项值',
      placeholder: 'EffectMiscValue2',
    );
    final effectMiscValueB2Input = FormItem(
      controller: vm.effectMiscValueB2Controller,
      label: '效果2杂项值B',
      placeholder: 'EffectMiscValueB2',
    );
    final effectRadiusIndex2Input = FormItem(
      controller: vm.effectRadiusIndex2Controller,
      label: '效果2半径',
      placeholder: 'EffectRadiusIndex2',
    );
    final effectChainAmplitude2Input = FormItem(
      controller: vm.effectChainAmplitude2Controller,
      label: '效果2连锁振幅',
      placeholder: 'EffectChainAmplitude2',
    );
    final effectBonusCoefficient2Input = FormItem(
      controller: vm.effectBonusCoefficient2Controller,
      label: '效果2加成系数',
      placeholder: 'EffectBonusCoefficient2',
    );
    final effectItemType2Input = FormItem(
      controller: vm.effectItemType2Controller,
      label: '效果2物品类型',
      placeholder: 'EffectItemType2',
    );
    final effectTriggerSpell2Input = FormItem(
      controller: vm.effectTriggerSpell2Controller,
      label: '效果2触发法术',
      placeholder: 'EffectTriggerSpell2',
    );
    final effectChainTargets2Input = FormItem(
      controller: vm.effectChainTargets2Controller,
      label: '效果2连锁目标',
      placeholder: 'EffectChainTargets2',
    );
    final effectPointsPerCombo2Input = FormItem(
      controller: vm.effectPointsPerCombo2Controller,
      label: '效果2连击点数',
      placeholder: 'EffectPointsPerCombo2',
    );
    final effectSpellClassMaskA2Input = FormItem(
      controller: vm.effectSpellClassMaskA2Controller,
      label: '效果2分类掩码A',
      placeholder: 'EffectSpellClassMaskA2',
    );
    final effectSpellClassMaskB2Input = FormItem(
      controller: vm.effectSpellClassMaskB2Controller,
      label: '效果2分类掩码B',
      placeholder: 'EffectSpellClassMaskB2',
    );
    final effectSpellClassMaskC2Input = FormItem(
      controller: vm.effectSpellClassMaskC2Controller,
      label: '效果2分类掩码C',
      placeholder: 'EffectSpellClassMaskC2',
    );

    // === 装备限制 ===
    final equippedItemClassInput = FormItem(
      controller: vm.equippedItemClassController,
      label: '装备职业',
      placeholder: 'EquippedItemClass',
    );
    final equippedItemSubclassInput = FormItem(
      controller: vm.equippedItemSubclassController,
      label: '装备子类',
      placeholder: 'EquippedItemSubclass',
    );
    final equippedItemInvTypesInput = FormItem(
      controller: vm.equippedItemInvTypesController,
      label: '装备栏位',
      placeholder: 'EquippedItemInvTypes',
    );

    // === 图腾/施法材料 ===
    final requiredTotemCategoryID0Input = FormItem(
      controller: vm.requiredTotemCategoryID0Controller,
      label: '图腾1类型',
      placeholder: 'RequiredTotemCategoryID0',
    );
    final totem0Input = FormItem(
      controller: vm.totem0Controller,
      label: '图腾1',
      placeholder: 'Totem0',
    );
    final requiredTotemCategoryID1Input = FormItem(
      controller: vm.requiredTotemCategoryID1Controller,
      label: '图腾2类型',
      placeholder: 'RequiredTotemCategoryID1',
    );
    final totem1Input = FormItem(
      controller: vm.totem1Controller,
      label: '图腾2',
      placeholder: 'Totem1',
    );
    final reagent0Input = FormItem(
      controller: vm.reagent0Controller,
      label: '施法材料1',
      placeholder: 'Reagent0',
    );
    final reagentCount0Input = FormItem(
      controller: vm.reagentCount0Controller,
      label: '材料1数量',
      placeholder: 'ReagentCount0',
    );
    final reagent1Input = FormItem(
      controller: vm.reagent1Controller,
      label: '施法材料2',
      placeholder: 'Reagent1',
    );
    final reagentCount1Input = FormItem(
      controller: vm.reagentCount1Controller,
      label: '材料2数量',
      placeholder: 'ReagentCount1',
    );
    final reagent2Input = FormItem(
      controller: vm.reagent2Controller,
      label: '施法材料3',
      placeholder: 'Reagent2',
    );
    final reagentCount2Input = FormItem(
      controller: vm.reagentCount2Controller,
      label: '材料3数量',
      placeholder: 'ReagentCount2',
    );
    final reagent3Input = FormItem(
      controller: vm.reagent3Controller,
      label: '施法材料4',
      placeholder: 'Reagent3',
    );
    final reagentCount3Input = FormItem(
      controller: vm.reagentCount3Controller,
      label: '材料4数量',
      placeholder: 'ReagentCount3',
    );

    // === 其他高级属性 ===
    final casterAuraSpellInput = FormItem(
      controller: vm.casterAuraSpellController,
      label: '施法者光环法术',
      placeholder: 'CasterAuraSpell',
    );
    final cumulativeAuraInput = FormItem(
      controller: vm.cumulativeAuraController,
      label: '累积光环',
      placeholder: 'CumulativeAura',
    );
    final minFactionIDInput = FormItem(
      controller: vm.minFactionIDController,
      label: '最低声望阵营',
      placeholder: 'MinFactionID',
    );
    final minReputationInput = FormItem(
      controller: vm.minReputationController,
      label: '最低声望等级',
      placeholder: 'MinReputation',
    );
    final spellPriorityInput = FormItem(
      controller: vm.spellPriorityController,
      label: '法术优先级',
      placeholder: 'SpellPriority',
    );
    final modalNextSpellInput = FormItem(
      controller: vm.modalNextSpellController,
      label: '下个模态法术',
      placeholder: 'ModalNextSpell',
    );
    final requiredAuraVisionInput = FormItem(
      controller: vm.requiredAuraVisionController,
      label: '需求光环视野',
      placeholder: 'RequiredAuraVision',
    );
    final targetAuraSpellInput = FormItem(
      controller: vm.targetAuraSpellController,
      label: '目标光环法术',
      placeholder: 'TargetAuraSpell',
    );
    final stanceBarOrderInput = FormItem(
      controller: vm.stanceBarOrderController,
      label: '姿态栏顺序',
      placeholder: 'StanceBarOrder',
    );
    final shapeshiftMask0Input = FormItem(
      controller: vm.shapeshiftMask0Controller,
      label: '变形掩码',
      placeholder: 'ShapeshiftMask0',
    );
    final shapeshiftExclude0Input = FormItem(
      controller: vm.shapeshiftExclude0Controller,
      label: '变形排除',
      placeholder: 'ShapeshiftExclude0',
    );

    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: nameInput),
          Expanded(child: subtextInput),
          Expanded(child: descriptionInput),
          Expanded(child: auraDescriptionInput),
        ],
      ),
    ];

    final visualRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: spellIconIDInput),
          Expanded(child: activeIconIDInput),
          Expanded(child: spellVisualID0Input),
          Expanded(child: spellVisualID1Input),
        ],
      ),
    ];

    final categoryRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: categoryInput),
          Expanded(child: schoolMaskInput),
          Expanded(child: mechanicInput),
          Expanded(child: defenseTypeInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: dispelTypeInput),
          Expanded(child: preventionTypeInput),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    final castingRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: castingTimeIndexInput),
          Expanded(child: durationIndexInput),
          Expanded(child: rangeIndexInput),
          Expanded(child: spellDescVarIDInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: baseLevelInput),
          Expanded(child: spellLevelInput),
          Expanded(child: maxLevelInput),
          Expanded(child: spellDifficultyIDInput),
        ],
      ),
    ];

    final recoveryRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: startRecoveryCategoryInput),
          Expanded(child: startRecoveryTimeInput),
          Expanded(child: recoveryTimeInput),
          Expanded(child: categoryRecoveryTimeInput),
        ],
      ),
    ];

    final targetRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: targetCreatureTypeInput),
          Expanded(child: targetsInput),
          Expanded(child: maxTargetsInput),
          Expanded(child: maxTargetLevelInput),
        ],
      ),
    ];

    final stateRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: casterAuraStateInput),
          Expanded(child: targetAuraStateInput),
          Expanded(child: spellMissileIDInput),
          Expanded(child: speedInput),
        ],
      ),
    ];

    final requiredRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: requiredAreasIDInput),
          Expanded(child: requiresSpellFocusInput),
          Expanded(child: facingCasterFlagsInput),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    final powerRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: powerDisplayIDInput),
          Expanded(child: powerTypeInput),
          Expanded(child: runeCostIDInput),
          Expanded(child: manaCostInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: manaCostPctInput),
          Expanded(child: manaCostPerLevelInput),
          Expanded(child: manaPerSecondInput),
          Expanded(child: manaPerSecondPerLevelInput),
        ],
      ),
    ];

    final attributeFlagRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: interruptFlagsInput),
          Expanded(child: auraInterruptFlagsInput),
          Expanded(child: channelInterruptFlagsInput),
          Expanded(child: attributesInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: attributesExInput),
          Expanded(child: attributesExBInput),
          Expanded(child: attributesExCInput),
          Expanded(child: attributesExDInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: attributesExEInput),
          Expanded(child: attributesExFInput),
          Expanded(child: attributesExGInput),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    final procRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: procTypeMaskInput),
          Expanded(child: procChanceInput),
          Expanded(child: procChargesInput),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    final spellClassRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: spellClassSetInput),
          Expanded(child: spellClassMask0Input),
          Expanded(child: spellClassMask1Input),
          Expanded(child: spellClassMask2Input),
        ],
      ),
    ];

    final effect0Rows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: effect0Input),
          Expanded(child: effectBasePoints0Input),
          Expanded(child: effectDieSides0Input),
          Expanded(child: effectRealPointsPerLevel0Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectMechanic0Input),
          Expanded(child: effectChainTargets0Input),
          Expanded(child: effectAura0Input),
          Expanded(child: effectAuraPeriod0Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectAmplitude0Input),
          Expanded(child: implicitTargetA0Input),
          Expanded(child: implicitTargetB0Input),
          Expanded(child: effectMiscValue0Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectMiscValueB0Input),
          Expanded(child: effectRadiusIndex0Input),
          Expanded(child: effectChainAmplitude0Input),
          Expanded(child: effectBonusCoefficient0Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectItemType0Input),
          Expanded(child: effectTriggerSpell0Input),
          Expanded(child: effectChainTargets0Input),
          Expanded(child: effectPointsPerCombo0Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectSpellClassMaskA0Input),
          Expanded(child: effectSpellClassMaskB0Input),
          Expanded(child: effectSpellClassMaskC0Input),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    final effect1Rows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: effect1Input),
          Expanded(child: effectBasePoints1Input),
          Expanded(child: effectDieSides1Input),
          Expanded(child: effectRealPointsPerLevel1Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectMechanic1Input),
          Expanded(child: effectChainTargets1Input),
          Expanded(child: effectAura1Input),
          Expanded(child: effectAuraPeriod1Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectAmplitude1Input),
          Expanded(child: implicitTargetA1Input),
          Expanded(child: implicitTargetB1Input),
          Expanded(child: effectMiscValue1Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectMiscValueB1Input),
          Expanded(child: effectRadiusIndex1Input),
          Expanded(child: effectChainAmplitude1Input),
          Expanded(child: effectBonusCoefficient1Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectItemType1Input),
          Expanded(child: effectTriggerSpell1Input),
          Expanded(child: effectChainTargets1Input),
          Expanded(child: effectPointsPerCombo1Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectSpellClassMaskA1Input),
          Expanded(child: effectSpellClassMaskB1Input),
          Expanded(child: effectSpellClassMaskC1Input),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    final effect2Rows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: effect2Input),
          Expanded(child: effectBasePoints2Input),
          Expanded(child: effectDieSides2Input),
          Expanded(child: effectRealPointsPerLevel2Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectMechanic2Input),
          Expanded(child: effectChainTargets2Input),
          Expanded(child: effectAura2Input),
          Expanded(child: effectAuraPeriod2Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectAmplitude2Input),
          Expanded(child: implicitTargetA2Input),
          Expanded(child: implicitTargetB2Input),
          Expanded(child: effectMiscValue2Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectMiscValueB2Input),
          Expanded(child: effectRadiusIndex2Input),
          Expanded(child: effectChainAmplitude2Input),
          Expanded(child: effectBonusCoefficient2Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectItemType2Input),
          Expanded(child: effectTriggerSpell2Input),
          Expanded(child: effectChainTargets2Input),
          Expanded(child: effectPointsPerCombo2Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectSpellClassMaskA2Input),
          Expanded(child: effectSpellClassMaskB2Input),
          Expanded(child: effectSpellClassMaskC2Input),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    final equipRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: equippedItemClassInput),
          Expanded(child: equippedItemSubclassInput),
          Expanded(child: equippedItemInvTypesInput),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    final totemRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: requiredTotemCategoryID0Input),
          Expanded(child: totem0Input),
          Expanded(child: requiredTotemCategoryID1Input),
          Expanded(child: totem1Input),
        ],
      ),
    ];

    final reagentRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: reagent0Input),
          Expanded(child: reagentCount0Input),
          Expanded(child: reagent1Input),
          Expanded(child: reagentCount1Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: reagent2Input),
          Expanded(child: reagentCount2Input),
          Expanded(child: reagent3Input),
          Expanded(child: reagentCount3Input),
        ],
      ),
    ];

    final otherRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: casterAuraSpellInput),
          Expanded(child: cumulativeAuraInput),
          Expanded(child: minFactionIDInput),
          Expanded(child: minReputationInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: spellPriorityInput),
          Expanded(child: modalNextSpellInput),
          Expanded(child: requiredAuraVisionInput),
          Expanded(child: targetAuraSpellInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: stanceBarOrderInput),
          Expanded(child: shapeshiftMask0Input),
          Expanded(child: shapeshiftExclude0Input),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          section('基础文本', basicRows),
          section('图标视觉', visualRows),
          section('分类类型', categoryRows),
          section('施法参数', castingRows),
          section('冷却恢复', recoveryRows),
          section('目标', targetRows),
          section('状态', stateRows),
          section('需求', requiredRows),
          section('能量消耗', powerRows),
          section('标志位', attributeFlagRows),
          section('触发', procRows),
          section('法术分类掩码', spellClassRows),
          section('效果0', effect0Rows),
          section('效果1', effect1Rows),
          section('效果2', effect2Rows),
          section('装备限制', equipRows),
          section('图腾', totemRows),
          section('施法材料', reagentRows),
          section('其他高级属性', otherRows),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: Text('保存'),
              ),
              const SizedBox(width: 8),
              ShadButton.ghost(
                onPressed: () => viewModel.pop(),
                child: Text('取消'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget section(String title, List<Widget> rows) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 0,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(title),
      ),
      ShadCard(
        padding: EdgeInsets.all(16),
        child: Column(spacing: 8, children: rows),
      ),
    ],
  );
}
