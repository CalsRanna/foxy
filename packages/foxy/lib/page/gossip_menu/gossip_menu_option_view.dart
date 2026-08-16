import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/constant/gossip_menu_option_constants.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/gossip_menu_option_linked_list_view_model.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// Tab 3: gossip_menu_option dual-mode (list / form)
class GossipMenuOptionView extends StatefulWidget {
  final int menuId;

  const GossipMenuOptionView({super.key, required this.menuId});

  @override
  State<GossipMenuOptionView> createState() => _GossipMenuOptionViewState();
}

class _GossipMenuOptionViewState extends State<GossipMenuOptionView> {
  final viewModel = GetIt.instance.get<GossipMenuOptionLinkedListViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch((_) => _buildList());
  }

  @override
  void didUpdateWidget(covariant GossipMenuOptionView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.menuId != widget.menuId) {
      viewModel.setLinkKey(widget.menuId);
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
    if (widget.menuId != 0) {
      viewModel.initSignals(linkKey: widget.menuId);
    }
  }

  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.editingKey.value != null;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: DialogUtil.width),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '编号',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.optionIdController,
                    placeholder: 'OptionID',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '对话编号',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.menuIdController,
                    placeholder: 'MenuID',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '类型',
                  child: FoxyShadSelect<int>(
                    controller: viewModel.optionTypeController,
                    options: GossipMenuOptionConstants.gossipOptionTypes,
                    placeholder: const Text('OptionType'),
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
                  label: '图标',
                  child: FoxyShadSelect<int>(
                    controller: viewModel.optionIconController,
                    options: GossipMenuOptionConstants.gossipOptionIcons,
                    placeholder: const Text('OptionIcon'),
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: 'NPC标识',
                  child: FoxyFlagPicker(
                    controller: viewModel.optionNpcFlagController,
                    flags: CreatureFlags.npcFlagOptions,
                    title: 'Npc标识编辑器',
                    placeholder: 'OptionNpcFlag',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '子选项编号',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.gossipMenu,
                    controller: viewModel.actionMenuIdController,
                    placeholder: 'ActionMenuID',
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
                  label: '兴趣点',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.pointOfInterest,
                    controller: viewModel.actionPoiIdController,
                    placeholder: 'ActionPoiID',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '输入密码',
                  child: FoxyShadSelect<int>(
                    controller: viewModel.boxCodedController,
                    options: GossipMenuOptionConstants.gossipBooleanOptions,
                    placeholder: const Text('BoxCoded'),
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '选项文本',
                  child: FoxyLocalePicker(
                    entry: viewModel.selectedKey.value?.menuId,
                    ownerKey: viewModel.selectedKey.value,
                    controller: viewModel.optionTextController,
                    delegate:
                        FoxyLocalePickerDelegates.gossipMenuOptionOptionText,
                    placeholder: 'OptionText',
                    title: '选项文本',
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
                  label: '选项广播文本',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.broadcastText,
                    controller: viewModel.optionBroadcastTextIdController,
                    placeholder: 'OptionBroadcastTextID',
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
              Expanded(
                child: FoxyFormItem(
                  label: '确认文本',
                  child: FoxyLocalePicker(
                    entry: viewModel.selectedKey.value?.menuId,
                    ownerKey: viewModel.selectedKey.value,
                    controller: viewModel.boxTextController,
                    delegate: FoxyLocalePickerDelegates.gossipMenuOptionBoxText,
                    placeholder: 'BoxText',
                    title: '确认文本',
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
                  label: '确认广播文本',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.broadcastText,
                    controller: viewModel.boxBroadcastTextIdController,
                    placeholder: 'BoxBroadcastTextID',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '所需铜币',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.boxMoneyController,
                    placeholder: 'BoxMoney',
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
                      if (!dialogContext.mounted) return;
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

  Widget _buildList() {
    final createBtn = ShadButton(
      onPressed: _showCreateDialog,
      child: Text('新增'),
    );
    final toolbar = Row(
      children: [
        createBtn,
        const Spacer(),
        FoxyPagination(
          page: viewModel.page.value,
          pageSize: 50,
          total: viewModel.total.value,
          onChange: viewModel.paginate,
        ),
      ],
    );

    final options = viewModel.items.value;

    final table = FoxyDataTable<BriefGossipMenuOptionEntity>(
      shrinkWrap: true,
      pinnedRowCount: 1,
      rows: options,
      columns: [
        FoxyTableColumn.fixed(
          label: '编号',
          width: 120,
          cell: (_, o) => Text(o.optionId.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '图标',
          width: 120,
          cell: (_, o) => Text(
            GossipMenuOptionConstants.gossipOptionIcons[o.optionIcon] ??
                o.optionIcon.toString(),
          ),
        ),
        FoxyTableColumn.flex(
          label: '文本',
          cell: (_, o) =>
              Text(o.displayText, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        FoxyTableColumn.fixed(
          label: '类型',
          width: 120,
          cell: (_, o) => Text(
            GossipMenuOptionConstants.gossipOptionTypes[o.optionType] ??
                o.optionType.toString(),
          ),
        ),
        FoxyTableColumn.fixed(
          label: 'NPC标识',
          width: 120,
          cell: (_, o) => Text(o.optionNpcFlagLabel),
        ),
        FoxyTableColumn.fixed(
          label: '子选项',
          width: 120,
          cell: (_, o) => Text(o.actionMenuId.toString()),
        ),
      ],
      onRowDoubleTap: (o) => _showEditDialog(o.key),
      onRowSecondaryTapDownWithDetails: (o, details) {
        ContextMenu.show(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: () => _showEditDialog(o.key),
              child: Text('编辑'),
            ),
            ShadContextMenuItem(
              leading: Icon(LucideIcons.copy, size: 16),
              onPressed: () => _copy(o.key),
              child: Text('复制'),
            ),
            ShadContextMenuItem(
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed: () => _destroy(o.key),
              child: Text('删除'),
            ),
          ],
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        spacing: 16,
        children: [
          if (viewModel.errorMessage.value != null)
            FoxyInlineError(message: viewModel.errorMessage.value),
          toolbar,
          table,
        ],
      ),
    );
  }

  Future<void> _copy(GossipMenuOptionKey key) async {
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

  Future<void> _showCreateDialog() async {
    try {
      await viewModel.create(showForm: false);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('创建失败：${FoxyExceptions.message(error)}');
      return;
    }
    if (!mounted) return;
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: const Text('新增选项'),
        description: const Text('新增一条选项记录'),
        titlePinned: true,
        descriptionPinned: true,
        constraints: DialogUtil.constraints(dialogContext),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  Future<void> _destroy(GossipMenuOptionKey key) async {
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

  Future<void> _showEditDialog(GossipMenuOptionKey key) async {
    try {
      await viewModel.edit(key, showForm: false);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
      return;
    }
    if (!mounted) return;
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: const Text('编辑选项'),
        description: const Text('编辑选中的选项记录'),
        titlePinned: true,
        descriptionPinned: true,
        constraints: DialogUtil.constraints(dialogContext),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }
}
