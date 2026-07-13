import 'package:flutter/material.dart';
import 'package:foxy/constant/item_flags.dart';
import 'package:foxy/constant/quest_flags.dart';
import 'package:foxy/page/quest/quest_template_addon_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
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
            child: FoxyFormItem(
              label: '编号',
              child: FoxyNumberInput<int>(
                controller: vm.idController,
                readOnly: true,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '最大等级',
              child: FoxyNumberInput<int>(
                controller: vm.maxLevelController,
                placeholder: 'MaxLevel',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '允许职业',
              child: FoxyFlagPicker(
                controller: vm.allowableClassesController,
                placeholder: 'AllowableClasses',
                flags: kAllowableClassOptions,
                title: '允许职业',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '来源法术',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.spell,
                controller: vm.sourceSpellIdController,
                placeholder: 'SourceSpellId',
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
              label: '前置任务',
              child: FoxyNumberInput<int>(
                controller: vm.prevQuestIdController,
                placeholder: 'PrevQuestID',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '后续任务',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.questTemplate,
                controller: vm.nextQuestIdController,
                placeholder: 'NextQuestID',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '互斥组',
              child: FoxyNumberInput<int>(
                controller: vm.exclusiveGroupController,
                placeholder: 'ExclusiveGroup',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '面包屑目标任务',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.questTemplate,
                controller: vm.breadcrumbForQuestIdController,
                placeholder: 'BreadcrumbForQuestId',
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
              label: '奖励邮件模板',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.mailTemplate,
                controller: vm.rewardMailTemplateIdController,
                placeholder: 'RewardMailTemplateId',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '奖励邮件延迟',
              child: FoxyNumberInput<int>(
                controller: vm.rewardMailDelayController,
                placeholder: 'RewardMailDelay',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要技能',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.skillLine,
                controller: vm.requiredSkillIdController,
                placeholder: 'RequiredSkillId',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '需要技能点数',
              child: FoxyNumberInput<int>(
                controller: vm.requiredSkillPointsController,
                placeholder: 'RequiredSkillPoints',
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
              label: '最低声望阵营',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcFaction,
                controller: vm.requiredMinRepFactionController,
                placeholder: 'RequiredMinRepFaction',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '最高声望阵营',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcFaction,
                controller: vm.requiredMaxRepFactionController,
                placeholder: 'RequiredMaxRepFaction',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '最低声望值',
              child: FoxyNumberInput<int>(
                controller: vm.requiredMinRepValueController,
                placeholder: 'RequiredMinRepValue',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '最高声望值',
              child: FoxyNumberInput<int>(
                controller: vm.requiredMaxRepValueController,
                placeholder: 'RequiredMaxRepValue',
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
              label: '提供物品数量',
              child: FoxyNumberInput<int>(
                controller: vm.providedItemCountController,
                placeholder: 'ProvidedItemCount',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '特殊标志',
              child: FoxyFlagPicker(
                controller: vm.specialFlagsController,
                placeholder: 'SpecialFlags',
                flags: kQuestSpecialFlagOptions,
                title: '任务特殊标志',
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
          FoxyFormSection(title: '基本信息', children: rows),
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
