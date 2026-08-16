import 'package:flutter/material.dart';
import 'package:foxy/entity/creature_equip_template_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/creature_equip_template_linked_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/item_quality_color.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// Equip-template tab
class CreatureEquipTemplateView extends StatefulWidget {
  final int creatureId;

  const CreatureEquipTemplateView({super.key, required this.creatureId});

  @override
  State<CreatureEquipTemplateView> createState() =>
      _CreatureEquipTemplateViewState();
}

class _CreatureEquipTemplateViewState extends State<CreatureEquipTemplateView> {
  final viewModel = GetIt.instance
      .get<CreatureEquipTemplateLinkedListViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return _buildTable();
    });
  }

  @override
  void didUpdateWidget(covariant CreatureEquipTemplateView oldWidget) {
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

  /// Dialog form (vertical layout)
  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.editingKey.value != null;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: DialogUtil.width),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '生物ID',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.creatureIDController,
                    placeholder: 'CreatureID',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '模板ID',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.idController,
                    placeholder: 'ID',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '主手武器',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.handEquippableDbcItem,
                    controller: viewModel.itemID1Controller,
                    placeholder: 'ItemID1',
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
                  label: '副手武器',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.handEquippableDbcItem,
                    controller: viewModel.itemID2Controller,
                    placeholder: 'ItemID2',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '远程武器',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.handEquippableDbcItem,
                    controller: viewModel.itemID3Controller,
                    placeholder: 'ItemID3',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '验证版本',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.verifiedBuildController,
                    placeholder: 'VerifiedBuild',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          // Button row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShadButton.outline(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text('取消'),
              ),
              SizedBox(width: 8),
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
    // Add button
    var createButton = ShadButton(
      onPressed: _showCreateDialog,
      child: Text('新增'),
    );

    // Toolbar
    final toolbar = Row(
      children: [
        createButton,
        Spacer(),
        FoxyPagination(
          page: viewModel.page.value,
          pageSize: 50,
          total: viewModel.total.value,
          onChange: viewModel.paginate,
        ),
      ],
    );

    final items = viewModel.items.value;

    final table = FoxyDataTable<BriefCreatureEquipTemplateEntity>(
      shrinkWrap: true,
      rows: items,
      columns: [
        FoxyTableColumn.fixed(
          label: 'ID',
          width: 120,
          cell: (_, equip) => Text(equip.id.toString()),
        ),
        FoxyTableColumn.flex(
          label: '主手武器',
          cell: (_, equip) => Text(
            equip.displayName1,
            style: TextStyle(color: ItemQualityColor.of(equip.quality1)),
          ),
        ),
        FoxyTableColumn.flex(
          label: '副手武器',
          cell: (_, equip) => Text(
            equip.displayName2,
            style: TextStyle(color: ItemQualityColor.of(equip.quality2)),
          ),
        ),
        FoxyTableColumn.flex(
          label: '远程武器',
          cell: (_, equip) => Text(
            equip.displayName3,
            style: TextStyle(color: ItemQualityColor.of(equip.quality3)),
          ),
        ),
        FoxyTableColumn.fixed(
          label: '验证版本',
          width: 120,
          cell: (_, equip) => Text(equip.verifiedBuild.toString()),
        ),
      ],
      onRowDoubleTap: (equip) async {
        viewModel.selectedKey.value = equip.key;
        if (!await _load(viewModel.selectedKey.value!)) return;
        if (!mounted) return;
        _showEditDialog(context);
      },
      onRowSecondaryTapDownWithDetails: (equip, details) {
        ContextMenu.show(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: () async {
                viewModel.selectedKey.value = equip.key;
                if (!await _load(viewModel.selectedKey.value!)) return;
                if (!mounted) return;
                _showEditDialog(context);
              },
              child: Text('编辑'),
            ),
            ShadContextMenuItem(
              leading: Icon(LucideIcons.copy, size: 16),
              onPressed: () {
                viewModel.selectedKey.value = equip.key;
                _copy(viewModel.selectedKey.value!);
              },
              child: Text('复制'),
            ),
            ShadContextMenuItem(
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed: () {
                viewModel.selectedKey.value = equip.key;
                _destroy(viewModel.selectedKey.value!);
              },
              child: Text('删除'),
            ),
          ],
        );
      },
    );

    var children = [
      if (viewModel.errorMessage.value != null)
        FoxyInlineError(message: viewModel.errorMessage.value),
      toolbar,
      table,
    ];
    final column = Column(spacing: 16, children: children);
    return Padding(padding: const EdgeInsets.only(top: 16), child: column);
  }

  Future<void> _copy(CreatureEquipTemplateKey key) async {
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认复制',
      description: '确定要复制这条记录吗？',
      confirmText: '复制',
    );
    if (!confirmed) return;
    try {
      await viewModel.copy(key);
      if (!mounted) return;
      DialogUtil.instance.success('复制成功');
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('复制失败：${FoxyExceptions.message(error)}');
    }
  }

  Future<void> _destroy(CreatureEquipTemplateKey key) async {
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认删除',
      description: '确定要删除这条记录吗？此操作不可撤销。',
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

  Future<bool> _load(CreatureEquipTemplateKey key) async {
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

  /// Shows the add dialog
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
        title: Text('新增装备模板'),
        description: Text('新增一条装备模板记录'),
        titlePinned: true,
        descriptionPinned: true,
        constraints: DialogUtil.constraints(dialogContext),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// Shows the edit dialog
  void _showEditDialog(BuildContext context) {
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑装备模板'),
        description: Text('编辑选中的装备模板记录'),
        titlePinned: true,
        descriptionPinned: true,
        constraints: DialogUtil.constraints(dialogContext),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }
}
