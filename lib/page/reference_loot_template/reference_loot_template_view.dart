import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/page/reference_loot_template/reference_loot_template_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ReferenceLootTemplateView extends StatefulWidget {
  final int? entry;
  final int? item;

  const ReferenceLootTemplateView({super.key, this.entry, this.item});

  @override
  State<ReferenceLootTemplateView> createState() =>
      _ReferenceLootTemplateViewState();
}

class _ReferenceLootTemplateViewState extends State<ReferenceLootTemplateView> {
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
    return Watch((_) {
      // 复合主键 (Entry, Item)：新建可填，编辑只读
      final pkReadOnly = !viewModel.isNew;
      return _buildBody(context, pkReadOnly: pkReadOnly);
    });
  }

  Widget _buildBody(BuildContext context, {required bool pkReadOnly}) {
    final entryInput = FoxyFormItem(
      label: 'Entry',
      child: FoxyNumberInput<int>(
        placeholder: 'Entry',
        fieldController: viewModel.entryController,
        readOnly: pkReadOnly,
      ),
    );
    final itemInput = FoxyFormItem(
      label: '物品ID',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.itemTemplate,
        fieldController: viewModel.itemController,
        placeholder: 'Item',
        readOnly: pkReadOnly,
      ),
    );
    final referenceInput = FoxyFormItem(
      label: '关联ID',
      child: FoxyNumberInput<int>(
        placeholder: 'Reference',
        fieldController: viewModel.referenceController,
      ),
    );
    final chanceInput = FoxyFormItem(
      label: '掉落几率',
      child: FoxyNumberInput<double>(
        placeholder: 'Chance (%)',
        fieldController: viewModel.chanceController,
      ),
    );
    final questRequiredInput = FoxyFormItem(
      label: '需要任务',
      child: FoxyShadSelect<int>(
        fieldController: viewModel.questRequiredController,
        options: kBooleanOptions,
        placeholder: Text('QuestRequired'),
      ),
    );
    final lootModeInput = FoxyFormItem(
      label: '掉落模式',
      child: FoxyNumberInput<int>(
        placeholder: 'LootMode',
        fieldController: viewModel.lootModeController,
      ),
    );
    final groupIdInput = FoxyFormItem(
      label: '组ID',
      child: FoxyNumberInput<int>(
        placeholder: 'GroupId',
        fieldController: viewModel.groupIdController,
      ),
    );
    final minCountInput = FoxyFormItem(
      label: '最小数量',
      child: FoxyNumberInput<int>(
        placeholder: 'MinCount',
        fieldController: viewModel.minCountController,
      ),
    );
    final maxCountInput = FoxyFormItem(
      label: '最大数量',
      child: FoxyNumberInput<int>(
        placeholder: 'MaxCount',
        fieldController: viewModel.maxCountController,
      ),
    );
    final commentInput = FoxyFormItem(
      label: '备注',
      child: FoxyStringInput(
        controller: viewModel.commentController,
        placeholder: 'Comment',
      ),
    );

    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: entryInput),
          Expanded(child: itemInput),
          Expanded(child: referenceInput),
          Expanded(child: chanceInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: questRequiredInput),
          Expanded(child: lootModeInput),
          Expanded(child: groupIdInput),
          Expanded(child: SizedBox()),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: minCountInput),
          Expanded(child: maxCountInput),
          Expanded(flex: 2, child: commentInput),
        ],
      ),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(title: '基本信息', children: basicRows),
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
