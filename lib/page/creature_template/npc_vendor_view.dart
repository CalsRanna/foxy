import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/item_quality_color.dart';
import 'package:foxy/page/creature_template/npc_vendor_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
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

    Widget layoutBuilder = LayoutBuilder(
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
                child: Text(vendor.incrtime == 0 ? '-' : '${vendor.incrtime}s'),
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
        title: Text('新增商品'),
        description: Text('新增一条商品记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// 显示编辑对话框
  void _showEditDialog(BuildContext context) {
    showFoxyDialog(
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
          FoxyFormItem(
            label: '商人ID',
            child: FoxyNumberInput<int>(
              controller: viewModel.creatureIdController,
              placeholder: 'Entry',
              readOnly: true,
            ),
          ),
          SizedBox(height: 16),
          // 插槽
          FoxyFormItem(
            label: '插槽',
            child: FoxyNumberInput<int>(
              controller: viewModel.slotController,
              placeholder: 'slot',
            ),
          ),
          SizedBox(height: 16),
          // 物品
          FoxyFormItem(
            label: '物品',
            child: FoxyEntityPicker(
              delegate: FoxyEntityPickerDelegates.itemTemplate,
              controller: viewModel.itemController,
              placeholder: 'item',
              readOnly: isEditing,
            ),
          ),
          SizedBox(height: 16),
          // 最大数量
          FoxyFormItem(
            label: '最大数量',
            child: FoxyNumberInput<int>(
              controller: viewModel.maxcountController,
              placeholder: 'maxcount (0=无限)',
            ),
          ),
          SizedBox(height: 16),
          // 补货时间
          FoxyFormItem(
            label: '补货时间',
            child: FoxyNumberInput<int>(
              controller: viewModel.incrtimeController,
              placeholder: 'incrtime (秒)',
            ),
          ),
          SizedBox(height: 16),
          // 扩展价格
          FoxyFormItem(
            label: '扩展价格',
            child: FoxyEntityPicker(
              delegate: FoxyEntityPickerDelegates.itemExtendedCost,
              controller: viewModel.extendedCostController,
              placeholder: 'ExtendedCost',
              readOnly: isEditing,
            ),
          ),
          SizedBox(height: 16),
          // VerifiedBuild
          FoxyFormItem(
            label: 'VerifiedBuild',
            child: FoxyNumberInput<int>(
              controller: viewModel.verifiedBuildController,
              placeholder: 'VerifiedBuild',
            ),
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
