import 'package:flutter/material.dart';
import 'package:foxy/page/item/item_enchantment_template_selector.dart';
import 'package:foxy/page/item/item_enchantment_template_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// 物品附魔Tab
class ItemEnchantmentTemplateView extends StatefulWidget {
  final int entry;

  const ItemEnchantmentTemplateView({super.key, required this.entry});

  @override
  State<ItemEnchantmentTemplateView> createState() =>
      _ItemEnchantmentTemplateViewState();
}

class _ItemEnchantmentTemplateViewState
    extends State<ItemEnchantmentTemplateView> {
  final viewModel = GetIt.instance.get<ItemEnchantmentTemplateViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(entry: widget.entry);
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
    final headers = ['附魔ID', '名称', '几率'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var maxWidth = constraints.maxWidth;
        var nameWidth = maxWidth - 240;
        return FoxyShadTable(
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= items.length) {
              return ShadTableCell(child: SizedBox());
            }
            final ench = items[vicinity.row];

            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(ench.ench.toString())),
              1 => ShadTableCell(
                child: Text(
                  ench.name.isNotEmpty ? ench.name : '-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              2 => ShadTableCell(child: Text('${ench.chance}%')),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              1 => FixedTableSpanExtent(nameWidth),
              2 => FixedTableSpanExtent(120),
              _ => null,
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          loading: viewModel.loading.value,
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
    showShadDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('新增附魔'),
        description: Text('新增一条附魔记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// 显示编辑对话框
  void _showEditDialog(BuildContext context) {
    showShadDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑附魔'),
        description: Text('编辑选中的附魔记录'),
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
          FormItem(
            controller: TextEditingController(
              text: widget.entry.toString(),
            ),
            label: '物品ID',
            placeholder: 'Entry',
            readOnly: true,
          ),
          SizedBox(height: 16),
          // 附魔ID
          FormItem(
            label: '附魔ID',
            child: ItemEnchantmentTemplateSelector(
              controller: viewModel.enchController,
              placeholder: 'Ench',
            ),
          ),
          SizedBox(height: 16),
          // 几率
          FormItem(
            controller: viewModel.chanceController,
            label: '几率',
            placeholder: 'Chance (%)',
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