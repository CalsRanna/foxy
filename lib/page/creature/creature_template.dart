import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/model/creature_template.dart';
import 'package:foxy/provider/creature.dart';
import 'package:foxy/util/input_width_calculator.dart';
import 'package:foxy/widget/breadcrumb.dart';
import 'package:foxy/widget/header.dart';
import 'package:foxy/widget/input.dart';

@RoutePage()
class CreatureTemplatePage extends ConsumerStatefulWidget {
  final int? entry;
  const CreatureTemplatePage(this.entry, {super.key});

  @override
  ConsumerState<CreatureTemplatePage> createState() =>
      _CreatureTemplatePageState();
}

class _Breadcrumb extends StatelessWidget {
  final CreatureTemplate template;
  const _Breadcrumb({required this.template});

  @override
  Widget build(BuildContext context) {
    final children = [
      BreadcrumbItem(onTap: () {}, child: Text('首页')),
      BreadcrumbItem(onTap: () {}, child: Text('生物')),
      BreadcrumbItem(child: Text(template.name)),
    ];
    return Breadcrumb(children: children);
  }
}

class _CreatureTemplatePageState extends ConsumerState<CreatureTemplatePage> {
  /// Basic
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final subNameController = TextEditingController();
  final iconNameController = TextEditingController();
  final minLevelController = TextEditingController();
  final maxLevelController = TextEditingController();
  final unitClassController = TextEditingController();
  final rankController = TextEditingController();
  final racialLeaderController = TextEditingController();
  final factionController = TextEditingController();
  final familyController = TextEditingController();
  final typeController = TextEditingController();
  final regenerateHealthController = TextEditingController();
  final petSpellDataIdController = TextEditingController();
  final vehicleIdController = TextEditingController();
  final gossipMenuIdController = TextEditingController();

  /// Flag
  final npcFlagController = TextEditingController();
  final typeFlagController = TextEditingController();
  final dynamicFlagController = TextEditingController();
  final extraFlagController = TextEditingController();
  final unitFlagController = TextEditingController();
  final unitFlag2Controller = TextEditingController();

  /// Immune
  final mechanicImmuneMaskController = TextEditingController();
  final spellSchoolImmuneMaskController = TextEditingController();

  /// Modifier
  final expController = TextEditingController();
  final damageSchoolController = TextEditingController();
  final damageModifierController = TextEditingController();
  final armorModifierController = TextEditingController();
  final baseAttackTimeController = TextEditingController();
  final baseVarianceController = TextEditingController();
  final rangeAttackTimeController = TextEditingController();
  final rangeVarianceController = TextEditingController();
  final healthModifierController = TextEditingController();
  final manaModifierController = TextEditingController();
  final experienceModifierController = TextEditingController();
  final speedWalkController = TextEditingController();
  final speedRunController = TextEditingController();

  /// Loot
  final minGoldController = TextEditingController();
  final maxGoldController = TextEditingController();
  final lootController = TextEditingController();
  final pickpocketLootController = TextEditingController();
  final skinLootController = TextEditingController();

  /// Difficulty
  final killCredit1Controller = TextEditingController();
  final killCredit2Controller = TextEditingController();
  final difficultyEntry1Controller = TextEditingController();
  final difficultyEntry2Controller = TextEditingController();
  final difficultyEntry3Controller = TextEditingController();

  /// Model
  final modelId1Controller = TextEditingController();
  final modelId2Controller = TextEditingController();
  final modelId3Controller = TextEditingController();
  final modelId4Controller = TextEditingController();
  final scaleController = TextEditingController();

  /// Movement
  final movementIdController = TextEditingController();
  final movementTypeController = TextEditingController();
  final hoverHeightController = TextEditingController();

  /// Other
  final aiNameController = TextEditingController();
  final scriptNameController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = creatureTemplateNotifierProvider(widget.entry);
    final state = ref.watch(provider);
    return switch (state) {
      AsyncData(:final value) => _buildData(ref, value),
      AsyncError(:final error) => Text(error.toString()),
      AsyncLoading() => CircularProgressIndicator.adaptive(),
      _ => SizedBox(),
    };
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void handleTap(WidgetRef ref) {}

