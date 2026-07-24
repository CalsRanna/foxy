import 'package:flutter/material.dart';
import 'package:foxy/entity/game_object_loot_template_entity.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/page/game_object/game_object_loot_template_collection_editor_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:signals/signals_flutter.dart';

class GameObjectLootTemplateView extends StatefulWidget {
  final int parentKey;

  const GameObjectLootTemplateView({super.key, required this.parentKey});

  @override
  State<GameObjectLootTemplateView> createState() =>
      _GameObjectLootTemplateViewState();
}

class _GameObjectLootTemplateViewState
    extends State<GameObjectLootTemplateView> {
  final viewModel = GetIt.instance
      .get<GameObjectLootTemplateCollectionEditorViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(parentKey: widget.parentKey);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) => _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    final items = viewModel.items.value;
    final selectedKey = viewModel.selectedKey.value;
    final headers = ['物品ID', '物品名称', '几率', '数量', '任务', '组'];

    return Column(
      spacing: 16,
      children: [
        Row(
          spacing: 8,
          children: [
            ShadButton(
              leading: Icon(LucideIcons.plus, size: 16),
              onPressed: _showCreateDialog,
              size: ShadButtonSize.sm,
              child: Text('新增'),
            ),
            ShadButton.ghost(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: selectedKey != null ? _showEditDialog : null,
              size: ShadButtonSize.sm,
              child: Text('编辑'),
            ),
            const Spacer(),
            FoxyPagination(
              page: viewModel.page.value,
              pageSize: 50,
              total: viewModel.total.value,
              onChange: viewModel.paginate,
            ),
            ShadButton.destructive(
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed: selectedKey != null
                  ? () => _destroy(viewModel.selectedKey.value!)
                  : null,
              size: ShadButtonSize.sm,
              child: Text('删除'),
            ),
          ],
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            var width = constraints.maxWidth - 560;
            return FoxyShadTable(
              shrinkWrap: true,
              builder: (context, vicinity) {
                final item = items[vicinity.row];
                final nameStyle = TextStyle(
                  color: _getQualityColor(item.itemQuality),
                );
                return switch (vicinity.column) {
                  0 => ShadTableCell(child: Text(item.item.toString())),
                  1 => ShadTableCell(
                    child: Text(
                      item.reference != 0
                          ? '[${item.displayName}]'
                          : item.displayName,
                      style: nameStyle,
                    ),
                  ),
                  2 => ShadTableCell(child: Text(item.chance.toString())),
                  3 => ShadTableCell(
                    child: Text('${item.minCount}-${item.maxCount}'),
                  ),
                  4 => ShadTableCell(
                    child: Text(item.questRequired ? '是' : '否'),
                  ),
                  5 => ShadTableCell(child: Text(item.groupId.toString())),
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
                  4 => FixedTableSpanExtent(100),
                  5 => FixedTableSpanExtent(100),
                  _ => null,
                };
              },
              header: (context, index) {
                return ShadTableCell.header(child: Text(headers[index]));
              },
              onRowTap: (row) => viewModel.selectedKey.value = items[row].key,
              onRowDoubleTap: (row) async {
                viewModel.selectedKey.value = items[row].key;
                await _showEditDialog();
              },
              pinnedRowCount: 1,
              rowCount: items.length,
            );
          },
        ),
      ],
    );
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
        title: Text('新增掉落'),
        description: Text('新增一条掉落记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  Future<void> _showEditDialog() async {
    if (!await _load(viewModel.selectedKey.value!)) return;
    if (!mounted) return;
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
    final isEditing = viewModel.editingKey.value != null;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 960),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '游戏对象编号',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.gameObjectIdController,
                    placeholder: 'Entry',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '物品 ID',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.itemTemplate,
                    controller: viewModel.itemController,
                    placeholder: 'Item',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '引用掉落模板',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.referenceLoot,
                    controller: viewModel.referenceController,
                    placeholder: 'Reference',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '掉落几率',
                  child: FoxyNumberInput<double>(
                    controller: viewModel.chanceController,
                    placeholder: 'Chance',
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
                  label: '需要任务',
                  child: FoxyShadSelect<int>(
                    controller: viewModel.questRequiredController,
                    options: kBooleanOptions,
                    placeholder: const Text('QuestRequired'),
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '掉落模式',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.lootModeController,
                    placeholder: 'LootMode',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '组 ID',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.groupIdController,
                    placeholder: 'GroupId',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '最小数量',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.minCountController,
                    placeholder: 'MinCount',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '最大数量',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.maxCountController,
                    placeholder: 'MaxCount',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '备注',
                  child: FoxyStringInput(
                    controller: viewModel.commentController,
                    placeholder: 'Comment',
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

  Color _getQualityColor(int quality) {
    return switch (quality) {
      1 => const Color(0xFFFFFFFF),
      2 => const Color(0xFF1EFF00),
      3 => const Color(0xFF0070DD),
      4 => const Color(0xFFA335EE),
      5 => const Color(0xFFFF8000),
      _ => const Color(0xFF9D9D9D),
    };
  }

  Future<bool> _load(GameObjectLootTemplateKey key) async {
    try {
      await viewModel.edit(key);
      return true;
    } catch (error) {
      if (mounted) DialogUtil.instance.error('加载失败：$error');
      return false;
    }
  }

  Future<void> _destroy(GameObjectLootTemplateKey key) async {
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
