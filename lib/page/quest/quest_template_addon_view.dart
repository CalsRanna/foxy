import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_template_addon_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestTemplateAddonView extends StatefulWidget {
  final int questId;
  const QuestTemplateAddonView({super.key, required this.questId});

  @override
  State<QuestTemplateAddonView> createState() => _QuestTemplateAddonViewState();
}

class _QuestTemplateAddonViewState extends State<QuestTemplateAddonView> {
  final viewModel = GetIt.instance.get<QuestTemplateAddonViewModel>();

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

    final rows = [
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.idController, label: '编号', readOnly: true)),
        Expanded(child: FormItem(controller: vm.maxLevelController, label: '最大等级', placeholder: 'MaxLevel')),
        Expanded(child: FormItem(controller: vm.allowableClassesController, label: '允许职业', placeholder: 'AllowableClasses')),
        Expanded(child: FormItem(controller: vm.sourceSpellIdController, label: '来源法术', placeholder: 'SourceSpellId')),
      ]),
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.prevQuestIdController, label: '前置任务', placeholder: 'PrevQuestID')),
        Expanded(child: FormItem(controller: vm.nextQuestIdController, label: '后续任务', placeholder: 'NextQuestID')),
        Expanded(child: FormItem(controller: vm.exclusiveGroupController, label: '互斥组', placeholder: 'ExclusiveGroup')),
        Expanded(child: SizedBox()),
      ]),
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.rewardMailTemplateIdController, label: '奖励邮件模板', placeholder: 'RewardMailTemplateId')),
        Expanded(child: FormItem(controller: vm.rewardMailDelayController, label: '奖励邮件延迟', placeholder: 'RewardMailDelay')),
        Expanded(child: FormItem(controller: vm.requiredSkillIdController, label: '需要技能', placeholder: 'RequiredSkillId')),
        Expanded(child: FormItem(controller: vm.requiredSkillPointsController, label: '需要技能点数', placeholder: 'RequiredSkillPoints')),
      ]),
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.requiredMinRepFactionController, label: '最低声望阵营', placeholder: 'RequiredMinRepFaction')),
        Expanded(child: FormItem(controller: vm.requiredMaxRepFactionController, label: '最高声望阵营', placeholder: 'RequiredMaxRepFaction')),
        Expanded(child: FormItem(controller: vm.requiredMinRepValueController, label: '最低声望值', placeholder: 'RequiredMinRepValue')),
        Expanded(child: FormItem(controller: vm.requiredMaxRepValueController, label: '最高声望值', placeholder: 'RequiredMaxRepValue')),
      ]),
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.providedItemCountController, label: '提供物品数量', placeholder: 'ProvidedItemCount')),
        Expanded(child: FormItem(controller: vm.specialFlagsController, label: '特殊标志', placeholder: 'SpecialFlags')),
        Expanded(child: SizedBox()),
        Expanded(child: SizedBox()),
      ]),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: rows),
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
      ),
    );
  }
}