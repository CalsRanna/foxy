import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/npc_vendor_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/item_quality_color.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// NPC 商人 Tab
class NpcVendorView extends StatefulWidget {
  final int creatureId;

  const NpcVendorView({super.key, required this.creatureId});

  @override
  State<NpcVendorView> createState() => _NpcVendorViewState();
}

class _NpcVendorViewState extends State<NpcVendorView> {
  final viewModel = GetIt.instance.get<NpcVendorViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch((_) => _buildTable());
  }

  @override
  void didUpdateWidget(covariant NpcVendorView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.creatureId != widget.creatureId) {
      viewModel.setParentEntry(widget.creatureId);
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(creatureId: widget.creatureId);
  }

  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.editingKey.value != null;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FoxyFormItem(
            label: '商人 ID',
            child: FoxyNumberInput<int>(
              controller: viewModel.creatureIdController,
              placeholder: 'entry',
            ),
          ),
          const SizedBox(height: 16),
          FoxyFormItem(
            label: '插槽',
            child: FoxyNumberInput<int>(
              controller: viewModel.slotController,
              placeholder: 'slot',
            ),
          ),
          const SizedBox(height: 16),
          FoxyFormItem(
            label: '物品',
            child: FoxyEntityPicker(
              delegate: FoxyEntityPickerDelegates.itemTemplate,
              controller: viewModel.itemController,
              placeholder: 'item',
            ),
          ),
          const SizedBox(height: 16),
          FoxyFormItem(
            label: '最大数量',
            child: FoxyNumberInput<int>(
              controller: viewModel.maxcountController,
              placeholder: 'maxcount (0=无限)',
            ),
          ),
          const SizedBox(height: 16),
          FoxyFormItem(
            label: '补货时间',
            child: FoxyNumberInput<int>(
              controller: viewModel.incrtimeController,
              placeholder: 'incrtime (秒)',
            ),
          ),
          const SizedBox(height: 16),
          FoxyFormItem(
            label: '扩展价格',
            child: FoxyEntityPicker(
              delegate: FoxyEntityPickerDelegates.itemExtendedCost,
              controller: viewModel.extendedCostController,
              placeholder: 'ExtendedCost',
            ),
          ),
          const SizedBox(height: 16),
          FoxyFormItem(
            label: 'VerifiedBuild',
            child: FoxyNumberInput<int>(
              controller: viewModel.verifiedBuildController,
              placeholder: 'VerifiedBuild',
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShadButton.outline(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('取消'),
              ),
              const SizedBox(width: 8),
              ShadButton(
                onPressed: () async {
                  final saved = await viewModel.save(dialogContext);
                  if (!saved || !dialogContext.mounted) return;
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

  Widget _buildTable() {
    final items = viewModel.items.value;
    final toolbar = Row(
      children: [
        ShadButton(onPressed: _showCreateDialog, child: const Text('新增')),
        const Spacer(),
        FoxyPagination(
          page: viewModel.page.value,
          pageSize: 50,
          total: viewModel.total.value,
          onChange: viewModel.paginate,
        ),
      ],
    );
    const headers = ['插槽', '物品名称', '最大数量', '补货时间', '扩展价格'];
    final table = LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth - 480;
        return FoxyShadTable(
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= items.length) {
              return const ShadTableCell(child: SizedBox());
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
              _ => const ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) => switch (index) {
            0 => const FixedTableSpanExtent(120),
            1 => FixedTableSpanExtent(width),
            2 => const FixedTableSpanExtent(120),
            3 => const FixedTableSpanExtent(120),
            4 => const FixedTableSpanExtent(120),
            _ => null,
          },
          header: (context, index) =>
              ShadTableCell.header(child: Text(headers[index])),
          onRowSecondaryTapDownWithDetails: (row, details) {
            viewModel.selectRow(row);
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: const Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () async {
                    if (!await viewModel.edit() || !mounted) return;
                    _showEditDialog();
                  },
                  child: const Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: const Icon(LucideIcons.trash, size: 16),
                  onPressed: () => viewModel.delete(context),
                  child: const Text('删除'),
                ),
              ],
            );
          },
          rowCount: items.length,
          shrinkWrap: true,
        );
      },
    );
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(spacing: 16, children: [toolbar, table]),
    );
  }

  Future<void> _showCreateDialog() async {
    if (!await viewModel.create() || !mounted) return;
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: const Text('新增商品'),
        description: const Text('新增一条商品记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  void _showEditDialog() {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: const Text('编辑商品'),
        description: const Text('编辑选中的商品记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }
}
