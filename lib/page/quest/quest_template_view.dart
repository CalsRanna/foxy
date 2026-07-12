import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/page/quest/area_table_or_quest_sort_selector.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestTemplateView extends StatefulWidget {
  final int? questId;
  const QuestTemplateView({super.key, this.questId});

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
            child: FoxyFormItem(
              label: '编号',
              child: FoxyNumberInput<int>(
                fieldController: vm.idController,
                readOnly: true,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '任务类型',
              child: FoxyNumberInput<int>(
                placeholder: 'QuestType',
                fieldController: vm.questTypeController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '任务等级',
              child: FoxyNumberInput<int>(
                placeholder: 'QuestLevel',
                fieldController: vm.questLevelController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '最低等级',
              child: FoxyNumberInput<int>(
                placeholder: 'MinLevel',
                fieldController: vm.minLevelController,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '任务分类',
              child: AreaTableOrQuestSortSelector(
                fieldController: vm.questSortIdController,
                placeholder: 'QuestSortID',
                mode: 'QuestSort',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '任务信息',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.questInfo,
                fieldController: vm.questInfoIdController,
                placeholder: 'QuestInfoID',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '建议组人数',
              child: FoxyNumberInput<int>(
                placeholder: 'SuggestedGroupNum',
                fieldController: vm.suggestedGroupNumController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '标志',
              child: FoxyNumberInput<int>(
                placeholder: 'Flags',
                fieldController: vm.flagsController,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '需要阵营1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredFactionId1',
                fieldController: vm.requiredFactionId1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要阵营2',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredFactionId2',
                fieldController: vm.requiredFactionId2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '阵营值1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredFactionValue1',
                fieldController: vm.requiredFactionValue1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '阵营值2',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredFactionValue2',
                fieldController: vm.requiredFactionValue2Controller,
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
            child: FoxyFormItem(
              label: '需要NPC/GO1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGo1',
                fieldController: vm.requiredNpcOrGo1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要NPC/GO2',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGo2',
                fieldController: vm.requiredNpcOrGo2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要NPC/GO3',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGo3',
                fieldController: vm.requiredNpcOrGo3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要NPC/GO4',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGo4',
                fieldController: vm.requiredNpcOrGo4Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '需要数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGoCount1',
                fieldController: vm.requiredNpcOrGoCount1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要数量2',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGoCount2',
                fieldController: vm.requiredNpcOrGoCount2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGoCount3',
                fieldController: vm.requiredNpcOrGoCount3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要数量4',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGoCount4',
                fieldController: vm.requiredNpcOrGoCount4Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '需要物品1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemId1',
                fieldController: vm.requiredItemId1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要物品2',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemId2',
                fieldController: vm.requiredItemId2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要物品3',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemId3',
                fieldController: vm.requiredItemId3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要物品4',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemId4',
                fieldController: vm.requiredItemId4Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '需要物品5',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemId5',
                fieldController: vm.requiredItemId5Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要物品6',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemId6',
                fieldController: vm.requiredItemId6Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '物品数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount1',
                fieldController: vm.requiredItemCount1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '物品数量2',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount2',
                fieldController: vm.requiredItemCount2Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '物品数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount3',
                fieldController: vm.requiredItemCount3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '物品数量4',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount4',
                fieldController: vm.requiredItemCount4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '物品数量5',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount5',
                fieldController: vm.requiredItemCount5Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '物品数量6',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount6',
                fieldController: vm.requiredItemCount6Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '起始物品',
              child: FoxyNumberInput<int>(
                placeholder: 'StartItem',
                fieldController: vm.startItemController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要击杀',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredPlayerKills',
                fieldController: vm.requiredPlayerKillsController,
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
            child: FoxyFormItem(
              label: '下一个任务',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardNextQuest',
                fieldController: vm.rewardNextQuestController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '经验难度',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardXPDifficulty',
                fieldController: vm.rewardXpDifficultyController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '金币奖励',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardMoney',
                fieldController: vm.rewardMoneyController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '金币难度',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardMoneyDifficulty',
                fieldController: vm.rewardMoneyDifficultyController,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '展示法术',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardDisplaySpell',
                fieldController: vm.rewardDisplaySpellController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '法术奖励',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardSpell',
                fieldController: vm.rewardSpellController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '荣誉奖励',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardHonor',
                fieldController: vm.rewardHonorController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '杀敌荣誉',
              child: FoxyNumberInput<double>(
                placeholder: 'RewardKillHonor',
                fieldController: vm.rewardKillHonorController,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '奖励头衔',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.charTitle,
                fieldController: vm.rewardTitleController,
                placeholder: 'RewardTitle',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '奖励天赋',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardTalents',
                fieldController: vm.rewardTalentsController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '竞技场点数',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardArenaPoints',
                fieldController: vm.rewardArenaPointsController,
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
            child: FoxyFormItem(
              label: '奖励物品1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardItem1',
                fieldController: vm.rewardItem1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '奖励数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardAmount1',
                fieldController: vm.rewardAmount1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '奖励物品2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardItem2',
                fieldController: vm.rewardItem2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '奖励数量2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardAmount2',
                fieldController: vm.rewardAmount2Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '奖励物品3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardItem3',
                fieldController: vm.rewardItem3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '奖励数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardAmount3',
                fieldController: vm.rewardAmount3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '奖励物品4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardItem4',
                fieldController: vm.rewardItem4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '奖励数量4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardAmount4',
                fieldController: vm.rewardAmount4Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '可选奖励1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemID1',
                fieldController: vm.rewardChoiceItemId1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity1',
                fieldController: vm.rewardChoiceItemQuantity1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选奖励2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemID2',
                fieldController: vm.rewardChoiceItemId2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选数量2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity2',
                fieldController: vm.rewardChoiceItemQuantity2Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '可选奖励3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemID3',
                fieldController: vm.rewardChoiceItemId3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity3',
                fieldController: vm.rewardChoiceItemQuantity3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选奖励4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemID4',
                fieldController: vm.rewardChoiceItemId4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选数量4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity4',
                fieldController: vm.rewardChoiceItemQuantity4Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '可选奖励5',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemID5',
                fieldController: vm.rewardChoiceItemId5Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选数量5',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity5',
                fieldController: vm.rewardChoiceItemQuantity5Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选奖励6',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemID6',
                fieldController: vm.rewardChoiceItemId6Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选数量6',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity6',
                fieldController: vm.rewardChoiceItemQuantity6Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '掉落物品1',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDrop1',
                fieldController: vm.itemDrop1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '掉落数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDropQuantity1',
                fieldController: vm.itemDropQuantity1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '掉落物品2',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDrop2',
                fieldController: vm.itemDrop2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '掉落数量2',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDropQuantity2',
                fieldController: vm.itemDropQuantity2Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '掉落物品3',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDrop3',
                fieldController: vm.itemDrop3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '掉落数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDropQuantity3',
                fieldController: vm.itemDropQuantity3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '掉落物品4',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDrop4',
                fieldController: vm.itemDrop4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '掉落数量4',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDropQuantity4',
                fieldController: vm.itemDropQuantity4Controller,
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
            child: FoxyFormItem(
              label: '声望阵营1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionID1',
                fieldController: vm.rewardFactionId1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望值1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue1',
                fieldController: vm.rewardFactionValue1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望覆盖1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionOverride1',
                fieldController: vm.rewardFactionOverride1Controller,
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
            child: FoxyFormItem(
              label: '声望阵营2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionID2',
                fieldController: vm.rewardFactionId2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望值2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue2',
                fieldController: vm.rewardFactionValue2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望覆盖2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionOverride2',
                fieldController: vm.rewardFactionOverride2Controller,
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
            child: FoxyFormItem(
              label: '声望阵营3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionID3',
                fieldController: vm.rewardFactionId3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望值3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue3',
                fieldController: vm.rewardFactionValue3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望覆盖3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionOverride3',
                fieldController: vm.rewardFactionOverride3Controller,
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
            child: FoxyFormItem(
              label: '声望阵营4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionID4',
                fieldController: vm.rewardFactionId4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望值4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue4',
                fieldController: vm.rewardFactionValue4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望覆盖4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionOverride4',
                fieldController: vm.rewardFactionOverride4Controller,
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
            child: FoxyFormItem(
              label: '声望阵营5',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionID5',
                fieldController: vm.rewardFactionId5Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望值5',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue5',
                fieldController: vm.rewardFactionValue5Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望覆盖5',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionOverride5',
                fieldController: vm.rewardFactionOverride5Controller,
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
            child: FoxyFormItem(
              label: '日志标题',
              child: FoxyLocalePicker(
                entry: widget.questId,
                fieldController: vm.logTitleController,
                delegate: FoxyLocalePickerDelegates.questTemplate,
                placeholder: 'LogTitle',
                title: '日志标题',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '日志描述',
              child: FoxyLocalePicker(
                entry: widget.questId,
                fieldController: vm.logDescriptionController,
                delegate: FoxyLocalePickerDelegates.questTemplate,
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
            child: FoxyFormItem(
              label: '任务描述',
              child: FoxyLocalePicker(
                entry: widget.questId,
                fieldController: vm.questDescriptionController,
                delegate: FoxyLocalePickerDelegates.questTemplate,
                placeholder: 'QuestDescription',
                title: '任务描述',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '区域描述',
              child: FoxyLocalePicker(
                entry: widget.questId,
                fieldController: vm.areaDescriptionController,
                delegate: FoxyLocalePickerDelegates.questTemplate,
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
            child: FoxyFormItem(
              label: '完成日志',
              child: FoxyLocalePicker(
                entry: widget.questId,
                fieldController: vm.questCompletionLogController,
                delegate: FoxyLocalePickerDelegates.questTemplate,
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
            child: FoxyFormItem(
              label: '目标文本1',
              child: FoxyStringInput(
                controller: vm.objectiveText1Controller,
                placeholder: 'ObjectiveText1',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '目标文本2',
              child: FoxyStringInput(
                controller: vm.objectiveText2Controller,
                placeholder: 'ObjectiveText2',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '目标文本3',
              child: FoxyStringInput(
                controller: vm.objectiveText3Controller,
                placeholder: 'ObjectiveText3',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '目标文本4',
              child: FoxyStringInput(
                controller: vm.objectiveText4Controller,
                placeholder: 'ObjectiveText4',
              ),
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
            child: FoxyFormItem(
              label: 'POI大陆',
              child: FoxyNumberInput<int>(
                placeholder: 'POIContinent',
                fieldController: vm.poiContinentController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: 'POI X',
              child: FoxyNumberInput<double>(
                placeholder: 'POIx',
                fieldController: vm.poiXController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: 'POI Y',
              child: FoxyNumberInput<double>(
                placeholder: 'POIy',
                fieldController: vm.poiYController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: 'POI优先级',
              child: FoxyNumberInput<int>(
                placeholder: 'POIPriority',
                fieldController: vm.poiPriorityController,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '允许时间',
              child: FoxyNumberInput<int>(
                placeholder: 'TimeAllowed',
                fieldController: vm.timeAllowedController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '允许种族',
              child: FoxyNumberInput<int>(
                placeholder: 'AllowableRaces',
                fieldController: vm.allowableRacesController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '未知0',
              child: FoxyNumberInput<int>(
                placeholder: 'Unknown0',
                fieldController: vm.unknown0Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '验证版本',
              child: FoxyNumberInput<int>(
                fieldController: vm.verifiedBuildController,
                placeholder: 'VerifiedBuild',
              ),
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
          FoxyFormSection(title: '基础信息', children: basicRows),
          FoxyFormSection(title: '任务目标', children: objectiveRows),
          FoxyFormSection(title: '基础奖励', children: basicRewardRows),
          FoxyFormSection(title: '奖励物品', children: rewardItemRows),
          FoxyFormSection(title: '奖励声望', children: rewardFactionRows),
          FoxyFormSection(title: '任务文本', children: textRows),
          FoxyFormSection(title: '位置与其他', children: miscRows),
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
