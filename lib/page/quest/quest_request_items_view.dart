import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_request_items_view_model.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class QuestRequestItemsView extends StatefulWidget {
  final QuestTemplateDetailViewModel parentViewModel;

  const QuestRequestItemsView({super.key, required this.parentViewModel});

  @override
  State<QuestRequestItemsView> createState() => _QuestRequestItemsViewState();
}

class _QuestRequestItemsViewState extends State<QuestRequestItemsView> {
  final viewModel = GetIt.instance.get<QuestRequestItemsViewModel>();
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