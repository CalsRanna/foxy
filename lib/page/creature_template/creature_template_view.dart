import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/page/creature_template/creature_template_detail_view_model.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CreatureTemplateView extends StatefulWidget {
  final int? entry;
  const CreatureTemplateView({super.key, this.entry});

  @override
  State<CreatureTemplateView> createState() => _CreatureTemplateViewState();
}

class _CreatureTemplateViewState extends State<CreatureTemplateView> {
  final viewModel = GetIt.instance.get<CreatureTemplateDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(entry: widget.entry);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Basic
    final entryInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        controller: viewModel.entryController,
        placeholder: 'entry',
        readOnly: true,
      ),
    );
    final nameInput = FoxyFormItem(
      label: '名称',
      child: FoxyLocalePicker(
        entry: widget.entry,
        controller: viewModel.nameController,
        delegate: FoxyLocalePickerDelegates.creatureTemplateName,
        placeholder: 'name',
        title: '名称',
      ),
    );
    final subNameInput = FoxyFormItem(
      label: '称号',
      child: FoxyLocalePicker(
        entry: widget.entry,
        controller: viewModel.subNameController,
        delegate: FoxyLocalePickerDelegates.creatureTemplateName,
        placeholder: 'subname',
        title: '称号',
      ),
    );
    final iconNameInput = FoxyFormItem(
      label: '鼠标形状',
      child: FoxyStringInput(
        controller: viewModel.iconNameController,
        placeholder: 'IconName',
      ),
    );
    final minLevelInput = FoxyFormItem(
      label: '最低等级',
      child: FoxyNumberInput<int>(
        controller: viewModel.minLevelController,
        placeholder: 'minlevel',
      ),
    );
    final maxLevelInput = FoxyFormItem(
      label: '最高等级',
      child: FoxyNumberInput<int>(
        controller: viewModel.maxLevelController,
        placeholder: 'maxlevel',
      ),
    );
    final uniClassInput = FoxyFormItem(
      label: '职业',
      child: FoxyShadSelect<int>(
        controller: viewModel.unitClassController,
        options: kUnitClassOptions,
        placeholder: const Text('unit_class'),
      ),
    );
    final rankInput = FoxyFormItem(
      label: '稀有程度',
      child: FoxyShadSelect<int>(
        controller: viewModel.rankController,
        options: kRankOptions,
        placeholder: const Text('rank'),
      ),
    );
    final racialLeaderInput = FoxyFormItem(
      label: '种族领袖',
      child: FoxyShadSelect<int>(
        controller: viewModel.racialLeaderController,
        options: kBooleanOptions,
        placeholder: const Text('RacialLeader'),
      ),
    );
    final factionInput = FoxyFormItem(
      label: '阵营',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.dbcFaction,
        controller: viewModel.factionController,
        placeholder: 'faction',
      ),
    );
    final familyInput = FoxyFormItem(
      label: '族群',
      child: FoxyShadSelect<int>(
        controller: viewModel.familyController,
        options: kCreatureFamilyOptions,
        placeholder: const Text('family'),
      ),
    );
    final typeInput = FoxyFormItem(
      label: '类型',
      child: FoxyShadSelect<int>(
        controller: viewModel.typeController,
        options: kCreatureTypeOptions,
        placeholder: const Text('type'),
      ),
    );
    final regenerateHealthInput = FoxyFormItem(
      label: '回复生命',
      child: FoxyShadSelect<int>(
        controller: viewModel.regenerateHealthController,
        options: kBooleanOptions,
        placeholder: const Text('RegenHealth'),
      ),
    );
    final petSpellDataIdInput = FoxyFormItem(
      label: '宠物技能',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureSpellData,
        controller: viewModel.petSpellDataIdController,
        placeholder: 'PetSpellDataId',
      ),
    );
    final vehicleIdInput = FoxyFormItem(
      label: '载具',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.vehicle,
        controller: viewModel.vehicleIdController,
        placeholder: 'VehicleId',
      ),
    );
    final gossipMenuIdInput = FoxyFormItem(
      label: '对话',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.gossipMenu,
        controller: viewModel.gossipMenuIdController,
        placeholder: 'gossip_menu_id',
      ),
    );

    /// 1. 基础信息 (8个字段)
    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: entryInput),
          Expanded(child: nameInput),
          Expanded(child: subNameInput),
          Expanded(child: iconNameInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: minLevelInput),
          Expanded(child: maxLevelInput),
          Expanded(child: uniClassInput),
          Expanded(child: rankInput),
        ],
      ),
    ];

    /// 类型阵营输入
    final expInput = FoxyFormItem(
      label: '属性扩展',
      child: FoxyShadSelect<int>(
        controller: viewModel.expController,
        options: kExpansionOptions,
        placeholder: const Text('exp'),
      ),
    );

    /// 2. 类型阵营 (7个字段)
    final typeRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: typeInput),
          Expanded(child: familyInput),
          Expanded(child: factionInput),
          Expanded(child: racialLeaderInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: regenerateHealthInput),
          Expanded(child: expInput),
          Expanded(child: gossipMenuIdInput),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// Flag
    final npcFlagInput = FoxyFormItem(
      label: 'NPC标识',
      child: FoxyFlagPicker(
        controller: viewModel.npcFlagController,
        flags: kNpcFlagOptions,
        title: 'NPC标识',
        placeholder: 'npcflag',
      ),
    );
    final typeFlagInput = FoxyFormItem(
      label: '类型标识',
      child: FoxyFlagPicker(
        controller: viewModel.typeFlagController,
        flags: kCreatureTypeFlagOptions,
        title: '类型标识',
        placeholder: 'type_flags',
      ),
    );
    final dynamicFlagInput = FoxyFormItem(
      label: '动态标识',
      child: FoxyFlagPicker(
        controller: viewModel.dynamicFlagController,
        flags: kDynamicFlagOptions,
        title: '动态标识',
        placeholder: 'dynamicflags',
      ),
    );
    final extraFlagInput = FoxyFormItem(
      label: '额外标识',
      child: FoxyFlagPicker(
        controller: viewModel.extraFlagController,
        flags: kFlagsExtraOptions,
        title: '额外标识',
        placeholder: 'flags_extra',
      ),
    );
    final unitFlagInput = FoxyFormItem(
      label: '单位标识',
      child: FoxyFlagPicker(
        controller: viewModel.unitFlagController,
        flags: kUnitFlagOptions,
        title: '单位标识',
        placeholder: 'unit_flags',
      ),
    );
    final unitFlag2Input = FoxyFormItem(
      label: '单位标识2',
      child: FoxyFlagPicker(
        controller: viewModel.unitFlag2Controller,
        flags: kUnitFlag2Options,
        title: '单位标识2',
        placeholder: 'unit_flags2',
      ),
    );

    /// Modifier
    final damageSchoolInput = FoxyFormItem(
      label: '伤害类型',
      child: FoxyShadSelect<int>(
        controller: viewModel.damageSchoolController,
        options: kDamageSchoolOptions,
        placeholder: const Text('dmgschool'),
      ),
    );
    final damageModifierInput = FoxyFormItem(
      label: '伤害系数',
      child: FoxyNumberInput<double>(
        controller: viewModel.damageModifierController,
        placeholder: 'dmgschool',
      ),
    );
    final armorModifierInput = FoxyFormItem(
      label: '护甲系数',
      child: FoxyNumberInput<double>(
        controller: viewModel.armorModifierController,
        placeholder: 'ArmorModifier',
      ),
    );
    final baseAttackTimeInput = FoxyFormItem(
      label: '近战攻击间隔',
      child: FoxyNumberInput<int>(
        controller: viewModel.baseAttackTimeController,
        placeholder: 'BaseAttackTime',
      ),
    );
    final baseVarianceInput = FoxyFormItem(
      label: '近战攻击方差',
      child: FoxyNumberInput<double>(
        controller: viewModel.baseVarianceController,
        placeholder: 'BaseVariance',
      ),
    );
    final rangeAttackTimeInput = FoxyFormItem(
      label: '远程攻击间隔',
      child: FoxyNumberInput<int>(
        controller: viewModel.rangeAttackTimeController,
        placeholder: 'RangeAttackTime',
      ),
    );
    final rangeVarianceInput = FoxyFormItem(
      label: '远程攻击方差',
      child: FoxyNumberInput<double>(
        controller: viewModel.rangeVarianceController,
        placeholder: 'RangeVariance',
      ),
    );
    final healthModifierInput = FoxyFormItem(
      label: '生命值系数',
      child: FoxyNumberInput<double>(
        controller: viewModel.healthModifierController,
        placeholder: 'HealthModifier',
      ),
    );
    final manaModifierInput = FoxyFormItem(
      label: '法力值系数',
      child: FoxyNumberInput<double>(
        controller: viewModel.manaModifierController,
        placeholder: 'ManaModifier',
      ),
    );
    final experienceModifierInput = FoxyFormItem(
      label: '经验值系数',
      child: FoxyNumberInput<double>(
        controller: viewModel.experienceModifierController,
        placeholder: 'ExperienceModifier',
      ),
    );
    final speedWalkInput = FoxyFormItem(
      label: '行走速度',
      child: FoxyNumberInput<double>(
        controller: viewModel.speedWalkController,
        placeholder: 'speed_walk',
      ),
    );
    final speedRunInput = FoxyFormItem(
      label: '奔跑速度',
      child: FoxyNumberInput<double>(
        controller: viewModel.speedRunController,
        placeholder: 'speed_run',
      ),
    );
    final speedSwimInput = FoxyFormItem(
      label: '游泳速度',
      child: FoxyNumberInput<double>(
        controller: viewModel.speedSwimController,
        placeholder: 'speed_swim',
      ),
    );
    final speedFlightInput = FoxyFormItem(
      label: '飞行速度',
      child: FoxyNumberInput<double>(
        controller: viewModel.speedFlightController,
        placeholder: 'speed_flight',
      ),
    );

    /// 4. 战斗属性 (11个字段)
    final combatRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: damageSchoolInput),
          Expanded(child: damageModifierInput),
          Expanded(child: armorModifierInput),
          Expanded(child: healthModifierInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: manaModifierInput),
          Expanded(child: experienceModifierInput),
          Expanded(child: baseAttackTimeInput),
          Expanded(child: baseVarianceInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: rangeAttackTimeInput),
          Expanded(child: rangeVarianceInput),
          Expanded(child: petSpellDataIdInput),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// Loot
    final minGoldInput = FoxyFormItem(
      label: '最小金钱掉落',
      child: FoxyNumberInput<int>(
        controller: viewModel.minGoldController,
        placeholder: 'mingold',
      ),
    );
    final maxGoldInput = FoxyFormItem(
      label: '最大金钱掉落',
      child: FoxyNumberInput<int>(
        controller: viewModel.maxGoldController,
        placeholder: 'maxgold',
      ),
    );
    final lootInput = FoxyFormItem(
      label: '击杀掉落',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.lootTemplate(
          LootTableType.creature,
          '击杀掉落',
        ),
        controller: viewModel.lootIdController,
        placeholder: 'lootid',
      ),
    );
    final pickpocketLootInput = FoxyFormItem(
      label: '偷窃掉落',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.lootTemplate(
          LootTableType.pickpocket,
          '偷窃掉落',
        ),
        controller: viewModel.pickpocketLootController,
        placeholder: 'pickpocketloot',
      ),
    );
    final skinLootInput = FoxyFormItem(
      label: '剥皮掉落',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.lootTemplate(
          LootTableType.skinning,
          '剥皮掉落',
        ),
        controller: viewModel.skinLootController,
        placeholder: 'skinloot',
      ),
    );

    /// 移动属性输入
    final movementIdInput = FoxyFormItem(
      label: '移动',
      child: FoxyNumberInput<int>(
        controller: viewModel.movementIdController,
        placeholder: 'movementId',
      ),
    );
    final movementTypeInput = FoxyFormItem(
      label: '移动类型',
      child: FoxyShadSelect<int>(
        controller: viewModel.movementTypeController,
        options: kMovementTypeOptions,
        placeholder: const Text('movementType'),
      ),
    );
    final hoverHeightInput = FoxyFormItem(
      label: '盘旋高度',
      child: FoxyNumberInput<double>(
        controller: viewModel.hoverHeightController,
        placeholder: 'HoverHeight',
      ),
    );
    final detectionRangeInput = FoxyFormItem(
      label: '探测范围',
      child: FoxyNumberInput<double>(
        controller: viewModel.detectionRangeController,
        placeholder: 'detection_range',
      ),
    );

    /// 5. 移动属性
    final movementRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: movementIdInput),
          Expanded(child: movementTypeInput),
          Expanded(child: speedWalkInput),
          Expanded(child: speedRunInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: speedSwimInput),
          Expanded(child: speedFlightInput),
          Expanded(child: detectionRangeInput),
          Expanded(child: hoverHeightInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: vehicleIdInput),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// 免疫输入
    final creatureImmunitiesIdInput = FoxyFormItem(
      label: '免疫ID',
      child: FoxyNumberInput<int>(
        controller: viewModel.creatureImmunitiesIdController,
        placeholder: 'CreatureImmunitiesId',
      ),
    );

    /// 6. 标识免疫
    final flagImmuneRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: npcFlagInput),
          Expanded(child: unitFlagInput),
          Expanded(child: unitFlag2Input),
          Expanded(child: typeFlagInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: dynamicFlagInput),
          Expanded(child: extraFlagInput),
          Expanded(child: creatureImmunitiesIdInput),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// 难度与脚本输入
    final killCredit1Input = FoxyFormItem(
      label: '击杀关联1',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureTemplate,
        controller: viewModel.killCredit1Controller,
        placeholder: 'KillCredit1',
      ),
    );
    final killCredit2input = FoxyFormItem(
      label: '击杀关联2',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureTemplate,
        controller: viewModel.killCredit2Controller,
        placeholder: 'KillCredit2',
      ),
    );
    final difficultyEntry1Input = FoxyFormItem(
      label: '难度1',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureTemplate,
        controller: viewModel.difficultyEntry1Controller,
        placeholder: 'difficulty_entry_1',
      ),
    );
    final difficultyEntry2Input = FoxyFormItem(
      label: '难度2',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureTemplate,
        controller: viewModel.difficultyEntry2Controller,
        placeholder: 'difficulty_entry_2',
      ),
    );
    final difficultyEntry3Input = FoxyFormItem(
      label: '难度3',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureTemplate,
        controller: viewModel.difficultyEntry3Controller,
        placeholder: 'difficulty_entry_3',
      ),
    );
    final aiNameInput = FoxyFormItem(
      label: 'AI',
      child: FoxyStringInput(
        controller: viewModel.aiNameController,
        placeholder: 'AIName',
      ),
    );
    final scriptNameInput = FoxyFormItem(
      label: '脚本',
      child: FoxyStringInput(
        controller: viewModel.scriptNameController,
        placeholder: 'ScriptName',
      ),
    );
    final verifiedBuildInput = FoxyFormItem(
      label: 'VerifiedBuild',
      child: FoxyNumberInput<int>(
        controller: viewModel.verifiedBuildController,
        placeholder: 'VerifiedBuild',
      ),
    );

    /// 7. 掉落难度与脚本 (13个字段)
    final lootDifficultyScriptRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: minGoldInput),
          Expanded(child: maxGoldInput),
          Expanded(child: lootInput),
          Expanded(child: pickpocketLootInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: skinLootInput),
          Expanded(child: killCredit1Input),
          Expanded(child: killCredit2input),
          Expanded(child: difficultyEntry1Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: difficultyEntry2Input),
          Expanded(child: difficultyEntry3Input),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: aiNameInput),
          Expanded(child: scriptNameInput),
          Expanded(child: verifiedBuildInput),
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
          FoxyFormSection(title: '基础信息', children: basicRows),
          FoxyFormSection(title: '类型阵营', children: typeRows),
          FoxyFormSection(title: '战斗属性', children: combatRows),
          FoxyFormSection(title: '移动属性', children: movementRows),
          FoxyFormSection(title: '标识免疫', children: flagImmuneRows),
          FoxyFormSection(title: '掉落难度与脚本', children: lootDifficultyScriptRows),
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
