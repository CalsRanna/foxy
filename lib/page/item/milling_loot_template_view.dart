import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/item_quality.dart';
import 'package:foxy/page/item/milling_loot_template_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// 研磨掉落Tab
class MillingLootTemplateView extends StatefulWidget {
  final int entry;

  const MillingLootTemplateView({super.key, required this.entry});

  @override
  State<MillingLootTemplateView> createState() =>
      _MillingLootTemplateViewState();
}

class _MillingLootTemplateViewState extends State<MillingLootTemplateView> {
  final viewModel = GetIt.instance.get<MillingLootTemplateViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(itemId: widget.entry);
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
    final headers = ['物品ID', '物品名称', '几率', '数量', '任务', '组'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var maxWidth = constraints.maxWidth;
        var width = maxWidth - 600;
        return FoxyShadTable(
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= items.length) {
              return ShadTableCell(child: SizedBox());
            }
            final loot = items[vicinity.row];
            final qualityColor =
                kItemQualityColors[loot.itemQuality] ?? Colors.white;

            return switch (vicinity.column) {
              0 => ShadTableCell(
                child: Text(
                  loot.reference != 0
                      ? '${loot.item} (R)'
                      : loot.item.toString(),
                ),
              ),
              1 => ShadTableCell(
                child: loot.reference != 0
                    ? Text(
                        '关联掉落',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      )
                    : Text(
                        loot.displayName,
                        style: TextStyle(color: qualityColor),
                      ),
              ),
              2 => ShadTableCell(child: Text('${loot.chance}%')),
              3 => ShadTableCell(
                child: Text('${loot.minCount}-${loot.maxCount}'),
              ),
              4 => ShadTableCell(child: Text(loot.questRequired ? '是' : '否')),
              5 => ShadTableCell(child: Text(loot.groupId.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              1 => FixedTableSpanExtent(width),
              2 => FixedTableSpanExtent(120),
              3 => FixedTableSpanExtent(120),
              4 => FixedTableSpanExtent(120),
              5 => FixedTableSpanExtent(120),
              _ => null,
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () {
                    viewModel.selectRow(row);
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
        title: Text('新增掉落'),
        description: Text('新增一条掉落记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑掉落'),
        description: Text('编辑选中的掉落记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.editing.value;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FoxyFormItem(
            label: '物品ID',
            child: FoxyNumberInput<int>(
              fieldController: viewModel.entryController,
              placeholder: 'Entry',
              readOnly: true,
            ),
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '掉落物品',
            child: FoxyEntityPicker(
              delegate: FoxyEntityPickerDelegates.itemTemplate,
              fieldController: viewModel.itemController,
              placeholder: 'Item',
            ),
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '关联ID',
            child: FoxyNumberInput<int>(
              fieldController: viewModel.referenceController,
              placeholder: 'Reference (0=直接掉落)',
            ),
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '掉落几率',
            child: FoxyNumberInput<double>(
              fieldController: viewModel.chanceController,
              placeholder: 'Chance (%)',
            ),
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '需要任务',
            child: FoxyShadSelect<int>(
              fieldController: viewModel.questRequiredController,
              options: kBooleanOptions,
              placeholder: Text('QuestRequired'),
            ),
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '掉落模式',
            child: FoxyNumberInput<int>(
              fieldController: viewModel.lootModeController,
              placeholder: 'LootMode',
            ),
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '组ID',
            child: FoxyNumberInput<int>(
              fieldController: viewModel.groupIdController,
              placeholder: 'GroupId',
            ),
          ),
          SizedBox(height: 16),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '最小数量',
                  child: FoxyNumberInput<int>(
                    fieldController: viewModel.minCountController,
                    placeholder: 'MinCount',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '最大数量',
                  child: FoxyNumberInput<int>(
                    fieldController: viewModel.maxCountController,
                    placeholder: 'MaxCount',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '备注',
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
