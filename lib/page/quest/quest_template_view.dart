import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/constant/item_flags.dart';
import 'package:foxy/constant/quest_enums.dart';
import 'package:foxy/constant/quest_flags.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/page/quest/quest_objective_target_picker.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/page/quest/area_table_or_quest_sort_selector.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class QuestTemplateView extends StatelessWidget {
  final QuestTemplateDetailViewModel viewModel;

  const QuestTemplateView({super.key, required this.viewModel});

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
              child: FoxyNumberInput<int>(controller: vm.idController),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '任务方式',
              child: FoxyShadSelect<int>(
                controller: vm.questTypeController,
                options: kQuestMethodOptions,
                placeholder: const Text('QuestType'),
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '任务等级',
              child: FoxyNumberInput<int>(
                placeholder: 'QuestLevel',
                controller: vm.questLevelController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '任务分类',
              child: AreaTableOrQuestSortSelector(
                controller: vm.questSortIdController,
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
                controller: vm.questInfoIdController,
                placeholder: 'QuestInfoID',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '建议组人数',
              child: FoxyNumberInput<int>(
                placeholder: 'SuggestedGroupNum',
                controller: vm.suggestedGroupNumController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '标志',
              child: FoxyFlagPicker(
                placeholder: 'Flags',
                controller: vm.flagsController,
                flags: kQuestFlagOptions,
                title: '任务标志',
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
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcFaction,
                placeholder: 'RequiredFactionId1',
                controller: vm.requiredFactionId1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要阵营2',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcFaction,
                placeholder: 'RequiredFactionId2',
                controller: vm.requiredFactionId2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '阵营值1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredFactionValue1',
                controller: vm.requiredFactionValue1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '需要NPC/GO1',
              child: QuestObjectiveTargetPicker(
                placeholder: 'RequiredNpcOrGo1',
                controller: vm.requiredNpcOrGo1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要NPC/GO2',
              child: QuestObjectiveTargetPicker(
                placeholder: 'RequiredNpcOrGo2',
                controller: vm.requiredNpcOrGo2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要NPC/GO3',
              child: QuestObjectiveTargetPicker(
                placeholder: 'RequiredNpcOrGo3',
                controller: vm.requiredNpcOrGo3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要NPC/GO4',
              child: QuestObjectiveTargetPicker(
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
            child: FoxyFormItem(
              label: '需要数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGoCount1',
                controller: vm.requiredNpcOrGoCount1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要数量2',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGoCount2',
                controller: vm.requiredNpcOrGoCount2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredNpcOrGoCount3',
                controller: vm.requiredNpcOrGoCount3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '需要物品1',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RequiredItemId1',
                controller: vm.requiredItemId1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要物品2',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RequiredItemId2',
                controller: vm.requiredItemId2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要物品3',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RequiredItemId3',
                controller: vm.requiredItemId3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要物品4',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
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
            child: FoxyFormItem(
              label: '需要物品5',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RequiredItemId5',
                controller: vm.requiredItemId5Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要物品6',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RequiredItemId6',
                controller: vm.requiredItemId6Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '物品数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount1',
                controller: vm.requiredItemCount1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '物品数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount3',
                controller: vm.requiredItemCount3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '物品数量4',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount4',
                controller: vm.requiredItemCount4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '物品数量5',
              child: FoxyNumberInput<int>(
                placeholder: 'RequiredItemCount5',
                controller: vm.requiredItemCount5Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '起始物品',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'StartItem',
                controller: vm.startItemController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '下一个任务',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.questTemplate,
                placeholder: 'RewardNextQuest',
                controller: vm.rewardNextQuestController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '经验难度',
              child: FoxyShadSelect<int>(
                controller: vm.rewardXpDifficultyController,
                options: kQuestRewardDifficultyOptions,
                placeholder: const Text('RewardXPDifficulty'),
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '金币奖励',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardMoney',
                controller: vm.rewardMoneyController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '金币难度',
              child: FoxyShadSelect<int>(
                controller: vm.rewardMoneyDifficultyController,
                options: kQuestRewardDifficultyOptions,
                placeholder: const Text('RewardMoneyDifficulty'),
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
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.spell,
                placeholder: 'RewardDisplaySpell',
                controller: vm.rewardDisplaySpellController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '法术奖励',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.spell,
                placeholder: 'RewardSpell',
                controller: vm.rewardSpellController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '荣誉奖励',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardHonor',
                controller: vm.rewardHonorController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '奖励头衔',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.charTitle,
                controller: vm.rewardTitleController,
                placeholder: 'RewardTitle',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '奖励天赋',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardTalents',
                controller: vm.rewardTalentsController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '奖励物品1',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RewardItem1',
                controller: vm.rewardItem1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '奖励数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardAmount1',
                controller: vm.rewardAmount1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '奖励物品2',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RewardItem2',
                controller: vm.rewardItem2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '奖励物品3',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RewardItem3',
                controller: vm.rewardItem3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '奖励数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardAmount3',
                controller: vm.rewardAmount3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '奖励物品4',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RewardItem4',
                controller: vm.rewardItem4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '可选奖励1',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RewardChoiceItemID1',
                controller: vm.rewardChoiceItemId1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity1',
                controller: vm.rewardChoiceItemQuantity1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选奖励2',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RewardChoiceItemID2',
                controller: vm.rewardChoiceItemId2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '可选奖励3',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RewardChoiceItemID3',
                controller: vm.rewardChoiceItemId3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity3',
                controller: vm.rewardChoiceItemQuantity3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选奖励4',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RewardChoiceItemID4',
                controller: vm.rewardChoiceItemId4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '可选奖励5',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RewardChoiceItemID5',
                controller: vm.rewardChoiceItemId5Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选数量5',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardChoiceItemQuantity5',
                controller: vm.rewardChoiceItemQuantity5Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '可选奖励6',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'RewardChoiceItemID6',
                controller: vm.rewardChoiceItemId6Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '掉落物品1',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'ItemDrop1',
                controller: vm.itemDrop1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '掉落数量1',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDropQuantity1',
                controller: vm.itemDropQuantity1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '掉落物品2',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'ItemDrop2',
                controller: vm.itemDrop2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '掉落物品3',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'ItemDrop3',
                controller: vm.itemDrop3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '掉落数量3',
              child: FoxyNumberInput<int>(
                placeholder: 'ItemDropQuantity3',
                controller: vm.itemDropQuantity3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '掉落物品4',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.itemTemplate,
                placeholder: 'ItemDrop4',
                controller: vm.itemDrop4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '声望阵营1',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcFaction,
                placeholder: 'RewardFactionID1',
                controller: vm.rewardFactionId1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望值1',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue1',
                controller: vm.rewardFactionValue1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '声望阵营2',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcFaction,
                placeholder: 'RewardFactionID2',
                controller: vm.rewardFactionId2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望值2',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue2',
                controller: vm.rewardFactionValue2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '声望阵营3',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcFaction,
                placeholder: 'RewardFactionID3',
                controller: vm.rewardFactionId3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望值3',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue3',
                controller: vm.rewardFactionValue3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '声望阵营4',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcFaction,
                placeholder: 'RewardFactionID4',
                controller: vm.rewardFactionId4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望值4',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue4',
                controller: vm.rewardFactionValue4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '声望阵营5',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcFaction,
                placeholder: 'RewardFactionID5',
                controller: vm.rewardFactionId5Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '声望值5',
              child: FoxyNumberInput<int>(
                placeholder: 'RewardFactionValue5',
                controller: vm.rewardFactionValue5Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '日志标题',
              child: FoxyLocalePicker(
                entry: viewModel.persistedKey.value,
                controller: vm.logTitleController,
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
                entry: viewModel.persistedKey.value,
                controller: vm.logDescriptionController,
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
                entry: viewModel.persistedKey.value,
                controller: vm.questDescriptionController,
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
                entry: viewModel.persistedKey.value,
                controller: vm.areaDescriptionController,
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
                entry: viewModel.persistedKey.value,
                controller: vm.questCompletionLogController,
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
              child: FoxyLocalePicker(
                entry: viewModel.persistedKey.value,
                controller: vm.objectiveText1Controller,
                delegate: FoxyLocalePickerDelegates.questTemplate,
                placeholder: 'ObjectiveText1',
                title: '目标文本1',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '目标文本2',
              child: FoxyLocalePicker(
                entry: viewModel.persistedKey.value,
                controller: vm.objectiveText2Controller,
                delegate: FoxyLocalePickerDelegates.questTemplate,
                placeholder: 'ObjectiveText2',
                title: '目标文本2',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '目标文本3',
              child: FoxyLocalePicker(
                entry: viewModel.persistedKey.value,
                controller: vm.objectiveText3Controller,
                delegate: FoxyLocalePickerDelegates.questTemplate,
                placeholder: 'ObjectiveText3',
                title: '目标文本3',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '目标文本4',
              child: FoxyLocalePicker(
                entry: viewModel.persistedKey.value,
                controller: vm.objectiveText4Controller,
                delegate: FoxyLocalePickerDelegates.questTemplate,
                placeholder: 'ObjectiveText4',
                title: '目标文本4',
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
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.map,
                placeholder: 'POIContinent',
                controller: vm.poiContinentController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: 'POI X',
              child: FoxyNumberInput<double>(
                placeholder: 'POIx',
                controller: vm.poiXController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: 'POI Y',
              child: FoxyNumberInput<double>(
                placeholder: 'POIy',
                controller: vm.poiYController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '允许时间',
              child: FoxyNumberInput<int>(
                placeholder: 'TimeAllowed',
                controller: vm.timeAllowedController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '允许种族',
              child: FoxyFlagPicker(
                placeholder: 'AllowableRaces',
                controller: vm.allowableRacesController,
                flags: kAllowableRaceOptions,
                title: '允许种族',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '未知0',
              child: FoxyNumberInput<int>(
                placeholder: 'Unknown0',
                controller: vm.unknown0Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '验证版本',
              child: FoxyNumberInput<int>(
                controller: vm.verifiedBuildController,
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
              Watch(
                (_) => ShadButton(
                  enabled: !viewModel.submitting.value,
                  onPressed: () => _persist(context),
                  child: Text('保存'),
                ),
              ),
              ShadButton.ghost(onPressed: _goBack, child: Text('取消')),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _persist(BuildContext context) async {
    try {
      await viewModel.persist();
      if (!context.mounted) return;
      GetIt.instance.get<RouterFacade>().updateCurrentLabel(
        '任务 ${viewModel.persistedKey.value}',
      );
      ShadSonner.of(
        context,
      ).show(const ShadToast(description: Text('模板数据已保存')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }
}
