import 'package:flutter/material.dart';
import 'package:foxy/widget/entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/page/reference_loot_template/reference_loot_template_detail_view_model.dart';
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
      child: FoxyNumberInput<int>(
        placeholder: 'Entry',
        controller: viewModel.entryController,
      ),
    );
    final itemInput = FormItem(
      label: '物品ID',
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.itemTemplate,
        controller: viewModel.itemController,
        placeholder: 'Item',
      ),
    );
    final referenceInput = FormItem(
      label: '关联ID',
      child: FoxyNumberInput<int>(
        placeholder: 'Reference',
        controller: viewModel.referenceController,
      ),
    );
    final chanceInput = FormItem(
      label: '掉落几率',
      child: FoxyNumberInput<double>(
        placeholder: 'Chance (%)',
        controller: viewModel.chanceController,
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
      child: FoxyNumberInput<int>(
        placeholder: 'LootMode',
        controller: viewModel.lootModeController,
      ),
    );
    final groupIdInput = FormItem(
      label: '组ID',
      child: FoxyNumberInput<int>(
        placeholder: 'GroupId',
        controller: viewModel.groupIdController,
      ),
    );
    final minCountInput = FormItem(
      label: '最小数量',
      child: FoxyNumberInput<int>(
        placeholder: 'MinCount',
        controller: viewModel.minCountController,
      ),
    );
    final maxCountInput = FormItem(
      label: '最大数量',
      child: FoxyNumberInput<int>(
        placeholder: 'MaxCount',
        controller: viewModel.maxCountController,
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
