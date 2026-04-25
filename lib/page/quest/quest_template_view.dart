import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestTemplateView extends StatefulWidget {
  final QuestTemplateDetailViewModel viewModel;
  const QuestTemplateView({super.key, required this.viewModel});

  @override
  State<QuestTemplateView> createState() => _QuestTemplateViewState();
}

class _QuestTemplateViewState extends State<QuestTemplateView> {
  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;
    final fields = Column(
      spacing: 8,
      children: [
        FormItem(
          controller: vm.controllerOf('ID'),
          label: '编号',
          placeholder: 'ID',
          readOnly: true,
        ),
        FormItem(
          controller: vm.controllerOf('QuestType'),
          label: '任务类型',
          placeholder: 'QuestType',
        ),
        FormItem(
          controller: vm.controllerOf('QuestLevel'),
          label: '任务等级',
          placeholder: 'QuestLevel',
        ),
        FormItem(
          controller: vm.controllerOf('MinLevel'),
          label: '最低等级',
          placeholder: 'MinLevel',
        ),
        FormItem(
          controller: vm.controllerOf('QuestSortID'),
          label: '任务分类',
          placeholder: 'QuestSortID',
        ),
        FormItem(
          controller: vm.controllerOf('QuestInfoID'),
          label: '任务信息',
          placeholder: 'QuestInfoID',
        ),
        FormItem(
          controller: vm.controllerOf('SuggestedGroupNum'),
          label: '建议组人数',
          placeholder: 'SuggestedGroupNum',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredFactionId1'),
          label: '需要阵营1',
          placeholder: 'RequiredFactionId1',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredFactionId2'),
          label: '需要阵营2',
          placeholder: 'RequiredFactionId2',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredFactionValue1'),
          label: '阵营值1',
          placeholder: 'RequiredFactionValue1',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredFactionValue2'),
          label: '阵营值2',
          placeholder: 'RequiredFactionValue2',
        ),
        FormItem(
          controller: vm.controllerOf('RewardNextQuest'),
          label: '下一个任务',
          placeholder: 'RewardNextQuest',
        ),
        FormItem(
          controller: vm.controllerOf('RewardXPDifficulty'),
          label: '经验奖励难度',
          placeholder: 'RewardXPDifficulty',
        ),
        FormItem(
          controller: vm.controllerOf('RewardMoney'),
          label: '金币奖励',
          placeholder: 'RewardMoney',
        ),
        FormItem(
          controller: vm.controllerOf('RewardMoneyDifficulty'),
          label: '金币奖励难度',
          placeholder: 'RewardMoneyDifficulty',
        ),
        FormItem(
          controller: vm.controllerOf('RewardDisplaySpell'),
          label: '展示法术奖励',
          placeholder: 'RewardDisplaySpell',
        ),
        FormItem(
          controller: vm.controllerOf('RewardSpell'),
          label: '法术奖励',
          placeholder: 'RewardSpell',
        ),
        FormItem(
          controller: vm.controllerOf('RewardHonor'),
          label: '荣誉奖励',
          placeholder: 'RewardHonor',
        ),
        FormItem(
          controller: vm.controllerOf('RewardKillHonor'),
          label: '杀敌荣誉',
          placeholder: 'RewardKillHonor',
        ),
        FormItem(
          controller: vm.controllerOf('StartItem'),
          label: '起始物品',
          placeholder: 'StartItem',
        ),
        FormItem(
          controller: vm.controllerOf('Flags'),
          label: '标志',
          placeholder: 'Flags',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredPlayerKills'),
          label: '需要玩家击杀',
          placeholder: 'RequiredPlayerKills',
        ),
        FormItem(
          controller: vm.controllerOf('RewardItem1'),
          label: '奖励物品1',
          placeholder: 'RewardItem1',
        ),
        FormItem(
          controller: vm.controllerOf('RewardAmount1'),
          label: '奖励数量1',
          placeholder: 'RewardAmount1',
        ),
        FormItem(
          controller: vm.controllerOf('RewardItem2'),
          label: '奖励物品2',
          placeholder: 'RewardItem2',
        ),
        FormItem(
          controller: vm.controllerOf('RewardAmount2'),
          label: '奖励数量2',
          placeholder: 'RewardAmount2',
        ),
        FormItem(
          controller: vm.controllerOf('RewardItem3'),
          label: '奖励物品3',
          placeholder: 'RewardItem3',
        ),
        FormItem(
          controller: vm.controllerOf('RewardAmount3'),
          label: '奖励数量3',
          placeholder: 'RewardAmount3',
        ),
        FormItem(
          controller: vm.controllerOf('RewardItem4'),
          label: '奖励物品4',
          placeholder: 'RewardItem4',
        ),
        FormItem(
          controller: vm.controllerOf('RewardAmount4'),
          label: '奖励数量4',
          placeholder: 'RewardAmount4',
        ),
        FormItem(
          controller: vm.controllerOf('ItemDrop1'),
          label: '掉落物品1',
          placeholder: 'ItemDrop1',
        ),
        FormItem(
          controller: vm.controllerOf('ItemDropQuantity1'),
          label: '掉落数量1',
          placeholder: 'ItemDropQuantity1',
        ),
        FormItem(
          controller: vm.controllerOf('ItemDrop2'),
          label: '掉落物品2',
          placeholder: 'ItemDrop2',
        ),
        FormItem(
          controller: vm.controllerOf('ItemDropQuantity2'),
          label: '掉落数量2',
          placeholder: 'ItemDropQuantity2',
        ),
        FormItem(
          controller: vm.controllerOf('ItemDrop3'),
          label: '掉落物品3',
          placeholder: 'ItemDrop3',
        ),
        FormItem(
          controller: vm.controllerOf('ItemDropQuantity3'),
          label: '掉落数量3',
          placeholder: 'ItemDropQuantity3',
        ),
        FormItem(
          controller: vm.controllerOf('ItemDrop4'),
          label: '掉落物品4',
          placeholder: 'ItemDrop4',
        ),
        FormItem(
          controller: vm.controllerOf('ItemDropQuantity4'),
          label: '掉落数量4',
          placeholder: 'ItemDropQuantity4',
        ),
        FormItem(
          controller: vm.controllerOf('RewardChoiceItemID1'),
          label: '选择奖励物品1',
          placeholder: 'RewardChoiceItemID1',
        ),
        FormItem(
          controller: vm.controllerOf('RewardChoiceItemQuantity1'),
          label: '选择奖励数量1',
          placeholder: 'RewardChoiceItemQuantity1',
        ),
        FormItem(
          controller: vm.controllerOf('RewardChoiceItemID2'),
          label: '选择奖励物品2',
          placeholder: 'RewardChoiceItemID2',
        ),
        FormItem(
          controller: vm.controllerOf('RewardChoiceItemQuantity2'),
          label: '选择奖励数量2',
          placeholder: 'RewardChoiceItemQuantity2',
        ),
        FormItem(
          controller: vm.controllerOf('RewardChoiceItemID3'),
          label: '选择奖励物品3',
          placeholder: 'RewardChoiceItemID3',
        ),
        FormItem(
          controller: vm.controllerOf('RewardChoiceItemQuantity3'),
          label: '选择奖励数量3',
          placeholder: 'RewardChoiceItemQuantity3',
        ),
        FormItem(
          controller: vm.controllerOf('RewardChoiceItemID4'),
          label: '选择奖励物品4',
          placeholder: 'RewardChoiceItemID4',
        ),
        FormItem(
          controller: vm.controllerOf('RewardChoiceItemQuantity4'),
          label: '选择奖励数量4',
          placeholder: 'RewardChoiceItemQuantity4',
        ),
        FormItem(
          controller: vm.controllerOf('RewardChoiceItemID5'),
          label: '选择奖励物品5',
          placeholder: 'RewardChoiceItemID5',
        ),
        FormItem(
          controller: vm.controllerOf('RewardChoiceItemQuantity5'),
          label: '选择奖励数量5',
          placeholder: 'RewardChoiceItemQuantity5',
        ),
        FormItem(
          controller: vm.controllerOf('RewardChoiceItemID6'),
          label: '选择奖励物品6',
          placeholder: 'RewardChoiceItemID6',
        ),
        FormItem(
          controller: vm.controllerOf('RewardChoiceItemQuantity6'),
          label: '选择奖励数量6',
          placeholder: 'RewardChoiceItemQuantity6',
        ),
        FormItem(
          controller: vm.controllerOf('POIContinent'),
          label: 'POI大陆',
          placeholder: 'POIContinent',
        ),
        FormItem(
          controller: vm.controllerOf('POIx'),
          label: 'POI X坐标',
          placeholder: 'POIx',
        ),
        FormItem(
          controller: vm.controllerOf('POIy'),
          label: 'POI Y坐标',
          placeholder: 'POIy',
        ),
        FormItem(
          controller: vm.controllerOf('POIPriority'),
          label: 'POI优先级',
          placeholder: 'POIPriority',
        ),
        FormItem(
          controller: vm.controllerOf('RewardTitle'),
          label: '奖励头衔',
          placeholder: 'RewardTitle',
        ),
        FormItem(
          controller: vm.controllerOf('RewardTalents'),
          label: '奖励天赋点',
          placeholder: 'RewardTalents',
        ),
        FormItem(
          controller: vm.controllerOf('RewardArenaPoints'),
          label: '奖励竞技场点数',
          placeholder: 'RewardArenaPoints',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionID1'),
          label: '奖励声望阵营1',
          placeholder: 'RewardFactionID1',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionValue1'),
          label: '奖励声望值1',
          placeholder: 'RewardFactionValue1',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionOverride1'),
          label: '奖励声望覆盖1',
          placeholder: 'RewardFactionOverride1',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionID2'),
          label: '奖励声望阵营2',
          placeholder: 'RewardFactionID2',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionValue2'),
          label: '奖励声望值2',
          placeholder: 'RewardFactionValue2',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionOverride2'),
          label: '奖励声望覆盖2',
          placeholder: 'RewardFactionOverride2',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionID3'),
          label: '奖励声望阵营3',
          placeholder: 'RewardFactionID3',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionValue3'),
          label: '奖励声望值3',
          placeholder: 'RewardFactionValue3',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionOverride3'),
          label: '奖励声望覆盖3',
          placeholder: 'RewardFactionOverride3',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionID4'),
          label: '奖励声望阵营4',
          placeholder: 'RewardFactionID4',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionValue4'),
          label: '奖励声望值4',
          placeholder: 'RewardFactionValue4',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionOverride4'),
          label: '奖励声望覆盖4',
          placeholder: 'RewardFactionOverride4',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionID5'),
          label: '奖励声望阵营5',
          placeholder: 'RewardFactionID5',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionValue5'),
          label: '奖励声望值5',
          placeholder: 'RewardFactionValue5',
        ),
        FormItem(
          controller: vm.controllerOf('RewardFactionOverride5'),
          label: '奖励声望覆盖5',
          placeholder: 'RewardFactionOverride5',
        ),
        FormItem(
          controller: vm.controllerOf('TimeAllowed'),
          label: '允许时间',
          placeholder: 'TimeAllowed',
        ),
        FormItem(
          controller: vm.controllerOf('AllowableRaces'),
          label: '允许种族',
          placeholder: 'AllowableRaces',
        ),
        FormItem(
          controller: vm.controllerOf('LogTitle'),
          label: '日志标题',
          placeholder: 'LogTitle',
        ),
        FormItem(
          controller: vm.controllerOf('LogDescription'),
          label: '日志描述',
          placeholder: 'LogDescription',
        ),
        FormItem(
          controller: vm.controllerOf('QuestDescription'),
          label: '任务描述',
          placeholder: 'QuestDescription',
        ),
        FormItem(
          controller: vm.controllerOf('AreaDescription'),
          label: '区域描述',
          placeholder: 'AreaDescription',
        ),
        FormItem(
          controller: vm.controllerOf('QuestCompletionLog'),
          label: '完成日志',
          placeholder: 'QuestCompletionLog',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredNpcOrGo1'),
          label: '需要NPC/GO1',
          placeholder: 'RequiredNpcOrGo1',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredNpcOrGo2'),
          label: '需要NPC/GO2',
          placeholder: 'RequiredNpcOrGo2',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredNpcOrGo3'),
          label: '需要NPC/GO3',
          placeholder: 'RequiredNpcOrGo3',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredNpcOrGo4'),
          label: '需要NPC/GO4',
          placeholder: 'RequiredNpcOrGo4',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredNpcOrGoCount1'),
          label: '需要NPC/GO数量1',
          placeholder: 'RequiredNpcOrGoCount1',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredNpcOrGoCount2'),
          label: '需要NPC/GO数量2',
          placeholder: 'RequiredNpcOrGoCount2',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredNpcOrGoCount3'),
          label: '需要NPC/GO数量3',
          placeholder: 'RequiredNpcOrGoCount3',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredNpcOrGoCount4'),
          label: '需要NPC/GO数量4',
          placeholder: 'RequiredNpcOrGoCount4',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredItemId1'),
          label: '需要物品1',
          placeholder: 'RequiredItemId1',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredItemId2'),
          label: '需要物品2',
          placeholder: 'RequiredItemId2',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredItemId3'),
          label: '需要物品3',
          placeholder: 'RequiredItemId3',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredItemId4'),
          label: '需要物品4',
          placeholder: 'RequiredItemId4',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredItemId5'),
          label: '需要物品5',
          placeholder: 'RequiredItemId5',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredItemId6'),
          label: '需要物品6',
          placeholder: 'RequiredItemId6',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredItemCount1'),
          label: '需要物品数量1',
          placeholder: 'RequiredItemCount1',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredItemCount2'),
          label: '需要物品数量2',
          placeholder: 'RequiredItemCount2',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredItemCount3'),
          label: '需要物品数量3',
          placeholder: 'RequiredItemCount3',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredItemCount4'),
          label: '需要物品数量4',
          placeholder: 'RequiredItemCount4',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredItemCount5'),
          label: '需要物品数量5',
          placeholder: 'RequiredItemCount5',
        ),
        FormItem(
          controller: vm.controllerOf('RequiredItemCount6'),
          label: '需要物品数量6',
          placeholder: 'RequiredItemCount6',
        ),
        FormItem(
          controller: vm.controllerOf('Unknown0'),
          label: '未知0',
          placeholder: 'Unknown0',
        ),
        FormItem(
          controller: vm.controllerOf('ObjectiveText1'),
          label: '目标文本1',
          placeholder: 'ObjectiveText1',
        ),
        FormItem(
          controller: vm.controllerOf('ObjectiveText2'),
          label: '目标文本2',
          placeholder: 'ObjectiveText2',
        ),
        FormItem(
          controller: vm.controllerOf('ObjectiveText3'),
          label: '目标文本3',
          placeholder: 'ObjectiveText3',
        ),
        FormItem(
          controller: vm.controllerOf('ObjectiveText4'),
          label: '目标文本4',
          placeholder: 'ObjectiveText4',
        ),
        FormItem(
          controller: vm.controllerOf('VerifiedBuild'),
          label: '验证版本',
          placeholder: 'VerifiedBuild',
        ),
        ShadButton(onPressed: vm.onSave, child: Text('保存')),
      ],
    );
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: fields,
    );
  }
}