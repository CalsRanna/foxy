import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/page/reference_loot_template/reference_loot_template_detail_view_model.dart';
import 'package:foxy/page/creature_template/item_template_selector.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ReferenceLootTemplateView extends StatefulWidget {
  final int? entry;
  final int? item;

  const ReferenceLootTemplateView({super.key, this.entry, this.item});

  @override
  State<ReferenceLootTemplateView> createState() =>
      _ReferenceLootTemplateViewState();
}

class _ReferenceLootTemplateViewState
    extends State<ReferenceLootTemplateView> {
  final viewModel = GetIt.instance.get<ReferenceLootTemplateDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(entry: widget.entry, item: widget.item);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entryInput = FormItem(
      label: 'Entry',
      placeholder: 'Entry',
      child: FoxyNumberInput<int>(
        value: viewModel.entry.value,
        onChanged: (v) => viewModel.entry.value = v,
      ),
    );
    final itemInput = FormItem(
      label: '物品ID',
      child: ItemTemplateSelector(
        controller: viewModel.itemController,
        placeholder: 'Item',
      ),
    );
    final referenceInput = FormItem(
      label: '关联ID',
      placeholder: 'Reference',
      child: FoxyNumberInput<int>(
        value: viewModel.reference.value,
        onChanged: (v) => viewModel.reference.value = v,
      ),
    );
    final chanceInput = FormItem(
      label: '掉落几率',
      placeholder: 'Chance (%)',
      child: FoxyNumberInput<double>(
        value: viewModel.chance.value,
        onChanged: (v) => viewModel.chance.value = v,
      ),
    );
    final questRequiredInput = FormItem(
      label: '需要任务',
      child: FoxyShadSelect<int>(
        controller: viewModel.questRequiredController,
        options: kBooleanOptions,
        placeholder: Text('QuestRequired'),
      ),
    );
    final lootModeInput = FormItem(
      label: '掉落模式',
      placeholder: 'LootMode',
      child: FoxyNumberInput<int>(
        value: viewModel.lootMode.value,
        onChanged: (v) => viewModel.lootMode.value = v,
      ),
    );
    final groupIdInput = FormItem(
      label: '组ID',
      placeholder: 'GroupId',
      child: FoxyNumberInput<int>(
        value: viewModel.groupId.value,
        onChanged: (v) => viewModel.groupId.value = v,
      ),
    );
    final minCountInput = FormItem(
      label: '最小数量',
      placeholder: 'MinCount',
      child: FoxyNumberInput<int>(
        value: viewModel.minCount.value,
        onChanged: (v) => viewModel.minCount.value = v,
      ),
    );
    final maxCountInput = FormItem(
      label: '最大数量',
      placeholder: 'MaxCount',
      child: FoxyNumberInput<int>(
        value: viewModel.maxCount.value,
        onChanged: (v) => viewModel.maxCount.value = v,
      ),
    );
    final commentInput = FormItem(
      controller: viewModel.commentController,
      label: '备注',
      placeholder: 'Comment',
    );

    final basicRows = [
      Row(spacing: 8, children: [
        Expanded(child: entryInput),
        Expanded(child: itemInput),
        Expanded(child: referenceInput),
        Expanded(child: chanceInput),
      ]),
      Row(spacing: 8, children: [
        Expanded(child: questRequiredInput),
        Expanded(child: lootModeInput),
        Expanded(child: groupIdInput),
        Expanded(child: SizedBox()),
      ]),
      Row(spacing: 8, children: [
        Expanded(child: minCountInput),
        Expanded(child: maxCountInput),
        Expanded(flex: 2, child: commentInput),
      ]),
    ];

    final isNew = widget.entry == null;

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('基本信息'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: basicRows),
          ),
          Row(
            children: [
              ShadButton(
                onPressed: () => isNew
                    ? viewModel.save(context)
                    : viewModel.update(context),
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
