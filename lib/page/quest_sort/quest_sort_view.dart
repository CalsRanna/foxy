import 'package:flutter/material.dart';
import 'package:foxy/page/quest_sort/quest_sort_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestSortView extends StatefulWidget {
  final int? entry;
  const QuestSortView({super.key, this.entry});

  @override
  State<QuestSortView> createState() => _QuestSortViewState();
}

class _QuestSortViewState extends State<QuestSortView> {
  final viewModel = GetIt.instance.get<QuestSortDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(id: widget.entry);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final idInput = FormItem(
      label: '编号',
      placeholder: 'ID',
      child: FoxyNumberInput<int>(
        value: viewModel.id.value,
        onChanged: (v) => viewModel.id.value = v,
        readOnly: true,
      ),
    );
    final nameInput = FormItem(
      controller: viewModel.nameController,
      label: '名称',
      placeholder: 'SortName_Lang_zhCN',
    );

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Row(
              spacing: 8,
              children: [
                Expanded(child: idInput),
                Expanded(child: nameInput),
              ],
            ),
          ),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: Text('保存'),
              ),
              const SizedBox(width: 8),
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
