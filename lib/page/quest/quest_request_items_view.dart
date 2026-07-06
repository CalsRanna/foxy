import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/locale_picker_delegates.dart';
import 'package:foxy/page/quest/quest_request_items_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
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
              label: '完成表情',
              placeholder: 'EmoteOnComplete',
              child: FoxyNumberInput<int>(
                controller: vm.emoteOnCompleteController,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '未完成表情',
              placeholder: 'EmoteOnIncomplete',
              child: FoxyNumberInput<int>(
                controller: vm.emoteOnIncompleteController,
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
              label: '完成文本',
              child: FoxyLocalePicker(
                entry: widget.questId,
                controller: vm.completionTextController,
                delegate: LocalePickerDelegates.questRequestItems,
                placeholder: 'CompletionText',
                title: '完成文本',
              ),
            ),
          ),
          Expanded(child: SizedBox()),
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
          FormSection(title: '基本信息', children: rows),
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
