import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/page/creature_template/creature_template_detail_view_model.dart';
import 'package:foxy/page/creature_template/creature_template_locale_name_selector.dart';
import 'package:foxy/widget/creature_template_selector.dart';
import 'package:foxy/widget/faction_template_selector.dart';
import 'package:foxy/widget/flag_picker.dart';
import 'package:foxy/widget/gossip_menu_selector.dart';
import 'package:foxy/widget/loot_template_selector.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/tab.dart';
import 'package:foxy/widget/header.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class CreatureTemplateDetailPage extends StatefulWidget {
  final int? entry;
  const CreatureTemplateDetailPage({super.key, this.entry});

  @override
  State<CreatureTemplateDetailPage> createState() =>
      _CreatureTemplatePageState();
}

class _CreatureTemplatePageState extends State<CreatureTemplateDetailPage> {
  final viewModel = GetIt.instance.get<CreatureTemplateDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(entry: widget.entry);
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
      ),
    );
    final subNameInput = FormItem(
      label: '称号',
      child: CreatureTemplateLocaleNameSelector(
        entry: widget.entry,
        controller: viewModel.subNameController,
        placeholder: 'subname',
      ),
    );
    final iconNameInput = FormItem(
      controller: viewModel.iconNameController,
      label: '鼠标形状',
      placeholder: 'IconName',
    );
    final minLevelInput = FormItem(
      controller: viewModel.minLevelController,
      label: '最低等级',
      placeholder: 'minlevel',
    );
    final maxLevelInput = FormItem(
      controller: viewModel.maxLevelController,
      label: '最高等级',
      placeholder: 'maxlevel',
    );
    final uniClassInput = FormItem(
      label: '职业',
      child: ShadSelect<int>(
        controller: viewModel.unitClassController,
        options: kUnitClassOptions.toShadOptions(),
        selectedOptionBuilder: (context, value) => Text(kUnitClassOptions[value] ?? ''),
        placeholder: const Text('unit_class'),
      ),
    );
    final rankInput = FormItem(
      label: '稀有程度',
      child: ShadSelect<int>(
        controller: viewModel.rankController,
        options: kRankOptions.toShadOptions(),
        selectedOptionBuilder: (context, value) => Text(kRankOptions[value] ?? ''),
        placeholder: const Text('rank'),
      ),
    );
    final racialLeaderInput = FormItem(
      label: '种族领袖',
      child: ShadSelect<int>(
        controller: viewModel.racialLeaderController,
        options: kBooleanOptions.toShadOptions(),
        selectedOptionBuilder: (context, value) => Text(kBooleanOptions[value] ?? ''),
        placeholder: const Text('RacialLeader'),
      ),
    );
    final factionInput = FormItem(
      label: '阵营',
      child: FactionTemplateSelector(
        controller: viewModel.factionController,
        placeholder: 'faction',
      ),
    );
    final familyInput = FormItem(
      controller: viewModel.familyController,
      label: '族群',
      placeholder: 'family',
    );
    final typeInput = FormItem(
      label: '类型',
      child: ShadSelect<int>(
        controller: viewModel.typeController,
        options: kCreatureTypeOptions.toShadOptions(),
        selectedOptionBuilder: (context, value) => Text(kCreatureTypeOptions[value] ?? ''),
        placeholder: const Text('type'),
      ),
    );
    final regenerateHealthInput = FormItem(
      label: '回复生命',
      child: ShadSelect<int>(
        controller: viewModel.regenerateHealthController,
        options: kBooleanOptions.toShadOptions(),
        selectedOptionBuilder: (context, value) => Text(kBooleanOptions[value] ?? ''),
        placeholder: const Text('RegenHealth'),
      ),
    );
    final petSpellDataIdInput = FormItem(
      controller: viewModel.petSpellDataIdController,
      label: '宠物技能',
      placeholder: 'PetSpellDataId',
    );
    final vehicleIdInput = FormItem(
      controller: viewModel.vehicleIdController,
      label: '载具',
      placeholder: 'VehicleId',
    );
    final gossipMenuIdInput = FormItem(
      label: '对话',
      child: GossipMenuSelector(
        controller: viewModel.gossipMenuIdController,
        placeholder: 'gossip_menu_id',
      ),
    );

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
      Row(
        spacing: 8,
        children: [
          Expanded(child: racialLeaderInput),
          Expanded(child: factionInput),
          Expanded(child: familyInput),
          Expanded(child: typeInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: regenerateHealthInput),
          Expanded(child: petSpellDataIdInput),
          Expanded(child: vehicleIdInput),
          Expanded(child: gossipMenuIdInput),
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

    final flagRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: npcFlagInput),
          Expanded(child: typeFlagInput),
          Expanded(child: dynamicFlagInput),
          Expanded(child: extraFlagInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: unitFlagInput),
          Expanded(child: unitFlag2Input),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// Immune
    final mechanicImmuneMaskInput = FormItem(
      label: '免疫机制',
      child: FlagPicker(
        controller: viewModel.mechanicImmuneMaskController,
        flags: kMechanicImmuneMaskOptions,
        title: '免疫机制',
        placeholder: 'mechanic_immune_mask',
      ),
    );
    final spellSchoolImmuneMaskInput = FormItem(
      label: '免疫法术类型',
      child: FlagPicker(
        controller: viewModel.spellSchoolImmuneMaskController,
        flags: kSpellSchoolImmuneMaskOptions,
        title: '免疫法术类型',
        placeholder: 'spell_school_immune_mask',
      ),
    );

    final immuneRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: mechanicImmuneMaskInput),
          Expanded(child: spellSchoolImmuneMaskInput),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// Modifier
    final expInput = FormItem(
      label: '属性扩展',
      child: ShadSelect<int>(
        controller: viewModel.expController,
        options: kExpansionOptions.toShadOptions(),
        selectedOptionBuilder: (context, value) => Text(kExpansionOptions[value] ?? ''),
        placeholder: const Text('exp'),
      ),
    );
    final damageSchoolInput = FormItem(
      label: '伤害类型',
      child: ShadSelect<int>(
        controller: viewModel.damageSchoolController,
        options: kDamageSchoolOptions.toShadOptions(),
        selectedOptionBuilder: (context, value) => Text(kDamageSchoolOptions[value] ?? ''),
        placeholder: const Text('dmgschool'),
      ),
    );
    final damageModifierInput = FormItem(
      controller: viewModel.damageModifierController,
      label: '伤害系数',
      placeholder: 'dmgschool',
    );
    final armorModifierInput = FormItem(
      controller: viewModel.armorModifierController,
      label: '护甲系数',
      placeholder: 'ArmorModifier',
    );
    final baseAttackTimeInput = FormItem(
      controller: viewModel.baseAttackTimeController,
      label: '近战攻击间隔',
      placeholder: 'BaseAttackTime',
    );
    final baseVarianceInput = FormItem(
      controller: viewModel.baseVarianceController,
      label: '近战攻击方差',
      placeholder: 'BaseVariance',
    );
    final rangeAttackTimeInput = FormItem(
      controller: viewModel.rangeAttackTimeController,
      label: '远程攻击间隔',
      placeholder: 'RangeAttackTime',
    );
    final rangeVarianceInput = FormItem(
      controller: viewModel.rangeVarianceController,
      label: '远程攻击方差',
      placeholder: 'RangeVariance',
    );
    final healthModifierInput = FormItem(
      controller: viewModel.healthModifierController,
      label: '生命值系数',
      placeholder: 'HealthModifier',
    );
    final manaModifierInput = FormItem(
      controller: viewModel.manaModifierController,
      label: '法力值系数',
      placeholder: 'ManaModifier',
    );
    final experienceModifierInput = FormItem(
      controller: viewModel.experienceModifierController,
      label: '经验值系数',
      placeholder: 'ExperienceModifier',
    );
    final speedWalkInput = FormItem(
      controller: viewModel.speedWalkController,
      label: '行走速度',
      placeholder: 'speed_walk',
    );
    final speedRunInput = FormItem(
      controller: viewModel.speedRunController,
      label: '奔跑速度',
      placeholder: 'speed_run',
    );

    final modifierRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: expInput),
          Expanded(child: damageSchoolInput),
          Expanded(child: damageModifierInput),
          Expanded(child: armorModifierInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: baseAttackTimeInput),
          Expanded(child: baseVarianceInput),
          Expanded(child: rangeAttackTimeInput),
          Expanded(child: rangeVarianceInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: healthModifierInput),
          Expanded(child: manaModifierInput),
          Expanded(child: experienceModifierInput),
          Expanded(child: speedWalkInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: speedRunInput),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// Loot
    final minGoldInput = FormItem(
      controller: viewModel.minGoldController,
      label: '最小金钱掉落',
      placeholder: 'mingold',
    );
    final maxGoldInput = FormItem(
      controller: viewModel.maxGoldController,
      label: '最大金钱掉落',
      placeholder: 'maxgold',
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
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// Difficulty
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

    final difficultyRows = [
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
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// Model
    final modelId1Input = FormItem(
      controller: viewModel.modelId1Controller,
      label: '模型1',
      placeholder: 'modelid4',
    );
    final modelId2Input = FormItem(
      controller: viewModel.modelId2Controller,
      label: '模型2',
      placeholder: 'modelid2',
    );
    final modelId3Input = FormItem(
      controller: viewModel.modelId3Controller,
      label: '模型3',
      placeholder: 'modelid3',
    );
    final modelId4Input = FormItem(
      controller: viewModel.modelId4Controller,
      label: '模型4',
      placeholder: 'modelid4',
    );
    final scaleInput = FormItem(
      controller: viewModel.scaleController,
      label: '缩放',
      placeholder: 'scale',
    );

    final modelRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: modelId1Input),
          Expanded(child: modelId2Input),
          Expanded(child: modelId3Input),
          Expanded(child: modelId4Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: scaleInput),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// Movement
    final movementIdInput = FormItem(
      controller: viewModel.movementIdController,
      label: '移动',
      placeholder: 'movementId',
    );
    final movementTypeInput = FormItem(
      label: '移动类型',
      child: ShadSelect<int>(
        controller: viewModel.movementTypeController,
        options: kMovementTypeOptions.toShadOptions(),
        selectedOptionBuilder: (context, value) => Text(kMovementTypeOptions[value] ?? ''),
        placeholder: const Text('movementType'),
      ),
    );
    final hoverHeightInput = FormItem(
      controller: viewModel.hoverHeightController,
      label: '盘旋高度',
      placeholder: 'HoverHeight',
    );

    final movementRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: movementIdInput),
          Expanded(child: movementTypeInput),
          Expanded(child: hoverHeightInput),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// Other
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
      controller: viewModel.verifiedBuildController,
      label: 'VerifiedBuild',
      placeholder: 'VerifiedBuild',
    );

    final otherRows = [
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

    var tabs = [
      Text('生物模板'),
      Text('模板补充'),
      Text('击杀声望'),
      Text('抗性'),
      Text('技能'),
      Text('装备模板'),
      Text('任务物品'),
      Text('商人'),
      Text('训练师'),
      Text('击杀掉落'),
      Text('偷窃掉落'),
      Text('剥皮掉落'),
      Text('移动'),
    ];
    var tab = FoxyTab(tabs: tabs);
    final children = [
      Watch((_) => _Header(viewModel.template.value.name)),
      tab,
      SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text('基本信息'),
      ),
      SizedBox(height: 4),
      ShadCard(
        padding: EdgeInsets.all(16),
        child: Column(spacing: 8, children: basicRows),
      ),
      SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text('标识信息'),
      ),
      SizedBox(height: 4),
      ShadCard(
        padding: EdgeInsets.all(16),
        child: Column(spacing: 8, children: flagRows),
      ),
      SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text('免疫信息'),
      ),
      SizedBox(height: 4),
      ShadCard(
        padding: EdgeInsets.all(16),
        child: Column(spacing: 8, children: immuneRows),
      ),
      SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text('属性信息'),
      ),
      SizedBox(height: 4),
      ShadCard(
        padding: EdgeInsets.all(16),
        child: Column(spacing: 8, children: modifierRows),
      ),
      SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text('掉落信息'),
      ),
      SizedBox(height: 4),
      ShadCard(
        padding: EdgeInsets.all(16),
        child: Column(spacing: 8, children: lootRows),
      ),
      SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text('难度信息'),
      ),
      SizedBox(height: 4),
      ShadCard(
        padding: EdgeInsets.all(16),
        child: Column(spacing: 8, children: difficultyRows),
      ),
      SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text('模型信息'),
      ),
      SizedBox(height: 4),
      ShadCard(
        padding: EdgeInsets.all(16),
        child: Column(spacing: 8, children: modelRows),
      ),
      SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text('移动信息'),
      ),
      SizedBox(height: 4),
      ShadCard(
        padding: EdgeInsets.all(16),
        child: Column(spacing: 8, children: movementRows),
      ),
      SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text('其他信息'),
      ),
      SizedBox(height: 4),
      ShadCard(
        padding: EdgeInsets.all(16),
        child: Column(spacing: 8, children: otherRows),
      ),
      SizedBox(height: 72),
    ];
    var listView = ListView(
      padding: const EdgeInsets.all(16),
      children: children,
    );
    var positioned = Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: _Footer(onTap: () {}),
    );
    return Stack(children: [listView, positioned]);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}

class _Footer extends StatelessWidget {
  final void Function()? onTap;
  const _Footer({this.onTap});

  @override
  Widget build(BuildContext context) {
    final cancelButton = ShadButton.ghost(
      onPressed: () => handlePressed(context),
      child: Text('取消'),
    );
    final children = [
      ShadButton(onPressed: onTap, child: Text('保存')),
      const SizedBox(width: 8),
      cancelButton,
    ];
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final surface = colorScheme.surface;
    final outline = colorScheme.outline;
    var boxDecoration = BoxDecoration(
      border: Border(top: BorderSide(color: outline.withValues(alpha: 0.25))),
      color: surface,
    );
    return Container(
      decoration: boxDecoration,
      padding: const EdgeInsets.all(16.0),
      child: Row(children: children),
    );
  }

  void handlePressed(BuildContext context) {
    AutoRouter.of(context).maybePop();
  }
}

class _Header extends StatelessWidget {
  final String title;
  const _Header(this.title);

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.only(bottom: 12);
    final text = title.isNotEmpty ? title : '新建生物';
    return Padding(padding: edgeInsets, child: FoxyHeader(text));
  }
}
