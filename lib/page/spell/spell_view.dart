import 'package:flutter/material.dart';
import 'package:foxy/page/spell/spell_detail_view_model.dart';
import 'package:foxy/page/spell/spell_icon_selector.dart';
import 'package:foxy/page/spell/spell_duration_selector.dart';
import 'package:foxy/page/spell/spell_range_selector.dart';
import 'package:foxy/page/area_table/area_table_selector.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
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
        signal: vm.spellIconID,
        placeholder: 'SpellIconID',
      ),
    );
    final activeIconIDInput = FormItem(
      label: '激活图标',
      child: SpellIconSelector(
        signal: vm.activeIconID,
        placeholder: 'ActiveIconID',
      ),
    );
    final spellVisualID0Input = FormItem(
      label: '视觉效果1',
      placeholder: 'SpellVisualID0',
      child: FoxyNumberInput<int>(
        value: vm.spellVisualID0.value,
        onChanged: (v) => vm.spellVisualID0.value = v,
      ),
    );
    final spellVisualID1Input = FormItem(
      label: '视觉效果2',
      placeholder: 'SpellVisualID1',
      child: FoxyNumberInput<int>(
        value: vm.spellVisualID1.value,
        onChanged: (v) => vm.spellVisualID1.value = v,
      ),
    );

    // === 分类/类型 ===
    final categoryInput = FormItem(
      label: '分类',
      placeholder: 'Category',
      child: FoxyNumberInput<int>(
        value: vm.category.value,
        onChanged: (v) => vm.category.value = v,
      ),
    );
    final schoolMaskInput = FormItem(
      label: '法术类型掩码',
      placeholder: 'SchoolMask',
      child: FoxyNumberInput<int>(
        value: vm.schoolMask.value,
        onChanged: (v) => vm.schoolMask.value = v,
      ),
    );
    final mechanicInput = FormItem(
      label: '机制',
      placeholder: 'Mechanic',
      child: FoxyNumberInput<int>(
        value: vm.mechanic.value,
        onChanged: (v) => vm.mechanic.value = v,
      ),
    );
    final defenseTypeInput = FormItem(
      label: '防御类型',
      placeholder: 'DefenseType',
      child: FoxyNumberInput<int>(
        value: vm.defenseType.value,
        onChanged: (v) => vm.defenseType.value = v,
      ),
    );
    final dispelTypeInput = FormItem(
      label: '驱散类型',
      placeholder: 'DispelType',
      child: FoxyNumberInput<int>(
        value: vm.dispelType.value,
        onChanged: (v) => vm.dispelType.value = v,
      ),
    );
    final preventionTypeInput = FormItem(
      label: '防止类型',
      placeholder: 'PreventionType',
      child: FoxyNumberInput<int>(
        value: vm.preventionType.value,
        onChanged: (v) => vm.preventionType.value = v,
      ),
    );

    // === 施法参数 ===
    final castingTimeIndexInput = FormItem(
      label: '施法时间',
      placeholder: 'CastingTimeIndex',
      child: FoxyNumberInput<int>(
        value: vm.castingTimeIndex.value,
        onChanged: (v) => vm.castingTimeIndex.value = v,
      ),
    );
    final durationIndexInput = FormItem(
      label: '持续时间',
      child: SpellDurationSelector(
        signal: vm.durationIndex,
        placeholder: 'DurationIndex',
      ),
    );
    final rangeIndexInput = FormItem(
      label: '施法范围',
      child: SpellRangeSelector(
        signal: vm.rangeIndex,
        placeholder: 'RangeIndex',
      ),
    );
    final spellDescriptionVariableIDInput = FormItem(
      label: '描述变量',
      placeholder: 'SpellDescriptionVariableID',
      child: FoxyNumberInput<int>(
        value: vm.spellDescriptionVariableID.value,
        onChanged: (v) => vm.spellDescriptionVariableID.value = v,
      ),
    );

    // === 等级 ===
    final baseLevelInput = FormItem(
      label: '基础等级',
      placeholder: 'BaseLevel',
      child: FoxyNumberInput<int>(
        value: vm.baseLevel.value,
        onChanged: (v) => vm.baseLevel.value = v,
      ),
    );
    final spellLevelInput = FormItem(
      label: '法术等级',
      placeholder: 'SpellLevel',
      child: FoxyNumberInput<int>(
        value: vm.spellLevel.value,
        onChanged: (v) => vm.spellLevel.value = v,
      ),
    );
    final maxLevelInput = FormItem(
      label: '最高等级',
      placeholder: 'MaxLevel',
      child: FoxyNumberInput<int>(
        value: vm.maxLevel.value,
        onChanged: (v) => vm.maxLevel.value = v,
      ),
    );
    final spellDifficultyIDInput = FormItem(
      label: '难度ID',
      placeholder: 'SpellDifficultyID',
      child: FoxyNumberInput<int>(
        value: vm.spellDifficultyID.value,
        onChanged: (v) => vm.spellDifficultyID.value = v,
      ),
    );

    // === 冷却/恢复 ===
    final startRecoveryCategoryInput = FormItem(
      label: '冷却分类',
      placeholder: 'StartRecoveryCategory',
      child: FoxyNumberInput<int>(
        value: vm.startRecoveryCategory.value,
        onChanged: (v) => vm.startRecoveryCategory.value = v,
      ),
    );
    final startRecoveryTimeInput = FormItem(
      label: '冷却开始时间',
      placeholder: 'StartRecoveryTime',
      child: FoxyNumberInput<int>(
        value: vm.startRecoveryTime.value,
        onChanged: (v) => vm.startRecoveryTime.value = v,
      ),
    );
    final recoveryTimeInput = FormItem(
      label: '冷却时间',
      placeholder: 'RecoveryTime',
      child: FoxyNumberInput<int>(
        value: vm.recoveryTime.value,
        onChanged: (v) => vm.recoveryTime.value = v,
      ),
    );
    final categoryRecoveryTimeInput = FormItem(
      label: '分类冷却时间',
      placeholder: 'CategoryRecoveryTime',
      child: FoxyNumberInput<int>(
        value: vm.categoryRecoveryTime.value,
        onChanged: (v) => vm.categoryRecoveryTime.value = v,
      ),
    );

    // === 目标 ===
    final targetCreatureTypeInput = FormItem(
      label: '目标生物类型',
      placeholder: 'TargetCreatureType',
      child: FoxyNumberInput<int>(
        value: vm.targetCreatureType.value,
        onChanged: (v) => vm.targetCreatureType.value = v,
      ),
    );
    final targetsInput = FormItem(
      label: '目标限制',
      placeholder: 'Targets',
      child: FoxyNumberInput<int>(
        value: vm.targets.value,
        onChanged: (v) => vm.targets.value = v,
      ),
    );
    final maxTargetsInput = FormItem(
      label: '最大目标数',
      placeholder: 'MaxTargets',
      child: FoxyNumberInput<int>(
        value: vm.maxTargets.value,
        onChanged: (v) => vm.maxTargets.value = v,
      ),
    );
    final maxTargetLevelInput = FormItem(
      label: '最大目标等级',
      placeholder: 'MaxTargetLevel',
      child: FoxyNumberInput<int>(
        value: vm.maxTargetLevel.value,
        onChanged: (v) => vm.maxTargetLevel.value = v,
      ),
    );

    // === 状态 ===
    final casterAuraStateInput = FormItem(
      label: '施法者状态',
      placeholder: 'CasterAuraState',
      child: FoxyNumberInput<int>(
        value: vm.casterAuraState.value,
        onChanged: (v) => vm.casterAuraState.value = v,
      ),
    );
    final targetAuraStateInput = FormItem(
      label: '目标状态',
      placeholder: 'TargetAuraState',
      child: FoxyNumberInput<int>(
        value: vm.targetAuraState.value,
        onChanged: (v) => vm.targetAuraState.value = v,
      ),
    );
    final spellMissileIDInput = FormItem(
      label: '弹道',
      placeholder: 'SpellMissileID',
      child: FoxyNumberInput<int>(
        value: vm.spellMissileID.value,
        onChanged: (v) => vm.spellMissileID.value = v,
      ),
    );
    final speedInput = FormItem(
      label: '弹道速度',
      placeholder: 'Speed',
      child: FoxyNumberInput<double>(
        value: vm.speed.value,
        onChanged: (v) => vm.speed.value = v,
      ),
    );

    // === 需求 ===
    final requiredAreasIDInput = FormItem(
      label: '需求区域',
      child: AreaTableSelector(
        signal: vm.requiredAreasID,
        placeholder: 'RequiredAreasID',
      ),
    );
    final requiresSpellFocusInput = FormItem(
      label: '需求法术焦点',
      placeholder: 'RequiresSpellFocus',
      child: FoxyNumberInput<int>(
        value: vm.requiresSpellFocus.value,
        onChanged: (v) => vm.requiresSpellFocus.value = v,
      ),
    );
    final facingCasterFlagsInput = FormItem(
      label: '施法朝向',
      placeholder: 'FacingCasterFlags',
      child: FoxyNumberInput<int>(
        value: vm.facingCasterFlags.value,
        onChanged: (v) => vm.facingCasterFlags.value = v,
      ),
    );

    // === 能量消耗 ===
    final powerDisplayIDInput = FormItem(
      label: '能量显示',
      placeholder: 'PowerDisplayID',
      child: FoxyNumberInput<int>(
        value: vm.powerDisplayID.value,
        onChanged: (v) => vm.powerDisplayID.value = v,
      ),
    );
    final powerTypeInput = FormItem(
      label: '能量类型',
      placeholder: 'PowerType',
      child: FoxyNumberInput<int>(
        value: vm.powerType.value,
        onChanged: (v) => vm.powerType.value = v,
      ),
    );
    final runeCostIDInput = FormItem(
      label: '符文消耗',
      placeholder: 'RuneCostID',
      child: FoxyNumberInput<int>(
        value: vm.runeCostID.value,
        onChanged: (v) => vm.runeCostID.value = v,
      ),
    );
    final manaCostInput = FormItem(
      label: '法力消耗',
      placeholder: 'ManaCost',
      child: FoxyNumberInput<int>(
        value: vm.manaCost.value,
        onChanged: (v) => vm.manaCost.value = v,
      ),
    );
    final manaCostPctInput = FormItem(
      label: '法力消耗百分比',
      placeholder: 'ManaCostPct',
      child: FoxyNumberInput<int>(
        value: vm.manaCostPct.value,
        onChanged: (v) => vm.manaCostPct.value = v,
      ),
    );
    final manaCostPerLevelInput = FormItem(
      label: '每级法力消耗',
      placeholder: 'ManaCostPerLevel',
      child: FoxyNumberInput<int>(
        value: vm.manaCostPerLevel.value,
        onChanged: (v) => vm.manaCostPerLevel.value = v,
      ),
    );
    final manaPerSecondInput = FormItem(
      label: '每秒法力',
      placeholder: 'ManaPerSecond',
      child: FoxyNumberInput<int>(
        value: vm.manaPerSecond.value,
        onChanged: (v) => vm.manaPerSecond.value = v,
      ),
    );
    final manaPerSecondPerLevelInput = FormItem(
      label: '每秒每级法力',
      placeholder: 'ManaPerSecondPerLevel',
      child: FoxyNumberInput<int>(
        value: vm.manaPerSecondPerLevel.value,
        onChanged: (v) => vm.manaPerSecondPerLevel.value = v,
      ),
    );

    // === 标志位（所有属性标志） ===
    final interruptFlagsInput = FormItem(
      label: '打断标志',
      placeholder: 'InterruptFlags',
      child: FoxyNumberInput<int>(
        value: vm.interruptFlags.value,
        onChanged: (v) => vm.interruptFlags.value = v,
      ),
    );
    final auraInterruptFlagsInput = FormItem(
      label: '光环打断标志',
      placeholder: 'AuraInterruptFlags',
      child: FoxyNumberInput<int>(
        value: vm.auraInterruptFlags.value,
        onChanged: (v) => vm.auraInterruptFlags.value = v,
      ),
    );
    final channelInterruptFlagsInput = FormItem(
      label: '引导打断标志',
      placeholder: 'ChannelInterruptFlags',
      child: FoxyNumberInput<int>(
        value: vm.channelInterruptFlags.value,
        onChanged: (v) => vm.channelInterruptFlags.value = v,
      ),
    );
    final attributesInput = FormItem(
      label: '属性',
      placeholder: 'Attributes',
      child: FoxyNumberInput<int>(
        value: vm.attributes.value,
        onChanged: (v) => vm.attributes.value = v,
      ),
    );
    final attributesExInput = FormItem(
      label: '属性Ex',
      placeholder: 'AttributesEx',
      child: FoxyNumberInput<int>(
        value: vm.attributesEx.value,
        onChanged: (v) => vm.attributesEx.value = v,
      ),
    );
    final attributesExBInput = FormItem(
      label: '属性ExB',
      placeholder: 'AttributesExB',
      child: FoxyNumberInput<int>(
        value: vm.attributesExB.value,
        onChanged: (v) => vm.attributesExB.value = v,
      ),
    );
    final attributesExCInput = FormItem(
      label: '属性ExC',
      placeholder: 'AttributesExC',
      child: FoxyNumberInput<int>(
        value: vm.attributesExC.value,
        onChanged: (v) => vm.attributesExC.value = v,
      ),
    );
    final attributesExDInput = FormItem(
      label: '属性ExD',
      placeholder: 'AttributesExD',
      child: FoxyNumberInput<int>(
        value: vm.attributesExD.value,
        onChanged: (v) => vm.attributesExD.value = v,
      ),
    );
    final attributesExEInput = FormItem(
      label: '属性ExE',
      placeholder: 'AttributesExE',
      child: FoxyNumberInput<int>(
        value: vm.attributesExE.value,
        onChanged: (v) => vm.attributesExE.value = v,
      ),
    );
    final attributesExFInput = FormItem(
      label: '属性ExF',
      placeholder: 'AttributesExF',
      child: FoxyNumberInput<int>(
        value: vm.attributesExF.value,
        onChanged: (v) => vm.attributesExF.value = v,
      ),
    );
    final attributesExGInput = FormItem(
      label: '属性ExG',
      placeholder: 'AttributesExG',
      child: FoxyNumberInput<int>(
        value: vm.attributesExG.value,
        onChanged: (v) => vm.attributesExG.value = v,
      ),
    );

    // === 触发 ===
    final procTypeMaskInput = FormItem(
      label: '触发类型掩码',
      placeholder: 'ProcTypeMask',
      child: FoxyNumberInput<int>(
        value: vm.procTypeMask.value,
        onChanged: (v) => vm.procTypeMask.value = v,
      ),
    );
    final procChanceInput = FormItem(
      label: '触发几率',
      placeholder: 'ProcChance',
      child: FoxyNumberInput<int>(
        value: vm.procChance.value,
        onChanged: (v) => vm.procChance.value = v,
      ),
    );
    final procChargesInput = FormItem(
      label: '触发次数',
      placeholder: 'ProcCharges',
      child: FoxyNumberInput<int>(
        value: vm.procCharges.value,
        onChanged: (v) => vm.procCharges.value = v,
      ),
    );

    // === 法术分类掩码 ===
    final spellClassSetInput = FormItem(
      label: '法术分类集',
      placeholder: 'SpellClassSet',
      child: FoxyNumberInput<int>(
        value: vm.spellClassSet.value,
        onChanged: (v) => vm.spellClassSet.value = v,
      ),
    );
    final spellClassMask0Input = FormItem(
      label: '分类掩码1',
      placeholder: 'SpellClassMask0',
      child: FoxyNumberInput<int>(
        value: vm.spellClassMask0.value,
        onChanged: (v) => vm.spellClassMask0.value = v,
      ),
    );
    final spellClassMask1Input = FormItem(
      label: '分类掩码2',
      placeholder: 'SpellClassMask1',
      child: FoxyNumberInput<int>(
        value: vm.spellClassMask1.value,
        onChanged: (v) => vm.spellClassMask1.value = v,
      ),
    );
    final spellClassMask2Input = FormItem(
      label: '分类掩码3',
      placeholder: 'SpellClassMask2',
      child: FoxyNumberInput<int>(
        value: vm.spellClassMask2.value,
        onChanged: (v) => vm.spellClassMask2.value = v,
      ),
    );

    // === 效果0 ===
    final effect0Input = FormItem(
      label: '效果0类型',
      placeholder: 'Effect0',
      child: FoxyNumberInput<int>(
        value: vm.effect0.value,
        onChanged: (v) => vm.effect0.value = v,
      ),
    );
    final effectBasePoints0Input = FormItem(
      label: '效果0基础值',
      placeholder: 'EffectBasePoints0',
      child: FoxyNumberInput<int>(
        value: vm.effectBasePoints0.value,
        onChanged: (v) => vm.effectBasePoints0.value = v,
      ),
    );
    final effectDieSides0Input = FormItem(
      label: '效果0波动值',
      placeholder: 'EffectDieSides0',
      child: FoxyNumberInput<int>(
        value: vm.effectDieSides0.value,
        onChanged: (v) => vm.effectDieSides0.value = v,
      ),
    );
    final effectRealPointsPerLevel0Input = FormItem(
      label: '效果0每级加成',
      placeholder: 'EffectRealPointsPerLevel0',
      child: FoxyNumberInput<double>(
        value: vm.effectRealPointsPerLevel0.value,
        onChanged: (v) => vm.effectRealPointsPerLevel0.value = v,
      ),
    );
    final effectMechanic0Input = FormItem(
      label: '效果0机制',
      placeholder: 'EffectMechanic0',
      child: FoxyNumberInput<int>(
        value: vm.effectMechanic0.value,
        onChanged: (v) => vm.effectMechanic0.value = v,
      ),
    );
    final effectAura0Input = FormItem(
      label: '效果0光环',
      placeholder: 'EffectAura0',
      child: FoxyNumberInput<int>(
        value: vm.effectAura0.value,
        onChanged: (v) => vm.effectAura0.value = v,
      ),
    );
    final effectAuraPeriod0Input = FormItem(
      label: '效果0光环周期',
      placeholder: 'EffectAuraPeriod0',
      child: FoxyNumberInput<int>(
        value: vm.effectAuraPeriod0.value,
        onChanged: (v) => vm.effectAuraPeriod0.value = v,
      ),
    );
    final effectAmplitude0Input = FormItem(
      label: '效果0振幅',
      placeholder: 'EffectAmplitude0',
      child: FoxyNumberInput<double>(
        value: vm.effectAmplitude0.value,
        onChanged: (v) => vm.effectAmplitude0.value = v,
      ),
    );
    final implicitTargetA0Input = FormItem(
      label: '效果0目标A',
      placeholder: 'ImplicitTargetA0',
      child: FoxyNumberInput<int>(
        value: vm.implicitTargetA0.value,
        onChanged: (v) => vm.implicitTargetA0.value = v,
      ),
    );
    final implicitTargetB0Input = FormItem(
      label: '效果0目标B',
      placeholder: 'ImplicitTargetB0',
      child: FoxyNumberInput<int>(
        value: vm.implicitTargetB0.value,
        onChanged: (v) => vm.implicitTargetB0.value = v,
      ),
    );
    final effectMiscValue0Input = FormItem(
      label: '效果0杂项值',
      placeholder: 'EffectMiscValue0',
      child: FoxyNumberInput<int>(
        value: vm.effectMiscValue0.value,
        onChanged: (v) => vm.effectMiscValue0.value = v,
      ),
    );
    final effectMiscValueB0Input = FormItem(
      label: '效果0杂项值B',
      placeholder: 'EffectMiscValueB0',
      child: FoxyNumberInput<int>(
        value: vm.effectMiscValueB0.value,
        onChanged: (v) => vm.effectMiscValueB0.value = v,
      ),
    );
    final effectRadiusIndex0Input = FormItem(
      label: '效果0半径',
      placeholder: 'EffectRadiusIndex0',
      child: FoxyNumberInput<int>(
        value: vm.effectRadiusIndex0.value,
        onChanged: (v) => vm.effectRadiusIndex0.value = v,
      ),
    );
    final effectChainAmplitude0Input = FormItem(
      label: '效果0连锁振幅',
      placeholder: 'EffectChainAmplitude0',
      child: FoxyNumberInput<double>(
        value: vm.effectChainAmplitude0.value,
        onChanged: (v) => vm.effectChainAmplitude0.value = v,
      ),
    );
    final effectBonusCoefficient0Input = FormItem(
      label: '效果0加成系数',
      placeholder: 'EffectBonusCoefficient0',
      child: FoxyNumberInput<double>(
        value: vm.effectBonusCoefficient0.value,
        onChanged: (v) => vm.effectBonusCoefficient0.value = v,
      ),
    );
    final effectItemType0Input = FormItem(
      label: '效果0物品类型',
      placeholder: 'EffectItemType0',
      child: FoxyNumberInput<int>(
        value: vm.effectItemType0.value,
        onChanged: (v) => vm.effectItemType0.value = v,
      ),
    );
    final effectTriggerSpell0Input = FormItem(
      label: '效果0触发法术',
      placeholder: 'EffectTriggerSpell0',
      child: FoxyNumberInput<int>(
        value: vm.effectTriggerSpell0.value,
        onChanged: (v) => vm.effectTriggerSpell0.value = v,
      ),
    );
    final effectChainTargets0Input = FormItem(
      label: '效果0连锁目标',
      placeholder: 'EffectChainTargets0',
      child: FoxyNumberInput<int>(
        value: vm.effectChainTargets0.value,
        onChanged: (v) => vm.effectChainTargets0.value = v,
      ),
    );
    final effectPointsPerCombo0Input = FormItem(
      label: '效果0连击点数',
      placeholder: 'EffectPointsPerCombo0',
      child: FoxyNumberInput<double>(
        value: vm.effectPointsPerCombo0.value,
        onChanged: (v) => vm.effectPointsPerCombo0.value = v,
      ),
    );
    final effectSpellClassMaskA0Input = FormItem(
      label: '效果0分类掩码A',
      placeholder: 'EffectSpellClassMaskA0',
      child: FoxyNumberInput<int>(
        value: vm.effectSpellClassMaskA0.value,
        onChanged: (v) => vm.effectSpellClassMaskA0.value = v,
      ),
    );
    final effectSpellClassMaskB0Input = FormItem(
      label: '效果0分类掩码B',
      placeholder: 'EffectSpellClassMaskB0',
      child: FoxyNumberInput<int>(
        value: vm.effectSpellClassMaskB0.value,
        onChanged: (v) => vm.effectSpellClassMaskB0.value = v,
      ),
    );
    final effectSpellClassMaskC0Input = FormItem(
      label: '效果0分类掩码C',
      placeholder: 'EffectSpellClassMaskC0',
      child: FoxyNumberInput<int>(
        value: vm.effectSpellClassMaskC0.value,
        onChanged: (v) => vm.effectSpellClassMaskC0.value = v,
      ),
    );

    // === 效果1 ===
    final effect1Input = FormItem(
      label: '效果1类型',
      placeholder: 'Effect1',
      child: FoxyNumberInput<int>(
        value: vm.effect1.value,
        onChanged: (v) => vm.effect1.value = v,
      ),
    );
    final effectBasePoints1Input = FormItem(
      label: '效果1基础值',
      placeholder: 'EffectBasePoints1',
      child: FoxyNumberInput<int>(
        value: vm.effectBasePoints1.value,
        onChanged: (v) => vm.effectBasePoints1.value = v,
      ),
    );
    final effectDieSides1Input = FormItem(
      label: '效果1波动值',
      placeholder: 'EffectDieSides1',
      child: FoxyNumberInput<int>(
        value: vm.effectDieSides1.value,
        onChanged: (v) => vm.effectDieSides1.value = v,
      ),
    );
    final effectRealPointsPerLevel1Input = FormItem(
      label: '效果1每级加成',
      placeholder: 'EffectRealPointsPerLevel1',
      child: FoxyNumberInput<double>(
        value: vm.effectRealPointsPerLevel1.value,
        onChanged: (v) => vm.effectRealPointsPerLevel1.value = v,
      ),
    );
    final effectMechanic1Input = FormItem(
      label: '效果1机制',
      placeholder: 'EffectMechanic1',
      child: FoxyNumberInput<int>(
        value: vm.effectMechanic1.value,
        onChanged: (v) => vm.effectMechanic1.value = v,
      ),
    );
    final effectAura1Input = FormItem(
      label: '效果1光环',
      placeholder: 'EffectAura1',
      child: FoxyNumberInput<int>(
        value: vm.effectAura1.value,
        onChanged: (v) => vm.effectAura1.value = v,
      ),
    );
    final effectAuraPeriod1Input = FormItem(
      label: '效果1光环周期',
      placeholder: 'EffectAuraPeriod1',
      child: FoxyNumberInput<int>(
        value: vm.effectAuraPeriod1.value,
        onChanged: (v) => vm.effectAuraPeriod1.value = v,
      ),
    );
    final effectAmplitude1Input = FormItem(
      label: '效果1振幅',
      placeholder: 'EffectAmplitude1',
      child: FoxyNumberInput<double>(
        value: vm.effectAmplitude1.value,
        onChanged: (v) => vm.effectAmplitude1.value = v,
      ),
    );
    final implicitTargetA1Input = FormItem(
      label: '效果1目标A',
      placeholder: 'ImplicitTargetA1',
      child: FoxyNumberInput<int>(
        value: vm.implicitTargetA1.value,
        onChanged: (v) => vm.implicitTargetA1.value = v,
      ),
    );
    final implicitTargetB1Input = FormItem(
      label: '效果1目标B',
      placeholder: 'ImplicitTargetB1',
      child: FoxyNumberInput<int>(
        value: vm.implicitTargetB1.value,
        onChanged: (v) => vm.implicitTargetB1.value = v,
      ),
    );
    final effectMiscValue1Input = FormItem(
      label: '效果1杂项值',
      placeholder: 'EffectMiscValue1',
      child: FoxyNumberInput<int>(
        value: vm.effectMiscValue1.value,
        onChanged: (v) => vm.effectMiscValue1.value = v,
      ),
    );
    final effectMiscValueB1Input = FormItem(
      label: '效果1杂项值B',
      placeholder: 'EffectMiscValueB1',
      child: FoxyNumberInput<int>(
        value: vm.effectMiscValueB1.value,
        onChanged: (v) => vm.effectMiscValueB1.value = v,
      ),
    );
    final effectRadiusIndex1Input = FormItem(
      label: '效果1半径',
      placeholder: 'EffectRadiusIndex1',
      child: FoxyNumberInput<int>(
        value: vm.effectRadiusIndex1.value,
        onChanged: (v) => vm.effectRadiusIndex1.value = v,
      ),
    );
    final effectChainAmplitude1Input = FormItem(
      label: '效果1连锁振幅',
      placeholder: 'EffectChainAmplitude1',
      child: FoxyNumberInput<double>(
        value: vm.effectChainAmplitude1.value,
        onChanged: (v) => vm.effectChainAmplitude1.value = v,
      ),
    );
    final effectBonusCoefficient1Input = FormItem(
      label: '效果1加成系数',
      placeholder: 'EffectBonusCoefficient1',
      child: FoxyNumberInput<double>(
        value: vm.effectBonusCoefficient1.value,
        onChanged: (v) => vm.effectBonusCoefficient1.value = v,
      ),
    );
    final effectItemType1Input = FormItem(
      label: '效果1物品类型',
      placeholder: 'EffectItemType1',
      child: FoxyNumberInput<int>(
        value: vm.effectItemType1.value,
        onChanged: (v) => vm.effectItemType1.value = v,
      ),
    );
    final effectTriggerSpell1Input = FormItem(
      label: '效果1触发法术',
      placeholder: 'EffectTriggerSpell1',
      child: FoxyNumberInput<int>(
        value: vm.effectTriggerSpell1.value,
        onChanged: (v) => vm.effectTriggerSpell1.value = v,
      ),
    );
    final effectChainTargets1Input = FormItem(
      label: '效果1连锁目标',
      placeholder: 'EffectChainTargets1',
      child: FoxyNumberInput<int>(
        value: vm.effectChainTargets1.value,
        onChanged: (v) => vm.effectChainTargets1.value = v,
      ),
    );
    final effectPointsPerCombo1Input = FormItem(
      label: '效果1连击点数',
      placeholder: 'EffectPointsPerCombo1',
      child: FoxyNumberInput<double>(
        value: vm.effectPointsPerCombo1.value,
        onChanged: (v) => vm.effectPointsPerCombo1.value = v,
      ),
    );
    final effectSpellClassMaskA1Input = FormItem(
      label: '效果1分类掩码A',
      placeholder: 'EffectSpellClassMaskA1',
      child: FoxyNumberInput<int>(
        value: vm.effectSpellClassMaskA1.value,
        onChanged: (v) => vm.effectSpellClassMaskA1.value = v,
      ),
    );
    final effectSpellClassMaskB1Input = FormItem(
      label: '效果1分类掩码B',
      placeholder: 'EffectSpellClassMaskB1',
      child: FoxyNumberInput<int>(
        value: vm.effectSpellClassMaskB1.value,
        onChanged: (v) => vm.effectSpellClassMaskB1.value = v,
      ),
    );
    final effectSpellClassMaskC1Input = FormItem(
      label: '效果1分类掩码C',
      placeholder: 'EffectSpellClassMaskC1',
      child: FoxyNumberInput<int>(
        value: vm.effectSpellClassMaskC1.value,
        onChanged: (v) => vm.effectSpellClassMaskC1.value = v,
      ),
    );

    // === 效果2 ===
    final effect2Input = FormItem(
      label: '效果2类型',
      placeholder: 'Effect2',
      child: FoxyNumberInput<int>(
        value: vm.effect2.value,
        onChanged: (v) => vm.effect2.value = v,
      ),
    );
    final effectBasePoints2Input = FormItem(
      label: '效果2基础值',
      placeholder: 'EffectBasePoints2',
      child: FoxyNumberInput<int>(
        value: vm.effectBasePoints2.value,
        onChanged: (v) => vm.effectBasePoints2.value = v,
      ),
    );
    final effectDieSides2Input = FormItem(
      label: '效果2波动值',
      placeholder: 'EffectDieSides2',
      child: FoxyNumberInput<int>(
        value: vm.effectDieSides2.value,
        onChanged: (v) => vm.effectDieSides2.value = v,
      ),
    );
    final effectRealPointsPerLevel2Input = FormItem(
      label: '效果2每级加成',
      placeholder: 'EffectRealPointsPerLevel2',
      child: FoxyNumberInput<double>(
        value: vm.effectRealPointsPerLevel2.value,
        onChanged: (v) => vm.effectRealPointsPerLevel2.value = v,
      ),
    );
    final effectMechanic2Input = FormItem(
      label: '效果2机制',
      placeholder: 'EffectMechanic2',
      child: FoxyNumberInput<int>(
        value: vm.effectMechanic2.value,
        onChanged: (v) => vm.effectMechanic2.value = v,
      ),
    );
    final effectAura2Input = FormItem(
      label: '效果2光环',
      placeholder: 'EffectAura2',
      child: FoxyNumberInput<int>(
        value: vm.effectAura2.value,
        onChanged: (v) => vm.effectAura2.value = v,
      ),
    );
    final effectAuraPeriod2Input = FormItem(
      label: '效果2光环周期',
      placeholder: 'EffectAuraPeriod2',
      child: FoxyNumberInput<int>(
        value: vm.effectAuraPeriod2.value,
        onChanged: (v) => vm.effectAuraPeriod2.value = v,
      ),
    );
    final effectAmplitude2Input = FormItem(
      label: '效果2振幅',
      placeholder: 'EffectAmplitude2',
      child: FoxyNumberInput<double>(
        value: vm.effectAmplitude2.value,
        onChanged: (v) => vm.effectAmplitude2.value = v,
      ),
    );
    final implicitTargetA2Input = FormItem(
      label: '效果2目标A',
      placeholder: 'ImplicitTargetA2',
      child: FoxyNumberInput<int>(
        value: vm.implicitTargetA2.value,
        onChanged: (v) => vm.implicitTargetA2.value = v,
      ),
    );
    final implicitTargetB2Input = FormItem(
      label: '效果2目标B',
      placeholder: 'ImplicitTargetB2',
      child: FoxyNumberInput<int>(
        value: vm.implicitTargetB2.value,
        onChanged: (v) => vm.implicitTargetB2.value = v,
      ),
    );
    final effectMiscValue2Input = FormItem(
      label: '效果2杂项值',
      placeholder: 'EffectMiscValue2',
      child: FoxyNumberInput<int>(
        value: vm.effectMiscValue2.value,
        onChanged: (v) => vm.effectMiscValue2.value = v,
      ),
    );
    final effectMiscValueB2Input = FormItem(
      label: '效果2杂项值B',
      placeholder: 'EffectMiscValueB2',
      child: FoxyNumberInput<int>(
        value: vm.effectMiscValueB2.value,
        onChanged: (v) => vm.effectMiscValueB2.value = v,
      ),
    );
    final effectRadiusIndex2Input = FormItem(
      label: '效果2半径',
      placeholder: 'EffectRadiusIndex2',
      child: FoxyNumberInput<int>(
        value: vm.effectRadiusIndex2.value,
        onChanged: (v) => vm.effectRadiusIndex2.value = v,
      ),
    );
    final effectChainAmplitude2Input = FormItem(
      label: '效果2连锁振幅',
      placeholder: 'EffectChainAmplitude2',
      child: FoxyNumberInput<double>(
        value: vm.effectChainAmplitude2.value,
        onChanged: (v) => vm.effectChainAmplitude2.value = v,
      ),
    );
    final effectBonusCoefficient2Input = FormItem(
      label: '效果2加成系数',
      placeholder: 'EffectBonusCoefficient2',
      child: FoxyNumberInput<double>(
        value: vm.effectBonusCoefficient2.value,
        onChanged: (v) => vm.effectBonusCoefficient2.value = v,
      ),
    );
    final effectItemType2Input = FormItem(
      label: '效果2物品类型',
      placeholder: 'EffectItemType2',
      child: FoxyNumberInput<int>(
        value: vm.effectItemType2.value,
        onChanged: (v) => vm.effectItemType2.value = v,
      ),
    );
    final effectTriggerSpell2Input = FormItem(
      label: '效果2触发法术',
      placeholder: 'EffectTriggerSpell2',
      child: FoxyNumberInput<int>(
        value: vm.effectTriggerSpell2.value,
        onChanged: (v) => vm.effectTriggerSpell2.value = v,
      ),
    );
    final effectChainTargets2Input = FormItem(
      label: '效果2连锁目标',
      placeholder: 'EffectChainTargets2',
      child: FoxyNumberInput<int>(
        value: vm.effectChainTargets2.value,
        onChanged: (v) => vm.effectChainTargets2.value = v,
      ),
    );
    final effectPointsPerCombo2Input = FormItem(
      label: '效果2连击点数',
      placeholder: 'EffectPointsPerCombo2',
      child: FoxyNumberInput<double>(
        value: vm.effectPointsPerCombo2.value,
        onChanged: (v) => vm.effectPointsPerCombo2.value = v,
      ),
    );
    final effectSpellClassMaskA2Input = FormItem(
      label: '效果2分类掩码A',
      placeholder: 'EffectSpellClassMaskA2',
      child: FoxyNumberInput<int>(
        value: vm.effectSpellClassMaskA2.value,
        onChanged: (v) => vm.effectSpellClassMaskA2.value = v,
      ),
    );
    final effectSpellClassMaskB2Input = FormItem(
      label: '效果2分类掩码B',
      placeholder: 'EffectSpellClassMaskB2',
      child: FoxyNumberInput<int>(
        value: vm.effectSpellClassMaskB2.value,
        onChanged: (v) => vm.effectSpellClassMaskB2.value = v,
      ),
    );
    final effectSpellClassMaskC2Input = FormItem(
      label: '效果2分类掩码C',
      placeholder: 'EffectSpellClassMaskC2',
      child: FoxyNumberInput<int>(
        value: vm.effectSpellClassMaskC2.value,
        onChanged: (v) => vm.effectSpellClassMaskC2.value = v,
      ),
    );

    // === 装备限制 ===
    final equippedItemClassInput = FormItem(
      label: '装备职业',
      placeholder: 'EquippedItemClass',
      child: FoxyNumberInput<int>(
        value: vm.equippedItemClass.value,
        onChanged: (v) => vm.equippedItemClass.value = v,
      ),
    );
    final equippedItemSubclassInput = FormItem(
      label: '装备子类',
      placeholder: 'EquippedItemSubclass',
      child: FoxyNumberInput<int>(
        value: vm.equippedItemSubclass.value,
        onChanged: (v) => vm.equippedItemSubclass.value = v,
      ),
    );
    final equippedItemInvTypesInput = FormItem(
      label: '装备栏位',
      placeholder: 'EquippedItemInvTypes',
      child: FoxyNumberInput<int>(
        value: vm.equippedItemInvTypes.value,
        onChanged: (v) => vm.equippedItemInvTypes.value = v,
      ),
    );

    // === 图腾/施法材料 ===
    final requiredTotemCategoryID0Input = FormItem(
      label: '图腾1类型',
      placeholder: 'RequiredTotemCategoryID0',
      child: FoxyNumberInput<int>(
        value: vm.requiredTotemCategoryID0.value,
        onChanged: (v) => vm.requiredTotemCategoryID0.value = v,
      ),
    );
    final totem0Input = FormItem(
      label: '图腾1',
      placeholder: 'Totem0',
      child: FoxyNumberInput<int>(
        value: vm.totem0.value,
        onChanged: (v) => vm.totem0.value = v,
      ),
    );
    final requiredTotemCategoryID1Input = FormItem(
      label: '图腾2类型',
      placeholder: 'RequiredTotemCategoryID1',
      child: FoxyNumberInput<int>(
        value: vm.requiredTotemCategoryID1.value,
        onChanged: (v) => vm.requiredTotemCategoryID1.value = v,
      ),
    );
    final totem1Input = FormItem(
      label: '图腾2',
      placeholder: 'Totem1',
      child: FoxyNumberInput<int>(
        value: vm.totem1.value,
        onChanged: (v) => vm.totem1.value = v,
      ),
    );
    final reagent0Input = FormItem(
      label: '施法材料1',
      placeholder: 'Reagent0',
      child: FoxyNumberInput<int>(
        value: vm.reagent0.value,
        onChanged: (v) => vm.reagent0.value = v,
      ),
    );
    final reagentCount0Input = FormItem(
      label: '材料1数量',
      placeholder: 'ReagentCount0',
      child: FoxyNumberInput<int>(
        value: vm.reagentCount0.value,
        onChanged: (v) => vm.reagentCount0.value = v,
      ),
    );
    final reagent1Input = FormItem(
      label: '施法材料2',
      placeholder: 'Reagent1',
      child: FoxyNumberInput<int>(
        value: vm.reagent1.value,
        onChanged: (v) => vm.reagent1.value = v,
      ),
    );
    final reagentCount1Input = FormItem(
      label: '材料2数量',
      placeholder: 'ReagentCount1',
      child: FoxyNumberInput<int>(
        value: vm.reagentCount1.value,
        onChanged: (v) => vm.reagentCount1.value = v,
      ),
    );
    final reagent2Input = FormItem(
      label: '施法材料3',
      placeholder: 'Reagent2',
      child: FoxyNumberInput<int>(
        value: vm.reagent2.value,
        onChanged: (v) => vm.reagent2.value = v,
      ),
    );
    final reagentCount2Input = FormItem(
      label: '材料3数量',
      placeholder: 'ReagentCount2',
      child: FoxyNumberInput<int>(
        value: vm.reagentCount2.value,
        onChanged: (v) => vm.reagentCount2.value = v,
      ),
    );
    final reagent3Input = FormItem(
      label: '施法材料4',
      placeholder: 'Reagent3',
      child: FoxyNumberInput<int>(
        value: vm.reagent3.value,
        onChanged: (v) => vm.reagent3.value = v,
      ),
    );
    final reagentCount3Input = FormItem(
      label: '材料4数量',
      placeholder: 'ReagentCount3',
      child: FoxyNumberInput<int>(
        value: vm.reagentCount3.value,
        onChanged: (v) => vm.reagentCount3.value = v,
      ),
    );

    // === 其他高级属性 ===
    final casterAuraSpellInput = FormItem(
      label: '施法者光环法术',
      placeholder: 'CasterAuraSpell',
      child: FoxyNumberInput<int>(
        value: vm.casterAuraSpell.value,
        onChanged: (v) => vm.casterAuraSpell.value = v,
      ),
    );
    final cumulativeAuraInput = FormItem(
      label: '累积光环',
      placeholder: 'CumulativeAura',
      child: FoxyNumberInput<int>(
        value: vm.cumulativeAura.value,
        onChanged: (v) => vm.cumulativeAura.value = v,
      ),
    );
    final minFactionIDInput = FormItem(
      label: '最低声望阵营',
      placeholder: 'MinFactionID',
      child: FoxyNumberInput<int>(
        value: vm.minFactionID.value,
        onChanged: (v) => vm.minFactionID.value = v,
      ),
    );
    final minReputationInput = FormItem(
      label: '最低声望等级',
      placeholder: 'MinReputation',
      child: FoxyNumberInput<int>(
        value: vm.minReputation.value,
        onChanged: (v) => vm.minReputation.value = v,
      ),
    );
    final spellPriorityInput = FormItem(
      label: '法术优先级',
      placeholder: 'SpellPriority',
      child: FoxyNumberInput<int>(
        value: vm.spellPriority.value,
        onChanged: (v) => vm.spellPriority.value = v,
      ),
    );
    final modalNextSpellInput = FormItem(
      label: '下个模态法术',
      placeholder: 'ModalNextSpell',
      child: FoxyNumberInput<int>(
        value: vm.modalNextSpell.value,
        onChanged: (v) => vm.modalNextSpell.value = v,
      ),
    );
    final requiredAuraVisionInput = FormItem(
      label: '需求光环视野',
      placeholder: 'RequiredAuraVision',
      child: FoxyNumberInput<int>(
        value: vm.requiredAuraVision.value,
        onChanged: (v) => vm.requiredAuraVision.value = v,
      ),
    );
    final targetAuraSpellInput = FormItem(
      label: '目标光环法术',
      placeholder: 'TargetAuraSpell',
      child: FoxyNumberInput<int>(
        value: vm.targetAuraSpell.value,
        onChanged: (v) => vm.targetAuraSpell.value = v,
      ),
    );
    final stanceBarOrderInput = FormItem(
      label: '姿态栏顺序',
      placeholder: 'StanceBarOrder',
      child: FoxyNumberInput<int>(
        value: vm.stanceBarOrder.value,
        onChanged: (v) => vm.stanceBarOrder.value = v,
      ),
    );
    final shapeshiftMask0Input = FormItem(
      label: '变形掩码',
      placeholder: 'ShapeshiftMask0',
      child: FoxyNumberInput<int>(
        value: vm.shapeshiftMask0.value,
        onChanged: (v) => vm.shapeshiftMask0.value = v,
      ),
    );
    final shapeshiftExclude0Input = FormItem(
      label: '变形排除',
      placeholder: 'ShapeshiftExclude0',
      child: FoxyNumberInput<int>(
        value: vm.shapeshiftExclude0.value,
        onChanged: (v) => vm.shapeshiftExclude0.value = v,
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
