import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/quest_info_picker_delegate.dart';
import 'package:foxy/widget/char_title_picker_delegate.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/page/quest/quest_template_locale_selector.dart';
import 'package:foxy/page/quest/area_table_or_quest_sort_selector.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/form_section.dart';
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
              label: '编号',
              child: FoxyNumberInput<int>(
                controller: vm.idController,
                readOnly: true,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '任务类型',
              child: FoxyNumberInput<int>(
                placeholder: 'QuestType',
                controller: vm.questTypeController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '任务等级',
              child: FoxyNumberInput<int>(
                placeholder: 'QuestLevel',
                controller: vm.questLevelController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '最低等级',
              child: FoxyNumberInput<int>(
                placeholder: 'MinLevel',
                controller: vm.minLevelController,
              ),
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
              child: FoxyEntityPicker(
                delegate: questInfoPickerDelegate,
                controller: vm.questInfoIdController,
                placeholder: 'QuestInfoID',
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '建议组人数',
              child: FoxyNumberInput<int>(
                placeholder: 'SuggestedGroupNum',
                controller: vm.suggestedGroupNumController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '标志',
              child: FoxyNumberInput<int>(
                placeholder: 'Flags',
                controller: vm.flagsController,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '需要阵营1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredFactionId1',
                controller: vm.requiredFactionId1Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要阵营2',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredFactionId2',
                controller: vm.requiredFactionId2Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '阵营值1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredFactionValue1',
                controller: vm.requiredFactionValue1Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '阵营值2',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredFactionValue2',
                controller: vm.requiredFactionValue2Controller,
              ),
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
              label: '需要NPC/GO1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGo1',
                controller: vm.requiredNpcOrGo1Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要NPC/GO2',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGo2',
                controller: vm.requiredNpcOrGo2Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要NPC/GO3',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGo3',
                controller: vm.requiredNpcOrGo3Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要NPC/GO4',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGo4',
                controller: vm.requiredNpcOrGo4Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '需要数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGoCount1',
                controller: vm.requiredNpcOrGoCount1Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要数量2',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGoCount2',
                controller: vm.requiredNpcOrGoCount2Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGoCount3',
                controller: vm.requiredNpcOrGoCount3Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要数量4',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGoCount4',
                controller: vm.requiredNpcOrGoCount4Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '需要物品1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemId1',
                controller: vm.requiredItemId1Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要物品2',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemId2',
                controller: vm.requiredItemId2Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要物品3',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemId3',
                controller: vm.requiredItemId3Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要物品4',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemId4',
                controller: vm.requiredItemId4Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '需要物品5',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemId5',
                controller: vm.requiredItemId5Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要物品6',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemId6',
                controller: vm.requiredItemId6Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '物品数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount1',
                controller: vm.requiredItemCount1Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '物品数量2',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount2',
                controller: vm.requiredItemCount2Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '物品数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount3',
                controller: vm.requiredItemCount3Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '物品数量4',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount4',
                controller: vm.requiredItemCount4Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '物品数量5',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount5',
                controller: vm.requiredItemCount5Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '物品数量6',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount6',
                controller: vm.requiredItemCount6Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '起始物品',
              child: FoxyNumberInput<int>(
                placeholder: 'StartItem',
                controller: vm.startItemController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要击杀',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredPlayerKills',
                controller: vm.requiredPlayerKillsController,
              ),
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
              label: '下一个任务',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardNextQuest',
                controller: vm.rewardNextQuestController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '经验难度',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardXPDifficulty',
                controller: vm.rewardXpDifficultyController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '金币奖励',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardMoney',
                controller: vm.rewardMoneyController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '金币难度',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardMoneyDifficulty',
                controller: vm.rewardMoneyDifficultyController,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '展示法术',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardDisplaySpell',
                controller: vm.rewardDisplaySpellController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '法术奖励',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardSpell',
                controller: vm.rewardSpellController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '荣誉奖励',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardHonor',
                controller: vm.rewardHonorController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '杀敌荣誉',
              child: FoxyNumberInput<double>(
                placeholder: 'RewardKillHonor',
                controller: vm.rewardKillHonorController,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '奖励头衔',
              child: FoxyEntityPicker(
                delegate: charTitlePickerDelegate,
                controller: vm.rewardTitleController,
                placeholder: 'RewardTitle',
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励天赋',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardTalents',
                controller: vm.rewardTalentsController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '竞技场点数',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardArenaPoints',
                controller: vm.rewardArenaPointsController,
              ),
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
              label: '奖励物品1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardItem1',
                controller: vm.rewardItem1Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardAmount1',
                controller: vm.rewardAmount1Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励物品2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardItem2',
                controller: vm.rewardItem2Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励数量2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardAmount2',
                controller: vm.rewardAmount2Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '奖励物品3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardItem3',
                controller: vm.rewardItem3Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardAmount3',
                controller: vm.rewardAmount3Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励物品4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardItem4',
                controller: vm.rewardItem4Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励数量4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardAmount4',
                controller: vm.rewardAmount4Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '可选奖励1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemID1',
                controller: vm.rewardChoiceItemId1Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity1',
                controller: vm.rewardChoiceItemQuantity1Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选奖励2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemID2',
                controller: vm.rewardChoiceItemId2Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选数量2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity2',
                controller: vm.rewardChoiceItemQuantity2Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '可选奖励3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemID3',
                controller: vm.rewardChoiceItemId3Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity3',
                controller: vm.rewardChoiceItemQuantity3Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选奖励4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemID4',
                controller: vm.rewardChoiceItemId4Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选数量4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity4',
                controller: vm.rewardChoiceItemQuantity4Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '可选奖励5',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemID5',
                controller: vm.rewardChoiceItemId5Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选数量5',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity5',
                controller: vm.rewardChoiceItemQuantity5Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选奖励6',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemID6',
                controller: vm.rewardChoiceItemId6Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选数量6',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity6',
                controller: vm.rewardChoiceItemQuantity6Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '掉落物品1',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDrop1',
                controller: vm.itemDrop1Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '掉落数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDropQuantity1',
                controller: vm.itemDropQuantity1Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '掉落物品2',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDrop2',
                controller: vm.itemDrop2Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '掉落数量2',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDropQuantity2',
                controller: vm.itemDropQuantity2Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '掉落物品3',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDrop3',
                controller: vm.itemDrop3Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '掉落数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDropQuantity3',
                controller: vm.itemDropQuantity3Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '掉落物品4',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDrop4',
                controller: vm.itemDrop4Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '掉落数量4',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDropQuantity4',
                controller: vm.itemDropQuantity4Controller,
              ),
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
              label: '声望阵营1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionID1',
                controller: vm.rewardFactionId1Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望值1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue1',
                controller: vm.rewardFactionValue1Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望覆盖1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionOverride1',
                controller: vm.rewardFactionOverride1Controller,
              ),
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
              label: '声望阵营2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionID2',
                controller: vm.rewardFactionId2Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望值2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue2',
                controller: vm.rewardFactionValue2Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望覆盖2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionOverride2',
                controller: vm.rewardFactionOverride2Controller,
              ),
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
              label: '声望阵营3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionID3',
                controller: vm.rewardFactionId3Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望值3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue3',
                controller: vm.rewardFactionValue3Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望覆盖3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionOverride3',
                controller: vm.rewardFactionOverride3Controller,
              ),
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
              label: '声望阵营4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionID4',
                controller: vm.rewardFactionId4Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望值4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue4',
                controller: vm.rewardFactionValue4Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望覆盖4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionOverride4',
                controller: vm.rewardFactionOverride4Controller,
              ),
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
              label: '声望阵营5',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionID5',
                controller: vm.rewardFactionId5Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望值5',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue5',
                controller: vm.rewardFactionValue5Controller,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望覆盖5',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionOverride5',
                controller: vm.rewardFactionOverride5Controller,
              ),
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
              label: 'POI大陆',
              child: FoxyNumberInput<int>(
                placeholder: 'POIContinent',
                controller: vm.poiContinentController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: 'POI X',
              child: FoxyNumberInput<double>(
                placeholder: 'POIx',
                controller: vm.poiXController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: 'POI Y',
              child: FoxyNumberInput<double>(
                placeholder: 'POIy',
                controller: vm.poiYController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: 'POI优先级',
              child: FoxyNumberInput<int>(
                placeholder: 'POIPriority',
                controller: vm.poiPriorityController,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '允许时间',
              child: FoxyNumberInput<int>(
                placeholder: 'TimeAllowed',
                controller: vm.timeAllowedController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '允许种族',
              child: FoxyNumberInput<int>(
                placeholder: 'AllowableRaces',
                controller: vm.allowableRacesController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '未知0',
              child: FoxyNumberInput<int>(
                placeholder: 'Unknown0',
                controller: vm.unknown0Controller,
              ),
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

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FormSection(title: '基础信息', children: basicRows),
          FormSection(title: '任务目标', children: objectiveRows),
          FormSection(title: '基础奖励', children: basicRewardRows),
          FormSection(title: '奖励物品', children: rewardItemRows),
          FormSection(title: '奖励声望', children: rewardFactionRows),
          FormSection(title: '任务文本', children: textRows),
          FormSection(title: '位置与其他', children: miscRows),
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
