import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_template_addon_view_model.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class QuestTemplateAddonView extends StatefulWidget {
  final QuestTemplateDetailViewModel parentViewModel;

  const QuestTemplateAddonView({super.key, required this.parentViewModel});

  @override
  State<QuestTemplateAddonView> createState() => _QuestTemplateAddonViewState();
}

class _QuestTemplateAddonViewState extends State<QuestTemplateAddonView> {
  final viewModel = GetIt.instance.get<QuestTemplateAddonViewModel>();
  late final VoidCallback _disposer;

  @override
  void initState() {
    super.initState();
    final initialId = widget.parentViewModel.id.value;
    if (initialId != 0) {
      viewModel.search(initialId);
    }
    _disposer = effect(() {
      final questId = widget.parentViewModel.id.value;
      if (questId != 0) {
        viewModel.search(questId);
      }
    });
  }

  @override
  void dispose() {
    _disposer();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      if (viewModel.loading.value) {
        return const Padding(
          padding: EdgeInsets.all(32),
          child: Center(child: CircularProgressIndicator()),
        );
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            FormItem(
              controller: viewModel.idController,
              label: '编号',
              readOnly: true,
            ),
            FormItem(
              controller: viewModel.maxLevelController,
              label: '最大等级',
            ),
            FormItem(
              controller: viewModel.allowableClassesController,
              label: '允许职业',
            ),
            FormItem(
              controller: viewModel.sourceSpellIdController,
              label: '来源法术',
            ),
            FormItem(
              controller: viewModel.prevQuestIdController,
              label: '前置任务',
            ),
            FormItem(
              controller: viewModel.nextQuestIdController,
              label: '后续任务',
            ),
            FormItem(
              controller: viewModel.exclusiveGroupController,
              label: '互斥组',
            ),
            FormItem(
              controller: viewModel.rewardMailTemplateIdController,
              label: '奖励邮件模板',
            ),
            FormItem(
              controller: viewModel.rewardMailDelayController,
              label: '奖励邮件延迟',
            ),
            FormItem(
              controller: viewModel.requiredSkillIdController,
              label: '需要技能',
            ),
            FormItem(
              controller: viewModel.requiredSkillPointsController,
              label: '需要技能点数',
            ),
            FormItem(
              controller: viewModel.requiredMinRepFactionController,
              label: '需要最低声望阵营',
            ),
            FormItem(
              controller: viewModel.requiredMaxRepFactionController,
              label: '需要最高声望阵营',
            ),
            FormItem(
              controller: viewModel.requiredMinRepValueController,
              label: '需要最低声望值',
            ),
            FormItem(
              controller: viewModel.requiredMaxRepValueController,
              label: '需要最高声望值',
            ),
            FormItem(
              controller: viewModel.providedItemCountController,
              label: '提供物品数量',
            ),
            FormItem(
              controller: viewModel.specialFlagsController,
              label: '特殊标志',
            ),
            ShadButton(
              onPressed: viewModel.onSave,
              child: Text('保存'),
            ),
          ],
        ),
      );
    });
  }
}