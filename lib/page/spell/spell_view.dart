import 'package:flutter/material.dart';
import 'package:foxy/widget/entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/constant/spell_enums.dart';
import 'package:foxy/constant/spell_flags.dart';
import 'package:foxy/page/spell/spell_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/flag_picker.dart';
import 'package:foxy/widget/form_section.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

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
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.spellIcon,
        controller: vm.spellIconIDController,
        placeholder: 'SpellIconID',
      ),
    );
    final activeIconIDInput = FormItem(
      label: '激活图标',
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.spellIcon,
        controller: vm.activeIconIDController,
        placeholder: 'ActiveIconID',
      ),
    );
    final spellVisualID0Input = FormItem(
      label: '视觉',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellVisualID0',
        controller: vm.spellVisualID0Controller,
      ),
    );
    final spellVisualID1Input = FormItem(
      label: '视觉',
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
      child: FlagPicker(
        signal: vm.schoolMask,
        flags: kSpellSchoolMaskOptions,
        title: '法术类型掩码',
        placeholder: 'SchoolMask',
      ),
    );
    final mechanicInput = FormItem(
      label: '机制',
      child: FoxyShadSelect<int>(
        controller: vm.mechanicController,
        options: kSpellMechanicOptions,
        placeholder: const Text('Mechanic'),
      ),
    );
    final defenseTypeInput = FormItem(
      label: '伤害类型',
      child: FoxyShadSelect<int>(
        controller: vm.defenseTypeController,
        options: kSpellDmgClassOptions,
        placeholder: const Text('DefenseType'),
      ),
    );
    final dispelTypeInput = FormItem(
      label: '驱散类型',
      child: FoxyShadSelect<int>(
        controller: vm.dispelTypeController,
        options: kSpellDispelTypeOptions,
        placeholder: const Text('DispelType'),
      ),
    );
    final preventionTypeInput = FormItem(
      label: '防止类型',
      child: FoxyShadSelect<int>(
        controller: vm.preventionTypeController,
        options: kSpellPreventionTypeOptions,
        placeholder: const Text('PreventionType'),
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
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.spellDuration,
        controller: vm.durationIndexController,
        placeholder: 'DurationIndex',
      ),
    );
    final rangeIndexInput = FormItem(
      label: '施法范围',
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.spellRange,
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
      child: FoxyShadSelect<int>(
        controller: vm.targetCreatureTypeController,
        options: kCreatureTypeOptions,
        placeholder: const Text('TargetCreatureType'),
      ),
    );
    final targetsInput = FormItem(
      label: '目标限制',
      child: FlagPicker(
        signal: vm.targets,
        flags: kSpellCastTargetFlagsOptions,
        title: '目标限制',
        placeholder: 'Targets',
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
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.areaTable,
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
      child: FlagPicker(
        signal: vm.facingCasterFlags,
        flags: kSpellFacingFlagsOptions,
        title: '施法朝向',
        placeholder: 'FacingCasterFlags',
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
      child: FoxyShadSelect<int>(
        controller: vm.powerTypeController,
        options: kSpellPowerTypeOptions,
        placeholder: const Text('PowerType'),
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
      child: FlagPicker(
        signal: vm.interruptFlags,
        flags: kSpellInterruptFlagsOptions,
        title: '打断标志',
        placeholder: 'InterruptFlags',
      ),
    );
    final auraInterruptFlagsInput = FormItem(
      label: '光环打断标志',
      child: FlagPicker(
        signal: vm.auraInterruptFlags,
        flags: kSpellAuraInterruptFlagsOptions,
        title: '光环打断标志',
        placeholder: 'AuraInterruptFlags',
      ),
    );
    final channelInterruptFlagsInput = FormItem(
      label: '引导打断标志',
      child: FlagPicker(
        signal: vm.channelInterruptFlags,
        flags: kSpellChannelInterruptFlagsOptions,
        title: '引导打断标志',
        placeholder: 'ChannelInterruptFlags',
      ),
    );
    final attributesInput = FormItem(
      label: '属性',
      child: FlagPicker(
        signal: vm.attributes,
        flags: kSpellAttr0Options,
        title: '属性 (Attributes)',
        placeholder: 'Attributes',
      ),
    );
    final attributesExInput = FormItem(
      label: '属性Ex',
      child: FlagPicker(
        signal: vm.attributesEx,
        flags: kSpellAttr1Options,
        title: '属性Ex (AttributesEx)',
        placeholder: 'AttributesEx',
      ),
    );
    final attributesExBInput = FormItem(
      label: '属性ExB',
      child: FlagPicker(
        signal: vm.attributesExB,
        flags: kSpellAttr2Options,
        title: '属性ExB (AttributesExB)',
        placeholder: 'AttributesExB',
      ),
    );
    final attributesExCInput = FormItem(
      label: '属性ExC',
      child: FlagPicker(
        signal: vm.attributesExC,
        flags: kSpellAttr3Options,
        title: '属性ExC (AttributesExC)',
        placeholder: 'AttributesExC',
      ),
    );
    final attributesExDInput = FormItem(
      label: '属性ExD',
      child: FlagPicker(
        signal: vm.attributesExD,
        flags: kSpellAttr4Options,
        title: '属性ExD (AttributesExD)',
        placeholder: 'AttributesExD',
      ),
    );
    final attributesExEInput = FormItem(
      label: '属性ExE',
      child: FlagPicker(
        signal: vm.attributesExE,
        flags: kSpellAttr5Options,
        title: '属性ExE (AttributesExE)',
        placeholder: 'AttributesExE',
      ),
    );
    final attributesExFInput = FormItem(
      label: '属性ExF',
      child: FlagPicker(
        signal: vm.attributesExF,
        flags: kSpellAttr6Options,
        title: '属性ExF (AttributesExF)',
        placeholder: 'AttributesExF',
      ),
    );
    final attributesExGInput = FormItem(
      label: '属性ExG',
      child: FlagPicker(
        signal: vm.attributesExG,
        flags: kSpellAttr7Options,
        title: '属性ExG (AttributesExG)',
        placeholder: 'AttributesExG',
      ),
    );

    // === 触发 ===
    final procTypeMaskInput = FormItem(
      label: '触发类型掩码',
      child: FlagPicker(
        signal: vm.procTypeMask,
        flags: kSpellProcFlagsOptions,
        title: '触发类型掩码',
        placeholder: 'ProcTypeMask',
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
      label: '法术族',
      child: FoxyShadSelect<int>(
        controller: vm.spellClassSetController,
        options: kSpellFamilyNameOptions,
        placeholder: const Text('SpellClassSet'),
      ),
    );

    // 效果区域的输入框已移至响应式 _buildEffectSection 方法中

    // === 装备限制 ===
    final equippedItemClassInput = FormItem(
      label: '装备类型',
      child: FoxyShadSelect<int>(
        controller: vm.equippedItemClassController,
        options: kSpellItemClassOptions,
        placeholder: const Text('EquippedItemClass'),
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
      child: FlagPicker(
        signal: vm.equippedItemInvTypes,
        flags: kInventoryTypeOptions,
        title: '装备栏位',
        placeholder: 'EquippedItemInvTypes',
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
      child: FoxyShadSelect<int>(
        controller: vm.minReputationController,
        options: kSpellReputationRankOptions,
        placeholder: const Text('MinReputation'),
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
      child: FlagPicker(
        signal: vm.shapeshiftMask0,
        flags: kShapeshiftFormMaskOptions,
        title: '变形掩码',
        placeholder: 'ShapeshiftMask0',
      ),
    );
    final shapeshiftExclude0Input = FormItem(
      label: '变形排除',
      child: FlagPicker(
        signal: vm.shapeshiftExclude0,
        flags: kShapeshiftFormMaskOptions,
        title: '变形排除',
        placeholder: 'ShapeshiftExclude0',
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
          Watch((_) {
            return FormSection(title: '法术分类掩码', children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: spellClassSetInput),
                  Expanded(child: FormItem(
                    label: '分类掩码1',
                    child: FlagPicker(
                      signal: vm.spellClassMask0,
                      flags: kSpellClassMaskBits,
                      title: '分类掩码1',
                      placeholder: 'SpellClassMask0',
                    ),
                  )),
                  Expanded(child: FormItem(
                    label: '分类掩码2',
                    child: FlagPicker(
                      signal: vm.spellClassMask1,
                      flags: kSpellClassMaskBits,
                      title: '分类掩码2',
                      placeholder: 'SpellClassMask1',
                    ),
                  )),
                  Expanded(child: FormItem(
                    label: '分类掩码3',
                    child: FlagPicker(
                      signal: vm.spellClassMask2,
                      flags: kSpellClassMaskBits,
                      title: '分类掩码3',
                      placeholder: 'SpellClassMask2',
                    ),
                  )),
                ],
              ),
            ]);
          }),
          _buildEffectSection(0),
          _buildEffectSection(1),
          _buildEffectSection(2),
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

  /// 根据 Effect 和 EffectAura 返回 MiscValue 的动态标签
  String _miscValueLabel(int effect, int aura) {
    if (effect == 0) return '杂项值';
    switch (effect) {
      case 6: // APPLY_AURA - 由 Aura 决定
        return switch (aura) {
          13 || 87 || 174 || 237 || 238 => '法术类型掩码',
          22 || 83 => '抗性类型',
          29 || 137 || 175 || 182 || 212 || 268 => '属性ID',
          30 || 98 => '技能ID',
          31 => '速度类型',
          36 => '变形形态',
          75 => '语言ID',
          78 => '坐骑显示ID',
          82 => '水下呼吸类型',
          99 => '攻击强度类型',
          107 || 108 => 'SpellModOp',
          287 => '偏转几率%',
          _ => '杂项值',
        };
      case 24: return '物品ID';
      case 28: return '生物ID';
      case 30: return '能量类型';
      case 36: return '法术ID';
      case 38: return '驱散掩码';
      case 44: return '技能ID';
      case 56: return '宠物ID';
      case 64: return '触发法术ID';
      case 77: return '脚本参数';
      case 80: return '连击点数';
      case 83: return '决斗类型';
      case 118: return '技能ID';
      default: return '杂项值';
    }
  }

  /// MiscValueB 的动态标签
  String _miscValueBLabel(int effect, int aura) {
    if (effect == 0) return '杂项值B';
    return switch (effect) {
      6 => switch (aura) {
        30 => '技能步进值',
        174 => '属性ID',
        _ => '杂项值B',
      },
      _ => '杂项值B',
    };
  }

  /// 返回 MiscValueB 对应的枚举选项
  dynamic _miscValueBOptions(int effect, int aura) {
    if (effect == 0) return null;
    return switch (effect) {
      6 => switch (aura) {
        174 => kStatsEnumOptions,   // MOD_SPELL_DAMAGE_OF_STAT_PERCENT — 用 Stats 枚举！
        _ => null,
      },
      _ => null,
    };
  }

  /// 返回 MiscValue 对应的枚举选项，null=数字输入, Map=下拉框, List=FlagPicker
  dynamic _miscValueOptions(int effect, int aura) {
    if (effect == 0) return null;
    if (effect == 6) {
      return switch (aura) {
        13 || 87 || 174 || 237 || 238 => kSpellSchoolMaskOptions,  // school mask → FlagPicker!
        22 || 83 => kDamageSchoolOptions,         // 单值抗性 → 下拉
        29 || 137 || 175 || 182 || 212 || 268 => kStatTypeOptions, // 单值属性 → 下拉
        30 || 98 => null,                          // 技能ID → 数字
        31 => kSpeedTypeOptions,
        36 => kShapeshiftFormOptions,
        99 => kAttackPowerTypeOptions,
        107 || 108 => kSpellModOpOptions,
        _ => null,
      };
    }
    return switch (effect) {
      30 => kEnergizePowerTypeOptions,   // ENERGIZE
      _ => null,
    };
  }

  /// 构建响应式效果区域
  /// 根据 [effectSignal] 和 [effectAuraSignal] 决定子字段的 readonly 状态
  Widget _buildEffectSection(int i) {
    final labels = ['效果1', '效果2', '效果3'];
    return Watch((_) {
      final effectValue = switch (i) {
        0 => viewModel.effect0Signal.value,
        1 => viewModel.effect1Signal.value,
        2 => viewModel.effect2Signal.value,
        _ => 0,
      };
      final auraValue = switch (i) {
        0 => viewModel.effectAura0Signal.value,
        1 => viewModel.effectAura1Signal.value,
        2 => viewModel.effectAura2Signal.value,
        _ => 0,
      };
      final effectActive = effectValue != 0;
      // 只有 SPELL_EFFECT_APPLY_AURA(6) 或区域光环效果才需要光环字段
      final needsAura = effectValue == 6 ||
          effectValue == 27 || effectValue == 35 || effectValue == 65 ||
          effectValue == 119 || effectValue == 128 || effectValue == 129 ||
          effectValue == 143;
      // 周期性光环
      final isPeriodic = const {3, 8, 23, 24, 53, 64, 89, 226, 227, 316}.contains(auraValue);
      final miscOptions = _miscValueOptions(effectValue, auraValue);
      final miscBOptions = _miscValueBOptions(effectValue, auraValue);
      // 字段联动：某些子字段只在特定 Effect 下有意义
      final needsItemType = const {24, 34, 53, 54, 99, 127, 157, 158}.contains(effectValue);
      final needsTriggerSpell = const {32, 36, 64, 140, 141, 142, 148, 151}.contains(effectValue);
      final needsComboPoints = effectValue == 80;

      // Controllers by index
      final effCtrl = switch (i) { 0 => viewModel.effect0Controller, 1 => viewModel.effect1Controller, 2 => viewModel.effect2Controller, _ => viewModel.effect0Controller };
      final basePointsCtrl = switch (i) { 0 => viewModel.effectBasePoints0Controller, 1 => viewModel.effectBasePoints1Controller, 2 => viewModel.effectBasePoints2Controller, _ => viewModel.effectBasePoints0Controller };
      final dieSidesCtrl = switch (i) { 0 => viewModel.effectDieSides0Controller, 1 => viewModel.effectDieSides1Controller, 2 => viewModel.effectDieSides2Controller, _ => viewModel.effectDieSides0Controller };
      final pointsPerLevelCtrl = switch (i) { 0 => viewModel.effectRealPointsPerLevel0Controller, 1 => viewModel.effectRealPointsPerLevel1Controller, 2 => viewModel.effectRealPointsPerLevel2Controller, _ => viewModel.effectRealPointsPerLevel0Controller };
      final mechanicCtrl = switch (i) { 0 => viewModel.effectMechanic0Controller, 1 => viewModel.effectMechanic1Controller, 2 => viewModel.effectMechanic2Controller, _ => viewModel.effectMechanic0Controller };
      final chainTargetsCtrl = switch (i) { 0 => viewModel.effectChainTargets0Controller, 1 => viewModel.effectChainTargets1Controller, 2 => viewModel.effectChainTargets2Controller, _ => viewModel.effectChainTargets0Controller };
      final chainTargetsVal = int.tryParse(chainTargetsCtrl.text) ?? 0;
      final needsChainAmplitude = chainTargetsVal > 0;
      final auraCtrl = switch (i) { 0 => viewModel.effectAura0Controller, 1 => viewModel.effectAura1Controller, 2 => viewModel.effectAura2Controller, _ => viewModel.effectAura0Controller };
      final auraPeriodCtrl = switch (i) { 0 => viewModel.effectAuraPeriod0Controller, 1 => viewModel.effectAuraPeriod1Controller, 2 => viewModel.effectAuraPeriod2Controller, _ => viewModel.effectAuraPeriod0Controller };
      final amplitudeCtrl = switch (i) { 0 => viewModel.effectAmplitude0Controller, 1 => viewModel.effectAmplitude1Controller, 2 => viewModel.effectAmplitude2Controller, _ => viewModel.effectAmplitude0Controller };
      final targetACtrl = switch (i) { 0 => viewModel.implicitTargetA0Controller, 1 => viewModel.implicitTargetA1Controller, 2 => viewModel.implicitTargetA2Controller, _ => viewModel.implicitTargetA0Controller };
      final targetBCtrl = switch (i) { 0 => viewModel.implicitTargetB0Controller, 1 => viewModel.implicitTargetB1Controller, 2 => viewModel.implicitTargetB2Controller, _ => viewModel.implicitTargetB0Controller };
      final miscValueCtrl = switch (i) { 0 => viewModel.effectMiscValue0Controller, 1 => viewModel.effectMiscValue1Controller, 2 => viewModel.effectMiscValue2Controller, _ => viewModel.effectMiscValue0Controller };
      final miscValueBCtrl = switch (i) { 0 => viewModel.effectMiscValueB0Controller, 1 => viewModel.effectMiscValueB1Controller, 2 => viewModel.effectMiscValueB2Controller, _ => viewModel.effectMiscValueB0Controller };
      final radiusCtrl = switch (i) { 0 => viewModel.effectRadiusIndex0Controller, 1 => viewModel.effectRadiusIndex1Controller, 2 => viewModel.effectRadiusIndex2Controller, _ => viewModel.effectRadiusIndex0Controller };
      final chainAmpCtrl = switch (i) { 0 => viewModel.effectChainAmplitude0Controller, 1 => viewModel.effectChainAmplitude1Controller, 2 => viewModel.effectChainAmplitude2Controller, _ => viewModel.effectChainAmplitude0Controller };
      final bonusCoefCtrl = switch (i) { 0 => viewModel.effectBonusCoefficient0Controller, 1 => viewModel.effectBonusCoefficient1Controller, 2 => viewModel.effectBonusCoefficient2Controller, _ => viewModel.effectBonusCoefficient0Controller };
      final itemTypeCtrl = switch (i) { 0 => viewModel.effectItemType0Controller, 1 => viewModel.effectItemType1Controller, 2 => viewModel.effectItemType2Controller, _ => viewModel.effectItemType0Controller };
      final triggerSpellCtrl = switch (i) { 0 => viewModel.effectTriggerSpell0Controller, 1 => viewModel.effectTriggerSpell1Controller, 2 => viewModel.effectTriggerSpell2Controller, _ => viewModel.effectTriggerSpell0Controller };
      final comboCtrl = switch (i) { 0 => viewModel.effectPointsPerCombo0Controller, 1 => viewModel.effectPointsPerCombo1Controller, 2 => viewModel.effectPointsPerCombo2Controller, _ => viewModel.effectPointsPerCombo0Controller };
      final maskACtrl = switch (i) { 0 => viewModel.effectSpellClassMaskA0, 1 => viewModel.effectSpellClassMaskA1, 2 => viewModel.effectSpellClassMaskA2, _ => viewModel.effectSpellClassMaskA0 };
      final maskBCtrl = switch (i) { 0 => viewModel.effectSpellClassMaskB0, 1 => viewModel.effectSpellClassMaskB1, 2 => viewModel.effectSpellClassMaskB2, _ => viewModel.effectSpellClassMaskB0 };
      final maskCCtrl = switch (i) { 0 => viewModel.effectSpellClassMaskC0, 1 => viewModel.effectSpellClassMaskC1, 2 => viewModel.effectSpellClassMaskC2, _ => viewModel.effectSpellClassMaskC0 };

      return FormSection(title: labels[i], children: [
        Row(spacing: 8, children: [
          Expanded(child: FormItem(
            label: '类型',
            child: FoxyShadSelect<int>(controller: effCtrl, options: kSpellEffectOptions, placeholder: const Text('Effect')),
          )),
          Expanded(child: FormItem(
            label: '基础值',
            child: FoxyNumberInput<int>(placeholder: 'BasePoints', controller: basePointsCtrl, readOnly: !effectActive),
          )),
          Expanded(child: FormItem(
            label: '波动值',
            child: FoxyNumberInput<int>(placeholder: 'DieSides', controller: dieSidesCtrl, readOnly: !effectActive),
          )),
          Expanded(child: FormItem(
            label: '每级加成',
            child: FoxyNumberInput<double>(placeholder: 'RealPointsPerLevel', controller: pointsPerLevelCtrl, readOnly: !effectActive),
          )),
        ]),
        Row(spacing: 8, children: [
          Expanded(child: FormItem(
            label: '机制',
            child: FoxyShadSelect<int>(controller: mechanicCtrl, options: kSpellMechanicOptions, placeholder: const Text('Mechanic'), enabled: effectActive),
          )),
          Expanded(child: FormItem(
            label: '连锁目标',
            child: FoxyNumberInput<int>(placeholder: 'ChainTarget', controller: chainTargetsCtrl, readOnly: !effectActive),
          )),
          Expanded(child: FormItem(
            label: '光环',
            child: FoxyShadSelect<int>(controller: auraCtrl, options: kSpellAuraTypeOptions, placeholder: const Text('Aura'), enabled: needsAura),
          )),
          Expanded(child: FormItem(
            label: '光环周期',
            child: FoxyNumberInput<int>(placeholder: 'AuraPeriod', controller: auraPeriodCtrl, readOnly: !(needsAura && isPeriodic)),
          )),
        ]),
        Row(spacing: 8, children: [
          Expanded(child: FormItem(
            label: '振幅',
            child: FoxyNumberInput<double>(placeholder: 'Amplitude', controller: amplitudeCtrl, readOnly: !effectActive),
          )),
          Expanded(child: FormItem(
            label: '目标A',
            child: FoxyShadSelect<int>(controller: targetACtrl, options: kSpellImplicitTargetOptions, placeholder: const Text('TargetA'), enabled: effectActive),
          )),
          Expanded(child: FormItem(
            label: '目标B',
            child: FoxyShadSelect<int>(controller: targetBCtrl, options: kSpellImplicitTargetOptions, placeholder: const Text('TargetB'), enabled: effectActive),
          )),
          Expanded(child: FormItem(
            label: _miscValueLabel(effectValue, auraValue),
            child: _MiscValueInput(
              textController: miscValueCtrl,
              options: miscOptions,
              readOnly: !effectActive,
            ),
          )),
        ]),
        Row(spacing: 8, children: [
          Expanded(child: FormItem(
            label: _miscValueBLabel(effectValue, auraValue),
            child: _MiscValueInput(
              textController: miscValueBCtrl,
              options: miscBOptions,
              readOnly: !effectActive,
            ),
          )),
          Expanded(child: FormItem(
            label: '半径',
            child: FoxyNumberInput<int>(placeholder: 'RadiusIndex', controller: radiusCtrl, readOnly: !effectActive),
          )),
          Expanded(child: FormItem(
            label: '连锁振幅',
            child: FoxyNumberInput<double>(placeholder: 'ChainAmplitude', controller: chainAmpCtrl, readOnly: !effectActive || !needsChainAmplitude),
          )),
          Expanded(child: FormItem(
            label: '加成系数',
            child: FoxyNumberInput<double>(placeholder: 'BonusCoefficient', controller: bonusCoefCtrl, readOnly: !effectActive),
          )),
        ]),
        Row(spacing: 8, children: [
          Expanded(child: FormItem(
            label: '物品类型',
            child: FoxyShadSelect<int>(controller: itemTypeCtrl, options: kSpellItemClassOptions, placeholder: const Text('ItemType'), enabled: effectActive && needsItemType),
          )),
          Expanded(child: FormItem(
            label: '触发法术',
            child: FoxyNumberInput<int>(placeholder: 'TriggerSpell', controller: triggerSpellCtrl, readOnly: !effectActive || !needsTriggerSpell),
          )),
          Expanded(child: FormItem(
            label: '连锁目标',
            child: FoxyNumberInput<int>(placeholder: 'ChainTarget', controller: chainTargetsCtrl, readOnly: !effectActive),
          )),
          Expanded(child: FormItem(
            label: '连击点数',
            child: FoxyNumberInput<double>(placeholder: 'PointsPerCombo', controller: comboCtrl, readOnly: !effectActive || !needsComboPoints),
          )),
        ]),
        Row(spacing: 8, children: [
          Expanded(child: FormItem(
            label: '分类掩码A',
            child: FlagPicker(signal: maskACtrl, flags: kSpellClassMaskBits, title: '分类掩码A', placeholder: 'MaskA'),
          )),
          Expanded(child: FormItem(
            label: '分类掩码B',
            child: FlagPicker(signal: maskBCtrl, flags: kSpellClassMaskBits, title: '分类掩码B', placeholder: 'MaskB'),
          )),
          Expanded(child: FormItem(
            label: '分类掩码C',
            child: FlagPicker(signal: maskCCtrl, flags: kSpellClassMaskBits, title: '分类掩码C', placeholder: 'MaskC'),
          )),
          Expanded(child: SizedBox()),
        ]),
      ]);
    });
  }
}

/// 根据上下文动态切换 数字输入 / 下拉框 / FlagPicker。
class _MiscValueInput extends StatefulWidget {
  final TextEditingController textController;
  final dynamic options; // null=数字输入, Map=下拉框, List=FlagPicker
  final bool readOnly;

  const _MiscValueInput({
    required this.textController,
    this.options,
    this.readOnly = false,
  });

  @override
  State<_MiscValueInput> createState() => _MiscValueInputState();
}

class _MiscValueInputState extends State<_MiscValueInput> {
  ShadSelectController<int>? _selectController;
  late final Signal<int> _flagSignal;
  void Function()? _flagUnsub;

  @override
  void initState() {
    super.initState();
    _flagSignal = signal(int.tryParse(widget.textController.text) ?? 0);
    _syncController();
    if (_isFlagMode) {
      _flagUnsub = _flagSignal.subscribe((v) {
        widget.textController.text = v.toString();
      });
    }
  }

  @override
  void didUpdateWidget(_MiscValueInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.options != widget.options) {
      _selectController?.dispose();
      _selectController = null;
      // 模式切换时重新同步值
      if (_isSelectMode) {
        _syncController();
      } else if (_isFlagMode) {
        _flagSignal.value = int.tryParse(widget.textController.text) ?? 0;
        _flagUnsub ??= _flagSignal.subscribe((v) {
          widget.textController.text = v.toString();
        });
      }
    }
  }

  @override
  void dispose() {
    _selectController?.dispose();
    _flagUnsub?.call();
    super.dispose();
  }

  bool get _isFlagMode => widget.options is List<FlagItem>;
  bool get _isSelectMode => widget.options is Map<int, String>;

  void _syncController() {
    if (_isSelectMode) {
      final curVal = int.tryParse(widget.textController.text) ?? 0;
      _selectController = ShadSelectController<int>();
      _selectController!.value = {curVal};
      _selectController!.addListener(() {
        final v = _selectController!.value.firstOrNull;
        if (v != null) widget.textController.text = v.toString();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_isFlagMode) {
      return FlagPicker(
        signal: _flagSignal,
        flags: widget.options as List<FlagItem>,
        title: '杂项值',
        placeholder: 'MiscValue',
      );
    }
    if (_isSelectMode) {
      return FoxyShadSelect<int>(
        controller: _selectController!,
        options: widget.options as Map<int, String>,
        placeholder: const Text('选择...'),
        enabled: !widget.readOnly,
      );
    }
    return FoxyNumberInput<int>(
      placeholder: 'MiscValue',
      controller: widget.textController,
      readOnly: widget.readOnly,
    );
  }
}
