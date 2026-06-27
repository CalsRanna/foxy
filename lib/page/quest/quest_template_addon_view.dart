import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_template_addon_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
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
              label: '最大等级',
              placeholder: 'MaxLevel',
              child: FoxyNumberInput<int>(
                controller: vm.maxLevelController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '允许职业',
              placeholder: 'AllowableClasses',
              child: FoxyNumberInput<int>(
                controller: vm.allowableClassesController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '来源法术',
              placeholder: 'SourceSpellId',
              child: FoxyNumberInput<int>(
                controller: vm.sourceSpellIdController,
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
              label: '前置任务',
              placeholder: 'PrevQuestID',
              child: FoxyNumberInput<int>(
                controller: vm.prevQuestIdController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '后续任务',
              placeholder: 'NextQuestID',
              child: FoxyNumberInput<int>(
                controller: vm.nextQuestIdController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '互斥组',
              placeholder: 'ExclusiveGroup',
              child: FoxyNumberInput<int>(
                controller: vm.exclusiveGroupController,
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
              label: '奖励邮件模板',
              placeholder: 'RewardMailTemplateId',
              child: FoxyNumberInput<int>(
                controller: vm.rewardMailTemplateIdController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励邮件延迟',
              placeholder: 'RewardMailDelay',
              child: FoxyNumberInput<int>(
                controller: vm.rewardMailDelayController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要技能',
              placeholder: 'RequiredSkillId',
              child: FoxyNumberInput<int>(
                controller: vm.requiredSkillIdController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要技能点数',
              placeholder: 'RequiredSkillPoints',
              child: FoxyNumberInput<int>(
                controller: vm.requiredSkillPointsController,
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
              label: '最低声望阵营',
              placeholder: 'RequiredMinRepFaction',
              child: FoxyNumberInput<int>(
                controller: vm.requiredMinRepFactionController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '最高声望阵营',
              placeholder: 'RequiredMaxRepFaction',
              child: FoxyNumberInput<int>(
                controller: vm.requiredMaxRepFactionController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '最低声望值',
              placeholder: 'RequiredMinRepValue',
              child: FoxyNumberInput<int>(
                controller: vm.requiredMinRepValueController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '最高声望值',
              placeholder: 'RequiredMaxRepValue',
              child: FoxyNumberInput<int>(
                controller: vm.requiredMaxRepValueController,
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
              label: '提供物品数量',
              placeholder: 'ProvidedItemCount',
              child: FoxyNumberInput<int>(
                controller: vm.providedItemCountController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '特殊标志',
              placeholder: 'SpecialFlags',
              child: FoxyNumberInput<int>(
                controller: vm.specialFlagsController,
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
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
