import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/page/spell/spell_loot_template_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SpellLootTemplateView extends StatefulWidget {
  final int spellId;

  const SpellLootTemplateView({super.key, required this.spellId});

  @override
  State<SpellLootTemplateView> createState() => _SpellLootTemplateViewState();
}

class _SpellLootTemplateViewState extends State<SpellLootTemplateView> {
  final viewModel = GetIt.instance.get<SpellLootTemplateViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(spellId: widget.spellId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return _buildTable();
    });
  }

  Widget _buildTable() {
    var createButton = ShadButton(
      onPressed: _showCreateDialog,
      child: Text('新增'),
    );

    final toolbar = Row(children: [createButton, Spacer()]);

    final items = viewModel.items.value;
    final headers = ['编号', '名称', '关联', '几率', '需要任务', '最小数量', '最大数量'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var maxWidth = constraints.maxWidth;
        var flexWidth = maxWidth - 600;
        return FoxyShadTable(
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= items.length) {
              return ShadTableCell(child: SizedBox());
            }
            final item = items[vicinity.row];
            final displayName = item.localeName.isNotEmpty
                ? item.localeName
                : item.itemName;
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.item.toString())),
              1 => ShadTableCell(child: Text(displayName)),
              2 => ShadTableCell(child: Text(item.reference.toString())),
              3 => ShadTableCell(child: Text('${item.chance.toString()}%')),
              4 => ShadTableCell(
                child: Text(item.questRequired == 1 ? '需要' : '不需要'),
              ),
              5 => ShadTableCell(child: Text(item.minCount.toString())),
              6 => ShadTableCell(child: Text(item.maxCount.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(80),
              1 => FixedTableSpanExtent(flexWidth * 0.4),
              2 => FixedTableSpanExtent(80),
              3 => FixedTableSpanExtent(100),
              4 => FixedTableSpanExtent(100),
              5 => FixedTableSpanExtent(80),
              6 => FixedTableSpanExtent(80),
              _ => null,
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            viewModel.selectRow(row);
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () {
                    viewModel.edit();
                    _showEditDialog(context);
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => viewModel.copy(context),
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => viewModel.delete(context),
                  child: Text('删除'),
                ),
              ],
            );
          },
          rowCount: items.length,
          shrinkWrap: true,
        );
      },
    );

    var children = [toolbar, layoutBuilder];
    final column = Column(spacing: 16, children: children);
    return Padding(padding: const EdgeInsets.only(top: 16), child: column);
  }

  void _showCreateDialog() {
    viewModel.create();
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('新增技能掉落'),
        description: Text('新增一条技能掉落记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑技能掉落'),
        description: Text('编辑选中的技能掉落记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.selectedIndex.value != null;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '编号',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.spellIdController,
                    placeholder: 'Entry',
                    readOnly: true,
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '物品',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.itemController,
                    placeholder: 'Item',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '关联',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.referenceController,
                    placeholder: 'Reference',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '几率',
                  child: FoxyNumberInput<double>(
                    controller: viewModel.chanceController,
                    placeholder: 'Chance',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '需要任务',
                  child: FoxyShadSelect<int>(
                    controller: viewModel.questRequiredController,
                    options: kBooleanOptions,
                    placeholder: Text('QuestRequired'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '掉落模式',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.lootModeController,
                    placeholder: 'LootMode',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '组ID',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.groupIdController,
                    placeholder: 'GroupId',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '最小数量',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.minCountController,
                    placeholder: 'MinCount',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '最大数量',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.maxCountController,
                    placeholder: 'MaxCount',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '注解',
            child: FoxyStringInput(
              controller: viewModel.commentController,
              placeholder: 'Comment',
            ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShadButton.outline(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text('取消'),
              ),
              SizedBox(width: 8),
              ShadButton(
                onPressed: () async {
                  if (isEditing) {
                    await viewModel.update(dialogContext);
                  } else {
                    await viewModel.save(dialogContext);
                  }
                  if (!dialogContext.mounted) return;
                  Navigator.of(dialogContext).pop();
                },
                child: Text(isEditing ? '更新' : '保存'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
