import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestTemplateView extends StatefulWidget {
  final int questId;
  const QuestTemplateView({super.key, required this.questId});

  @override
  State<QuestTemplateView> createState() => _QuestTemplateViewState();
}

class _QuestTemplateViewState extends State<QuestTemplateView> {
  final viewModel = GetIt.instance.get<QuestTemplateDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(questId: widget.questId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = viewModel;
    final fields = Column(
      spacing: 8,
      children: [
        FormItem(
          controller: vm.idController,
          label: '编号',
          placeholder: 'ID',
          readOnly: true,
        ),
        FormItem(
          controller: vm.questTypeController,
          label: '任务类型',
          placeholder: 'QuestType',
        ),
        FormItem(
          controller: vm.questLevelController,
          label: '任务等级',
          placeholder: 'QuestLevel',
        ),
        FormItem(
          controller: vm.minLevelController,
          label: '最低等级',
          placeholder: 'MinLevel',
        ),
        FormItem(
          controller: vm.questSortIdController,
          label: '任务分类',
          placeholder: 'QuestSortID',
        ),
        FormItem(
          controller: vm.questInfoIdController,
          label: '任务信息',
          placeholder: 'QuestInfoID',
        ),
        FormItem(
          controller: vm.suggestedGroupNumController,
          label: '建议组人数',
          placeholder: 'SuggestedGroupNum',
        ),
        FormItem(
          controller: vm.requiredFactionId1Controller,
          label: '需要阵营1',
          placeholder: 'RequiredFactionId1',
        ),
        FormItem(
          controller: vm.requiredFactionId2Controller,
          label: '需要阵营2',
          placeholder: 'RequiredFactionId2',
        ),
        FormItem(
          controller: vm.requiredFactionValue1Controller,
          label: '阵营值1',
          placeholder: 'RequiredFactionValue1',
        ),
        FormItem(
          controller: vm.requiredFactionValue2Controller,
          label: '阵营值2',
          placeholder: 'RequiredFactionValue2',
        ),
        FormItem(
          controller: vm.rewardNextQuestController,
          label: '下一个任务',
          placeholder: 'RewardNextQuest',
        ),
        FormItem(
          controller: vm.rewardXpDifficultyController,
          label: '经验奖励难度',
          placeholder: 'RewardXPDifficulty',
        ),
        FormItem(
          controller: vm.rewardMoneyController,
          label: '金币奖励',
          placeholder: 'RewardMoney',
        ),
        FormItem(
          controller: vm.rewardMoneyDifficultyController,
          label: '金币奖励难度',
          placeholder: 'RewardMoneyDifficulty',
        ),
        FormItem(
          controller: vm.rewardDisplaySpellController,
          label: '展示法术奖励',
          placeholder: 'RewardDisplaySpell',
        ),
        FormItem(
          controller: vm.rewardSpellController,
          label: '法术奖励',
          placeholder: 'RewardSpell',
        ),
        FormItem(
          controller: vm.rewardHonorController,
          label: '荣誉奖励',
          placeholder: 'RewardHonor',
        ),
        FormItem(
          controller: vm.rewardKillHonorController,
          label: '杀敌荣誉',
          placeholder: 'RewardKillHonor',
        ),
        FormItem(
          controller: vm.startItemController,
          label: '起始物品',
          placeholder: 'StartItem',
        ),
        FormItem(
          controller: vm.flagsController,
          label: '标志',
          placeholder: 'Flags',
        ),
        FormItem(
          controller: vm.requiredPlayerKillsController,
          label: '需要玩家击杀',
          placeholder: 'RequiredPlayerKills',
        ),
        FormItem(
          controller: vm.rewardItem1Controller,
          label: '奖励物品1',
          placeholder: 'RewardItem1',
        ),
        FormItem(
          controller: vm.rewardAmount1Controller,
          label: '奖励数量1',
          placeholder: 'RewardAmount1',
        ),
        FormItem(
          controller: vm.rewardItem2Controller,
          label: '奖励物品2',
          placeholder: 'RewardItem2',
        ),
        FormItem(
          controller: vm.rewardAmount2Controller,
          label: '奖励数量2',
          placeholder: 'RewardAmount2',
        ),
        FormItem(
          controller: vm.rewardItem3Controller,
          label: '奖励物品3',
          placeholder: 'RewardItem3',
        ),
        FormItem(
          controller: vm.rewardAmount3Controller,
          label: '奖励数量3',
          placeholder: 'RewardAmount3',
        ),
        FormItem(
          controller: vm.rewardItem4Controller,
          label: '奖励物品4',
          placeholder: 'RewardItem4',
        ),
        FormItem(
          controller: vm.rewardAmount4Controller,
          label: '奖励数量4',
          placeholder: 'RewardAmount4',
        ),
        FormItem(
          controller: vm.itemDrop1Controller,
          label: '掉落物品1',
          placeholder: 'ItemDrop1',
        ),
        FormItem(
          controller: vm.itemDropQuantity1Controller,
          label: '掉落数量1',
          placeholder: 'ItemDropQuantity1',
        ),
        FormItem(
          controller: vm.itemDrop2Controller,
          label: '掉落物品2',
          placeholder: 'ItemDrop2',
        ),
        FormItem(
          controller: vm.itemDropQuantity2Controller,
          label: '掉落数量2',
          placeholder: 'ItemDropQuantity2',
        ),
        FormItem(
          controller: vm.itemDrop3Controller,
          label: '掉落物品3',
          placeholder: 'ItemDrop3',
        ),
        FormItem(
          controller: vm.itemDropQuantity3Controller,
          label: '掉落数量3',
          placeholder: 'ItemDropQuantity3',
        ),
        FormItem(
          controller: vm.itemDrop4Controller,
          label: '掉落物品4',
          placeholder: 'ItemDrop4',
        ),
        FormItem(
          controller: vm.itemDropQuantity4Controller,
          label: '掉落数量4',
          placeholder: 'ItemDropQuantity4',
        ),
        FormItem(
          controller: vm.rewardChoiceItemId1Controller,
          label: '选择奖励物品1',
          placeholder: 'RewardChoiceItemID1',
        ),
        FormItem(
          controller: vm.rewardChoiceItemQuantity1Controller,
          label: '选择奖励数量1',
          placeholder: 'RewardChoiceItemQuantity1',
        ),
        FormItem(
          controller: vm.rewardChoiceItemId2Controller,
          label: '选择奖励物品2',
          placeholder: 'RewardChoiceItemID2',
        ),
        FormItem(
          controller: vm.rewardChoiceItemQuantity2Controller,
          label: '选择奖励数量2',
          placeholder: 'RewardChoiceItemQuantity2',
        ),
        FormItem(
          controller: vm.rewardChoiceItemId3Controller,
          label: '选择奖励物品3',
          placeholder: 'RewardChoiceItemID3',
        ),
        FormItem(
          controller: vm.rewardChoiceItemQuantity3Controller,
          label: '选择奖励数量3',
          placeholder: 'RewardChoiceItemQuantity3',
        ),
        FormItem(
          controller: vm.rewardChoiceItemId4Controller,
          label: '选择奖励物品4',
          placeholder: 'RewardChoiceItemID4',
        ),
        FormItem(
          controller: vm.rewardChoiceItemQuantity4Controller,
          label: '选择奖励数量4',
          placeholder: 'RewardChoiceItemQuantity4',
        ),
        FormItem(
          controller: vm.rewardChoiceItemId5Controller,
          label: '选择奖励物品5',
          placeholder: 'RewardChoiceItemID5',
        ),
        FormItem(
          controller: vm.rewardChoiceItemQuantity5Controller,
          label: '选择奖励数量5',
          placeholder: 'RewardChoiceItemQuantity5',
        ),
        FormItem(
          controller: vm.rewardChoiceItemId6Controller,
          label: '选择奖励物品6',
          placeholder: 'RewardChoiceItemID6',
        ),
        FormItem(
          controller: vm.rewardChoiceItemQuantity6Controller,
          label: '选择奖励数量6',
          placeholder: 'RewardChoiceItemQuantity6',
        ),
        FormItem(
          controller: vm.poiContinentController,
          label: 'POI大陆',
          placeholder: 'POIContinent',
        ),
        FormItem(
          controller: vm.poiXController,
          label: 'POI X坐标',
          placeholder: 'POIx',
        ),
        FormItem(
          controller: vm.poiYController,
          label: 'POI Y坐标',
          placeholder: 'POIy',
        ),
        FormItem(
          controller: vm.poiPriorityController,
          label: 'POI优先级',
          placeholder: 'POIPriority',
        ),
        FormItem(
          controller: vm.rewardTitleController,
          label: '奖励头衔',
          placeholder: 'RewardTitle',
        ),
        FormItem(
          controller: vm.rewardTalentsController,
          label: '奖励天赋点',
          placeholder: 'RewardTalents',
        ),
        FormItem(
          controller: vm.rewardArenaPointsController,
          label: '奖励竞技场点数',
          placeholder: 'RewardArenaPoints',
        ),
        FormItem(
          controller: vm.rewardFactionId1Controller,
          label: '奖励声望阵营1',
          placeholder: 'RewardFactionID1',
        ),
        FormItem(
          controller: vm.rewardFactionValue1Controller,
          label: '奖励声望值1',
          placeholder: 'RewardFactionValue1',
        ),
        FormItem(
          controller: vm.rewardFactionOverride1Controller,
          label: '奖励声望覆盖1',
          placeholder: 'RewardFactionOverride1',
        ),
        FormItem(
          controller: vm.rewardFactionId2Controller,
          label: '奖励声望阵营2',
          placeholder: 'RewardFactionID2',
        ),
        FormItem(
          controller: vm.rewardFactionValue2Controller,
          label: '奖励声望值2',
          placeholder: 'RewardFactionValue2',
        ),
        FormItem(
          controller: vm.rewardFactionOverride2Controller,
          label: '奖励声望覆盖2',
          placeholder: 'RewardFactionOverride2',
        ),
        FormItem(
          controller: vm.rewardFactionId3Controller,
          label: '奖励声望阵营3',
          placeholder: 'RewardFactionID3',
        ),
        FormItem(
          controller: vm.rewardFactionValue3Controller,
          label: '奖励声望值3',
          placeholder: 'RewardFactionValue3',
        ),
        FormItem(
          controller: vm.rewardFactionOverride3Controller,
          label: '奖励声望覆盖3',
          placeholder: 'RewardFactionOverride3',
        ),
        FormItem(
          controller: vm.rewardFactionId4Controller,
          label: '奖励声望阵营4',
          placeholder: 'RewardFactionID4',
        ),
        FormItem(
          controller: vm.rewardFactionValue4Controller,
          label: '奖励声望值4',
          placeholder: 'RewardFactionValue4',
        ),
        FormItem(
          controller: vm.rewardFactionOverride4Controller,
          label: '奖励声望覆盖4',
          placeholder: 'RewardFactionOverride4',
        ),
        FormItem(
          controller: vm.rewardFactionId5Controller,
          label: '奖励声望阵营5',
          placeholder: 'RewardFactionID5',
        ),
        FormItem(
          controller: vm.rewardFactionValue5Controller,
          label: '奖励声望值5',
          placeholder: 'RewardFactionValue5',
        ),
        FormItem(
          controller: vm.rewardFactionOverride5Controller,
          label: '奖励声望覆盖5',
          placeholder: 'RewardFactionOverride5',
        ),
        FormItem(
          controller: vm.timeAllowedController,
          label: '允许时间',
          placeholder: 'TimeAllowed',
        ),
        FormItem(
          controller: vm.allowableRacesController,
          label: '允许种族',
          placeholder: 'AllowableRaces',
        ),
        FormItem(
          controller: vm.logTitleController,
          label: '日志标题',
          placeholder: 'LogTitle',
        ),
        FormItem(
          controller: vm.logDescriptionController,
          label: '日志描述',
          placeholder: 'LogDescription',
        ),
        FormItem(
          controller: vm.questDescriptionController,
          label: '任务描述',
          placeholder: 'QuestDescription',
        ),
        FormItem(
          controller: vm.areaDescriptionController,
          label: '区域描述',
          placeholder: 'AreaDescription',
        ),
        FormItem(
          controller: vm.questCompletionLogController,
          label: '完成日志',
          placeholder: 'QuestCompletionLog',
        ),
        FormItem(
          controller: vm.requiredNpcOrGo1Controller,
          label: '需要NPC/GO1',
          placeholder: 'RequiredNpcOrGo1',
        ),
        FormItem(
          controller: vm.requiredNpcOrGo2Controller,
          label: '需要NPC/GO2',
          placeholder: 'RequiredNpcOrGo2',
        ),
        FormItem(
          controller: vm.requiredNpcOrGo3Controller,
          label: '需要NPC/GO3',
          placeholder: 'RequiredNpcOrGo3',
        ),
        FormItem(
          controller: vm.requiredNpcOrGo4Controller,
          label: '需要NPC/GO4',
          placeholder: 'RequiredNpcOrGo4',
        ),
        FormItem(
          controller: vm.requiredNpcOrGoCount1Controller,
          label: '需要NPC/GO数量1',
          placeholder: 'RequiredNpcOrGoCount1',
        ),
        FormItem(
          controller: vm.requiredNpcOrGoCount2Controller,
          label: '需要NPC/GO数量2',
          placeholder: 'RequiredNpcOrGoCount2',
        ),
        FormItem(
          controller: vm.requiredNpcOrGoCount3Controller,
          label: '需要NPC/GO数量3',
          placeholder: 'RequiredNpcOrGoCount3',
        ),
        FormItem(
          controller: vm.requiredNpcOrGoCount4Controller,
          label: '需要NPC/GO数量4',
          placeholder: 'RequiredNpcOrGoCount4',
        ),
        FormItem(
          controller: vm.requiredItemId1Controller,
          label: '需要物品1',
          placeholder: 'RequiredItemId1',
        ),
        FormItem(
          controller: vm.requiredItemId2Controller,
          label: '需要物品2',
          placeholder: 'RequiredItemId2',
        ),
        FormItem(
          controller: vm.requiredItemId3Controller,
          label: '需要物品3',
          placeholder: 'RequiredItemId3',
        ),
        FormItem(
          controller: vm.requiredItemId4Controller,
          label: '需要物品4',
          placeholder: 'RequiredItemId4',
        ),
        FormItem(
          controller: vm.requiredItemId5Controller,
          label: '需要物品5',
          placeholder: 'RequiredItemId5',
        ),
        FormItem(
          controller: vm.requiredItemId6Controller,
          label: '需要物品6',
          placeholder: 'RequiredItemId6',
        ),
        FormItem(
          controller: vm.requiredItemCount1Controller,
          label: '需要物品数量1',
          placeholder: 'RequiredItemCount1',
        ),
        FormItem(
          controller: vm.requiredItemCount2Controller,
          label: '需要物品数量2',
          placeholder: 'RequiredItemCount2',
        ),
        FormItem(
          controller: vm.requiredItemCount3Controller,
          label: '需要物品数量3',
          placeholder: 'RequiredItemCount3',
        ),
        FormItem(
          controller: vm.requiredItemCount4Controller,
          label: '需要物品数量4',
          placeholder: 'RequiredItemCount4',
        ),
        FormItem(
          controller: vm.requiredItemCount5Controller,
          label: '需要物品数量5',
          placeholder: 'RequiredItemCount5',
        ),
        FormItem(
          controller: vm.requiredItemCount6Controller,
          label: '需要物品数量6',
          placeholder: 'RequiredItemCount6',
        ),
        FormItem(
          controller: vm.unknown0Controller,
          label: '未知0',
          placeholder: 'Unknown0',
        ),
        FormItem(
          controller: vm.objectiveText1Controller,
          label: '目标文本1',
          placeholder: 'ObjectiveText1',
        ),
        FormItem(
          controller: vm.objectiveText2Controller,
          label: '目标文本2',
          placeholder: 'ObjectiveText2',
        ),
        FormItem(
          controller: vm.objectiveText3Controller,
          label: '目标文本3',
          placeholder: 'ObjectiveText3',
        ),
        FormItem(
          controller: vm.objectiveText4Controller,
          label: '目标文本4',
          placeholder: 'ObjectiveText4',
        ),
        FormItem(
          controller: vm.verifiedBuildController,
          label: '验证版本',
          placeholder: 'VerifiedBuild',
        ),
        Row(
          spacing: 8,
          children: [
            ShadButton(
              onPressed: () => viewModel.save(context),
              child: Text('保存'),
            ),
            ShadButton.ghost(
              onPressed: () => viewModel.pop(),
              child: Text('取消'),
            ),
          ],
        ),
      ],
    );
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: fields,
    );
  }
}