  Widget _buildData(WidgetRef ref, CreatureTemplate template) {
    _initControllers(template);
    final width = InputWidthCalculator(context).calculate();
    const edgeInsets = EdgeInsets.symmetric(vertical: 16.0);

    /// Basic
    final entryInput = _Input(
      controller: entryController,
      label: '编号',
      placeholder: 'entry',
    );
    final nameInput = _Input(
      controller: nameController,
      label: '名称',
      placeholder: 'name',
    );
    final subNameInput = _Input(
      controller: subNameController,
      label: '称号',
      placeholder: 'subname',
    );
    final iconNameInput = _Input(
      controller: subNameController,
      label: '鼠标形状',
      placeholder: 'IconName',
    );
    final minLevelInput = _Input(
      controller: minLevelController,
      label: '最低等级',
      placeholder: 'minlevel',
    );
    final maxLevelInput = _Input(
      controller: maxLevelController,
      label: '最高等级',
      placeholder: 'maxlevel',
    );
    final uniClassInput = _Input(
      controller: unitClassController,
      label: '职业',
      placeholder: 'unit_class',
    );
    final rankInput = _Input(
      controller: rankController,
      label: '稀有程度',
      placeholder: 'unit_class',
    );
    final racialLeaderInput = _Input(
      controller: rankController,
      label: '种族领袖',
      placeholder: 'RacialLeader',
    );
    final factionInput = _Input(
      controller: factionController,
      label: '阵营',
      placeholder: 'faction',
    );
    final familyInput = _Input(
      controller: familyController,
      label: '族群',
      placeholder: 'family',
    );
    final typeInput = _Input(
      controller: typeController,
      label: '类型',
      placeholder: 'type',
    );
    final regenerateHealthInput = _Input(
      controller: regenerateHealthController,
      label: '回复生命',
      placeholder: 'RegenHealth',
    );
    final petSpellDataIdInput = _Input(
      controller: petSpellDataIdController,
      label: '宠物技能',
      placeholder: 'PetSpellDataId',
    );
    final vehicleIdInput = _Input(
      controller: vehicleIdController,
      label: '载具',
      placeholder: 'VehicleId',
    );
    final gossipMenuIdInput = _Input(
      controller: gossipMenuIdController,
      label: '对话',
      placeholder: 'gossip_menu_id',
    );
    final basicChildren = [
      SizedBox(width: width, child: entryInput),
      SizedBox(width: width, child: nameInput),
      SizedBox(width: width, child: subNameInput),
      SizedBox(width: width, child: iconNameInput),
      SizedBox(width: width, child: minLevelInput),
      SizedBox(width: width, child: maxLevelInput),
      SizedBox(width: width, child: uniClassInput),
      SizedBox(width: width, child: rankInput),
      SizedBox(width: width, child: racialLeaderInput),
      SizedBox(width: width, child: factionInput),
      SizedBox(width: width, child: familyInput),
      SizedBox(width: width, child: typeInput),
      SizedBox(width: width, child: regenerateHealthInput),
      SizedBox(width: width, child: petSpellDataIdInput),
      SizedBox(width: width, child: vehicleIdInput),
      SizedBox(width: width, child: gossipMenuIdInput),
    ];
    final basicWrap = Wrap(runSpacing: 8, spacing: 8, children: basicChildren);
    final basicPadding = Padding(padding: edgeInsets, child: basicWrap);

    /// Flag
    final npcFlagInput = _Input(
      controller: npcFlagController,
      label: 'NPC标识',
      placeholder: 'npcflag',
    );
    final typeFlagInput = _Input(
      controller: npcFlagController,
      label: '类型标识',
      placeholder: 'type_flags',
    );
    final dynamicFlagInput = _Input(
      controller: dynamicFlagController,
      label: '动态标识',
      placeholder: 'dynamicflags',
    );
    final extraFlagInput = _Input(
      controller: extraFlagController,
      label: '额外标识',
      placeholder: 'flags_extra',
    );
    final unitFlagInput = _Input(
      controller: unitFlagController,
      label: '单位标识',
      placeholder: 'unit_flags',
    );
    final unitFlag2Input = _Input(
      controller: unitFlag2Controller,
      label: '单位标识2',
      placeholder: 'unit_flags2',
    );
    final flagChildren = [
      SizedBox(width: width, child: npcFlagInput),
      SizedBox(width: width, child: typeFlagInput),
      SizedBox(width: width, child: dynamicFlagInput),
      SizedBox(width: width, child: extraFlagInput),
      SizedBox(width: width, child: unitFlagInput),
      SizedBox(width: width, child: unitFlag2Input),
    ];
    final flagWrap = Wrap(runSpacing: 8, spacing: 8, children: flagChildren);
    final flagPadding = Padding(padding: edgeInsets, child: flagWrap);

    /// Immune
    final mechanicImmuneMaskInput = _Input(
      controller: mechanicImmuneMaskController,
      label: '免疫机制',
      placeholder: 'mechanic_immune_mask',
    );
    final spellSchoolImmuneMaskInput = _Input(
      controller: spellSchoolImmuneMaskController,
      label: '免疫法术类型',
      placeholder: 'spell_school_immune_mask',
    );
    final immuneChildren = [
      SizedBox(width: width, child: mechanicImmuneMaskInput),
      SizedBox(width: width, child: spellSchoolImmuneMaskInput),
    ];
    final immuneWrap = Wrap(
      runSpacing: 8,
      spacing: 8,
      children: immuneChildren,
    );
    final immunePadding = Padding(padding: edgeInsets, child: immuneWrap);

    /// Modifier
    final expInput = _Input(
      controller: expController,
      label: '属性扩展',
      placeholder: 'exp',
    );
    final damageSchoolInput = _Input(
      controller: damageSchoolController,
      label: '伤害类型',
      placeholder: 'dmgschool',
    );
    final damageModifierInput = _Input(
      controller: damageModifierController,
      label: '伤害系数',
      placeholder: 'dmgschool',
    );
    final armorModifierInput = _Input(
      controller: armorModifierController,
      label: '护甲系数',
      placeholder: 'ArmorModifier',
    );
    final baseAttackTimeInput = _Input(
      controller: baseAttackTimeController,
      label: '近战攻击间隔',
      placeholder: 'BaseAttackTime',
    );
    final baseVarianceInput = _Input(
      controller: baseVarianceController,
      label: '近战攻击方差',
      placeholder: 'BaseVariance',
    );
    final rangeAttackTimeInput = _Input(
      controller: rangeAttackTimeController,
      label: '远程攻击间隔',
      placeholder: 'RangeAttackTime',
    );
    final rangeVarianceInput = _Input(
      controller: rangeVarianceController,
      label: '远程攻击方差',
      placeholder: 'RangeVariance',
    );
    final healthModifierInput = _Input(
      controller: healthModifierController,
      label: '生命值系数',
      placeholder: 'HealthModifier',
    );
    final manaModifierInput = _Input(
      controller: manaModifierController,
      label: '法力值系数',
      placeholder: 'ManaModifier',
    );
    final experienceModifierInput = _Input(
      controller: experienceModifierController,
      label: '经验值系数',
      placeholder: 'ExperienceModifier',
    );
    final speedWalkInput = _Input(
      controller: speedWalkController,
      label: '行走速度',
      placeholder: 'speed_walk',
    );
    final speedRunInput = _Input(
      controller: speedRunController,
      label: '奔跑速度',
      placeholder: 'speed_run',
    );
    final modifierChildren = [
      SizedBox(width: width, child: expInput),
      SizedBox(width: width, child: damageSchoolInput),
      SizedBox(width: width, child: damageModifierInput),
      SizedBox(width: width, child: armorModifierInput),
      SizedBox(width: width, child: baseAttackTimeInput),
      SizedBox(width: width, child: baseVarianceInput),
      SizedBox(width: width, child: rangeAttackTimeInput),
      SizedBox(width: width, child: rangeVarianceInput),
      SizedBox(width: width, child: healthModifierInput),
      SizedBox(width: width, child: manaModifierInput),
      SizedBox(width: width, child: experienceModifierInput),
      SizedBox(width: width, child: speedWalkInput),
      SizedBox(width: width, child: speedRunInput),
    ];
    final modifierWrap = Wrap(
      runSpacing: 8,
      spacing: 8,
      children: modifierChildren,
    );
    final modifierPadding = Padding(padding: edgeInsets, child: modifierWrap);

    /// Loot
    final minGoldInput = _Input(
      controller: minGoldController,
      label: '最小金钱掉落',
      placeholder: 'mingold',
    );
    final maxGoldInput = _Input(
      controller: maxGoldController,
      label: '最大金钱掉落',
      placeholder: 'maxgold',
    );
    final lootInput = _Input(
      controller: lootController,
      label: '击杀掉落',
      placeholder: 'lootid',
    );
    final pickpocketLootInput = _Input(
      controller: pickpocketLootController,
      label: '偷窃掉落',
      placeholder: 'pickpocketloot',
    );
    final skinLootInput = _Input(
      controller: skinLootController,
      label: '剥皮掉落',
      placeholder: 'skinloot',
    );
    final lootChildren = [
      SizedBox(width: width, child: minGoldInput),
      SizedBox(width: width, child: maxGoldInput),
      SizedBox(width: width, child: lootInput),
      SizedBox(width: width, child: pickpocketLootInput),
      SizedBox(width: width, child: skinLootInput),
    ];
    final lootWrap = Wrap(runSpacing: 8, spacing: 8, children: lootChildren);
    final lootPadding = Padding(padding: edgeInsets, child: lootWrap);

    /// Difficulty
    final killCredit1Input = _Input(
      controller: killCredit1Controller,
      label: '击杀关联1',
      placeholder: 'KillCredit1',
    );
    final killCredit2input = _Input(
      controller: killCredit2Controller,
      label: '击杀关联2',
      placeholder: 'KillCredit2',
    );
    final difficultyEntry1Input = _Input(
      controller: difficultyEntry1Controller,
      label: '难度1',
      placeholder: 'difficulty_entry_2',
    );
    final difficultyEntry2Input = _Input(
      controller: difficultyEntry2Controller,
      label: '难度2',
      placeholder: 'difficulty_entry_2',
    );
    final difficultyEntry3Input = _Input(
      controller: difficultyEntry3Controller,
      label: '难度3',
      placeholder: 'difficulty_entry_3',
    );
    final difficultyChildren = [
      SizedBox(width: width, child: killCredit1Input),
      SizedBox(width: width, child: killCredit2input),
      SizedBox(width: width, child: difficultyEntry1Input),
      SizedBox(width: width, child: difficultyEntry2Input),
      SizedBox(width: width, child: difficultyEntry3Input),
    ];
    final difficultyWrap = Wrap(
      runSpacing: 8,
      spacing: 8,
      children: difficultyChildren,
    );
    final difficultyPadding = Padding(
      padding: edgeInsets,
      child: difficultyWrap,
    );

    /// Model
    final modelId1Input = _Input(
      controller: modelId1Controller,
      label: '模型1',
      placeholder: 'modelid4',
    );
    final modelId2Input = _Input(
      controller: modelId2Controller,
      label: '模型2',
      placeholder: 'modelid2',
    );
    final modelId3Input = _Input(
      controller: modelId3Controller,
      label: '模型3',
      placeholder: 'modelid3',
    );
    final modelId4Input = _Input(
      controller: modelId4Controller,
      label: '模型4',
      placeholder: 'modelid4',
    );
    final scaleInput = _Input(
      controller: scaleController,
      label: '缩放',
      placeholder: 'scale',
    );
    final modelChildren = [
      SizedBox(width: width, child: modelId1Input),
      SizedBox(width: width, child: modelId2Input),
      SizedBox(width: width, child: modelId3Input),
      SizedBox(width: width, child: modelId4Input),
      SizedBox(width: width, child: scaleInput),
    ];
    final modelWrap = Wrap(runSpacing: 8, spacing: 8, children: modelChildren);
    final modelPadding = Padding(padding: edgeInsets, child: modelWrap);

    /// Movement
    final movementIdInput = _Input(
      controller: movementIdController,
      label: '移动',
      placeholder: 'movementId',
    );
    final movementTypeInput = _Input(
      controller: movementTypeController,
      label: '移动类型',
      placeholder: 'movementType',
    );
    final hoverHeightInput = _Input(
      controller: hoverHeightController,
      label: '盘旋高度',
      placeholder: 'HoverHeight',
    );
    final movementChildren = [
      SizedBox(width: width, child: movementIdInput),
      SizedBox(width: width, child: movementTypeInput),
      SizedBox(width: width, child: hoverHeightInput),
    ];
    final movementWrap = Wrap(
      runSpacing: 8,
      spacing: 8,
      children: movementChildren,
    );
    final movementPadding = Padding(padding: edgeInsets, child: movementWrap);

    /// Other
    final aiNameInput = _Input(
      controller: aiNameController,
      label: 'AI',
      placeholder: 'AIName',
    );
    final scriptNameInput = _Input(
      controller: scriptNameController,
      label: '脚本',
      placeholder: 'ScriptName',
    );
    final verifiedBuildInput = _Input(
      controller: verifiedBuildController,
      label: 'VerifiedBuild',
      placeholder: 'VerifiedBuild',
    );
    final otherChildren = [
      SizedBox(width: width, child: aiNameInput),
      SizedBox(width: width, child: scriptNameInput),
      SizedBox(width: width, child: verifiedBuildInput),
    ];
    final otherWrap = Wrap(runSpacing: 8, spacing: 8, children: otherChildren);
    final otherPadding = Padding(padding: edgeInsets, child: otherWrap);

    final children = [
      _Breadcrumb(template: template),
      _Header(template.name),
      Card(child: basicPadding),
      Card(child: flagPadding),
      Card(child: immunePadding),
      Card(child: modifierPadding),
      Card(child: lootPadding),
      Card(child: difficultyPadding),
      Card(child: modelPadding),
      Card(child: movementPadding),
      Card(child: otherPadding),
      _Footer(onTap: () => handleTap(ref)),
    ];
    return ListView(padding: const EdgeInsets.all(16), children: children);
  }

