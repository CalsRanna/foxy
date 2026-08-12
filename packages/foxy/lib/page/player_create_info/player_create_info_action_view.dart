import 'package:flutter/material.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_action_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/player_create_info_action_linked_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PlayerCreateInfoActionView extends StatefulWidget {
  final int? race;
  final int? playerClass;
  const PlayerCreateInfoActionView({super.key, this.race, this.playerClass});

  @override
  State<PlayerCreateInfoActionView> createState() =>
      _PlayerCreateInfoActionViewState();
}

class _PlayerCreateInfoActionViewState
    extends State<PlayerCreateInfoActionView> {
  final viewModel = GetIt.instance
      .get<PlayerCreateInfoActionLinkedListViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch(
      (_) => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          spacing: 16,
          children: [
            Row(
              children: [
                ShadButton(
                  onPressed: widget.race == null || widget.playerClass == null
                      ? null
                      : _showCreateDialog,
                  child: Text('新增'),
                ),
                const Spacer(),
                FoxyPagination(
                  page: viewModel.page.value,
                  pageSize: 50,
                  total: viewModel.total.value,
                  onChange: viewModel.paginate,
                ),
              ],
            ),
            _buildTable(),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant PlayerCreateInfoActionView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.race != widget.race ||
        oldWidget.playerClass != widget.playerClass) {
      final race = widget.race;
      final playerClass = widget.playerClass;
      if (race == null || playerClass == null) return;
      viewModel.setLinkKey(
        PlayerCreateInfoKey(race: race, class_: playerClass),
      );
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
    final race = widget.race;
    final playerClass = widget.playerClass;
    if (race == null || playerClass == null) return;
    viewModel.initSignals(
      linkKey: PlayerCreateInfoKey(race: race, class_: playerClass),
    );
  }

  Widget _buildActionInput() {
    return switch (viewModel.actionType.value) {
      0 => FoxyEntityPicker(
        controller: viewModel.actionController,
        delegate: FoxyEntityPickerDelegates.spell,
        placeholder: 'action (Spell.dbc)',
      ),
      128 => FoxyEntityPicker(
        controller: viewModel.actionController,
        delegate: FoxyEntityPickerDelegates.itemTemplate,
        placeholder: 'action (item_template)',
      ),
      _ => FoxyNumberInput<int>(
        placeholder: 'action (0..16777215)',
        controller: viewModel.actionController,
      ),
    };
  }

  Widget _buildDialog(BuildContext dialogContext, {required bool isEditing}) {
    return ShadDialog(
      title: Text(isEditing ? '编辑动作' : '新增动作'),
      titlePinned: true,
      descriptionPinned: true,
      constraints: DialogUtil.constraints(dialogContext),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 720),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: FoxyFormItem(
                    label: '种族',
                    child: FoxyShadSelect<int>(
                      controller: viewModel.raceController,
                      options: PlayerCreateInfoConstants.playerRaceOptions,
                      placeholder: const Text('race'),
                    ),
                  ),
                ),
                Expanded(
                  child: FoxyFormItem(
                    label: '职业',
                    child: FoxyShadSelect<int>(
                      controller: viewModel.classController,
                      options: PlayerCreateInfoConstants.playerClassOptions,
                      placeholder: const Text('class'),
                    ),
                  ),
                ),
                Expanded(
                  child: FoxyFormItem(
                    label: '按钮',
                    child: FoxyNumberInput<int>(
                      placeholder: 'button (0..143)',
                      controller: viewModel.buttonController,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: FoxyFormItem(
                    label: '动作',
                    child: Watch((_) => _buildActionInput()),
                  ),
                ),
                Expanded(
                  child: FoxyFormItem(
                    label: '类型',
                    child: FoxyShadSelect<int>(
                      controller: viewModel.typeController,
                      options: PlayerCreateInfoConstants
                          .playerActionButtonTypeOptions,
                      placeholder: const Text('type'),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
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
                          '保存失败：${FoxyError.message(error)}',
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
      ),
    );
  }

  Widget _buildTable() {
    final actions = viewModel.items.value;

    return FoxyDataTable<BriefPlayerCreateInfoActionEntity>(
      shrinkWrap: true,
      rows: actions,
      columns: [
        FoxyTableColumn.fixed(
          label: '按钮',
          width: 120,
          cell: (_, item) => Text(item.button.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '动作',
          width: 120,
          cell: (_, item) => Text(item.action.toString()),
        ),
        FoxyTableColumn.flex(
          label: '类型',
          cell: (_, item) => Text(item.typeLabel),
        ),
      ],
      onRowDoubleTap: (item) async {
        if (!await _load(item.key)) return;
        if (!mounted) return;
        _showDialog(isEditing: true);
      },
      onRowSecondaryTapDownWithDetails: (item, details) {
        ContextMenu.show(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: () async {
                if (!await _load(item.key)) return;
                if (!mounted) return;
                _showDialog(isEditing: true);
              },
              child: Text('编辑'),
            ),
            ShadContextMenuItem(
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed: () => _destroy(item.key),
              child: Text('删除'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _destroy(PlayerCreateInfoActionKey key) async {
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
      DialogUtil.instance.error('删除失败：${FoxyError.message(error)}');
    }
  }

  Future<bool> _load(PlayerCreateInfoActionKey key) async {
    try {
      await viewModel.edit(key);
      return true;
    } catch (error) {
      if (mounted) {
        DialogUtil.instance.error('加载失败：${FoxyError.message(error)}');
      }
      return false;
    }
  }

  Future<void> _showCreateDialog() async {
    try {
      await viewModel.create();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('创建失败：${FoxyError.message(error)}');
      return;
    }
    if (!mounted) return;
    _showDialog(isEditing: false);
  }

  void _showDialog({required bool isEditing}) {
    DialogUtil.show(
      context: context,
      builder: (c) => _buildDialog(c, isEditing: isEditing),
    );
  }
}
