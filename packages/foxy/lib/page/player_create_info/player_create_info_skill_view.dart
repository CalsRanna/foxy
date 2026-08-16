import 'package:flutter/material.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_skill_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/player_create_info_skill_linked_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:foxy/widget/foxy_form_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PlayerCreateInfoSkillView extends StatefulWidget {
  final int? race;
  final int? playerClass;

  const PlayerCreateInfoSkillView({super.key, this.race, this.playerClass});

  @override
  State<PlayerCreateInfoSkillView> createState() =>
      _PlayerCreateInfoSkillViewState();
}

class _PlayerCreateInfoSkillViewState extends State<PlayerCreateInfoSkillView> {
  final viewModel = GetIt.instance
      .get<PlayerCreateInfoSkillLinkedListViewModel>();

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
  void didUpdateWidget(covariant PlayerCreateInfoSkillView oldWidget) {
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
    final rows = viewModel.items.value;
    return FoxyDataTable<BriefPlayerCreateInfoSkillEntity>(
      shrinkWrap: true,
      rows: rows,
      columns: [
        FoxyTableColumn.flex(
          label: '种族掩码',
          cell: (_, row) => Text(row.raceMaskLabel),
        ),
        FoxyTableColumn.flex(
          label: '职业掩码',
          cell: (_, row) => Text(row.classMaskLabel),
        ),
        FoxyTableColumn.fixed(
          label: '技能',
          width: 120,
          cell: (_, row) => Text(row.skill.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '阶数',
          width: 120,
          cell: (_, row) => Text(row.rank.toString()),
        ),
        FoxyTableColumn.flex(label: '备注', cell: (_, row) => Text(row.comment)),
      ],
      onRowDoubleTap: (row) => _showEditDialog(row),
      onRowSecondaryTapDownWithDetails: (row, details) {
        ContextMenu.show(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: const Icon(LucideIcons.squarePen, size: 16),
              onPressed: () => _showEditDialog(row),
              child: const Text('编辑'),
            ),
            ShadContextMenuItem(
              leading: const Icon(LucideIcons.trash, size: 16),
              onPressed: () => _destroy(row.key),
              child: const Text('删除'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _destroy(PlayerCreateInfoSkillKey key) async {
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

  Widget _dialogActions(BuildContext dialogContext) => Row(
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
          child: const Text('保存'),
        ),
      ),
    ],
  );

  Future<bool> _load(PlayerCreateInfoSkillKey key) async {
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
    _showDialog('新增技能');
  }

  void _showDialog(String title) {
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => FoxyFormDialog(
        title: title,
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
                    label: '技能',
                    child: FoxyEntityPicker(
                      controller: viewModel.skillController,
                      delegate: FoxyEntityPickerDelegates.skillLine,
                      placeholder: 'skill',
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
                    label: '阶数',
                    child: FoxyNumberInput<int>(
                      controller: viewModel.rankController,
                      placeholder: 'rank (0..15)',
                    ),
                  ),
                ),
                Expanded(
                  child: FoxyFormItem(
                    label: '备注',
                    child: FoxyStringInput(
                      controller: viewModel.commentController,
                      placeholder: 'comment',
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
            _dialogActions(dialogContext),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditDialog(BriefPlayerCreateInfoSkillEntity entity) async {
    if (!await _load(entity.key)) return;
    if (!mounted) return;
    _showDialog('编辑技能');
  }
}
