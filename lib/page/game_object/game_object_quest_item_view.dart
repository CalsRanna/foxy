import 'package:flutter/material.dart';
import 'package:foxy/entity/game_object_quest_item_key.dart';
import 'package:foxy/page/game_object/game_object_quest_item_collection_editor_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:signals/signals_flutter.dart';

class GameObjectQuestItemView extends StatefulWidget {
  final int gameObjectId;

  const GameObjectQuestItemView({super.key, required this.gameObjectId});

  @override
  State<GameObjectQuestItemView> createState() =>
      _GameObjectQuestItemViewState();
}

class _GameObjectQuestItemViewState extends State<GameObjectQuestItemView> {
  final viewModel = GetIt.instance
      .get<GameObjectQuestItemCollectionEditorViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(parentKey: widget.gameObjectId);
  }

  @override
  void didUpdateWidget(covariant GameObjectQuestItemView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gameObjectId != widget.gameObjectId) {
      viewModel.setParentKey(widget.gameObjectId);
    }
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
    final headers = ['索引', '物品名称', '验证版本'];

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
            ShadButton.ghost(
              leading: Icon(LucideIcons.copy, size: 16),
              onPressed: selectedKey != null
                  ? () => _copy(viewModel.selectedKey.value!)
                  : null,
              size: ShadButtonSize.sm,
              child: Text('复制'),
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
            var width = constraints.maxWidth - 240;
            return FoxyShadTable(
              shrinkWrap: true,
              builder: (context, vicinity) {
                final item = items[vicinity.row];
                final nameStyle = TextStyle(
                  color: _getQualityColor(item.itemQuality),
                );
                return switch (vicinity.column) {
                  0 => ShadTableCell(child: Text(item.idx.toString())),
                  1 => ShadTableCell(
                    child: Text(item.displayName, style: nameStyle),
                  ),
                  2 => ShadTableCell(
                    child: Text(item.verifiedBuild.toString()),
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
        title: Text('新增任务物品'),
        description: Text('新增一条任务物品记录'),
        child: _buildDialogForm(dialogContext, isEditing: false),
      ),
    );
  }

  Future<void> _showEditDialog() async {
    if (!await _load(viewModel.selectedKey.value!)) return;
    if (!mounted) return;
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑任务物品'),
        description: Text('编辑选中的任务物品记录'),
        child: _buildDialogForm(dialogContext, isEditing: true),
      ),
    );
  }

  Widget _buildDialogForm(
    BuildContext dialogContext, {
    required bool isEditing,
  }) {
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
                    placeholder: 'GameObjectEntry',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '索引',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.idxController,
                    placeholder: 'Idx',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '物品',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.itemTemplate,
                    controller: viewModel.itemIdController,
                    placeholder: 'ItemId',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: 'VerifiedBuild',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.verifiedBuildController,
                    placeholder: 'VerifiedBuild',
                  ),
                ),
              ),
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

  Future<bool> _load(GameObjectQuestItemKey key) async {
    try {
      await viewModel.edit(key);
      return true;
    } catch (error) {
      if (mounted) DialogUtil.instance.error('加载失败：$error');
      return false;
    }
  }

  Future<void> _destroy(GameObjectQuestItemKey key) async {
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

  Future<void> _copy(GameObjectQuestItemKey key) async {
    try {
      await viewModel.copy(key);
      if (!mounted) return;
      DialogUtil.instance.success('复制成功');
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('复制失败：$error');
    }
  }
}
