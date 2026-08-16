import 'package:flutter/material.dart';
import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/npc_vendor_linked_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/item_quality_color.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// NPC vendor tab
class NpcVendorView extends StatefulWidget {
  final int creatureId;

  const NpcVendorView({super.key, required this.creatureId});

  @override
  State<NpcVendorView> createState() => _NpcVendorViewState();
}

class _NpcVendorViewState extends State<NpcVendorView> {
  final viewModel = GetIt.instance.get<NpcVendorLinkedListViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch((_) => _buildTable());
  }

  @override
  void didUpdateWidget(covariant NpcVendorView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.creatureId != widget.creatureId) {
      viewModel.setLinkKey(widget.creatureId);
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
    viewModel.initSignals(linkKey: widget.creatureId);
  }

  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.editingKey.value != null;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 720),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '商人 ID',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.entryController,
                    placeholder: 'entry',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '插槽',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.slotController,
                    placeholder: 'slot',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '物品',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.itemTemplate,
                    controller: viewModel.itemController,
                    placeholder: 'item',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '最大数量',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.maxcountController,
                    placeholder: 'maxcount',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '补货时间',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.incrtimeController,
                    placeholder: 'incrtime',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '扩展价格',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.itemExtendedCost,
                    controller: viewModel.extendedCostController,
                    placeholder: 'ExtendedCost',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '验证版本',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.verifiedBuildController,
                    placeholder: 'VerifiedBuild',
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              const Expanded(child: SizedBox()),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShadButton.outline(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('取消'),
              ),
              const SizedBox(width: 8),
              Watch(
                (_) => ShadButton(
                  enabled: !viewModel.submitting.value,
                  onPressed: () async {
                    try {
                      await viewModel.persist();
                    } catch (error) {
                      if (!mounted) return;
                      DialogUtil.instance.error(
                        '保存失败：${FoxyExceptions.message(error)}',
                      );
                      return;
                    }
                    if (!dialogContext.mounted) return;
                    ShadSonner.of(
                      dialogContext,
                    ).show(const ShadToast(description: Text('保存成功')));
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(isEditing ? '更新' : '保存'),
                ),
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
    final table = FoxyDataTable<BriefNpcVendorEntity>(
      shrinkWrap: true,
      rows: items,
      columns: [
        FoxyTableColumn.fixed(
          label: '插槽',
          width: 120,
          cell: (_, vendor) => Text(vendor.slot.toString()),
        ),
        FoxyTableColumn.flex(
          label: '物品名称',
          cell: (_, vendor) {
            final qualityColor = ItemQualityColor.of(vendor.itemQuality);
            return Text(
              vendor.displayName,
              style: TextStyle(color: qualityColor),
            );
          },
        ),
        FoxyTableColumn.fixed(
          label: '最大数量',
          width: 120,
          cell: (_, vendor) =>
              Text(vendor.maxcount == 0 ? '无限' : vendor.maxcount.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '补货时间',
          width: 120,
          cell: (_, vendor) =>
              Text(vendor.incrtime == 0 ? '-' : '${vendor.incrtime}s'),
        ),
        FoxyTableColumn.fixed(
          label: '扩展价格',
          width: 120,
          cell: (_, vendor) => Text(
            vendor.extendedCost == 0 ? '-' : vendor.extendedCost.toString(),
          ),
        ),
      ],
      onRowDoubleTap: (vendor) async {
        viewModel.selectedKey.value = vendor.key;
        if (!await _load(viewModel.selectedKey.value!)) return;
        if (!mounted) return;
        _showEditDialog();
      },
      onRowSecondaryTapDownWithDetails: (vendor, details) {
        viewModel.selectedKey.value = vendor.key;
        ContextMenu.show(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: const Icon(LucideIcons.squarePen, size: 16),
              onPressed: () async {
                if (!await _load(viewModel.selectedKey.value!)) return;
                if (!mounted) return;
                _showEditDialog();
              },
              child: const Text('编辑'),
            ),
            ShadContextMenuItem(
              leading: const Icon(LucideIcons.trash, size: 16),
              onPressed: () => _destroy(viewModel.selectedKey.value!),
              child: const Text('删除'),
            ),
          ],
        );
      },
    );
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(spacing: 16, children: [toolbar, table]),
    );
  }

  Future<void> _destroy(NpcVendorKey key) async {
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认删除',
      description: '将永久删除该记录，确认继续？',
      confirmText: '删除',
      destructive: true,
    );
    if (!confirmed) return;
    try {
      await viewModel.destroy(key);
      if (!mounted) return;
      DialogUtil.instance.success('删除成功');
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('删除失败：${FoxyExceptions.message(error)}');
    }
  }

  Future<bool> _load(NpcVendorKey key) async {
    try {
      await viewModel.edit(key);
      return true;
    } catch (error) {
      if (mounted) {
        DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
      }
      return false;
    }
  }

  Future<void> _showCreateDialog() async {
    try {
      await viewModel.create();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('创建失败：${FoxyExceptions.message(error)}');
      return;
    }
    if (!mounted) return;
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: const Text('新增商品'),
        description: const Text('新增一条商品记录'),
        titlePinned: true,
        descriptionPinned: true,
        constraints: DialogUtil.constraints(dialogContext),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  void _showEditDialog() {
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: const Text('编辑商品'),
        description: const Text('编辑选中的商品记录'),
        titlePinned: true,
        descriptionPinned: true,
        constraints: DialogUtil.constraints(dialogContext),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }
}
