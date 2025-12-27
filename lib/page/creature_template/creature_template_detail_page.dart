import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/creature_template_detail_view_model.dart';
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
    final entryInput = _Input(
      controller: viewModel.entryController,
      label: '编号',
      placeholder: 'entry',
      readOnly: true,
    );
    final nameInput = _Input(
      controller: viewModel.nameController,
      label: '名称',
      placeholder: 'name',
    );
    final subNameInput = _Input(
      controller: viewModel.subNameController,
      label: '称号',
      placeholder: 'subname',
    );
    final iconNameInput = _Input(
      controller: viewModel.iconNameController,
      label: '鼠标形状',
      placeholder: 'IconName',
    );
    final minLevelInput = _Input(
      controller: viewModel.minLevelController,
      label: '最低等级',
      placeholder: 'minlevel',
    );
    final maxLevelInput = _Input(
      controller: viewModel.maxLevelController,
      label: '最高等级',
      placeholder: 'maxlevel',
    );
    final uniClassInput = _Input(
      controller: viewModel.unitClassController,
      label: '职业',
      placeholder: 'unit_class',
    );
    final rankInput = _Input(
      controller: viewModel.rankController,
      label: '稀有程度',
      placeholder: 'unit_class',
    );
    final racialLeaderInput = _Input(
      controller: viewModel.racialLeaderController,
      label: '种族领袖',
      placeholder: 'RacialLeader',
    );
    final factionInput = _Input(
      controller: viewModel.factionController,
      label: '阵营',
      placeholder: 'faction',
    );
    final familyInput = _Input(
      controller: viewModel.familyController,
      label: '族群',
      placeholder: 'family',
    );
    final typeInput = _Input(
      controller: viewModel.typeController,
      label: '类型',
      placeholder: 'type',
    );
    final regenerateHealthInput = _Input(
      controller: viewModel.regenerateHealthController,
      label: '回复生命',
      placeholder: 'RegenHealth',
    );
    final petSpellDataIdInput = _Input(
      controller: viewModel.petSpellDataIdController,
      label: '宠物技能',
      placeholder: 'PetSpellDataId',
    );
    final vehicleIdInput = _Input(
      controller: viewModel.vehicleIdController,
      label: '载具',
      placeholder: 'VehicleId',
    );
    final gossipMenuIdInput = _Input(
      controller: viewModel.gossipMenuIdController,
      label: '对话',
      placeholder: 'gossip_menu_id',
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
    final npcFlagInput = _Input(
      controller: viewModel.npcFlagController,
      label: 'NPC标识',
      placeholder: 'npcflag',
    );
    final typeFlagInput = _Input(
      controller: viewModel.typeFlagController,
      label: '类型标识',
      placeholder: 'type_flags',
    );
    final dynamicFlagInput = _Input(
      controller: viewModel.dynamicFlagController,
      label: '动态标识',
      placeholder: 'dynamicflags',
    );
    final extraFlagInput = _Input(
      controller: viewModel.extraFlagController,
      label: '额外标识',
      placeholder: 'flags_extra',
    );
    final unitFlagInput = _Input(
      controller: viewModel.unitFlagController,
      label: '单位标识',
      placeholder: 'unit_flags',
    );
    final unitFlag2Input = _Input(
      controller: viewModel.unitFlag2Controller,
      label: '单位标识2',
      placeholder: 'unit_flags2',
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
    final mechanicImmuneMaskInput = _Input(
      controller: viewModel.mechanicImmuneMaskController,
      label: '免疫机制',
      placeholder: 'mechanic_immune_mask',
    );
    final spellSchoolImmuneMaskInput = _Input(
      controller: viewModel.spellSchoolImmuneMaskController,
      label: '免疫法术类型',
      placeholder: 'spell_school_immune_mask',
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
    final expInput = _Input(
      controller: viewModel.expController,
      label: '属性扩展',
      placeholder: 'exp',
    );
    final damageSchoolInput = _Input(
      controller: viewModel.damageSchoolController,
      label: '伤害类型',
      placeholder: 'dmgschool',
    );
    final damageModifierInput = _Input(
      controller: viewModel.damageModifierController,
      label: '伤害系数',
      placeholder: 'dmgschool',
    );
    final armorModifierInput = _Input(
      controller: viewModel.armorModifierController,
      label: '护甲系数',
      placeholder: 'ArmorModifier',
    );
    final baseAttackTimeInput = _Input(
      controller: viewModel.baseAttackTimeController,
      label: '近战攻击间隔',
      placeholder: 'BaseAttackTime',
    );
    final baseVarianceInput = _Input(
      controller: viewModel.baseVarianceController,
      label: '近战攻击方差',
      placeholder: 'BaseVariance',
    );
    final rangeAttackTimeInput = _Input(
      controller: viewModel.rangeAttackTimeController,
      label: '远程攻击间隔',
      placeholder: 'RangeAttackTime',
    );
    final rangeVarianceInput = _Input(
      controller: viewModel.rangeVarianceController,
      label: '远程攻击方差',
      placeholder: 'RangeVariance',
    );
    final healthModifierInput = _Input(
      controller: viewModel.healthModifierController,
      label: '生命值系数',
      placeholder: 'HealthModifier',
    );
    final manaModifierInput = _Input(
      controller: viewModel.manaModifierController,
      label: '法力值系数',
      placeholder: 'ManaModifier',
    );
    final experienceModifierInput = _Input(
      controller: viewModel.experienceModifierController,
      label: '经验值系数',
      placeholder: 'ExperienceModifier',
    );
    final speedWalkInput = _Input(
      controller: viewModel.speedWalkController,
      label: '行走速度',
      placeholder: 'speed_walk',
    );
    final speedRunInput = _Input(
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
    final minGoldInput = _Input(
      controller: viewModel.minGoldController,
      label: '最小金钱掉落',
      placeholder: 'mingold',
    );
    final maxGoldInput = _Input(
      controller: viewModel.maxGoldController,
      label: '最大金钱掉落',
      placeholder: 'maxgold',
    );
    final lootInput = _Input(
      controller: viewModel.lootController,
      label: '击杀掉落',
      placeholder: 'lootid',
    );
    final pickpocketLootInput = _Input(
      controller: viewModel.pickpocketLootController,
      label: '偷窃掉落',
      placeholder: 'pickpocketloot',
    );
    final skinLootInput = _Input(
      controller: viewModel.skinLootController,
      label: '剥皮掉落',
      placeholder: 'skinloot',
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
    final killCredit1Input = _Input(
      controller: viewModel.killCredit1Controller,
      label: '击杀关联1',
      placeholder: 'KillCredit1',
    );
    final killCredit2input = _Input(
      controller: viewModel.killCredit2Controller,
      label: '击杀关联2',
      placeholder: 'KillCredit2',
    );
    final difficultyEntry1Input = _Input(
      controller: viewModel.difficultyEntry1Controller,
      label: '难度1',
      placeholder: 'difficulty_entry_2',
    );
    final difficultyEntry2Input = _Input(
      controller: viewModel.difficultyEntry2Controller,
      label: '难度2',
      placeholder: 'difficulty_entry_2',
    );
    final difficultyEntry3Input = _Input(
      controller: viewModel.difficultyEntry3Controller,
      label: '难度3',
      placeholder: 'difficulty_entry_3',
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
    final modelId1Input = _Input(
      controller: viewModel.modelId1Controller,
      label: '模型1',
      placeholder: 'modelid4',
    );
    final modelId2Input = _Input(
      controller: viewModel.modelId2Controller,
      label: '模型2',
      placeholder: 'modelid2',
    );
    final modelId3Input = _Input(
      controller: viewModel.modelId3Controller,
      label: '模型3',
      placeholder: 'modelid3',
    );
    final modelId4Input = _Input(
      controller: viewModel.modelId4Controller,
      label: '模型4',
      placeholder: 'modelid4',
    );
    final scaleInput = _Input(
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
    final movementIdInput = _Input(
      controller: viewModel.movementIdController,
      label: '移动',
      placeholder: 'movementId',
    );
    final movementTypeInput = _Input(
      controller: viewModel.movementTypeController,
      label: '移动类型',
      placeholder: 'movementType',
    );
    final hoverHeightInput = _Input(
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
    final aiNameInput = _Input(
      controller: viewModel.aiNameController,
      label: 'AI',
      placeholder: 'AIName',
    );
    final scriptNameInput = _Input(
      controller: viewModel.scriptNameController,
      label: '脚本',
      placeholder: 'ScriptName',
    );
    final verifiedBuildInput = _Input(
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
      ShadCard(
        padding: EdgeInsets.all(16),
        description: Text('基本信息'),
        child: Column(spacing: 8, children: basicRows),
      ),
      SizedBox(height: 16),
      ShadCard(
        padding: EdgeInsets.all(16),
        description: Text('标识信息'),
        child: Column(spacing: 8, children: flagRows),
      ),
      SizedBox(height: 16),
      ShadCard(
        padding: EdgeInsets.all(16),
        description: Text('免疫信息'),
        child: Column(spacing: 8, children: immuneRows),
      ),
      SizedBox(height: 16),
      ShadCard(
        padding: EdgeInsets.all(16),
        description: Text('属性信息'),
        child: Column(spacing: 8, children: modifierRows),
      ),
      SizedBox(height: 16),
      ShadCard(
        padding: EdgeInsets.all(16),
        description: Text('掉落信息'),
        child: Column(spacing: 8, children: lootRows),
      ),
      SizedBox(height: 16),
      ShadCard(
        padding: EdgeInsets.all(16),
        description: Text('难度信息'),
        child: Column(spacing: 8, children: difficultyRows),
      ),
      SizedBox(height: 16),
      ShadCard(
        padding: EdgeInsets.all(16),
        description: Text('模型信息'),
        child: Column(spacing: 8, children: modelRows),
      ),
      SizedBox(height: 16),
      ShadCard(
        padding: EdgeInsets.all(16),
        description: Text('移动信息'),
        child: Column(spacing: 8, children: movementRows),
      ),
      SizedBox(height: 16),
      ShadCard(
        padding: EdgeInsets.all(16),
        description: Text('其他信息'),
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

class _Input extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? placeholder;
  final bool readOnly;
  const _Input({
    this.controller,
    this.label,
    this.placeholder,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final leading = _buildLeading();
    final input = ShadInput(
      controller: controller,
      placeholder: Text(placeholder ?? ''),
      readOnly: readOnly,
    );
    return Row(
      spacing: 16,
      children: [
        leading,
        Expanded(child: input),
      ],
    );
  }

  Widget _buildLeading() {
    if (label == null) return const SizedBox();
    if (label!.isEmpty) return const SizedBox();
    return SizedBox(width: 96, child: Text(label!, textAlign: TextAlign.end));
  }
}
