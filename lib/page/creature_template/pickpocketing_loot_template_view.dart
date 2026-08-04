import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/entity/pickpocketing_loot_template_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/pickpocketing_loot_template_linked_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:foxy/widget/item_quality_color.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Pickpocketing loot tab
class PickpocketingLootTemplateView extends StatefulWidget {
  final int linkKey;

  const PickpocketingLootTemplateView({super.key, required this.linkKey});

  @override
  State<PickpocketingLootTemplateView> createState() =>
      _PickpocketingLootTemplateViewState();
}

class _PickpocketingLootTemplateViewState
    extends State<PickpocketingLootTemplateView> {
  final viewModel = GetIt.instance
      .get<PickpocketingLootTemplateLinkedListViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return _buildTable();
    });
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(linkKey: widget.linkKey);
  }

  /// Dialog form (vertical layout)
  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.selectedKey.value != null;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FoxyFormItem(
            label: '掉落模板 ID',
            child: FoxyNumberInput<int>(
              controller: viewModel.entryController,
              placeholder: 'Entry',
            ),
          ),
          SizedBox(height: 16),
          // Item ID
          FoxyFormItem(
            label: '物品ID',
            child: FoxyEntityPicker(
              delegate: FoxyEntityPickerDelegates.itemTemplate,
              controller: viewModel.itemController,
              placeholder: 'Item',
            ),
          ),
          SizedBox(height: 16),
          // Reference ID
          FoxyFormItem(
            label: '关联ID',
            child: FoxyEntityPicker(
              delegate: FoxyEntityPickerDelegates.referenceLoot,
              controller: viewModel.referenceController,
              placeholder: 'Reference (0=直接掉落)',
            ),
          ),
          SizedBox(height: 16),
          // Drop chance
          FoxyFormItem(
            label: '掉落几率',
            child: FoxyNumberInput<double>(
              controller: viewModel.chanceController,
              placeholder: 'Chance (%)',
            ),
          ),
          SizedBox(height: 16),
          // Required quest
          FoxyFormItem(
            label: '需要任务',
            child: FoxyShadSelect<int>(
              controller: viewModel.questRequiredController,
              options: kBooleanOptions,
              placeholder: Text('QuestRequired'),
            ),
          ),
          SizedBox(height: 16),
          // Loot mode
          FoxyFormItem(
            label: '掉落模式',
            child: FoxyFlagPicker(
              controller: viewModel.lootModeController,
              flags: kLootModeFlagOptions,
              title: '掉落模式',
              placeholder: 'LootMode',
            ),
          ),
          SizedBox(height: 16),
          // Group ID
          FoxyFormItem(
            label: '组ID',
            child: FoxyNumberInput<int>(
              controller: viewModel.groupIdController,
              placeholder: 'GroupId',
            ),
          ),
          SizedBox(height: 16),
          // Quantity range
          Row(
            spacing: 16,
            children: [
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
              const Expanded(child: SizedBox()),
              const Expanded(child: SizedBox()),
            ],
          ),
          SizedBox(height: 16),
          // Comment
          FoxyFormItem(
            label: '备注',
            child: FoxyStringInput(
              controller: viewModel.commentController,
              placeholder: 'Comment',
            ),
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
                        '保存失败：${foxyErrorMessage(error)}',
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
            final qualityColor = getItemQualityColor(loot.itemQuality);

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
                  onPressed: () async {
                    viewModel.selectedKey.value = items[row].key;
                    if (!await _load(viewModel.selectedKey.value!)) return;
                    if (!mounted) return;
                    _showEditDialog();
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () {
                    viewModel.selectedKey.value = items[row].key;
                    _destroy(viewModel.selectedKey.value!);
                  },
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

    var children = [
      if (viewModel.errorMessage.value != null)
        FoxyInlineError(message: viewModel.errorMessage.value),
      toolbar,
      layoutBuilder,
    ];
    final column = Column(spacing: 16, children: children);
    return Padding(padding: const EdgeInsets.only(top: 16), child: column);
  }

  Future<void> _destroy(PickpocketingLootTemplateKey key) async {
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
      DialogUtil.instance.error('删除失败：${foxyErrorMessage(error)}');
    }
  }

  Future<bool> _load(PickpocketingLootTemplateKey key) async {
    try {
      await viewModel.edit(key);
      return true;
    } catch (error) {
      if (mounted) DialogUtil.instance.error('加载失败：${foxyErrorMessage(error)}');
      return false;
    }
  }

  /// Shows the add dialog
  Future<void> _showCreateDialog() async {
    try {
      await viewModel.create();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('创建失败：${foxyErrorMessage(error)}');
      return;
    }
    if (!mounted) return;
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('新增掉落'),
        description: Text('新增一条掉落记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// Shows the edit dialog
  void _showEditDialog() {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑掉落'),
        description: Text('编辑选中的掉落记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }
}
