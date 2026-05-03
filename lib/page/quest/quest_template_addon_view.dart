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
                value: vm.id.value,
                readOnly: true,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '最大等级',
              placeholder: 'MaxLevel',
              child: FoxyNumberInput<int>(
                value: vm.maxLevel.value,
                onChanged: (v) => vm.maxLevel.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '允许职业',
              placeholder: 'AllowableClasses',
              child: FoxyNumberInput<int>(
                value: vm.allowableClasses.value,
                onChanged: (v) => vm.allowableClasses.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '来源法术',
              placeholder: 'SourceSpellId',
              child: FoxyNumberInput<int>(
                value: vm.sourceSpellId.value,
                onChanged: (v) => vm.sourceSpellId.value = v,
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
                value: vm.prevQuestId.value,
                onChanged: (v) => vm.prevQuestId.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '后续任务',
              placeholder: 'NextQuestID',
              child: FoxyNumberInput<int>(
                value: vm.nextQuestId.value,
                onChanged: (v) => vm.nextQuestId.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '互斥组',
              placeholder: 'ExclusiveGroup',
              child: FoxyNumberInput<int>(
                value: vm.exclusiveGroup.value,
                onChanged: (v) => vm.exclusiveGroup.value = v,
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
                value: vm.rewardMailTemplateId.value,
                onChanged: (v) => vm.rewardMailTemplateId.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '奖励邮件延迟',
              placeholder: 'RewardMailDelay',
              child: FoxyNumberInput<int>(
                value: vm.rewardMailDelay.value,
                onChanged: (v) => vm.rewardMailDelay.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要技能',
              placeholder: 'RequiredSkillId',
              child: FoxyNumberInput<int>(
                value: vm.requiredSkillId.value,
                onChanged: (v) => vm.requiredSkillId.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '需要技能点数',
              placeholder: 'RequiredSkillPoints',
              child: FoxyNumberInput<int>(
                value: vm.requiredSkillPoints.value,
                onChanged: (v) => vm.requiredSkillPoints.value = v,
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
                value: vm.requiredMinRepFaction.value,
                onChanged: (v) => vm.requiredMinRepFaction.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '最高声望阵营',
              placeholder: 'RequiredMaxRepFaction',
              child: FoxyNumberInput<int>(
                value: vm.requiredMaxRepFaction.value,
                onChanged: (v) => vm.requiredMaxRepFaction.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '最低声望值',
              placeholder: 'RequiredMinRepValue',
              child: FoxyNumberInput<int>(
                value: vm.requiredMinRepValue.value,
                onChanged: (v) => vm.requiredMinRepValue.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '最高声望值',
              placeholder: 'RequiredMaxRepValue',
              child: FoxyNumberInput<int>(
                value: vm.requiredMaxRepValue.value,
                onChanged: (v) => vm.requiredMaxRepValue.value = v,
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
                value: vm.providedItemCount.value,
                onChanged: (v) => vm.providedItemCount.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '特殊标志',
              placeholder: 'SpecialFlags',
              child: FoxyNumberInput<int>(
                value: vm.specialFlags.value,
                onChanged: (v) => vm.specialFlags.value = v,
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
