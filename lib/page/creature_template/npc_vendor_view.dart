import 'package:flutter/material.dart';
import 'package:foxy/constant/item_quality.dart';
import 'package:foxy/page/creature_template/item_extended_cost_selector.dart';
import 'package:foxy/page/creature_template/item_template_selector.dart';
import 'package:foxy/page/creature_template/npc_vendor_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// NPC商人Tab
class NpcVendorView extends StatefulWidget {
  final int creatureId;

  const NpcVendorView({super.key, required this.creatureId});

  @override
  State<NpcVendorView> createState() => _NpcVendorViewState();
}

class _NpcVendorViewState extends State<NpcVendorView> {
  final viewModel = GetIt.instance.get<NpcVendorViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(creatureId: widget.creatureId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      if (viewModel.loading.value) {
        return Center(child: CircularProgressIndicator());
      }

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
    final headers = ['插槽', '物品名称', '最大数量', '补货时间', '扩展价格'];

    // 表格（固定高度）
    Widget layoutBuilder = SizedBox(
      height: 500,
      child: LayoutBuilder(
        builder: (context, constraints) {
          var maxWidth = constraints.maxWidth;
          var width = maxWidth - 480;
          return FoxyShadTable(
            builder: (context, vicinity) {
              if (vicinity.row < 0 || vicinity.row >= items.length) {
                return ShadTableCell(child: SizedBox());
              }
              final vendor = items[vicinity.row];
              final qualityColor =
                  kItemQualityColors[vendor.itemQuality] ?? Colors.white;
              return switch (vicinity.column) {
                0 => ShadTableCell(child: Text(vendor.slot.toString())),
                1 => ShadTableCell(
                  child: Text(
                    vendor.displayName,
                    style: TextStyle(color: qualityColor),
                  ),
                ),
                2 => ShadTableCell(
                  child: Text(
                    vendor.maxcount == 0 ? '无限' : vendor.maxcount.toString(),
                  ),
                ),
                3 => ShadTableCell(
                  child: Text(
                    vendor.incrtime == 0 ? '-' : '${vendor.incrtime}s',
                  ),
                ),
                4 => ShadTableCell(
                  child: Text(
                    vendor.extendedCost == 0
                        ? '-'
                        : vendor.extendedCost.toString(),
                  ),
                ),
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
            pinnedRowCount: 1,
            rowCount: items.length,
          );
        },
      ),
    );

    var children = [toolbar, layoutBuilder];
    final column = Column(spacing: 16, children: children);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ShadCard(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: column,
      ),
    );
  }

  /// 显示新增对话框
  void _showCreateDialog() {
    viewModel.create();
    showShadDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('新增商品'),
        description: Text('新增一条商品记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// 显示编辑对话框
  void _showEditDialog(BuildContext context) {
    showShadDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑商品'),
        description: Text('编辑选中的商品记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// 对话框表单（垂直布局）
  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.selectedIndex.value != null;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 商人ID（只读）
          FormItem(
            controller: TextEditingController(
              text: widget.creatureId.toString(),
            ),
            label: '商人ID',
            placeholder: 'Entry',
            readOnly: true,
          ),
          SizedBox(height: 16),
          // 插槽
          FormItem(
            controller: viewModel.slotController,
            label: '插槽',
            placeholder: 'slot',
          ),
          SizedBox(height: 16),
          // 物品
          FormItem(
            label: '物品',
            child: ItemTemplateSelector(
              controller: viewModel.itemController,
              placeholder: 'item',
            ),
          ),
          SizedBox(height: 16),
          // 最大数量
          FormItem(
            controller: viewModel.maxcountController,
            label: '最大数量',
            placeholder: 'maxcount (0=无限)',
          ),
          SizedBox(height: 16),
          // 补货时间
          FormItem(
            controller: viewModel.incrtimeController,
            label: '补货时间',
            placeholder: 'incrtime (秒)',
          ),
          SizedBox(height: 16),
          // 扩展价格
          FormItem(
            label: '扩展价格',
            child: ItemExtendedCostSelector(
              controller: viewModel.extendedCostController,
              placeholder: 'ExtendedCost',
            ),
          ),
          SizedBox(height: 16),
          // VerifiedBuild
          FormItem(
            controller: viewModel.verifiedBuildController,
            label: 'VerifiedBuild',
            placeholder: 'VerifiedBuild',
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
                  final navigator = Navigator.of(dialogContext);
                  if (isEditing) {
                    await viewModel.update(dialogContext);
                  } else {
                    await viewModel.save(dialogContext);
                  }
                  if (!mounted) return;
                  navigator.pop();
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
