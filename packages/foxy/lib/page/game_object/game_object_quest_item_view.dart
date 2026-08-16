import 'package:flutter/material.dart';
import 'package:foxy/entity/game_object_quest_item_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/game_object_quest_item_linked_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/item_quality_color.dart';
import 'package:foxy/widget/foxy_form_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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
      .get<GameObjectQuestItemLinkedListViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch((_) => _buildContent(context));
  }

  @override
  void didUpdateWidget(covariant GameObjectQuestItemView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gameObjectId != widget.gameObjectId) {
      viewModel.setLinkKey(widget.gameObjectId);
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
    viewModel.initSignals(linkKey: widget.gameObjectId);
  }

  Widget _buildContent(BuildContext context) {
    final items = viewModel.items.value;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        spacing: 16,
        children: [
          if (viewModel.errorMessage.value != null)
            FoxyInlineError(message: viewModel.errorMessage.value),
          Row(
            children: [
              ShadButton(onPressed: _showCreateDialog, child: Text('新增')),
              const Spacer(),
              FoxyPagination(
                page: viewModel.page.value,
                pageSize: 50,
                total: viewModel.total.value,
                onChange: viewModel.paginate,
              ),
            ],
          ),
          FoxyDataTable<BriefGameObjectQuestItemEntity>(
            shrinkWrap: true,
            pinnedRowCount: 1,
            rows: items,
            onRowDoubleTap: (item) async {
              viewModel.selectedKey.value = item.key;
              await _showEditDialog();
            },
            onRowSecondaryTapDownWithDetails: (item, details) {
              ContextMenu.show(
                context: context,
                position: details.globalPosition,
                items: [
                  ShadContextMenuItem(
                    leading: Icon(LucideIcons.squarePen, size: 16),
                    onPressed: () async {
                      viewModel.selectedKey.value = item.key;
                      await _showEditDialog();
                    },
                    child: Text('编辑'),
                  ),
                  ShadContextMenuItem(
                    enabled: !viewModel.submitting.value,
                    leading: Icon(LucideIcons.copy, size: 16),
                    onPressed: () => _copy(item.key),
                    child: Text('复制'),
                  ),
                  ShadContextMenuItem(
                    leading: Icon(LucideIcons.trash, size: 16),
                    onPressed: () => _destroy(item.key),
                    child: Text('删除'),
                  ),
                ],
              );
            },
            columns: [
              FoxyTableColumn.fixed(
                label: '索引',
                width: 120,
                cell: (_, item) => Text(item.idx.toString()),
              ),
              FoxyTableColumn.flex(
                label: '物品名称',
                cell: (_, item) => Text(
                  item.displayName,
                  style: TextStyle(
                    color: ItemQualityColor.of(item.itemQuality),
                  ),
                ),
              ),
              FoxyTableColumn.fixed(
                label: '验证版本',
                width: 120,
                cell: (_, item) => Text(item.verifiedBuild.toString()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDialogForm(
    BuildContext dialogContext, {
    required bool isEditing,
  }) {
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
                  label: '游戏对象编号',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.gameObjectEntryController,
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
            spacing: 8,
            children: [
              ShadButton.outline(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text('取消'),
              ),
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
                    DialogUtil.instance.success('保存成功');
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

  Future<void> _copy(GameObjectQuestItemKey key) async {
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

  Future<void> _destroy(GameObjectQuestItemKey key) async {
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

  Future<bool> _load(GameObjectQuestItemKey key) async {
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
      builder: (dialogContext) => FoxyFormDialog(
        title: '新增任务物品',
        description: '新增一条任务物品记录',
        child: _buildDialogForm(dialogContext, isEditing: false),
      ),
    );
  }

  Future<void> _showEditDialog() async {
    if (!await _load(viewModel.selectedKey.value!)) return;
    if (!mounted) return;
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => FoxyFormDialog(
        title: '编辑任务物品',
        description: '编辑选中的任务物品记录',
        child: _buildDialogForm(dialogContext, isEditing: true),
      ),
    );
  }
}
