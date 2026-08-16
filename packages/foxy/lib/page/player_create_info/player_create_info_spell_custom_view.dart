import 'package:flutter/material.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_spell_custom_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/player_create_info_spell_custom_linked_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:foxy/widget/foxy_form_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class PlayerCreateInfoSpellCustomView extends StatefulWidget {
  final int? race;
  final int? playerClass;

  const PlayerCreateInfoSpellCustomView({
    super.key,
    this.race,
    this.playerClass,
  });

  @override
  State<PlayerCreateInfoSpellCustomView> createState() =>
      _PlayerCreateInfoSpellCustomViewState();
}

class _PlayerCreateInfoSpellCustomViewState
    extends State<PlayerCreateInfoSpellCustomView> {
  final viewModel = GetIt.instance
      .get<PlayerCreateInfoSpellCustomLinkedListViewModel>();

  @override
  Widget build(BuildContext context) => Watch(
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
                child: const Text('新增'),
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
          if (viewModel.errorMessage.value != null)
            FoxyInlineError(message: viewModel.errorMessage.value),
          _buildTable(),
        ],
      ),
    ),
  );

  @override
  void didUpdateWidget(covariant PlayerCreateInfoSpellCustomView oldWidget) {
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

  Widget _buildTable() {
    final spells = viewModel.items.value;
    return FoxyDataTable<BriefPlayerCreateInfoSpellCustomEntity>(
      shrinkWrap: true,
      rows: spells,
      columns: [
        FoxyTableColumn.fixed(
          label: '种族掩码',
          width: 120,
          cell: (_, item) => Text(item.raceMaskLabel),
        ),
        FoxyTableColumn.fixed(
          label: '职业掩码',
          width: 120,
          cell: (_, item) => Text(item.classMaskLabel),
        ),
        FoxyTableColumn.fixed(
          label: '法术',
          width: 120,
          cell: (_, item) => Text(item.spell.toString()),
        ),
        FoxyTableColumn.flex(label: '备注', cell: (_, item) => Text(item.note)),
      ],
      onRowDoubleTap: (item) => _showEditDialog(item),
      onRowSecondaryTapDownWithDetails: (item, details) {
        ContextMenu.show(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: const Icon(LucideIcons.squarePen, size: 16),
              onPressed: () => _showEditDialog(item),
              child: const Text('编辑'),
            ),
            ShadContextMenuItem(
              leading: const Icon(LucideIcons.trash, size: 16),
              onPressed: () => _destroy(item.key),
              child: const Text('删除'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _destroy(PlayerCreateInfoSpellCustomKey key) async {
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

  Future<bool> _load(PlayerCreateInfoSpellCustomKey key) async {
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
    _showDialog(isEditing: false);
  }

  void _showDialog({required bool isEditing}) {
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => FoxyFormDialog(
        title: isEditing ? '编辑自定义法术' : '新增自定义法术',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: FoxyFormItem(
                    label: '种族掩码',
                    child: FoxyFlagPicker(
                      controller: viewModel.raceMaskController,
                      flags:
                          PlayerCreateInfoConstants.playerCreateRaceMaskFlags,
                      title: '种族掩码',
                    ),
                  ),
                ),
                Expanded(
                  child: FoxyFormItem(
                    label: '职业掩码',
                    child: FoxyFlagPicker(
                      controller: viewModel.classMaskController,
                      flags:
                          PlayerCreateInfoConstants.playerCreateClassMaskFlags,
                      title: '职业掩码',
                    ),
                  ),
                ),
                Expanded(
                  child: FoxyFormItem(
                    label: '法术',
                    child: FoxyEntityPicker(
                      placeholder: 'Spell',
                      controller: viewModel.spellController,
                      delegate: FoxyEntityPickerDelegates.spell,
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
                    label: '备注',
                    child: FoxyStringInput(
                      controller: viewModel.noteController,
                      placeholder: 'Note',
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                const Expanded(child: SizedBox()),
              ],
            ),
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
      ),
    );
  }

  Future<void> _showEditDialog(
    BriefPlayerCreateInfoSpellCustomEntity item,
  ) async {
    if (!await _load(item.key)) return;
    if (!mounted) return;
    _showDialog(isEditing: true);
  }
}
