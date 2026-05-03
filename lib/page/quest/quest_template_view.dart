import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/page/quest/quest_template_locale_selector.dart';
import 'package:foxy/page/quest/area_table_or_quest_sort_selector.dart';
import 'package:foxy/page/quest_info/quest_info_selector.dart';
import 'package:foxy/page/creature_template/char_title_selector.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
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
                value: vm.id.value,
                readOnly: true,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '任务类型',
              placeholder: 'QuestType',
              child: FoxyNumberInput<int>(
                value: vm.questType.value,
                onChanged: (v) => vm.questType.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '任务等级',
              placeholder: 'QuestLevel',
              child: FoxyNumberInput<int>(
                value: vm.questLevel.value,
                onChanged: (v) => vm.questLevel.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '最低等级',
              placeholder: 'MinLevel',
              child: FoxyNumberInput<int>(
                value: vm.minLevel.value,
                onChanged: (v) => vm.minLevel.value = v,
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
              child: QuestInfoSelector(
                controller: vm.questInfoIdController,
                placeholder: 'QuestInfoID',
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '建议组人数',
              placeholder: 'SuggestedGroupNum',
              child: FoxyNumberInput<int>(
                value: vm.suggestedGroupNum.value,
                onChanged: (v) => vm.suggestedGroupNum.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '标志',
              placeholder: 'Flags',
              child: FoxyNumberInput<int>(
                value: vm.flags.value,
                onChanged: (v) => vm.flags.value = v,
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
              placeholder: 'RequiredFactionId1',
              child: FoxyNumberInput<int>(
                value: vm.requiredFactionId1.value,
                onChanged: (v) => vm.requiredFactionId1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要阵营2',
              placeholder: 'RequiredFactionId2',
              child: FoxyNumberInput<int>(
                value: vm.requiredFactionId2.value,
                onChanged: (v) => vm.requiredFactionId2.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '阵营值1',
              placeholder: 'RequiredFactionValue1',
              child: FoxyNumberInput<int>(
                value: vm.requiredFactionValue1.value,
                onChanged: (v) => vm.requiredFactionValue1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '阵营值2',
              placeholder: 'RequiredFactionValue2',
              child: FoxyNumberInput<int>(
                value: vm.requiredFactionValue2.value,
                onChanged: (v) => vm.requiredFactionValue2.value = v,
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
              placeholder: 'RequiredNpcOrGo1',
              child: FoxyNumberInput<int>(
                value: vm.requiredNpcOrGo1.value,
                onChanged: (v) => vm.requiredNpcOrGo1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要NPC/GO2',
              placeholder: 'RequiredNpcOrGo2',
              child: FoxyNumberInput<int>(
                value: vm.requiredNpcOrGo2.value,
                onChanged: (v) => vm.requiredNpcOrGo2.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要NPC/GO3',
              placeholder: 'RequiredNpcOrGo3',
              child: FoxyNumberInput<int>(
                value: vm.requiredNpcOrGo3.value,
                onChanged: (v) => vm.requiredNpcOrGo3.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要NPC/GO4',
              placeholder: 'RequiredNpcOrGo4',
              child: FoxyNumberInput<int>(
                value: vm.requiredNpcOrGo4.value,
                onChanged: (v) => vm.requiredNpcOrGo4.value = v,
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
              placeholder: 'RequiredNpcOrGoCount1',
              child: FoxyNumberInput<int>(
                value: vm.requiredNpcOrGoCount1.value,
                onChanged: (v) => vm.requiredNpcOrGoCount1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要数量2',
              placeholder: 'RequiredNpcOrGoCount2',
              child: FoxyNumberInput<int>(
                value: vm.requiredNpcOrGoCount2.value,
                onChanged: (v) => vm.requiredNpcOrGoCount2.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要数量3',
              placeholder: 'RequiredNpcOrGoCount3',
              child: FoxyNumberInput<int>(
                value: vm.requiredNpcOrGoCount3.value,
                onChanged: (v) => vm.requiredNpcOrGoCount3.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要数量4',
              placeholder: 'RequiredNpcOrGoCount4',
              child: FoxyNumberInput<int>(
                value: vm.requiredNpcOrGoCount4.value,
                onChanged: (v) => vm.requiredNpcOrGoCount4.value = v,
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
              placeholder: 'RequiredItemId1',
              child: FoxyNumberInput<int>(
                value: vm.requiredItemId1.value,
                onChanged: (v) => vm.requiredItemId1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要物品2',
              placeholder: 'RequiredItemId2',
              child: FoxyNumberInput<int>(
                value: vm.requiredItemId2.value,
                onChanged: (v) => vm.requiredItemId2.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要物品3',
              placeholder: 'RequiredItemId3',
              child: FoxyNumberInput<int>(
                value: vm.requiredItemId3.value,
                onChanged: (v) => vm.requiredItemId3.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要物品4',
              placeholder: 'RequiredItemId4',
              child: FoxyNumberInput<int>(
                value: vm.requiredItemId4.value,
                onChanged: (v) => vm.requiredItemId4.value = v,
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
              placeholder: 'RequiredItemId5',
              child: FoxyNumberInput<int>(
                value: vm.requiredItemId5.value,
                onChanged: (v) => vm.requiredItemId5.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要物品6',
              placeholder: 'RequiredItemId6',
              child: FoxyNumberInput<int>(
                value: vm.requiredItemId6.value,
                onChanged: (v) => vm.requiredItemId6.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '物品数量1',
              placeholder: 'RequiredItemCount1',
              child: FoxyNumberInput<int>(
                value: vm.requiredItemCount1.value,
                onChanged: (v) => vm.requiredItemCount1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '物品数量2',
              placeholder: 'RequiredItemCount2',
              child: FoxyNumberInput<int>(
                value: vm.requiredItemCount2.value,
                onChanged: (v) => vm.requiredItemCount2.value = v,
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
              placeholder: 'RequiredItemCount3',
              child: FoxyNumberInput<int>(
                value: vm.requiredItemCount3.value,
                onChanged: (v) => vm.requiredItemCount3.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '物品数量4',
              placeholder: 'RequiredItemCount4',
              child: FoxyNumberInput<int>(
                value: vm.requiredItemCount4.value,
                onChanged: (v) => vm.requiredItemCount4.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '物品数量5',
              placeholder: 'RequiredItemCount5',
              child: FoxyNumberInput<int>(
                value: vm.requiredItemCount5.value,
                onChanged: (v) => vm.requiredItemCount5.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '物品数量6',
              placeholder: 'RequiredItemCount6',
              child: FoxyNumberInput<int>(
                value: vm.requiredItemCount6.value,
                onChanged: (v) => vm.requiredItemCount6.value = v,
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
              placeholder: 'StartItem',
              child: FoxyNumberInput<int>(
                value: vm.startItem.value,
                onChanged: (v) => vm.startItem.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要击杀',
              placeholder: 'RequiredPlayerKills',
              child: FoxyNumberInput<int>(
                value: vm.requiredPlayerKills.value,
                onChanged: (v) => vm.requiredPlayerKills.value = v,
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
              placeholder: 'RewardNextQuest',
              child: FoxyNumberInput<int>(
                value: vm.rewardNextQuest.value,
                onChanged: (v) => vm.rewardNextQuest.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '经验难度',
              placeholder: 'RewardXPDifficulty',
              child: FoxyNumberInput<int>(
                value: vm.rewardXpDifficulty.value,
                onChanged: (v) => vm.rewardXpDifficulty.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '金币奖励',
              placeholder: 'RewardMoney',
              child: FoxyNumberInput<int>(
                value: vm.rewardMoney.value,
                onChanged: (v) => vm.rewardMoney.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '金币难度',
              placeholder: 'RewardMoneyDifficulty',
              child: FoxyNumberInput<int>(
                value: vm.rewardMoneyDifficulty.value,
                onChanged: (v) => vm.rewardMoneyDifficulty.value = v,
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
              placeholder: 'RewardDisplaySpell',
              child: FoxyNumberInput<int>(
                value: vm.rewardDisplaySpell.value,
                onChanged: (v) => vm.rewardDisplaySpell.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '法术奖励',
              placeholder: 'RewardSpell',
              child: FoxyNumberInput<int>(
                value: vm.rewardSpell.value,
                onChanged: (v) => vm.rewardSpell.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '荣誉奖励',
              placeholder: 'RewardHonor',
              child: FoxyNumberInput<int>(
                value: vm.rewardHonor.value,
                onChanged: (v) => vm.rewardHonor.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '杀敌荣誉',
              placeholder: 'RewardKillHonor',
              child: FoxyNumberInput<double>(
                value: vm.rewardKillHonor.value,
                onChanged: (v) => vm.rewardKillHonor.value = v,
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
              child: CharTitleSelector(
                controller: vm.rewardTitleController,
                placeholder: 'RewardTitle',
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励天赋',
              placeholder: 'RewardTalents',
              child: FoxyNumberInput<int>(
                value: vm.rewardTalents.value,
                onChanged: (v) => vm.rewardTalents.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '竞技场点数',
              placeholder: 'RewardArenaPoints',
              child: FoxyNumberInput<int>(
                value: vm.rewardArenaPoints.value,
                onChanged: (v) => vm.rewardArenaPoints.value = v,
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
              placeholder: 'RewardItem1',
              child: FoxyNumberInput<int>(
                value: vm.rewardItem1.value,
                onChanged: (v) => vm.rewardItem1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励数量1',
              placeholder: 'RewardAmount1',
              child: FoxyNumberInput<int>(
                value: vm.rewardAmount1.value,
                onChanged: (v) => vm.rewardAmount1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励物品2',
              placeholder: 'RewardItem2',
              child: FoxyNumberInput<int>(
                value: vm.rewardItem2.value,
                onChanged: (v) => vm.rewardItem2.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励数量2',
              placeholder: 'RewardAmount2',
              child: FoxyNumberInput<int>(
                value: vm.rewardAmount2.value,
                onChanged: (v) => vm.rewardAmount2.value = v,
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
              placeholder: 'RewardItem3',
              child: FoxyNumberInput<int>(
                value: vm.rewardItem3.value,
                onChanged: (v) => vm.rewardItem3.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励数量3',
              placeholder: 'RewardAmount3',
              child: FoxyNumberInput<int>(
                value: vm.rewardAmount3.value,
                onChanged: (v) => vm.rewardAmount3.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励物品4',
              placeholder: 'RewardItem4',
              child: FoxyNumberInput<int>(
                value: vm.rewardItem4.value,
                onChanged: (v) => vm.rewardItem4.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励数量4',
              placeholder: 'RewardAmount4',
              child: FoxyNumberInput<int>(
                value: vm.rewardAmount4.value,
                onChanged: (v) => vm.rewardAmount4.value = v,
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
              placeholder: 'RewardChoiceItemID1',
              child: FoxyNumberInput<int>(
                value: vm.rewardChoiceItemId1.value,
                onChanged: (v) => vm.rewardChoiceItemId1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选数量1',
              placeholder: 'RewardChoiceItemQuantity1',
              child: FoxyNumberInput<int>(
                value: vm.rewardChoiceItemQuantity1.value,
                onChanged: (v) => vm.rewardChoiceItemQuantity1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选奖励2',
              placeholder: 'RewardChoiceItemID2',
              child: FoxyNumberInput<int>(
                value: vm.rewardChoiceItemId2.value,
                onChanged: (v) => vm.rewardChoiceItemId2.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选数量2',
              placeholder: 'RewardChoiceItemQuantity2',
              child: FoxyNumberInput<int>(
                value: vm.rewardChoiceItemQuantity2.value,
                onChanged: (v) => vm.rewardChoiceItemQuantity2.value = v,
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
              placeholder: 'RewardChoiceItemID3',
              child: FoxyNumberInput<int>(
                value: vm.rewardChoiceItemId3.value,
                onChanged: (v) => vm.rewardChoiceItemId3.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选数量3',
              placeholder: 'RewardChoiceItemQuantity3',
              child: FoxyNumberInput<int>(
                value: vm.rewardChoiceItemQuantity3.value,
                onChanged: (v) => vm.rewardChoiceItemQuantity3.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选奖励4',
              placeholder: 'RewardChoiceItemID4',
              child: FoxyNumberInput<int>(
                value: vm.rewardChoiceItemId4.value,
                onChanged: (v) => vm.rewardChoiceItemId4.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选数量4',
              placeholder: 'RewardChoiceItemQuantity4',
              child: FoxyNumberInput<int>(
                value: vm.rewardChoiceItemQuantity4.value,
                onChanged: (v) => vm.rewardChoiceItemQuantity4.value = v,
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
              placeholder: 'RewardChoiceItemID5',
              child: FoxyNumberInput<int>(
                value: vm.rewardChoiceItemId5.value,
                onChanged: (v) => vm.rewardChoiceItemId5.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选数量5',
              placeholder: 'RewardChoiceItemQuantity5',
              child: FoxyNumberInput<int>(
                value: vm.rewardChoiceItemQuantity5.value,
                onChanged: (v) => vm.rewardChoiceItemQuantity5.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选奖励6',
              placeholder: 'RewardChoiceItemID6',
              child: FoxyNumberInput<int>(
                value: vm.rewardChoiceItemId6.value,
                onChanged: (v) => vm.rewardChoiceItemId6.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '可选数量6',
              placeholder: 'RewardChoiceItemQuantity6',
              child: FoxyNumberInput<int>(
                value: vm.rewardChoiceItemQuantity6.value,
                onChanged: (v) => vm.rewardChoiceItemQuantity6.value = v,
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
              placeholder: 'ItemDrop1',
              child: FoxyNumberInput<int>(
                value: vm.itemDrop1.value,
                onChanged: (v) => vm.itemDrop1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '掉落数量1',
              placeholder: 'ItemDropQuantity1',
              child: FoxyNumberInput<int>(
                value: vm.itemDropQuantity1.value,
                onChanged: (v) => vm.itemDropQuantity1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '掉落物品2',
              placeholder: 'ItemDrop2',
              child: FoxyNumberInput<int>(
                value: vm.itemDrop2.value,
                onChanged: (v) => vm.itemDrop2.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '掉落数量2',
              placeholder: 'ItemDropQuantity2',
              child: FoxyNumberInput<int>(
                value: vm.itemDropQuantity2.value,
                onChanged: (v) => vm.itemDropQuantity2.value = v,
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
              placeholder: 'ItemDrop3',
              child: FoxyNumberInput<int>(
                value: vm.itemDrop3.value,
                onChanged: (v) => vm.itemDrop3.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '掉落数量3',
              placeholder: 'ItemDropQuantity3',
              child: FoxyNumberInput<int>(
                value: vm.itemDropQuantity3.value,
                onChanged: (v) => vm.itemDropQuantity3.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '掉落物品4',
              placeholder: 'ItemDrop4',
              child: FoxyNumberInput<int>(
                value: vm.itemDrop4.value,
                onChanged: (v) => vm.itemDrop4.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '掉落数量4',
              placeholder: 'ItemDropQuantity4',
              child: FoxyNumberInput<int>(
                value: vm.itemDropQuantity4.value,
                onChanged: (v) => vm.itemDropQuantity4.value = v,
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
              placeholder: 'RewardFactionID1',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionId1.value,
                onChanged: (v) => vm.rewardFactionId1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望值1',
              placeholder: 'RewardFactionValue1',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionValue1.value,
                onChanged: (v) => vm.rewardFactionValue1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望覆盖1',
              placeholder: 'RewardFactionOverride1',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionOverride1.value,
                onChanged: (v) => vm.rewardFactionOverride1.value = v,
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
              placeholder: 'RewardFactionID2',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionId2.value,
                onChanged: (v) => vm.rewardFactionId2.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望值2',
              placeholder: 'RewardFactionValue2',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionValue2.value,
                onChanged: (v) => vm.rewardFactionValue2.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望覆盖2',
              placeholder: 'RewardFactionOverride2',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionOverride2.value,
                onChanged: (v) => vm.rewardFactionOverride2.value = v,
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
              placeholder: 'RewardFactionID3',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionId3.value,
                onChanged: (v) => vm.rewardFactionId3.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望值3',
              placeholder: 'RewardFactionValue3',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionValue3.value,
                onChanged: (v) => vm.rewardFactionValue3.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望覆盖3',
              placeholder: 'RewardFactionOverride3',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionOverride3.value,
                onChanged: (v) => vm.rewardFactionOverride3.value = v,
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
              placeholder: 'RewardFactionID4',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionId4.value,
                onChanged: (v) => vm.rewardFactionId4.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望值4',
              placeholder: 'RewardFactionValue4',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionValue4.value,
                onChanged: (v) => vm.rewardFactionValue4.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望覆盖4',
              placeholder: 'RewardFactionOverride4',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionOverride4.value,
                onChanged: (v) => vm.rewardFactionOverride4.value = v,
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
              placeholder: 'RewardFactionID5',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionId5.value,
                onChanged: (v) => vm.rewardFactionId5.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望值5',
              placeholder: 'RewardFactionValue5',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionValue5.value,
                onChanged: (v) => vm.rewardFactionValue5.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '声望覆盖5',
              placeholder: 'RewardFactionOverride5',
              child: FoxyNumberInput<int>(
                value: vm.rewardFactionOverride5.value,
                onChanged: (v) => vm.rewardFactionOverride5.value = v,
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
              placeholder: 'POIContinent',
              child: FoxyNumberInput<int>(
                value: vm.poiContinent.value,
                onChanged: (v) => vm.poiContinent.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: 'POI X',
              placeholder: 'POIx',
              child: FoxyNumberInput<double>(
                value: vm.poiX.value,
                onChanged: (v) => vm.poiX.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: 'POI Y',
              placeholder: 'POIy',
              child: FoxyNumberInput<double>(
                value: vm.poiY.value,
                onChanged: (v) => vm.poiY.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: 'POI优先级',
              placeholder: 'POIPriority',
              child: FoxyNumberInput<int>(
                value: vm.poiPriority.value,
                onChanged: (v) => vm.poiPriority.value = v,
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
              placeholder: 'TimeAllowed',
              child: FoxyNumberInput<int>(
                value: vm.timeAllowed.value,
                onChanged: (v) => vm.timeAllowed.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '允许种族',
              placeholder: 'AllowableRaces',
              child: FoxyNumberInput<int>(
                value: vm.allowableRaces.value,
                onChanged: (v) => vm.allowableRaces.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '未知0',
              placeholder: 'Unknown0',
              child: FoxyNumberInput<int>(
                value: vm.unknown0.value,
                onChanged: (v) => vm.unknown0.value = v,
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
