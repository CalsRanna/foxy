import 'package:flutter/material.dart';
import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/creature_quest_ender_linked_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:signals_flutter/signals_flutter.dart';

class CreatureQuestEnderView extends StatefulWidget {
  final int questId;
  const CreatureQuestEnderView({super.key, required this.questId});

  @override
  State<CreatureQuestEnderView> createState() => _CreatureQuestEnderViewState();
}

class _CreatureQuestEnderViewState extends State<CreatureQuestEnderView> {
  final viewModel = GetIt.instance.get<CreatureQuestEnderLinkedListViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return _buildTable();
    });
  }

  @override
  void didUpdateWidget(covariant CreatureQuestEnderView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questId != widget.questId) {
      viewModel.setLinkKey(widget.questId);
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
    viewModel.initSignals(linkKey: widget.questId);
  }

  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.selectedKey.value != null;
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
                  label: '生物编号',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.creatureTemplate,
                    controller: viewModel.idController,
                    placeholder: 'CreatureId',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '任务编号',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.questController,
                  ),
                ),
              ),
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
    var createButton = ShadButton(
      onPressed: _showCreateDialog,
      leading: Icon(LucideIcons.plus, size: 16),
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

    final table = FoxyDataTable<BriefCreatureQuestEnderEntity>(
      shrinkWrap: true,
      rows: items,
      columns: [
        FoxyTableColumn.fixed(
          label: '编号',
          width: 120,
          cell: (_, item) => Text(item.id.toString()),
        ),
        FoxyTableColumn.flex(
          label: '名称',
          cell: (_, item) => Text(
            item.displayName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
      onRowDoubleTap: (item) async {
        viewModel.selectedKey.value = item.key;
        if (!await _load(viewModel.selectedKey.value!)) return;
        if (!mounted) return;
        _showEditDialog(context);
      },
      onRowSecondaryTapDownWithDetails: (item, details) {
        viewModel.selectedKey.value = item.key;
        showFoxyContextMenu(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: () async {
                if (!await _load(viewModel.selectedKey.value!)) return;
                if (!mounted) return;
                _showEditDialog(context);
              },
              child: Text('编辑'),
            ),
            ShadContextMenuItem(
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed: () => _destroy(viewModel.selectedKey.value!),
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

  Future<void> _destroy(CreatureQuestEnderKey key) async {
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

  Future<bool> _load(CreatureQuestEnderKey key) async {
    try {
      await viewModel.edit(key);
      return true;
    } catch (error) {
      if (mounted) DialogUtil.instance.error('加载失败：${foxyErrorMessage(error)}');
      return false;
    }
  }

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
        title: Text('新增结束生物'),
        titlePinned: true,
        descriptionPinned: true,
        constraints: foxyDialogConstraints(dialogContext),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑结束生物'),
        titlePinned: true,
        descriptionPinned: true,
        constraints: foxyDialogConstraints(dialogContext),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }
}