  void _disposeControllers() {
    /// Basic
    entryController.dispose();
    nameController.dispose();
    subNameController.dispose();
    iconNameController.dispose();
    minLevelController.dispose();
    maxLevelController.dispose();
    unitClassController.dispose();
    rankController.dispose();
    racialLeaderController.dispose();
    factionController.dispose();
    familyController.dispose();
    typeController.dispose();
    regenerateHealthController.dispose();
    petSpellDataIdController.dispose();
    vehicleIdController.dispose();
    gossipMenuIdController.dispose();

    /// Flag
    npcFlagController.dispose();
    typeFlagController.dispose();
    dynamicFlagController.dispose();
    extraFlagController.dispose();
    unitFlagController.dispose();
    unitFlag2Controller.dispose();

    /// Immune
    mechanicImmuneMaskController.dispose();
    spellSchoolImmuneMaskController.dispose();

    /// Modifier
    expController.dispose();
    damageSchoolController.dispose();
    damageModifierController.dispose();
    armorModifierController.dispose();
    baseAttackTimeController.dispose();
    baseVarianceController.dispose();
    rangeAttackTimeController.dispose();
    rangeVarianceController.dispose();
    healthModifierController.dispose();
    manaModifierController.dispose();
    experienceModifierController.dispose();
    speedWalkController.dispose();
    speedRunController.dispose();

    /// Loot
    minGoldController.dispose();
    maxGoldController.dispose();
    lootController.dispose();
    pickpocketLootController.dispose();
    skinLootController.dispose();

    /// Difficulty
    killCredit1Controller.dispose();
    killCredit2Controller.dispose();
    difficultyEntry1Controller.dispose();
    difficultyEntry2Controller.dispose();
    difficultyEntry3Controller.dispose();

    /// Model
    modelId1Controller.dispose();
    modelId2Controller.dispose();
    modelId3Controller.dispose();
    modelId4Controller.dispose();
    scaleController.dispose();

    /// Movement
    movementIdController.dispose();
    movementTypeController.dispose();
    hoverHeightController.dispose();

    /// Other
    aiNameController.dispose();
    scriptNameController.dispose();
    verifiedBuildController.dispose();
  }

