import 'package:flutter/material.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/page/quest/quest_request_items_single_editor_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:signals/signals_flutter.dart';

class QuestRequestItemsView extends StatefulWidget {
  final int questId;
  const QuestRequestItemsView({super.key, required this.questId});

  @override
  State<QuestRequestItemsView> createState() => _QuestRequestItemsViewState();
}

class _QuestRequestItemsViewState extends State<QuestRequestItemsView> {
  final viewModel = GetIt.instance
      .get<QuestRequestItemsSingleEditorViewModel>();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void didUpdateWidget(covariant QuestRequestItemsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questId != widget.questId) {
      _initialize();
    }
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(parentKey: widget.questId);
    } catch (error) {
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  Future<void> _persist() async {
    try {
      await viewModel.persist();
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(const ShadToast(description: Text('提交物品数据已保存')));
    } catch (error) {
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
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
              child: FoxyNumberInput<int>(controller: vm.idController),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '完成表情',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcEmote,
                controller: vm.emoteOnCompleteController,
                placeholder: 'EmoteOnComplete',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '未完成表情',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcEmote,
                controller: vm.emoteOnIncompleteController,
                placeholder: 'EmoteOnIncomplete',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '验证版本',
              child: FoxyNumberInput<int>(
                controller: vm.verifiedBuildController,
                placeholder: 'VerifiedBuild',
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
              label: '完成文本',
              child: Watch(
                (_) => FoxyLocalePicker(
                  entry: vm.editingKey.value,
                  controller: vm.completionTextController,
                  delegate: FoxyLocalePickerDelegates.questRequestItems,
                  placeholder: 'CompletionText',
                  title: '完成文本',
                ),
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
          FoxyFormSection(title: '基本信息', children: rows),
          Row(
            spacing: 8,
            children: [
              Watch(
                (_) => ShadButton(
                  enabled: !viewModel.submitting.value,
                  onPressed: () => _persist(),
                  child: Text('保存'),
                ),
              ),
              ShadButton.ghost(onPressed: () => _goBack(), child: Text('取消')),
            ],
          ),
        ],
      ),
    );
  }
}
