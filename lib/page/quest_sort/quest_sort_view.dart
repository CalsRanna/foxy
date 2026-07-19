import 'package:flutter/material.dart';
import 'package:foxy/page/quest_sort/quest_sort_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class QuestSortView extends StatelessWidget {
  final QuestSortDetailViewModel viewModel;

  const QuestSortView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
      ),
    );
    final nameInput = FoxyFormItem(
      label: '名称',
      child: Watch((_) {
        final id = viewModel.persistedKey.value?.id;
        return FoxyLocalePicker(
          entry: id,
          controller: viewModel.nameController,
          title: '任务分类名称本地化',
          placeholder: 'SortName_lang_zhCN',
          delegate: FoxyLocalePickerDelegates.dbcQuestSortSortName,
          onSaved: viewModel.applySortNameLocales,
        );
      }),
    );
    final sortNameLangFlagsInput = FoxyFormItem(
      label: '名称语言标志',
      child: FoxyNumberInput<int>(
        placeholder: 'SortName_lang_Flags',
        controller: viewModel.sortNameLangFlagsController,
      ),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(
            title: '基本信息',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: idInput),
                  Expanded(child: nameInput),
                  Expanded(child: sortNameLangFlagsInput),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: const Text('保存'),
              ),
              const SizedBox(width: 8),
              ShadButton.ghost(
                onPressed: viewModel.pop,
                child: const Text('取消'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
