import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_request_items_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestRequestItemsView extends StatefulWidget {
  final int questId;
  const QuestRequestItemsView({super.key, required this.questId});

  @override
  State<QuestRequestItemsView> createState() => _QuestRequestItemsViewState();
}

class _QuestRequestItemsViewState extends State<QuestRequestItemsView> {
  final viewModel = GetIt.instance.get<QuestRequestItemsViewModel>();

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
            controller: viewModel.emoteOnCompleteController,
            label: '完成表情',
          ),
          FormItem(
            controller: viewModel.emoteOnIncompleteController,
            label: '未完成表情',
          ),
          FormItem(
            controller: viewModel.completionTextController,
            label: '完成文本',
          ),
          FormItem(
            controller: viewModel.localeControllerOf('CompletionText'),
            label: '完成文本(中文)',
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