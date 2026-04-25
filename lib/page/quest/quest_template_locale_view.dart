import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_template_locale_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestTemplateLocaleView extends StatefulWidget {
  final int questId;
  const QuestTemplateLocaleView({super.key, required this.questId});

  @override
  State<QuestTemplateLocaleView> createState() =>
      _QuestTemplateLocaleViewState();
}

class _QuestTemplateLocaleViewState extends State<QuestTemplateLocaleView> {
  final viewModel = GetIt.instance.get<QuestTemplateLocaleViewModel>();

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