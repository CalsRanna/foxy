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
    final spellVisualID1Input = FormItem(
      controller: vm.spellVisualID1Controller,
      label: '视觉效果1',
      placeholder: 'SpellVisualID_1',
    );
    final spellVisualID2Input = FormItem(
      controller: vm.spellVisualID2Controller,
      label: '视觉效果2',
      placeholder: 'SpellVisualID_2',
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
    final spellClassMask1Input = FormItem(
      controller: vm.spellClassMask1Controller,
      label: '分类掩码1',
      placeholder: 'SpellClassMask_1',
    );
    final spellClassMask2Input = FormItem(
      controller: vm.spellClassMask2Controller,
      label: '分类掩码2',
      placeholder: 'SpellClassMask_2',
    );
    final spellClassMask3Input = FormItem(
      controller: vm.spellClassMask3Controller,
      label: '分类掩码3',
      placeholder: 'SpellClassMask_3',
    );

    // === 效果1 ===
    final effect1Input = FormItem(
      controller: vm.effect1Controller,
      label: '效果1类型',
      placeholder: 'Effect_1',
    );
    final effectBasePoints1Input = FormItem(
      controller: vm.effectBasePoints1Controller,
      label: '效果1基础值',
      placeholder: 'EffectBasePoints_1',
    );
    final effectDieSides1Input = FormItem(
      controller: vm.effectDieSides1Controller,
      label: '效果1波动值',
      placeholder: 'EffectDieSides_1',
    );
    final effectAura1Input = FormItem(
      controller: vm.effectAura1Controller,
      label: '效果1光环',
      placeholder: 'EffectAura_1',
    );
    final effectAuraPeriod1Input = FormItem(
      controller: vm.effectAuraPeriod1Controller,
      label: '效果1光环周期',
      placeholder: 'EffectAuraPeriod_1',
    );
    final implicitTargetA1Input = FormItem(
      controller: vm.implicitTargetA1Controller,
      label: '效果1目标A',
      placeholder: 'ImplicitTargetA_1',
    );
    final implicitTargetB1Input = FormItem(
      controller: vm.implicitTargetB1Controller,
      label: '效果1目标B',
      placeholder: 'ImplicitTargetB_1',
    );
    final effectMiscValue1Input = FormItem(
      controller: vm.effectMiscValue1Controller,
      label: '效果1杂项值',
      placeholder: 'EffectMiscValue_1',
    );
    final effectTriggerSpell1Input = FormItem(
      controller: vm.effectTriggerSpell1Controller,
      label: '效果1触发法术',
      placeholder: 'EffectTriggerSpell_1',
    );
    final effectChainTargets1Input = FormItem(
      controller: vm.effectChainTargets1Controller,
      label: '效果1连锁目标',
      placeholder: 'EffectChainTargets_1',
    );
    final effectRadiusIndex1Input = FormItem(
      controller: vm.effectRadiusIndex1Controller,
      label: '效果1半径',
      placeholder: 'EffectRadiusIndex_1',
    );
    final effectPointsPerCombo1Input = FormItem(
      controller: vm.effectPointsPerCombo1Controller,
      label: '效果1连击点数',
      placeholder: 'EffectPointsPerCombo_1',
    );

    // === 效果2 ===
    final effect2Input = FormItem(
      controller: vm.effect2Controller,
      label: '效果2类型',
      placeholder: 'Effect_2',
    );
    final effectBasePoints2Input = FormItem(
      controller: vm.effectBasePoints2Controller,
      label: '效果2基础值',
      placeholder: 'EffectBasePoints_2',
    );
    final effectDieSides2Input = FormItem(
      controller: vm.effectDieSides2Controller,
      label: '效果2波动值',
      placeholder: 'EffectDieSides_2',
    );
    final effectAura2Input = FormItem(
      controller: vm.effectAura2Controller,
      label: '效果2光环',
      placeholder: 'EffectAura_2',
    );
    final effectAuraPeriod2Input = FormItem(
      controller: vm.effectAuraPeriod2Controller,
      label: '效果2光环周期',
      placeholder: 'EffectAuraPeriod_2',
    );
    final implicitTargetA2Input = FormItem(
      controller: vm.implicitTargetA2Controller,
      label: '效果2目标A',
      placeholder: 'ImplicitTargetA_2',
    );
    final implicitTargetB2Input = FormItem(
      controller: vm.implicitTargetB2Controller,
      label: '效果2目标B',
      placeholder: 'ImplicitTargetB_2',
    );
    final effectTriggerSpell2Input = FormItem(
      controller: vm.effectTriggerSpell2Controller,
      label: '效果2触发法术',
      placeholder: 'EffectTriggerSpell_2',
    );
    final effectChainTargets2Input = FormItem(
      controller: vm.effectChainTargets2Controller,
      label: '效果2连锁目标',
      placeholder: 'EffectChainTargets_2',
    );
    final effectRadiusIndex2Input = FormItem(
      controller: vm.effectRadiusIndex2Controller,
      label: '效果2半径',
      placeholder: 'EffectRadiusIndex_2',
    );
    final effectPointsPerCombo2Input = FormItem(
      controller: vm.effectPointsPerCombo2Controller,
      label: '效果2连击点数',
      placeholder: 'EffectPointsPerCombo_2',
    );

    // === 效果3 ===
    final effect3Input = FormItem(
      controller: vm.effect3Controller,
      label: '效果3类型',
      placeholder: 'Effect_3',
    );
    final effectBasePoints3Input = FormItem(
      controller: vm.effectBasePoints3Controller,
      label: '效果3基础值',
      placeholder: 'EffectBasePoints_3',
    );
    final effectDieSides3Input = FormItem(
      controller: vm.effectDieSides3Controller,
      label: '效果3波动值',
      placeholder: 'EffectDieSides_3',
    );
    final effectAura3Input = FormItem(
      controller: vm.effectAura3Controller,
      label: '效果3光环',
      placeholder: 'EffectAura_3',
    );
    final effectAuraPeriod3Input = FormItem(
      controller: vm.effectAuraPeriod3Controller,
      label: '效果3光环周期',
      placeholder: 'EffectAuraPeriod_3',
    );
    final implicitTargetA3Input = FormItem(
      controller: vm.implicitTargetA3Controller,
      label: '效果3目标A',
      placeholder: 'ImplicitTargetA_3',
    );
    final implicitTargetB3Input = FormItem(
      controller: vm.implicitTargetB3Controller,
      label: '效果3目标B',
      placeholder: 'ImplicitTargetB_3',
    );
    final effectTriggerSpell3Input = FormItem(
      controller: vm.effectTriggerSpell3Controller,
      label: '效果3触发法术',
      placeholder: 'EffectTriggerSpell_3',
    );
    final effectChainTargets3Input = FormItem(
      controller: vm.effectChainTargets3Controller,
      label: '效果3连锁目标',
      placeholder: 'EffectChainTargets_3',
    );
    final effectRadiusIndex3Input = FormItem(
      controller: vm.effectRadiusIndex3Controller,
      label: '效果3半径',
      placeholder: 'EffectRadiusIndex_3',
    );
    final effectPointsPerCombo3Input = FormItem(
      controller: vm.effectPointsPerCombo3Controller,
      label: '效果3连击点数',
      placeholder: 'EffectPointsPerCombo_3',
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
    final requiredTotemCategoryID1Input = FormItem(
      controller: vm.requiredTotemCategoryID1Controller,
      label: '图腾1类型',
      placeholder: 'RequiredTotemCategoryID_1',
    );
    final totem1Input = FormItem(
      controller: vm.totem1Controller,
      label: '图腾1',
      placeholder: 'Totem_1',
    );
    final requiredTotemCategoryID2Input = FormItem(
      controller: vm.requiredTotemCategoryID2Controller,
      label: '图腾2类型',
      placeholder: 'RequiredTotemCategoryID_2',
    );
    final totem2Input = FormItem(
      controller: vm.totem2Controller,
      label: '图腾2',
      placeholder: 'Totem_2',
    );
    final reagent1Input = FormItem(
      controller: vm.reagent1Controller,
      label: '施法材料1',
      placeholder: 'Reagent_1',
    );
    final reagentCount1Input = FormItem(
      controller: vm.reagentCount1Controller,
      label: '材料1数量',
      placeholder: 'ReagentCount_1',
    );
    final reagent2Input = FormItem(
      controller: vm.reagent2Controller,
      label: '施法材料2',
      placeholder: 'Reagent_2',
    );
    final reagentCount2Input = FormItem(
      controller: vm.reagentCount2Controller,
      label: '材料2数量',
      placeholder: 'ReagentCount_2',
    );
    final reagent3Input = FormItem(
      controller: vm.reagent3Controller,
      label: '施法材料3',
      placeholder: 'Reagent_3',
    );
    final reagentCount3Input = FormItem(
      controller: vm.reagentCount3Controller,
      label: '材料3数量',
      placeholder: 'ReagentCount_3',
    );
    final reagent4Input = FormItem(
      controller: vm.reagent4Controller,
      label: '施法材料4',
      placeholder: 'Reagent_4',
    );
    final reagentCount4Input = FormItem(
      controller: vm.reagentCount4Controller,
      label: '材料4数量',
      placeholder: 'ReagentCount_4',
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
    final shapeshiftMaskInput = FormItem(
      controller: vm.shapeshiftMaskController,
      label: '变形掩码',
      placeholder: 'ShapeshiftMask',
    );
    final shapeshiftExcludeInput = FormItem(
      controller: vm.shapeshiftExcludeController,
      label: '变形排除',
      placeholder: 'ShapeshiftExclude',
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
          Expanded(child: spellVisualID1Input),
          Expanded(child: spellVisualID2Input),
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
          Expanded(child: spellClassMask1Input),
          Expanded(child: spellClassMask2Input),
          Expanded(child: spellClassMask3Input),
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
          Expanded(child: effectAura1Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectAuraPeriod1Input),
          Expanded(child: implicitTargetA1Input),
          Expanded(child: implicitTargetB1Input),
          Expanded(child: effectMiscValue1Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectTriggerSpell1Input),
          Expanded(child: effectChainTargets1Input),
          Expanded(child: effectRadiusIndex1Input),
          Expanded(child: effectPointsPerCombo1Input),
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
          Expanded(child: effectAura2Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectAuraPeriod2Input),
          Expanded(child: implicitTargetA2Input),
          Expanded(child: implicitTargetB2Input),
          Expanded(child: SizedBox()),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectTriggerSpell2Input),
          Expanded(child: effectChainTargets2Input),
          Expanded(child: effectRadiusIndex2Input),
          Expanded(child: effectPointsPerCombo2Input),
        ],
      ),
    ];

    final effect3Rows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: effect3Input),
          Expanded(child: effectBasePoints3Input),
          Expanded(child: effectDieSides3Input),
          Expanded(child: effectAura3Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectAuraPeriod3Input),
          Expanded(child: implicitTargetA3Input),
          Expanded(child: implicitTargetB3Input),
          Expanded(child: SizedBox()),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effectTriggerSpell3Input),
          Expanded(child: effectChainTargets3Input),
          Expanded(child: effectRadiusIndex3Input),
          Expanded(child: effectPointsPerCombo3Input),
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
          Expanded(child: requiredTotemCategoryID1Input),
          Expanded(child: totem1Input),
          Expanded(child: requiredTotemCategoryID2Input),
          Expanded(child: totem2Input),
        ],
      ),
    ];

    final reagentRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: reagent1Input),
          Expanded(child: reagentCount1Input),
          Expanded(child: reagent2Input),
          Expanded(child: reagentCount2Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: reagent3Input),
          Expanded(child: reagentCount3Input),
          Expanded(child: reagent4Input),
          Expanded(child: reagentCount4Input),
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
          Expanded(child: shapeshiftMaskInput),
          Expanded(child: shapeshiftExcludeInput),
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
          // 基础文本
          section('基础文本', basicRows),
          // 图标视觉
          section('图标视觉', visualRows),
          // 分类类型
          section('分类类型', categoryRows),
          // 施法参数
          section('施法参数', castingRows),
          // 冷却恢复
          section('冷却恢复', recoveryRows),
          // 目标
          section('目标', targetRows),
          // 状态
          section('状态', stateRows),
          // 需求
          section('需求', requiredRows),
          // 能量消耗
          section('能量消耗', powerRows),
          // 标志位
          section('标志位', attributeFlagRows),
          // 触发
          section('触发', procRows),
          // 法术分类掩码
          section('法术分类掩码', spellClassRows),
          // 效果1
          section('效果1', effect1Rows),
          // 效果2
          section('效果2', effect2Rows),
          // 效果3
          section('效果3', effect3Rows),
          // 装备限制
          section('装备限制', equipRows),
          // 图腾
          section('图腾', totemRows),
          // 施法材料
          section('施法材料', reagentRows),
          // 其他高级属性
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
