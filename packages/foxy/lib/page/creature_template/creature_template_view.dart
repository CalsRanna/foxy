import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/creature_template_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class CreatureTemplateView extends StatelessWidget {
  final CreatureTemplateDetailViewModel viewModel;

  const CreatureTemplateView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    /// Basic
    final entryInput = FoxyFormItem(
      label: '模板编号',
      child: FoxyNumberInput<int>(
        controller: viewModel.entryController,
        placeholder: 'entry',
      ),
    );
    final nameInput = FoxyFormItem(
      label: '名称',
      child: FoxyLocalePicker(
        entry: viewModel.persistedKey.value,
        controller: viewModel.nameController,
        delegate: FoxyLocalePickerDelegates.creatureTemplateName,
        placeholder: 'name',
        title: '名称',
      ),
    );
    final subNameInput = FoxyFormItem(
      label: '称号',
      child: FoxyLocalePicker(
        entry: viewModel.persistedKey.value,
        controller: viewModel.subNameController,
        delegate: FoxyLocalePickerDelegates.creatureTemplateTitle,
        placeholder: 'subname',
        title: '称号',
      ),
    );
    final iconNameInput = FoxyFormItem(
      label: '鼠标悬停图标',
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
    final unitClassInput = FoxyFormItem(
      label: '单位职业',
      child: FoxyShadSelect<int>(
        controller: viewModel.unitClassController,
        options: CreatureEnums.unitClassOptions,
        placeholder: const Text('unit_class'),
      ),
    );
    final rankInput = FoxyFormItem(
      label: '稀有等级',
      child: FoxyShadSelect<int>(
        controller: viewModel.rankController,
        options: CreatureEnums.rankOptions,
        placeholder: const Text('rank'),
      ),
    );
    final racialLeaderInput = FoxyFormItem(
      label: '种族领袖',
      child: FoxyShadSelect<int>(
        controller: viewModel.racialLeaderController,
        options: CreatureEnums.booleanOptions,
        placeholder: const Text('RacialLeader'),
      ),
    );
    final factionInput = FoxyFormItem(
      label: '阵营模板',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.dbcFactionTemplate,
        controller: viewModel.factionController,
        placeholder: 'faction',
      ),
    );
    final familyInput = FoxyFormItem(
      label: '生物族群',
      child: FoxyShadSelect<int>(
        controller: viewModel.familyController,
        options: CreatureEnums.creatureFamilyOptions,
        placeholder: const Text('family'),
      ),
    );
    final typeInput = FoxyFormItem(
      label: '生物类型',
      child: FoxyShadSelect<int>(
        controller: viewModel.typeController,
        options: CreatureEnums.creatureTypeOptions,
        placeholder: const Text('type'),
      ),
    );
    final regenerateHealthInput = FoxyFormItem(
      label: '自动回复生命',
      child: FoxyShadSelect<int>(
        controller: viewModel.regenHealthController,
        options: CreatureEnums.booleanOptions,
        placeholder: const Text('RegenHealth'),
      ),
    );
    final petSpellDataIdInput = FoxyFormItem(
      label: '宠物法术数据',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureSpellData,
        controller: viewModel.petSpellDataIdController,
        placeholder: 'PetSpellDataId',
      ),
    );
    final vehicleIdInput = FoxyFormItem(
      label: '载具数据',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.vehicle,
        controller: viewModel.vehicleIdController,
        placeholder: 'VehicleId',
      ),
    );
    final gossipMenuIdInput = FoxyFormItem(
      label: '对话菜单',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.gossipMenu,
        controller: viewModel.gossipMenuIdController,
        placeholder: 'gossip_menu_id',
      ),
    );

    /// 1. Basic info
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
          Expanded(child: unitClassInput),
          Expanded(child: rankInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: gossipMenuIdInput),
          const Expanded(child: SizedBox()),
          const Expanded(child: SizedBox()),
          const Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// Type/faction inputs
    final expInput = FoxyFormItem(
      label: '属性资料片',
      child: FoxyShadSelect<int>(
        controller: viewModel.expController,
        options: CreatureEnums.expansionOptions,
        placeholder: const Text('exp'),
      ),
    );

    /// 2. Type & faction
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
          Expanded(child: expInput),
          Expanded(child: petSpellDataIdInput),
          Expanded(child: vehicleIdInput),
          const Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// Flag
    final npcFlagInput = FoxyFormItem(
      label: 'NPC 功能标志',
      child: FoxyFlagPicker(
        controller: viewModel.npcFlagController,
        flags: CreatureFlags.npcFlagOptions,
        title: 'NPC 功能标志',
        placeholder: 'npcflag',
      ),
    );
    final typeFlagInput = FoxyFormItem(
      label: '生物类型标志',
      child: FoxyFlagPicker(
        controller: viewModel.typeFlagsController,
        flags: CreatureFlags.creatureTypeFlagOptions,
        title: '生物类型标志',
        placeholder: 'type_flags',
      ),
    );
    final dynamicFlagInput = FoxyFormItem(
      label: '动态状态标志',
      child: FoxyFlagPicker(
        controller: viewModel.dynamicFlagsController,
        flags: CreatureFlags.dynamicFlagOptions,
        title: '动态状态标志',
        placeholder: 'dynamicflags',
      ),
    );
    final extraFlagInput = FoxyFormItem(
      label: '服务端标志',
      child: FoxyFlagPicker(
        controller: viewModel.flagsExtraController,
        flags: CreatureFlags.flagsExtraOptions,
        title: '服务端额外标志',
        placeholder: 'flags_extra',
      ),
    );
    final unitFlagInput = FoxyFormItem(
      label: '单位标志',
      child: FoxyFlagPicker(
        controller: viewModel.unitFlagsController,
        flags: CreatureFlags.unitFlagOptions,
        title: '单位标志',
        placeholder: 'unit_flags',
      ),
    );
    final unitFlag2Input = FoxyFormItem(
      label: '单位标志 2',
      child: FoxyFlagPicker(
        controller: viewModel.unitFlags2Controller,
        flags: CreatureFlags.unitFlag2Options,
        title: '单位标志 2',
        placeholder: 'unit_flags2',
      ),
    );

    /// Modifier
    final damageSchoolInput = FoxyFormItem(
      label: '近战伤害学派',
      child: FoxyShadSelect<int>(
        controller: viewModel.damageSchoolController,
        options: CreatureEnums.damageSchoolOptions,
        placeholder: const Text('dmgschool'),
      ),
    );
    final damageModifierInput = FoxyFormItem(
      label: '伤害倍率',
      child: FoxyNumberInput<double>(
        controller: viewModel.damageModifierController,
        placeholder: 'DamageModifier',
      ),
    );
    final armorModifierInput = FoxyFormItem(
      label: '护甲倍率',
      child: FoxyNumberInput<double>(
        controller: viewModel.armorModifierController,
        placeholder: 'ArmorModifier',
      ),
    );
    final baseAttackTimeInput = FoxyFormItem(
      label: '基础攻击间隔',
      child: FoxyNumberInput<int>(
        controller: viewModel.baseAttackTimeController,
        placeholder: 'BaseAttackTime',
      ),
    );
    final baseVarianceInput = FoxyFormItem(
      label: '近战伤害系数',
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
      label: '远程伤害系数',
      child: FoxyNumberInput<double>(
        controller: viewModel.rangeVarianceController,
        placeholder: 'RangeVariance',
      ),
    );
    final healthModifierInput = FoxyFormItem(
      label: '生命值倍率',
      child: FoxyNumberInput<double>(
        controller: viewModel.healthModifierController,
        placeholder: 'HealthModifier',
      ),
    );
    final manaModifierInput = FoxyFormItem(
      label: '法力值倍率',
      child: FoxyNumberInput<double>(
        controller: viewModel.manaModifierController,
        placeholder: 'ManaModifier',
      ),
    );
    final experienceModifierInput = FoxyFormItem(
      label: '经验值倍率',
      child: FoxyNumberInput<double>(
        controller: viewModel.experienceModifierController,
        placeholder: 'ExperienceModifier',
      ),
    );
    final speedWalkInput = FoxyFormItem(
      label: '行走速度倍率',
      child: FoxyNumberInput<double>(
        controller: viewModel.speedWalkController,
        placeholder: 'speed_walk',
      ),
    );
    final speedRunInput = FoxyFormItem(
      label: '奔跑速度倍率',
      child: FoxyNumberInput<double>(
        controller: viewModel.speedRunController,
        placeholder: 'speed_run',
      ),
    );
    final speedSwimInput = FoxyFormItem(
      label: '游泳速度倍率',
      child: FoxyNumberInput<double>(
        controller: viewModel.speedSwimController,
        placeholder: 'speed_swim',
      ),
    );
    final speedFlightInput = FoxyFormItem(
      label: '飞行速度倍率',
      child: FoxyNumberInput<double>(
        controller: viewModel.speedFlightController,
        placeholder: 'speed_flight',
      ),
    );

    /// 4. Combat stats (11 fields)
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
          Expanded(child: regenerateHealthInput),
          const Expanded(child: SizedBox()),
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
      label: '击杀掉落模板',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureLoot,
        controller: viewModel.lootIdController,
        placeholder: 'lootid',
      ),
    );
    final pickpocketLootInput = FoxyFormItem(
      label: '偷窃掉落模板',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.pickpocketLoot,
        controller: viewModel.pickpocketLootController,
        placeholder: 'pickpocketloot',
      ),
    );
    final skinLootInput = FoxyFormItem(
      label: '剥皮掉落模板',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.skinningLoot,
        controller: viewModel.skinLootController,
        placeholder: 'skinloot',
      ),
    );

    /// Movement-stat inputs
    final movementIdInput = FoxyFormItem(
      label: '生物移动信息',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureMovementInfo,
        controller: viewModel.movementIdController,
        placeholder: 'movementId',
      ),
    );
    final movementTypeInput = FoxyFormItem(
      label: '默认移动方式',
      child: FoxyShadSelect<int>(
        controller: viewModel.movementTypeController,
        options: CreatureEnums.movementTypeOptions,
        placeholder: const Text('movementType'),
      ),
    );
    final hoverHeightInput = FoxyFormItem(
      label: '悬浮高度',
      child: FoxyNumberInput<double>(
        controller: viewModel.hoverHeightController,
        placeholder: 'HoverHeight',
      ),
    );
    final detectionRangeInput = FoxyFormItem(
      label: '仇恨探测范围',
      child: FoxyNumberInput<double>(
        controller: viewModel.detectionRangeController,
        placeholder: 'detection_range',
      ),
    );

    /// 5. Movement
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
    ];

    /// Immunity inputs
    final creatureImmunitiesIdInput = FoxyFormItem(
      label: '生物免疫配置',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureImmunity,
        controller: viewModel.creatureImmunitiesIdController,
        placeholder: 'CreatureImmunitiesId',
      ),
    );

    /// 6. Flags & immunities
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
          const Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// Difficulty/script inputs
    final killCredit1Input = FoxyFormItem(
      label: '击杀目标 1',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureTemplate,
        controller: viewModel.killCredit1Controller,
        placeholder: 'KillCredit1',
      ),
    );
    final killCredit2input = FoxyFormItem(
      label: '击杀目标 2',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureTemplate,
        controller: viewModel.killCredit2Controller,
        placeholder: 'KillCredit2',
      ),
    );
    final difficultyEntry1Input = FoxyFormItem(
      label: '难度模板 1',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureTemplate,
        controller: viewModel.difficultyEntry1Controller,
        placeholder: 'difficulty_entry_1',
      ),
    );
    final difficultyEntry2Input = FoxyFormItem(
      label: '难度模板 2',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureTemplate,
        controller: viewModel.difficultyEntry2Controller,
        placeholder: 'difficulty_entry_2',
      ),
    );
    final difficultyEntry3Input = FoxyFormItem(
      label: '难度模板 3',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.creatureTemplate,
        controller: viewModel.difficultyEntry3Controller,
        placeholder: 'difficulty_entry_3',
      ),
    );
    final aiNameInput = FoxyFormItem(
      label: 'AI 名称',
      child: FoxyStringInput(
        controller: viewModel.aiNameController,
        placeholder: 'AIName',
      ),
    );
    final scriptNameInput = FoxyFormItem(
      label: '脚本名称',
      child: FoxyStringInput(
        controller: viewModel.scriptNameController,
        placeholder: 'ScriptName',
      ),
    );
    final verifiedBuildInput = FoxyFormItem(
      label: '客户端构建号',
      child: FoxyNumberInput<int>(
        controller: viewModel.verifiedBuildController,
        placeholder: 'VerifiedBuild',
      ),
    );

    /// 7. Loot
    final lootRows = [
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
          const Expanded(child: SizedBox()),
          const Expanded(child: SizedBox()),
          const Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// 8. Difficulty & scripts
    final difficultyScriptRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: killCredit1Input),
          Expanded(child: killCredit2input),
          Expanded(child: difficultyEntry1Input),
          Expanded(child: difficultyEntry2Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: difficultyEntry3Input),
          Expanded(child: aiNameInput),
          Expanded(child: scriptNameInput),
          Expanded(child: verifiedBuildInput),
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
          FoxyFormSection(title: '类型与阵营', children: typeRows),
          FoxyFormSection(title: '战斗属性', children: combatRows),
          FoxyFormSection(title: '移动属性', children: movementRows),
          FoxyFormSection(title: '标志与免疫', children: flagImmuneRows),
          FoxyFormSection(title: '掉落', children: lootRows),
          FoxyFormSection(title: '难度与脚本', children: difficultyScriptRows),
          Row(
            children: [
              Watch(
                (_) => ShadButton(
                  enabled: !viewModel.submitting.value,
                  onPressed: () => _persist(context),
                  child: Text('保存'),
                ),
              ),
              const SizedBox(width: 8),
              ShadButton.ghost(onPressed: _goBack, child: Text('取消')),
            ],
          ),
        ],
      ),
    );
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }

  Future<void> _persist(BuildContext context) async {
    try {
      await viewModel.persist();
      if (!context.mounted) return;
      DialogUtil.instance.success('模板数据已保存');
    } catch (error) {
      if (!context.mounted) return;
      DialogUtil.instance.error('保存失败：${FoxyExceptions.message(error)}');
    }
  }
}
