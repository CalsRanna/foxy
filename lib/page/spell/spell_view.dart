import 'package:flutter/material.dart';
import 'package:foxy/page/spell/spell_detail_view_model.dart';
import 'package:foxy/page/spell/spell_icon_selector.dart';
import 'package:foxy/page/spell/spell_duration_selector.dart';
import 'package:foxy/page/spell/spell_range_selector.dart';
import 'package:foxy/page/area_table/area_table_selector.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/form_section.dart';
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
      label: '图标',
      child: SpellIconSelector(
        controller: vm.spellIconIDController,
        placeholder: 'SpellIconID',
      ),
    );
    final activeIconIDInput = FormItem(
      label: '激活图标',
      child: SpellIconSelector(
        controller: vm.activeIconIDController,
        placeholder: 'ActiveIconID',
      ),
    );
    final spellVisualID0Input = FormItem(
      label: '视觉效果1',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellVisualID0',
        controller: vm.spellVisualID0Controller,
      ),
    );
    final spellVisualID1Input = FormItem(
      label: '视觉效果2',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellVisualID1',
        controller: vm.spellVisualID1Controller,
      ),
    );

    // === 分类/类型 ===
    final categoryInput = FormItem(
      label: '分类',
      child: FoxyNumberInput<int>(
        placeholder: 'Category',
        controller: vm.categoryController,
      ),
    );
    final schoolMaskInput = FormItem(
      label: '法术类型掩码',
      child: FoxyNumberInput<int>(
        placeholder: 'SchoolMask',
        controller: vm.schoolMaskController,
      ),
    );
    final mechanicInput = FormItem(
      label: '机制',
      child: FoxyNumberInput<int>(
        placeholder: 'Mechanic',
        controller: vm.mechanicController,
      ),
    );
    final defenseTypeInput = FormItem(
      label: '防御类型',
      child: FoxyNumberInput<int>(
        placeholder: 'DefenseType',
        controller: vm.defenseTypeController,
      ),
    );
    final dispelTypeInput = FormItem(
      label: '驱散类型',
      child: FoxyNumberInput<int>(
        placeholder: 'DispelType',
        controller: vm.dispelTypeController,
      ),
    );
    final preventionTypeInput = FormItem(
      label: '防止类型',
      child: FoxyNumberInput<int>(
        placeholder: 'PreventionType',
        controller: vm.preventionTypeController,
      ),
    );

    // === 施法参数 ===
    final castingTimeIndexInput = FormItem(
      label: '施法时间',
      child: FoxyNumberInput<int>(
        placeholder: 'CastingTimeIndex',
        controller: vm.castingTimeIndexController,
      ),
    );
    final durationIndexInput = FormItem(
      label: '持续时间',
      child: SpellDurationSelector(
        controller: vm.durationIndexController,
        placeholder: 'DurationIndex',
      ),
    );
    final rangeIndexInput = FormItem(
      label: '施法范围',
      child: SpellRangeSelector(
        controller: vm.rangeIndexController,
        placeholder: 'RangeIndex',
      ),
    );
    final spellDescriptionVariableIDInput = FormItem(
      label: '描述变量',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellDescriptionVariableID',
        controller: vm.spellDescriptionVariableIDController,
      ),
    );

    // === 等级 ===
    final baseLevelInput = FormItem(
      label: '基础等级',
      child: FoxyNumberInput<int>(
        placeholder: 'BaseLevel',
        controller: vm.baseLevelController,
      ),
    );
    final spellLevelInput = FormItem(
      label: '法术等级',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellLevel',
        controller: vm.spellLevelController,
      ),
    );
    final maxLevelInput = FormItem(
      label: '最高等级',
      child: FoxyNumberInput<int>(
        placeholder: 'MaxLevel',
        controller: vm.maxLevelController,
      ),
    );
    final spellDifficultyIDInput = FormItem(
      label: '难度ID',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellDifficultyID',
        controller: vm.spellDifficultyIDController,
      ),
    );

    // === 冷却/恢复 ===
    final startRecoveryCategoryInput = FormItem(
      label: '冷却分类',
      child: FoxyNumberInput<int>(
        placeholder: 'StartRecoveryCategory',
        controller: vm.startRecoveryCategoryController,
      ),
    );
    final startRecoveryTimeInput = FormItem(
      label: '冷却开始时间',
      child: FoxyNumberInput<int>(
        placeholder: 'StartRecoveryTime',
        controller: vm.startRecoveryTimeController,
      ),
    );
    final recoveryTimeInput = FormItem(
      label: '冷却时间',
      child: FoxyNumberInput<int>(
        placeholder: 'RecoveryTime',
        controller: vm.recoveryTimeController,
      ),
    );
    final categoryRecoveryTimeInput = FormItem(
      label: '分类冷却时间',
      child: FoxyNumberInput<int>(
        placeholder: 'CategoryRecoveryTime',
        controller: vm.categoryRecoveryTimeController,
      ),
    );

    // === 目标 ===
    final targetCreatureTypeInput = FormItem(
      label: '目标生物类型',
      child: FoxyNumberInput<int>(
        placeholder: 'TargetCreatureType',
        controller: vm.targetCreatureTypeController,
      ),
    );
    final targetsInput = FormItem(
      label: '目标限制',
      child: FoxyNumberInput<int>(
        placeholder: 'Targets',
        controller: vm.targetsController,
      ),
    );
    final maxTargetsInput = FormItem(
      label: '最大目标数',
      child: FoxyNumberInput<int>(
        placeholder: 'MaxTargets',
        controller: vm.maxTargetsController,
      ),
    );
    final maxTargetLevelInput = FormItem(
      label: '最大目标等级',
      child: FoxyNumberInput<int>(
        placeholder: 'MaxTargetLevel',
        controller: vm.maxTargetLevelController,
      ),
    );

    // === 状态 ===
    final casterAuraStateInput = FormItem(
      label: '施法者状态',
      child: FoxyNumberInput<int>(
        placeholder: 'CasterAuraState',
        controller: vm.casterAuraStateController,
      ),
    );
    final targetAuraStateInput = FormItem(
      label: '目标状态',
      child: FoxyNumberInput<int>(
        placeholder: 'TargetAuraState',
        controller: vm.targetAuraStateController,
      ),
    );
    final spellMissileIDInput = FormItem(
      label: '弹道',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellMissileID',
        controller: vm.spellMissileIDController,
      ),
    );
    final speedInput = FormItem(
      label: '弹道速度',
      child: FoxyNumberInput<double>(
        placeholder: 'Speed',
        controller: vm.speedController,
      ),
    );

    // === 需求 ===
    final requiredAreasIDInput = FormItem(
      label: '需求区域',
      child: AreaTableSelector(
        controller: vm.requiredAreasIDController,
        placeholder: 'RequiredAreasID',
      ),
    );
    final requiresSpellFocusInput = FormItem(
      label: '需求法术焦点',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiresSpellFocus',
        controller: vm.requiresSpellFocusController,
      ),
    );
    final facingCasterFlagsInput = FormItem(
      label: '施法朝向',
      child: FoxyNumberInput<int>(
        placeholder: 'FacingCasterFlags',
        controller: vm.facingCasterFlagsController,
      ),
    );

    // === 能量消耗 ===
    final powerDisplayIDInput = FormItem(
      label: '能量显示',
      child: FoxyNumberInput<int>(
        placeholder: 'PowerDisplayID',
        controller: vm.powerDisplayIDController,
      ),
    );
    final powerTypeInput = FormItem(
      label: '能量类型',
      child: FoxyNumberInput<int>(
        placeholder: 'PowerType',
        controller: vm.powerTypeController,
      ),
    );
    final runeCostIDInput = FormItem(
      label: '符文消耗',
      child: FoxyNumberInput<int>(
        placeholder: 'RuneCostID',
        controller: vm.runeCostIDController,
      ),
    );
    final manaCostInput = FormItem(
      label: '法力消耗',
      child: FoxyNumberInput<int>(
        placeholder: 'ManaCost',
        controller: vm.manaCostController,
      ),
    );
    final manaCostPctInput = FormItem(
      label: '法力消耗百分比',
      child: FoxyNumberInput<int>(
        placeholder: 'ManaCostPct',
        controller: vm.manaCostPctController,
      ),
    );
    final manaCostPerLevelInput = FormItem(
      label: '每级法力消耗',
      child: FoxyNumberInput<int>(
        placeholder: 'ManaCostPerLevel',
        controller: vm.manaCostPerLevelController,
      ),
    );
    final manaPerSecondInput = FormItem(
      label: '每秒法力',
      child: FoxyNumberInput<int>(
        placeholder: 'ManaPerSecond',
        controller: vm.manaPerSecondController,
      ),
    );
    final manaPerSecondPerLevelInput = FormItem(
      label: '每秒每级法力',
      child: FoxyNumberInput<int>(
        placeholder: 'ManaPerSecondPerLevel',
        controller: vm.manaPerSecondPerLevelController,
      ),
    );

    // === 标志位（所有属性标志） ===
    final interruptFlagsInput = FormItem(
      label: '打断标志',
      child: FoxyNumberInput<int>(
        placeholder: 'InterruptFlags',
        controller: vm.interruptFlagsController,
      ),
    );
    final auraInterruptFlagsInput = FormItem(
      label: '光环打断标志',
      child: FoxyNumberInput<int>(
        placeholder: 'AuraInterruptFlags',
        controller: vm.auraInterruptFlagsController,
      ),
    );
    final channelInterruptFlagsInput = FormItem(
      label: '引导打断标志',
      child: FoxyNumberInput<int>(
        placeholder: 'ChannelInterruptFlags',
        controller: vm.channelInterruptFlagsController,
      ),
    );
    final attributesInput = FormItem(
      label: '属性',
      child: FoxyNumberInput<int>(
        placeholder: 'Attributes',
        controller: vm.attributesController,
      ),
    );
    final attributesExInput = FormItem(
      label: '属性Ex',
      child: FoxyNumberInput<int>(
        placeholder: 'AttributesEx',
        controller: vm.attributesExController,
      ),
    );
    final attributesExBInput = FormItem(
      label: '属性ExB',
      child: FoxyNumberInput<int>(
        placeholder: 'AttributesExB',
        controller: vm.attributesExBController,
      ),
    );
    final attributesExCInput = FormItem(
      label: '属性ExC',
      child: FoxyNumberInput<int>(
        placeholder: 'AttributesExC',
        controller: vm.attributesExCController,
      ),
    );
    final attributesExDInput = FormItem(
      label: '属性ExD',
      child: FoxyNumberInput<int>(
        placeholder: 'AttributesExD',
        controller: vm.attributesExDController,
      ),
    );
    final attributesExEInput = FormItem(
      label: '属性ExE',
      child: FoxyNumberInput<int>(
        placeholder: 'AttributesExE',
        controller: vm.attributesExEController,
      ),
    );
    final attributesExFInput = FormItem(
      label: '属性ExF',
      child: FoxyNumberInput<int>(
        placeholder: 'AttributesExF',
        controller: vm.attributesExFController,
      ),
    );
    final attributesExGInput = FormItem(
      label: '属性ExG',
      child: FoxyNumberInput<int>(
        placeholder: 'AttributesExG',
        controller: vm.attributesExGController,
      ),
    );

    // === 触发 ===
    final procTypeMaskInput = FormItem(
      label: '触发类型掩码',
      child: FoxyNumberInput<int>(
        placeholder: 'ProcTypeMask',
        controller: vm.procTypeMaskController,
      ),
    );
    final procChanceInput = FormItem(
      label: '触发几率',
      child: FoxyNumberInput<int>(
        placeholder: 'ProcChance',
        controller: vm.procChanceController,
      ),
    );
    final procChargesInput = FormItem(
      label: '触发次数',
      child: FoxyNumberInput<int>(
        placeholder: 'ProcCharges',
        controller: vm.procChargesController,
      ),
    );

    // === 法术分类掩码 ===
    final spellClassSetInput = FormItem(
      label: '法术分类集',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellClassSet',
        controller: vm.spellClassSetController,
      ),
    );
    final spellClassMask0Input = FormItem(
      label: '分类掩码1',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellClassMask0',
        controller: vm.spellClassMask0Controller,
      ),
    );
    final spellClassMask1Input = FormItem(
      label: '分类掩码2',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellClassMask1',
        controller: vm.spellClassMask1Controller,
      ),
    );
    final spellClassMask2Input = FormItem(
      label: '分类掩码3',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellClassMask2',
        controller: vm.spellClassMask2Controller,
      ),
    );

    // === 效果0 ===
    final effect0Input = FormItem(
      label: '效果0类型',
      child: FoxyNumberInput<int>(
        placeholder: 'Effect0',
        controller: vm.effect0Controller,
      ),
    );
    final effectBasePoints0Input = FormItem(
      label: '效果0基础值',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectBasePoints0',
        controller: vm.effectBasePoints0Controller,
      ),
    );
    final effectDieSides0Input = FormItem(
      label: '效果0波动值',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectDieSides0',
        controller: vm.effectDieSides0Controller,
      ),
    );
    final effectRealPointsPerLevel0Input = FormItem(
      label: '效果0每级加成',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectRealPointsPerLevel0',
        controller: vm.effectRealPointsPerLevel0Controller,
      ),
    );
    final effectMechanic0Input = FormItem(
      label: '效果0机制',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectMechanic0',
        controller: vm.effectMechanic0Controller,
      ),
    );
    final effectAura0Input = FormItem(
      label: '效果0光环',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectAura0',
        controller: vm.effectAura0Controller,
      ),
    );
    final effectAuraPeriod0Input = FormItem(
      label: '效果0光环周期',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectAuraPeriod0',
        controller: vm.effectAuraPeriod0Controller,
      ),
    );
    final effectAmplitude0Input = FormItem(
      label: '效果0振幅',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectAmplitude0',
        controller: vm.effectAmplitude0Controller,
      ),
    );
    final implicitTargetA0Input = FormItem(
      label: '效果0目标A',
      child: FoxyNumberInput<int>(
        placeholder: 'ImplicitTargetA0',
        controller: vm.implicitTargetA0Controller,
      ),
    );
    final implicitTargetB0Input = FormItem(
      label: '效果0目标B',
      child: FoxyNumberInput<int>(
        placeholder: 'ImplicitTargetB0',
        controller: vm.implicitTargetB0Controller,
      ),
    );
    final effectMiscValue0Input = FormItem(
      label: '效果0杂项值',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectMiscValue0',
        controller: vm.effectMiscValue0Controller,
      ),
    );
    final effectMiscValueB0Input = FormItem(
      label: '效果0杂项值B',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectMiscValueB0',
        controller: vm.effectMiscValueB0Controller,
      ),
    );
    final effectRadiusIndex0Input = FormItem(
      label: '效果0半径',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectRadiusIndex0',
        controller: vm.effectRadiusIndex0Controller,
      ),
    );
    final effectChainAmplitude0Input = FormItem(
      label: '效果0连锁振幅',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectChainAmplitude0',
        controller: vm.effectChainAmplitude0Controller,
      ),
    );
    final effectBonusCoefficient0Input = FormItem(
      label: '效果0加成系数',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectBonusCoefficient0',
        controller: vm.effectBonusCoefficient0Controller,
      ),
    );
    final effectItemType0Input = FormItem(
      label: '效果0物品类型',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectItemType0',
        controller: vm.effectItemType0Controller,
      ),
    );
    final effectTriggerSpell0Input = FormItem(
      label: '效果0触发法术',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectTriggerSpell0',
        controller: vm.effectTriggerSpell0Controller,
      ),
    );
    final effectChainTargets0Input = FormItem(
      label: '效果0连锁目标',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectChainTargets0',
        controller: vm.effectChainTargets0Controller,
      ),
    );
    final effectPointsPerCombo0Input = FormItem(
      label: '效果0连击点数',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectPointsPerCombo0',
        controller: vm.effectPointsPerCombo0Controller,
      ),
    );
    final effectSpellClassMaskA0Input = FormItem(
      label: '效果0分类掩码A',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectSpellClassMaskA0',
        controller: vm.effectSpellClassMaskA0Controller,
      ),
    );
    final effectSpellClassMaskB0Input = FormItem(
      label: '效果0分类掩码B',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectSpellClassMaskB0',
        controller: vm.effectSpellClassMaskB0Controller,
      ),
    );
    final effectSpellClassMaskC0Input = FormItem(
      label: '效果0分类掩码C',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectSpellClassMaskC0',
        controller: vm.effectSpellClassMaskC0Controller,
      ),
    );

    // === 效果1 ===
    final effect1Input = FormItem(
      label: '效果1类型',
      child: FoxyNumberInput<int>(
        placeholder: 'Effect1',
        controller: vm.effect1Controller,
      ),
    );
    final effectBasePoints1Input = FormItem(
      label: '效果1基础值',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectBasePoints1',
        controller: vm.effectBasePoints1Controller,
      ),
    );
    final effectDieSides1Input = FormItem(
      label: '效果1波动值',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectDieSides1',
        controller: vm.effectDieSides1Controller,
      ),
    );
    final effectRealPointsPerLevel1Input = FormItem(
      label: '效果1每级加成',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectRealPointsPerLevel1',
        controller: vm.effectRealPointsPerLevel1Controller,
      ),
    );
    final effectMechanic1Input = FormItem(
      label: '效果1机制',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectMechanic1',
        controller: vm.effectMechanic1Controller,
      ),
    );
    final effectAura1Input = FormItem(
      label: '效果1光环',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectAura1',
        controller: vm.effectAura1Controller,
      ),
    );
    final effectAuraPeriod1Input = FormItem(
      label: '效果1光环周期',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectAuraPeriod1',
        controller: vm.effectAuraPeriod1Controller,
      ),
    );
    final effectAmplitude1Input = FormItem(
      label: '效果1振幅',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectAmplitude1',
        controller: vm.effectAmplitude1Controller,
      ),
    );
    final implicitTargetA1Input = FormItem(
      label: '效果1目标A',
      child: FoxyNumberInput<int>(
        placeholder: 'ImplicitTargetA1',
        controller: vm.implicitTargetA1Controller,
      ),
    );
    final implicitTargetB1Input = FormItem(
      label: '效果1目标B',
      child: FoxyNumberInput<int>(
        placeholder: 'ImplicitTargetB1',
        controller: vm.implicitTargetB1Controller,
      ),
    );
    final effectMiscValue1Input = FormItem(
      label: '效果1杂项值',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectMiscValue1',
        controller: vm.effectMiscValue1Controller,
      ),
    );
    final effectMiscValueB1Input = FormItem(
      label: '效果1杂项值B',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectMiscValueB1',
        controller: vm.effectMiscValueB1Controller,
      ),
    );
    final effectRadiusIndex1Input = FormItem(
      label: '效果1半径',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectRadiusIndex1',
        controller: vm.effectRadiusIndex1Controller,
      ),
    );
    final effectChainAmplitude1Input = FormItem(
      label: '效果1连锁振幅',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectChainAmplitude1',
        controller: vm.effectChainAmplitude1Controller,
      ),
    );
    final effectBonusCoefficient1Input = FormItem(
      label: '效果1加成系数',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectBonusCoefficient1',
        controller: vm.effectBonusCoefficient1Controller,
      ),
    );
    final effectItemType1Input = FormItem(
      label: '效果1物品类型',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectItemType1',
        controller: vm.effectItemType1Controller,
      ),
    );
    final effectTriggerSpell1Input = FormItem(
      label: '效果1触发法术',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectTriggerSpell1',
        controller: vm.effectTriggerSpell1Controller,
      ),
    );
    final effectChainTargets1Input = FormItem(
      label: '效果1连锁目标',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectChainTargets1',
        controller: vm.effectChainTargets1Controller,
      ),
    );
    final effectPointsPerCombo1Input = FormItem(
      label: '效果1连击点数',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectPointsPerCombo1',
        controller: vm.effectPointsPerCombo1Controller,
      ),
    );
    final effectSpellClassMaskA1Input = FormItem(
      label: '效果1分类掩码A',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectSpellClassMaskA1',
        controller: vm.effectSpellClassMaskA1Controller,
      ),
    );
    final effectSpellClassMaskB1Input = FormItem(
      label: '效果1分类掩码B',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectSpellClassMaskB1',
        controller: vm.effectSpellClassMaskB1Controller,
      ),
    );
    final effectSpellClassMaskC1Input = FormItem(
      label: '效果1分类掩码C',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectSpellClassMaskC1',
        controller: vm.effectSpellClassMaskC1Controller,
      ),
    );

    // === 效果2 ===
    final effect2Input = FormItem(
      label: '效果2类型',
      child: FoxyNumberInput<int>(
        placeholder: 'Effect2',
        controller: vm.effect2Controller,
      ),
    );
    final effectBasePoints2Input = FormItem(
      label: '效果2基础值',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectBasePoints2',
        controller: vm.effectBasePoints2Controller,
      ),
    );
    final effectDieSides2Input = FormItem(
      label: '效果2波动值',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectDieSides2',
        controller: vm.effectDieSides2Controller,
      ),
    );
    final effectRealPointsPerLevel2Input = FormItem(
      label: '效果2每级加成',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectRealPointsPerLevel2',
        controller: vm.effectRealPointsPerLevel2Controller,
      ),
    );
    final effectMechanic2Input = FormItem(
      label: '效果2机制',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectMechanic2',
        controller: vm.effectMechanic2Controller,
      ),
    );
    final effectAura2Input = FormItem(
      label: '效果2光环',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectAura2',
        controller: vm.effectAura2Controller,
      ),
    );
    final effectAuraPeriod2Input = FormItem(
      label: '效果2光环周期',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectAuraPeriod2',
        controller: vm.effectAuraPeriod2Controller,
      ),
    );
    final effectAmplitude2Input = FormItem(
      label: '效果2振幅',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectAmplitude2',
        controller: vm.effectAmplitude2Controller,
      ),
    );
    final implicitTargetA2Input = FormItem(
      label: '效果2目标A',
      child: FoxyNumberInput<int>(
        placeholder: 'ImplicitTargetA2',
        controller: vm.implicitTargetA2Controller,
      ),
    );
    final implicitTargetB2Input = FormItem(
      label: '效果2目标B',
      child: FoxyNumberInput<int>(
        placeholder: 'ImplicitTargetB2',
        controller: vm.implicitTargetB2Controller,
      ),
    );
    final effectMiscValue2Input = FormItem(
      label: '效果2杂项值',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectMiscValue2',
        controller: vm.effectMiscValue2Controller,
      ),
    );
    final effectMiscValueB2Input = FormItem(
      label: '效果2杂项值B',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectMiscValueB2',
        controller: vm.effectMiscValueB2Controller,
      ),
    );
    final effectRadiusIndex2Input = FormItem(
      label: '效果2半径',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectRadiusIndex2',
        controller: vm.effectRadiusIndex2Controller,
      ),
    );
    final effectChainAmplitude2Input = FormItem(
      label: '效果2连锁振幅',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectChainAmplitude2',
        controller: vm.effectChainAmplitude2Controller,
      ),
    );
    final effectBonusCoefficient2Input = FormItem(
      label: '效果2加成系数',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectBonusCoefficient2',
        controller: vm.effectBonusCoefficient2Controller,
      ),
    );
    final effectItemType2Input = FormItem(
      label: '效果2物品类型',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectItemType2',
        controller: vm.effectItemType2Controller,
      ),
    );
    final effectTriggerSpell2Input = FormItem(
      label: '效果2触发法术',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectTriggerSpell2',
        controller: vm.effectTriggerSpell2Controller,
      ),
    );
    final effectChainTargets2Input = FormItem(
      label: '效果2连锁目标',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectChainTargets2',
        controller: vm.effectChainTargets2Controller,
      ),
    );
    final effectPointsPerCombo2Input = FormItem(
      label: '效果2连击点数',
      child: FoxyNumberInput<double>(
        placeholder: 'EffectPointsPerCombo2',
        controller: vm.effectPointsPerCombo2Controller,
      ),
    );
    final effectSpellClassMaskA2Input = FormItem(
      label: '效果2分类掩码A',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectSpellClassMaskA2',
        controller: vm.effectSpellClassMaskA2Controller,
      ),
    );
    final effectSpellClassMaskB2Input = FormItem(
      label: '效果2分类掩码B',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectSpellClassMaskB2',
        controller: vm.effectSpellClassMaskB2Controller,
      ),
    );
    final effectSpellClassMaskC2Input = FormItem(
      label: '效果2分类掩码C',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectSpellClassMaskC2',
        controller: vm.effectSpellClassMaskC2Controller,
      ),
    );

    // === 装备限制 ===
    final equippedItemClassInput = FormItem(
      label: '装备职业',
      child: FoxyNumberInput<int>(
        placeholder: 'EquippedItemClass',
        controller: vm.equippedItemClassController,
      ),
    );
    final equippedItemSubclassInput = FormItem(
      label: '装备子类',
      child: FoxyNumberInput<int>(
        placeholder: 'EquippedItemSubclass',
        controller: vm.equippedItemSubclassController,
      ),
    );
    final equippedItemInvTypesInput = FormItem(
      label: '装备栏位',
      child: FoxyNumberInput<int>(
        placeholder: 'EquippedItemInvTypes',
        controller: vm.equippedItemInvTypesController,
      ),
    );

    // === 图腾/施法材料 ===
    final requiredTotemCategoryID0Input = FormItem(
      label: '图腾1类型',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredTotemCategoryID0',
        controller: vm.requiredTotemCategoryID0Controller,
      ),
    );
    final totem0Input = FormItem(
      label: '图腾1',
      child: FoxyNumberInput<int>(
        placeholder: 'Totem0',
        controller: vm.totem0Controller,
      ),
    );
    final requiredTotemCategoryID1Input = FormItem(
      label: '图腾2类型',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredTotemCategoryID1',
        controller: vm.requiredTotemCategoryID1Controller,
      ),
    );
    final totem1Input = FormItem(
      label: '图腾2',
      child: FoxyNumberInput<int>(
        placeholder: 'Totem1',
        controller: vm.totem1Controller,
      ),
    );
    final reagent0Input = FormItem(
      label: '施法材料1',
      child: FoxyNumberInput<int>(
        placeholder: 'Reagent0',
        controller: vm.reagent0Controller,
      ),
    );
    final reagentCount0Input = FormItem(
      label: '材料1数量',
      child: FoxyNumberInput<int>(
        placeholder: 'ReagentCount0',
        controller: vm.reagentCount0Controller,
      ),
    );
    final reagent1Input = FormItem(
      label: '施法材料2',
      child: FoxyNumberInput<int>(
        placeholder: 'Reagent1',
        controller: vm.reagent1Controller,
      ),
    );
    final reagentCount1Input = FormItem(
      label: '材料2数量',
      child: FoxyNumberInput<int>(
        placeholder: 'ReagentCount1',
        controller: vm.reagentCount1Controller,
      ),
    );
    final reagent2Input = FormItem(
      label: '施法材料3',
      child: FoxyNumberInput<int>(
        placeholder: 'Reagent2',
        controller: vm.reagent2Controller,
      ),
    );
    final reagentCount2Input = FormItem(
      label: '材料3数量',
      child: FoxyNumberInput<int>(
        placeholder: 'ReagentCount2',
        controller: vm.reagentCount2Controller,
      ),
    );
    final reagent3Input = FormItem(
      label: '施法材料4',
      child: FoxyNumberInput<int>(
        placeholder: 'Reagent3',
        controller: vm.reagent3Controller,
      ),
    );
    final reagentCount3Input = FormItem(
      label: '材料4数量',
      child: FoxyNumberInput<int>(
        placeholder: 'ReagentCount3',
        controller: vm.reagentCount3Controller,
      ),
    );

    // === 其他高级属性 ===
    final casterAuraSpellInput = FormItem(
      label: '施法者光环法术',
      child: FoxyNumberInput<int>(
        placeholder: 'CasterAuraSpell',
        controller: vm.casterAuraSpellController,
      ),
    );
    final cumulativeAuraInput = FormItem(
      label: '累积光环',
      child: FoxyNumberInput<int>(
        placeholder: 'CumulativeAura',
        controller: vm.cumulativeAuraController,
      ),
    );
    final minFactionIDInput = FormItem(
      label: '最低声望阵营',
      child: FoxyNumberInput<int>(
        placeholder: 'MinFactionID',
        controller: vm.minFactionIDController,
      ),
    );
    final minReputationInput = FormItem(
      label: '最低声望等级',
      child: FoxyNumberInput<int>(
        placeholder: 'MinReputation',
        controller: vm.minReputationController,
      ),
    );
    final spellPriorityInput = FormItem(
      label: '法术优先级',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellPriority',
        controller: vm.spellPriorityController,
      ),
    );
    final modalNextSpellInput = FormItem(
      label: '下个模态法术',
      child: FoxyNumberInput<int>(
        placeholder: 'ModalNextSpell',
        controller: vm.modalNextSpellController,
      ),
    );
    final requiredAuraVisionInput = FormItem(
      label: '需求光环视野',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredAuraVision',
        controller: vm.requiredAuraVisionController,
      ),
    );
    final targetAuraSpellInput = FormItem(
      label: '目标光环法术',
      child: FoxyNumberInput<int>(
        placeholder: 'TargetAuraSpell',
        controller: vm.targetAuraSpellController,
      ),
    );
    final stanceBarOrderInput = FormItem(
      label: '姿态栏顺序',
      child: FoxyNumberInput<int>(
        placeholder: 'StanceBarOrder',
        controller: vm.stanceBarOrderController,
      ),
    );
    final shapeshiftMask0Input = FormItem(
      label: '变形掩码',
      child: FoxyNumberInput<int>(
        placeholder: 'ShapeshiftMask0',
        controller: vm.shapeshiftMask0Controller,
      ),
    );
    final shapeshiftExclude0Input = FormItem(
      label: '变形排除',
      child: FoxyNumberInput<int>(
        placeholder: 'ShapeshiftExclude0',
        controller: vm.shapeshiftExclude0Controller,
      ),
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
          Expanded(child: spellDescriptionVariableIDInput),
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
          FormSection(title: '基础文本', children: basicRows),
          FormSection(title: '图标视觉', children: visualRows),
          FormSection(title: '分类类型', children: categoryRows),
          FormSection(title: '施法参数', children: castingRows),
          FormSection(title: '冷却恢复', children: recoveryRows),
          FormSection(title: '目标', children: targetRows),
          FormSection(title: '状态', children: stateRows),
          FormSection(title: '需求', children: requiredRows),
          FormSection(title: '能量消耗', children: powerRows),
          FormSection(title: '标志位', children: attributeFlagRows),
          FormSection(title: '触发', children: procRows),
          FormSection(title: '法术分类掩码', children: spellClassRows),
          FormSection(title: '效果0', children: effect0Rows),
          FormSection(title: '效果1', children: effect1Rows),
          FormSection(title: '效果2', children: effect2Rows),
          FormSection(title: '装备限制', children: equipRows),
          FormSection(title: '图腾', children: totemRows),
          FormSection(title: '施法材料', children: reagentRows),
          FormSection(title: '其他高级属性', children: otherRows),
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
