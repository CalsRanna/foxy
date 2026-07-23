import 'package:flutter/material.dart';
import 'package:foxy/entity/item_enchantment_template_key.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_enchantment_template_parent_key.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/page/item/item_enchantment_template_collection_editor_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:signals/signals_flutter.dart';

/// 物品附魔Tab
class ItemEnchantmentTemplateView extends StatefulWidget {
  final ItemEnchantmentTemplateParentKey? parentKey;

  const ItemEnchantmentTemplateView({super.key, required this.parentKey});

  @override
  State<ItemEnchantmentTemplateView> createState() =>
      _ItemEnchantmentTemplateViewState();
}

class _ItemEnchantmentTemplateViewState
    extends State<ItemEnchantmentTemplateView> {
  final viewModel = GetIt.instance
      .get<ItemEnchantmentTemplateCollectionEditorViewModel>();

  @override
  void initState() {
    super.initState();
    final parentKey = widget.parentKey;
    if (parentKey != null) viewModel.initSignals(parentKey: parentKey);
  }

  @override
  void didUpdateWidget(covariant ItemEnchantmentTemplateView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.parentKey != widget.parentKey) {
      final parentKey = widget.parentKey;
      if (parentKey == null) {
        viewModel.clearParent();
      } else {
        viewModel.setParentKey(parentKey);
      }
    }
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
          onRowSecondaryTapDownWithDetails: (row, details) {
            viewModel.selectedKey.value = items[row].key;
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () async {
                    if (!await _load(items[row].key)) return;
                    if (context.mounted) {
                      _showEditDialog(context);
                    }
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => _destroy(items[row].key),
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

  Future<void> _showCreateDialog() async {
    try {
      await viewModel.create();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('创建失败：$error');
      return;
    }
    if (!mounted) return;
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('新增附魔'),
        description: Text('新增一条附魔记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑附魔'),
        description: Text('编辑选中的附魔记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.editingKey.value != null;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FoxyFormItem(
            label: '附魔组ID',
            child: FoxyNumberInput<int>(
              controller: viewModel.entryController,
              placeholder: 'Entry',
            ),
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '附魔ID',
            child: FoxyEntityPicker(
              delegate:
                  viewModel.parentKey.value?.kind ==
                      ItemEnchantmentKind.randomProperty
                  ? FoxyEntityPickerDelegates.itemRandomProperties
                  : FoxyEntityPickerDelegates.itemRandomSuffix,
              controller: viewModel.enchController,
              placeholder: 'Ench',
            ),
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '几率',
            child: FoxyNumberInput<double>(
              controller: viewModel.chanceController,
              placeholder: 'Chance (%)',
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
              Watch(
                (_) => ShadButton(
                  enabled: !viewModel.submitting.value,
                  onPressed: () async {
                    try {
                      await viewModel.persist();
                    } catch (error) {
                      if (!mounted) return;
                      DialogUtil.instance.error('保存失败：$error');
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

  Future<bool> _load(ItemEnchantmentTemplateKey key) async {
    try {
      await viewModel.edit(key);
      return true;
    } catch (error) {
      if (mounted) DialogUtil.instance.error('加载失败：$error');
      return false;
    }
  }

  Future<void> _destroy(ItemEnchantmentTemplateKey key) async {
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
      DialogUtil.instance.error('删除失败：$error');
    }
  }
}
