import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/page/quest/quest_template_locale_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class QuestTemplateLocaleView extends StatefulWidget {
  final QuestTemplateDetailViewModel parentViewModel;

  const QuestTemplateLocaleView({super.key, required this.parentViewModel});

  @override
  State<QuestTemplateLocaleView> createState() =>
      _QuestTemplateLocaleViewState();
}

class _QuestTemplateLocaleViewState extends State<QuestTemplateLocaleView> {
  final viewModel = GetIt.instance.get<QuestTemplateLocaleViewModel>();
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
              controller: viewModel.localeController,
              label: '语言',
              readOnly: true,
            ),
            FormItem(
              controller: viewModel.localeControllerOf('Title'),
              label: '标题',
            ),
            FormItem(
              controller: viewModel.localeControllerOf('Details'),
              label: '详情',
            ),
            FormItem(
              controller: viewModel.localeControllerOf('Objectives'),
              label: '目标',
            ),
            FormItem(
              controller: viewModel.localeControllerOf('EndText'),
              label: '结束文本',
            ),
            FormItem(
              controller: viewModel.localeControllerOf('CompletedText'),
              label: '完成文本',
            ),
            FormItem(
              controller: viewModel.localeControllerOf('ObjectiveText1'),
              label: '目标文本1',
            ),
            FormItem(
              controller: viewModel.localeControllerOf('ObjectiveText2'),
              label: '目标文本2',
            ),
            FormItem(
              controller: viewModel.localeControllerOf('ObjectiveText3'),
              label: '目标文本3',
            ),
            FormItem(
              controller: viewModel.localeControllerOf('ObjectiveText4'),
              label: '目标文本4',
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