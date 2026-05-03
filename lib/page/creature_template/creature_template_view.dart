import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/page/creature_template/creature_spell_data_selector.dart';
import 'package:foxy/page/creature_template/creature_template_detail_view_model.dart';
import 'package:foxy/page/creature_template/creature_template_locale_name_selector.dart';
import 'package:foxy/page/creature_template/creature_template_selector.dart';
import 'package:foxy/page/creature_template/dbc_faction_selector.dart';
import 'package:foxy/page/creature_template/gossip_menu_selector.dart';
import 'package:foxy/page/creature_template/loot_template_selector.dart';
import 'package:foxy/page/creature_template/vehicle_selector.dart';
import 'package:foxy/widget/flag_picker.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
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
    final entryInput = FormItem(
      controller: viewModel.entryController,
      label: '编号',
      placeholder: 'entry',
      readOnly: true,
    );
    final nameInput = FormItem(
      label: '名称',
      child: CreatureTemplateLocaleNameSelector(
        entry: widget.entry,
        controller: viewModel.nameController,
        placeholder: 'name',
        title: '名称',
      ),
    );
    final subNameInput = FormItem(
      label: '称号',
      child: CreatureTemplateLocaleNameSelector(
        entry: widget.entry,
        controller: viewModel.subNameController,
        placeholder: 'subname',
        title: '称号',
      ),
    );
    final iconNameInput = FormItem(
      controller: viewModel.iconNameController,
      label: '鼠标形状',
      placeholder: 'IconName',
    );
    final minLevelInput = FormItem(
      label: '最低等级',
      child: FoxyNumberInput<int>(
        value: viewModel.minLevel.value,
        onChanged: (v) => viewModel.minLevel.value = v,
        placeholder: 'minlevel',
      ),
    );
    final maxLevelInput = FormItem(
      label: '最高等级',
      child: FoxyNumberInput<int>(
        value: viewModel.maxLevel.value,
        onChanged: (v) => viewModel.maxLevel.value = v,
        placeholder: 'maxlevel',
      ),
    );
    final uniClassInput = FormItem(
      label: '职业',
      child: FoxyShadSelect<int>(
        controller: viewModel.unitClassController,
        options: kUnitClassOptions,
        placeholder: const Text('unit_class'),
      ),
    );
    final rankInput = FormItem(
      label: '稀有程度',
      child: FoxyShadSelect<int>(
        controller: viewModel.rankController,
        options: kRankOptions,
        placeholder: const Text('rank'),
      ),
    );
    final racialLeaderInput = FormItem(
      label: '种族领袖',
      child: FoxyShadSelect<int>(
        controller: viewModel.racialLeaderController,
        options: kBooleanOptions,
        placeholder: const Text('RacialLeader'),
      ),
    );
    final factionInput = FormItem(
      label: '阵营',
      child: DbcFactionSelector(
        controller: viewModel.factionController,
        placeholder: 'faction',
      ),
    );
    final familyInput = FormItem(
      label: '族群',
      child: FoxyShadSelect<int>(
        controller: viewModel.familyController,
        options: kCreatureFamilyOptions,
        placeholder: const Text('family'),
      ),
    );
    final typeInput = FormItem(
      label: '类型',
      child: FoxyShadSelect<int>(
        controller: viewModel.typeController,
        options: kCreatureTypeOptions,
        placeholder: const Text('type'),
      ),
    );
    final regenerateHealthInput = FormItem(
      label: '回复生命',
      child: FoxyShadSelect<int>(
        controller: viewModel.regenerateHealthController,
        options: kBooleanOptions,
        placeholder: const Text('RegenHealth'),
      ),
    );
    final petSpellDataIdInput = FormItem(
      label: '宠物技能',
      child: CreatureSpellDataSelector(
        controller: viewModel.petSpellDataIdController,
        placeholder: 'PetSpellDataId',
      ),
    );
    final vehicleIdInput = FormItem(
      label: '载具',
      child: VehicleSelector(
        controller: viewModel.vehicleIdController,
        placeholder: 'VehicleId',
      ),
    );
    final gossipMenuIdInput = FormItem(
      label: '对话',
      child: GossipMenuSelector(
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
    final expInput = FormItem(
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
    final npcFlagInput = FormItem(
      label: 'NPC标识',
      child: FlagPicker(
        controller: viewModel.npcFlagController,
        flags: kNpcFlagOptions,
        title: 'NPC标识',
        placeholder: 'npcflag',
      ),
    );
    final typeFlagInput = FormItem(
      label: '类型标识',
      child: FlagPicker(
        controller: viewModel.typeFlagController,
        flags: kCreatureTypeFlagOptions,
        title: '类型标识',
        placeholder: 'type_flags',
      ),
    );
    final dynamicFlagInput = FormItem(
      label: '动态标识',
      child: FlagPicker(
        controller: viewModel.dynamicFlagController,
        flags: kDynamicFlagOptions,
        title: '动态标识',
        placeholder: 'dynamicflags',
      ),
    );
    final extraFlagInput = FormItem(
      label: '额外标识',
      child: FlagPicker(
        controller: viewModel.extraFlagController,
        flags: kFlagsExtraOptions,
        title: '额外标识',
        placeholder: 'flags_extra',
      ),
    );
    final unitFlagInput = FormItem(
      label: '单位标识',
      child: FlagPicker(
        controller: viewModel.unitFlagController,
        flags: kUnitFlagOptions,
        title: '单位标识',
        placeholder: 'unit_flags',
      ),
    );
    final unitFlag2Input = FormItem(
      label: '单位标识2',
      child: FlagPicker(
        controller: viewModel.unitFlag2Controller,
        flags: kUnitFlag2Options,
        title: '单位标识2',
        placeholder: 'unit_flags2',
      ),
    );

    /// Modifier
    final damageSchoolInput = FormItem(
      label: '伤害类型',
      child: FoxyShadSelect<int>(
        controller: viewModel.damageSchoolController,
        options: kDamageSchoolOptions,
        placeholder: const Text('dmgschool'),
      ),
    );
    final damageModifierInput = FormItem(
      label: '伤害系数',
      child: FoxyNumberInput<double>(
        value: viewModel.damageModifier.value,
        onChanged: (v) => viewModel.damageModifier.value = v,
        placeholder: 'dmgschool',
      ),
    );
    final armorModifierInput = FormItem(
      label: '护甲系数',
      child: FoxyNumberInput<double>(
        value: viewModel.armorModifier.value,
        onChanged: (v) => viewModel.armorModifier.value = v,
        placeholder: 'ArmorModifier',
      ),
    );
    final baseAttackTimeInput = FormItem(
      label: '近战攻击间隔',
      child: FoxyNumberInput<int>(
        value: viewModel.baseAttackTime.value,
        onChanged: (v) => viewModel.baseAttackTime.value = v,
        placeholder: 'BaseAttackTime',
      ),
    );
    final baseVarianceInput = FormItem(
      label: '近战攻击方差',
      child: FoxyNumberInput<double>(
        value: viewModel.baseVariance.value,
        onChanged: (v) => viewModel.baseVariance.value = v,
        placeholder: 'BaseVariance',
      ),
    );
    final rangeAttackTimeInput = FormItem(
      label: '远程攻击间隔',
      child: FoxyNumberInput<int>(
        value: viewModel.rangeAttackTime.value,
        onChanged: (v) => viewModel.rangeAttackTime.value = v,
        placeholder: 'RangeAttackTime',
      ),
    );
    final rangeVarianceInput = FormItem(
      label: '远程攻击方差',
      child: FoxyNumberInput<double>(
        value: viewModel.rangeVariance.value,
        onChanged: (v) => viewModel.rangeVariance.value = v,
        placeholder: 'RangeVariance',
      ),
    );
    final healthModifierInput = FormItem(
      label: '生命值系数',
      child: FoxyNumberInput<double>(
        value: viewModel.healthModifier.value,
        onChanged: (v) => viewModel.healthModifier.value = v,
        placeholder: 'HealthModifier',
      ),
    );
    final manaModifierInput = FormItem(
      label: '法力值系数',
      child: FoxyNumberInput<double>(
        value: viewModel.manaModifier.value,
        onChanged: (v) => viewModel.manaModifier.value = v,
        placeholder: 'ManaModifier',
      ),
    );
    final experienceModifierInput = FormItem(
      label: '经验值系数',
      child: FoxyNumberInput<double>(
        value: viewModel.experienceModifier.value,
        onChanged: (v) => viewModel.experienceModifier.value = v,
        placeholder: 'ExperienceModifier',
      ),
    );
    final speedWalkInput = FormItem(
      label: '行走速度',
      child: FoxyNumberInput<double>(
        value: viewModel.speedWalk.value,
        onChanged: (v) => viewModel.speedWalk.value = v,
        placeholder: 'speed_walk',
      ),
    );
    final speedRunInput = FormItem(
      label: '奔跑速度',
      child: FoxyNumberInput<double>(
        value: viewModel.speedRun.value,
        onChanged: (v) => viewModel.speedRun.value = v,
        placeholder: 'speed_run',
      ),
    );
    final speedSwimInput = FormItem(
      label: '游泳速度',
      child: FoxyNumberInput<double>(
        value: viewModel.speedSwim.value,
        onChanged: (v) => viewModel.speedSwim.value = v,
        placeholder: 'speed_swim',
      ),
    );
    final speedFlightInput = FormItem(
      label: '飞行速度',
      child: FoxyNumberInput<double>(
        value: viewModel.speedFlight.value,
        onChanged: (v) => viewModel.speedFlight.value = v,
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
    final minGoldInput = FormItem(
      label: '最小金钱掉落',
      child: FoxyNumberInput<int>(
        value: viewModel.minGold.value,
        onChanged: (v) => viewModel.minGold.value = v,
        placeholder: 'mingold',
      ),
    );
    final maxGoldInput = FormItem(
      label: '最大金钱掉落',
      child: FoxyNumberInput<int>(
        value: viewModel.maxGold.value,
        onChanged: (v) => viewModel.maxGold.value = v,
        placeholder: 'maxgold',
      ),
    );
    final lootInput = FormItem(
      label: '击杀掉落',
      child: LootTemplateSelector.creature(
        controller: viewModel.lootController,
        placeholder: 'lootid',
      ),
    );
    final pickpocketLootInput = FormItem(
      label: '偷窃掉落',
      child: LootTemplateSelector.pickpocket(
        controller: viewModel.pickpocketLootController,
        placeholder: 'pickpocketloot',
      ),
    );
    final skinLootInput = FormItem(
      label: '剥皮掉落',
      child: LootTemplateSelector.skinning(
        controller: viewModel.skinLootController,
        placeholder: 'skinloot',
      ),
    );

    /// 移动属性输入
    final movementIdInput = FormItem(
      label: '移动',
      child: FoxyNumberInput<int>(
        value: viewModel.movementId.value,
        onChanged: (v) => viewModel.movementId.value = v,
        placeholder: 'movementId',
      ),
    );
    final movementTypeInput = FormItem(
      label: '移动类型',
      child: FoxyShadSelect<int>(
        controller: viewModel.movementTypeController,
        options: kMovementTypeOptions,
        placeholder: const Text('movementType'),
      ),
    );
    final hoverHeightInput = FormItem(
      label: '盘旋高度',
      child: FoxyNumberInput<double>(
        value: viewModel.hoverHeight.value,
        onChanged: (v) => viewModel.hoverHeight.value = v,
        placeholder: 'HoverHeight',
      ),
    );
    final detectionRangeInput = FormItem(
      label: '探测范围',
      child: FoxyNumberInput<double>(
        value: viewModel.detectionRange.value,
        onChanged: (v) => viewModel.detectionRange.value = v,
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
    final creatureImmunitiesIdInput = FormItem(
      label: '免疫ID',
      child: FoxyNumberInput<int>(
        value: viewModel.creatureImmunitiesId.value,
        onChanged: (v) => viewModel.creatureImmunitiesId.value = v,
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
    final killCredit1Input = FormItem(
      label: '击杀关联1',
      child: CreatureTemplateSelector(
        controller: viewModel.killCredit1Controller,
        placeholder: 'KillCredit1',
      ),
    );
    final killCredit2input = FormItem(
      label: '击杀关联2',
      child: CreatureTemplateSelector(
        controller: viewModel.killCredit2Controller,
        placeholder: 'KillCredit2',
      ),
    );
    final difficultyEntry1Input = FormItem(
      label: '难度1',
      child: CreatureTemplateSelector(
        controller: viewModel.difficultyEntry1Controller,
        placeholder: 'difficulty_entry_1',
      ),
    );
    final difficultyEntry2Input = FormItem(
      label: '难度2',
      child: CreatureTemplateSelector(
        controller: viewModel.difficultyEntry2Controller,
        placeholder: 'difficulty_entry_2',
      ),
    );
    final difficultyEntry3Input = FormItem(
      label: '难度3',
      child: CreatureTemplateSelector(
        controller: viewModel.difficultyEntry3Controller,
        placeholder: 'difficulty_entry_3',
      ),
    );
    final aiNameInput = FormItem(
      controller: viewModel.aiNameController,
      label: 'AI',
      placeholder: 'AIName',
    );
    final scriptNameInput = FormItem(
      controller: viewModel.scriptNameController,
      label: '脚本',
      placeholder: 'ScriptName',
    );
    final verifiedBuildInput = FormItem(
      label: 'VerifiedBuild',
      child: FoxyNumberInput<int>(
        value: viewModel.verifiedBuild.value,
        onChanged: (v) => viewModel.verifiedBuild.value = v,
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
          // 基础信息
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('基础信息'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: basicRows),
          ),
          // 类型阵营
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('类型阵营'),
          ),

          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: typeRows),
          ),
          // 战斗属性
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('战斗属性'),
          ),

          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: combatRows),
          ),
          // 移动属性
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('移动属性'),
          ),

          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: movementRows),
          ),
          // 标识免疫
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('标识免疫'),
          ),

          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: flagImmuneRows),
          ),
          // 掉落难度与脚本
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('掉落难度与脚本'),
          ),

          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: lootDifficultyScriptRows),
          ),
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
