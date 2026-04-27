import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/page/quest/quest_template_locale_selector.dart';
import 'package:foxy/page/quest/area_table_or_quest_sort_selector.dart';
import 'package:foxy/page/quest_info/quest_info_selector.dart';
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

    /// 1. 基础信息
    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.idController,
              label: '编号',
              readOnly: true,
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.questTypeController,
              label: '任务类型',
              placeholder: 'QuestType',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.questLevelController,
              label: '任务等级',
              placeholder: 'QuestLevel',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.minLevelController,
              label: '最低等级',
              placeholder: 'MinLevel',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '任务分类',
              child: AreaTableOrQuestSortSelector(
                controller: vm.questSortIdController,
                placeholder: 'QuestSortID',
                mode: 'QuestSort',
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '任务信息',
              child: QuestInfoSelector(
                controller: vm.questInfoIdController,
                placeholder: 'QuestInfoID',
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.suggestedGroupNumController,
              label: '建议组人数',
              placeholder: 'SuggestedGroupNum',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.flagsController,
              label: '标志',
              placeholder: 'Flags',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.requiredFactionId1Controller,
              label: '需要阵营1',
              placeholder: 'RequiredFactionId1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredFactionId2Controller,
              label: '需要阵营2',
              placeholder: 'RequiredFactionId2',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredFactionValue1Controller,
              label: '阵营值1',
              placeholder: 'RequiredFactionValue1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredFactionValue2Controller,
              label: '阵营值2',
              placeholder: 'RequiredFactionValue2',
            ),
          ),
        ],
      ),
    ];

    /// 2. 任务目标
    final objectiveRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.requiredNpcOrGo1Controller,
              label: '需要NPC/GO1',
              placeholder: 'RequiredNpcOrGo1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredNpcOrGo2Controller,
              label: '需要NPC/GO2',
              placeholder: 'RequiredNpcOrGo2',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredNpcOrGo3Controller,
              label: '需要NPC/GO3',
              placeholder: 'RequiredNpcOrGo3',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredNpcOrGo4Controller,
              label: '需要NPC/GO4',
              placeholder: 'RequiredNpcOrGo4',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.requiredNpcOrGoCount1Controller,
              label: '需要数量1',
              placeholder: 'RequiredNpcOrGoCount1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredNpcOrGoCount2Controller,
              label: '需要数量2',
              placeholder: 'RequiredNpcOrGoCount2',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredNpcOrGoCount3Controller,
              label: '需要数量3',
              placeholder: 'RequiredNpcOrGoCount3',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredNpcOrGoCount4Controller,
              label: '需要数量4',
              placeholder: 'RequiredNpcOrGoCount4',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.requiredItemId1Controller,
              label: '需要物品1',
              placeholder: 'RequiredItemId1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredItemId2Controller,
              label: '需要物品2',
              placeholder: 'RequiredItemId2',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredItemId3Controller,
              label: '需要物品3',
              placeholder: 'RequiredItemId3',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredItemId4Controller,
              label: '需要物品4',
              placeholder: 'RequiredItemId4',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.requiredItemId5Controller,
              label: '需要物品5',
              placeholder: 'RequiredItemId5',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredItemId6Controller,
              label: '需要物品6',
              placeholder: 'RequiredItemId6',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredItemCount1Controller,
              label: '物品数量1',
              placeholder: 'RequiredItemCount1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredItemCount2Controller,
              label: '物品数量2',
              placeholder: 'RequiredItemCount2',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.requiredItemCount3Controller,
              label: '物品数量3',
              placeholder: 'RequiredItemCount3',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredItemCount4Controller,
              label: '物品数量4',
              placeholder: 'RequiredItemCount4',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredItemCount5Controller,
              label: '物品数量5',
              placeholder: 'RequiredItemCount5',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredItemCount6Controller,
              label: '物品数量6',
              placeholder: 'RequiredItemCount6',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.startItemController,
              label: '起始物品',
              placeholder: 'StartItem',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.requiredPlayerKillsController,
              label: '需要击杀',
              placeholder: 'RequiredPlayerKills',
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// 3. 基础奖励
    final basicRewardRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.rewardNextQuestController,
              label: '下一个任务',
              placeholder: 'RewardNextQuest',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardXpDifficultyController,
              label: '经验难度',
              placeholder: 'RewardXPDifficulty',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardMoneyController,
              label: '金币奖励',
              placeholder: 'RewardMoney',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardMoneyDifficultyController,
              label: '金币难度',
              placeholder: 'RewardMoneyDifficulty',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.rewardDisplaySpellController,
              label: '展示法术',
              placeholder: 'RewardDisplaySpell',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardSpellController,
              label: '法术奖励',
              placeholder: 'RewardSpell',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardHonorController,
              label: '荣誉奖励',
              placeholder: 'RewardHonor',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardKillHonorController,
              label: '杀敌荣誉',
              placeholder: 'RewardKillHonor',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.rewardTitleController,
              label: '奖励头衔',
              placeholder: 'RewardTitle',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardTalentsController,
              label: '奖励天赋',
              placeholder: 'RewardTalents',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardArenaPointsController,
              label: '竞技场点数',
              placeholder: 'RewardArenaPoints',
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// 4. 奖励物品
    final rewardItemRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.rewardItem1Controller,
              label: '奖励物品1',
              placeholder: 'RewardItem1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardAmount1Controller,
              label: '奖励数量1',
              placeholder: 'RewardAmount1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardItem2Controller,
              label: '奖励物品2',
              placeholder: 'RewardItem2',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardAmount2Controller,
              label: '奖励数量2',
              placeholder: 'RewardAmount2',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.rewardItem3Controller,
              label: '奖励物品3',
              placeholder: 'RewardItem3',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardAmount3Controller,
              label: '奖励数量3',
              placeholder: 'RewardAmount3',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardItem4Controller,
              label: '奖励物品4',
              placeholder: 'RewardItem4',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardAmount4Controller,
              label: '奖励数量4',
              placeholder: 'RewardAmount4',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.rewardChoiceItemId1Controller,
              label: '可选奖励1',
              placeholder: 'RewardChoiceItemID1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardChoiceItemQuantity1Controller,
              label: '可选数量1',
              placeholder: 'RewardChoiceItemQuantity1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardChoiceItemId2Controller,
              label: '可选奖励2',
              placeholder: 'RewardChoiceItemID2',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardChoiceItemQuantity2Controller,
              label: '可选数量2',
              placeholder: 'RewardChoiceItemQuantity2',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.rewardChoiceItemId3Controller,
              label: '可选奖励3',
              placeholder: 'RewardChoiceItemID3',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardChoiceItemQuantity3Controller,
              label: '可选数量3',
              placeholder: 'RewardChoiceItemQuantity3',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardChoiceItemId4Controller,
              label: '可选奖励4',
              placeholder: 'RewardChoiceItemID4',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardChoiceItemQuantity4Controller,
              label: '可选数量4',
              placeholder: 'RewardChoiceItemQuantity4',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.rewardChoiceItemId5Controller,
              label: '可选奖励5',
              placeholder: 'RewardChoiceItemID5',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardChoiceItemQuantity5Controller,
              label: '可选数量5',
              placeholder: 'RewardChoiceItemQuantity5',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardChoiceItemId6Controller,
              label: '可选奖励6',
              placeholder: 'RewardChoiceItemID6',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardChoiceItemQuantity6Controller,
              label: '可选数量6',
              placeholder: 'RewardChoiceItemQuantity6',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.itemDrop1Controller,
              label: '掉落物品1',
              placeholder: 'ItemDrop1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.itemDropQuantity1Controller,
              label: '掉落数量1',
              placeholder: 'ItemDropQuantity1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.itemDrop2Controller,
              label: '掉落物品2',
              placeholder: 'ItemDrop2',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.itemDropQuantity2Controller,
              label: '掉落数量2',
              placeholder: 'ItemDropQuantity2',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.itemDrop3Controller,
              label: '掉落物品3',
              placeholder: 'ItemDrop3',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.itemDropQuantity3Controller,
              label: '掉落数量3',
              placeholder: 'ItemDropQuantity3',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.itemDrop4Controller,
              label: '掉落物品4',
              placeholder: 'ItemDrop4',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.itemDropQuantity4Controller,
              label: '掉落数量4',
              placeholder: 'ItemDropQuantity4',
            ),
          ),
        ],
      ),
    ];

    /// 5. 奖励声望
    final rewardFactionRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionId1Controller,
              label: '声望阵营1',
              placeholder: 'RewardFactionID1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionValue1Controller,
              label: '声望值1',
              placeholder: 'RewardFactionValue1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionOverride1Controller,
              label: '声望覆盖1',
              placeholder: 'RewardFactionOverride1',
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionId2Controller,
              label: '声望阵营2',
              placeholder: 'RewardFactionID2',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionValue2Controller,
              label: '声望值2',
              placeholder: 'RewardFactionValue2',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionOverride2Controller,
              label: '声望覆盖2',
              placeholder: 'RewardFactionOverride2',
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionId3Controller,
              label: '声望阵营3',
              placeholder: 'RewardFactionID3',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionValue3Controller,
              label: '声望值3',
              placeholder: 'RewardFactionValue3',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionOverride3Controller,
              label: '声望覆盖3',
              placeholder: 'RewardFactionOverride3',
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionId4Controller,
              label: '声望阵营4',
              placeholder: 'RewardFactionID4',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionValue4Controller,
              label: '声望值4',
              placeholder: 'RewardFactionValue4',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionOverride4Controller,
              label: '声望覆盖4',
              placeholder: 'RewardFactionOverride4',
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionId5Controller,
              label: '声望阵营5',
              placeholder: 'RewardFactionID5',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionValue5Controller,
              label: '声望值5',
              placeholder: 'RewardFactionValue5',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.rewardFactionOverride5Controller,
              label: '声望覆盖5',
              placeholder: 'RewardFactionOverride5',
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// 6. 任务文本
    final textRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '日志标题',
              child: QuestTemplateLocaleSelector(
                questId: widget.questId,
                controller: vm.logTitleController,
                placeholder: 'LogTitle',
                title: '日志标题',
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '日志描述',
              child: QuestTemplateLocaleSelector(
                questId: widget.questId,
                controller: vm.logDescriptionController,
                placeholder: 'LogDescription',
                title: '日志描述',
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '任务描述',
              child: QuestTemplateLocaleSelector(
                questId: widget.questId,
                controller: vm.questDescriptionController,
                placeholder: 'QuestDescription',
                title: '任务描述',
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '区域描述',
              child: QuestTemplateLocaleSelector(
                questId: widget.questId,
                controller: vm.areaDescriptionController,
                placeholder: 'AreaDescription',
                title: '区域描述',
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '完成日志',
              child: QuestTemplateLocaleSelector(
                questId: widget.questId,
                controller: vm.questCompletionLogController,
                placeholder: 'QuestCompletionLog',
                title: '完成日志',
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.objectiveText1Controller,
              label: '目标文本1',
              placeholder: 'ObjectiveText1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.objectiveText2Controller,
              label: '目标文本2',
              placeholder: 'ObjectiveText2',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.objectiveText3Controller,
              label: '目标文本3',
              placeholder: 'ObjectiveText3',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.objectiveText4Controller,
              label: '目标文本4',
              placeholder: 'ObjectiveText4',
            ),
          ),
        ],
      ),
    ];

    /// 7. 位置与其他
    final miscRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.poiContinentController,
              label: 'POI大陆',
              placeholder: 'POIContinent',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.poiXController,
              label: 'POI X',
              placeholder: 'POIx',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.poiYController,
              label: 'POI Y',
              placeholder: 'POIy',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.poiPriorityController,
              label: 'POI优先级',
              placeholder: 'POIPriority',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.timeAllowedController,
              label: '允许时间',
              placeholder: 'TimeAllowed',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.allowableRacesController,
              label: '允许种族',
              placeholder: 'AllowableRaces',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.unknown0Controller,
              label: '未知0',
              placeholder: 'Unknown0',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.verifiedBuildController,
              label: '验证版本',
              placeholder: 'VerifiedBuild',
            ),
          ),
        ],
      ),
    ];

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

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          section('基础信息', basicRows),
          section('任务目标', objectiveRows),
          section('基础奖励', basicRewardRows),
          section('奖励物品', rewardItemRows),
          section('奖励声望', rewardFactionRows),
          section('任务文本', textRows),
          section('位置与其他', miscRows),
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
      ),
    );
  }
}