  void _initControllers(CreatureTemplate template) {
    /// Basic
    entryController.text = template.entry.toString();
    nameController.text = template.name;
    subNameController.text = template.subname;
    iconNameController.text = template.iconName;
    minLevelController.text = template.minlevel.toString();
    maxLevelController.text = template.maxlevel.toString();
    unitClassController.text = template.unitClass.toString();
    rankController.text = template.rank.toString();
    racialLeaderController.text = template.racialLeader.toString();
    factionController.text = template.faction.toString();
    familyController.text = template.family.toString();
    typeController.text = template.type.toString();
    regenerateHealthController.text = template.regenHealth.toString();
    petSpellDataIdController.text = template.petSpellDataId.toString();
    vehicleIdController.text = template.vehicleId.toString();
    gossipMenuIdController.text = template.gossipMenuId.toString();

    /// Flag
    npcFlagController.text = template.npcflag.toString();
    typeFlagController.text = template.typeFlags.toString();
    dynamicFlagController.text = template.dynamicflags.toString();
    extraFlagController.text = template.flagsExtra.toString();
    unitFlagController.text = template.unitFlags.toString();
    unitFlag2Controller.text = template.unitFlags2.toString();

    /// Immune
    mechanicImmuneMaskController.text = template.mechanicImmuneMask.toString();
    spellSchoolImmuneMaskController.text =
        template.spellSchoolImmuneMask.toString();

    /// Modifier
    expController.text = template.exp.toString();
    damageSchoolController.text = template.dmgschool.toString();
    damageModifierController.text = template.damageModifier.toString();
    armorModifierController.text = template.armorModifier.toString();
    baseAttackTimeController.text = template.baseAttackTime.toString();
    baseVarianceController.text = template.baseVariance.toString();
    rangeAttackTimeController.text = template.rangeAttackTime.toString();
    rangeVarianceController.text = template.rangeVariance.toString();
    healthModifierController.text = template.healthModifier.toString();
    manaModifierController.text = template.manaModifier.toString();
    experienceModifierController.text = template.experienceModifier.toString();
    speedWalkController.text = template.speedWalk.toString();
    speedRunController.text = template.speedRun.toString();

    /// Loot
    minGoldController.text = template.mingold.toString();
    maxGoldController.text = template.maxgold.toString();
    lootController.text = template.lootid.toString();
    pickpocketLootController.text = template.pickpocketloot.toString();
    skinLootController.text = template.skinloot.toString();

    /// Difficulty
    killCredit1Controller.text = template.killCredit1.toString();
    killCredit2Controller.text = template.killCredit2.toString();
    difficultyEntry1Controller.text = template.difficultyEntry1.toString();
    difficultyEntry2Controller.text = template.difficultyEntry2.toString();
    difficultyEntry3Controller.text = template.difficultyEntry3.toString();

    /// Model
    modelId1Controller.text = template.modelid1.toString();
    modelId2Controller.text = template.modelid2.toString();
    modelId3Controller.text = template.modelid3.toString();
    modelId4Controller.text = template.modelid4.toString();
    scaleController.text = template.scale.toString();

    ///Movement
    movementIdController.text = template.movementId.toString();
    movementTypeController.text = template.movementType.toString();
    hoverHeightController.text = template.hoverHeight.toString();

    /// Other
    aiNameController.text = template.aiName;
    scriptNameController.text = template.scriptName;
    verifiedBuildController.text = template.verifiedBuild.toString();
  }
}

class _Footer extends StatelessWidget {
  final void Function()? onTap;
  const _Footer({this.onTap});

  @override
  Widget build(BuildContext context) {
    final cancelButton = TextButton(
      onPressed: () => handlePressed(context),
      child: Text('取消'),
    );
    final children = [
      FilledButton(onPressed: onTap, child: Text('保存')),
      const SizedBox(width: 8),
      cancelButton,
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
    const edgeInsets = EdgeInsets.symmetric(vertical: 12);
    return Padding(padding: edgeInsets, child: Header(title));
  }
}

class _Input extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? placeholder;
  const _Input({this.controller, this.label, this.placeholder});

  @override
  Widget build(BuildContext context) {
    final leading = _buildLeading();
    final input = FoxyInput(controller: controller, placeholder: placeholder);
    return Row(children: [leading, Expanded(child: input)]);
  }

  Widget _buildLeading() {
    if (label == null) return const SizedBox();
    if (label!.isEmpty) return const SizedBox();
    return Container(
      padding: EdgeInsets.only(right: 16),
      width: 120,
      child: Text(label!, textAlign: TextAlign.end),
    );
  }
}
