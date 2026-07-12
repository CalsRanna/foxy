import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/item_quality.dart';
import 'package:foxy/page/item/prospecting_loot_template_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// 选矿掉落Tab
class ProspectingLootTemplateView extends StatefulWidget {
  final int entry;

  const ProspectingLootTemplateView({super.key, required this.entry});

  @override
  State<ProspectingLootTemplateView> createState() =>
      _ProspectingLootTemplateViewState();
}

class _ProspectingLootTemplateViewState
    extends State<ProspectingLootTemplateView> {
  final viewModel = GetIt.instance.get<ProspectingLootTemplateViewModel>();

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
    // 新增按钮
    var createButton = ShadButton(
      onPressed: _showCreateDialog,
      child: Text('新增'),
    );

    // 工具栏
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

  /// 显示新增对话框
  void _showCreateDialog() {
    viewModel.create();
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('新增选矿掉落'),
        description: Text('新增一条选矿掉落记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// 显示编辑对话框
  void _showEditDialog(BuildContext context) {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑选矿掉落'),
        description: Text('编辑选中的选矿掉落记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// 对话框表单（垂直布局）
  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.editing.value;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 物品ID（只读）
          FoxyFormItem(
            controller: TextEditingController(text: widget.entry.toString()),
            label: '物品ID',
            placeholder: 'Entry',
            readOnly: true,
          ),
          SizedBox(height: 16),
          // 物品ID
          FoxyFormItem(
            label: '掉落物品',
            child: FoxyEntityPicker(
              delegate: FoxyEntityPickerDelegates.itemTemplate,
              controller: viewModel.itemController,
              placeholder: 'Item',
            ),
          ),
          SizedBox(height: 16),
          // 关联ID
          FoxyFormItem(
            label: '关联ID',
            placeholder: 'Reference (0=直接掉落)',
            child: FoxyNumberInput<int>(
              controller: viewModel.referenceController,
            ),
          ),
          SizedBox(height: 16),
          // 掉落几率
          FoxyFormItem(
            label: '掉落几率',
            placeholder: 'Chance (%)',
            child: FoxyNumberInput<double>(
              controller: viewModel.chanceController,
            ),
          ),
          SizedBox(height: 16),
          // 需要任务
          FoxyFormItem(
            label: '需要任务',
            child: FoxyShadSelect<int>(
              controller: viewModel.questRequiredController,
              options: kBooleanOptions,
              placeholder: Text('QuestRequired'),
            ),
          ),
          SizedBox(height: 16),
          // 掉落模式
          FoxyFormItem(
            label: '掉落模式',
            placeholder: 'LootMode',
            child: FoxyNumberInput<int>(
              controller: viewModel.lootModeController,
            ),
          ),
          SizedBox(height: 16),
          // 组ID
          FoxyFormItem(
            label: '组ID',
            placeholder: 'GroupId',
            child: FoxyNumberInput<int>(
              controller: viewModel.groupIdController,
            ),
          ),
          SizedBox(height: 16),
          // 数量范围
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '最小数量',
                  placeholder: 'MinCount',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.minCountController,
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '最大数量',
                  placeholder: 'MaxCount',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.maxCountController,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // 备注
          FoxyFormItem(
            controller: viewModel.commentController,
            label: '备注',
            placeholder: 'Comment',
          ),
          SizedBox(height: 24),
          // 按钮行
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
