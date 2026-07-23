import 'package:flutter/material.dart';
import 'package:foxy/entity/player_create_info_cast_spell_key.dart';
import 'package:foxy/entity/player_create_info_key.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/page/player_create_info/player_create_info_cast_spell_collection_editor_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_nullable_string_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:signals/signals_flutter.dart';

class PlayerCreateInfoCastSpellView extends StatefulWidget {
  final int? race;
  final int? playerClass;

  const PlayerCreateInfoCastSpellView({super.key, this.race, this.playerClass});

  @override
  State<PlayerCreateInfoCastSpellView> createState() =>
      _PlayerCreateInfoCastSpellViewState();
}

class _PlayerCreateInfoCastSpellViewState
    extends State<PlayerCreateInfoCastSpellView> {
  final viewModel = GetIt.instance
      .get<PlayerCreateInfoCastSpellCollectionEditorViewModel>();

  @override
  void initState() {
    super.initState();
    final race = widget.race;
    final playerClass = widget.playerClass;
    if (race == null || playerClass == null) return;
    viewModel.initSignals(
      parentKey: PlayerCreateInfoKey(race: race, class_: playerClass),
    );
  }

  @override
  void didUpdateWidget(covariant PlayerCreateInfoCastSpellView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.race != widget.race ||
        oldWidget.playerClass != widget.playerClass) {
      final race = widget.race;
      final playerClass = widget.playerClass;
      if (race == null || playerClass == null) return;
      viewModel.setParentKey(
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
          _buildTable(),
        ],
      ),
    ),
  );

  Widget _buildTable() {
    final rows = viewModel.items.value;
    const headers = ['种族掩码', '职业掩码', '法术', '备注'];
    return FoxyShadTable(
      builder: (context, vicinity) {
        final row = rows[vicinity.row];
        return ShadTableCell(
          child: Text(switch (vicinity.column) {
            0 => row.raceMask.toString(),
            1 => row.classMask.toString(),
            2 => row.spell.toString(),
            3 => row.note ?? 'NULL',
            _ => '',
          }),
        );
      },
      columnCount: headers.length,
      columnSpanExtent: (index) => FixedTableSpanExtent(index == 3 ? 360 : 180),
      header: (context, index) =>
          ShadTableCell.header(child: Text(headers[index])),
      onRowSecondaryTapDownWithDetails: (row, details) {
        showFoxyContextMenu(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: const Icon(LucideIcons.squarePen, size: 16),
              onPressed: () async {
                if (!await _load(rows[row].key)) return;
                if (context.mounted) {
                  _showDialog('编辑登录施法');
                }
              },
              child: const Text('编辑'),
            ),
            ShadContextMenuItem(
              leading: const Icon(LucideIcons.trash, size: 16),
              onPressed: () => _destroy(rows[row].key),
              child: const Text('删除'),
            ),
          ],
        );
      },
      rowCount: rows.length,
      shrinkWrap: true,
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
    if (mounted) _showDialog('新增登录施法');
  }

  void _showDialog(String title) {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text(title),
        constraints: const BoxConstraints(maxWidth: 960),
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
                      flags: kPlayerCreateRaceMaskFlags,
                      title: '种族掩码',
                    ),
                  ),
                ),
                Expanded(
                  child: FoxyFormItem(
                    label: '职业掩码',
                    child: FoxyFlagPicker(
                      controller: viewModel.classMaskController,
                      flags: kPlayerCreateClassMaskFlags,
                      title: '职业掩码',
                    ),
                  ),
                ),
                Expanded(
                  child: FoxyFormItem(
                    label: '法术',
                    child: FoxyEntityPicker(
                      controller: viewModel.spellController,
                      delegate: FoxyEntityPickerDelegates.spell,
                      placeholder: 'spell',
                    ),
                  ),
                ),
                Expanded(
                  child: FoxyFormItem(
                    label: '备注',
                    child: FoxyNullableStringInput(
                      controller: viewModel.noteController,
                      placeholder: 'note',
                    ),
                  ),
                ),
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
                        DialogUtil.instance.error('保存失败：$error');
                        return;
                      }
                      if (!dialogContext.mounted) return;
                      ShadSonner.of(
                        dialogContext,
                      ).show(const ShadToast(description: Text('保存成功')));
                      Navigator.of(dialogContext).pop();
                    },
                    child: const Text('保存'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _load(PlayerCreateInfoCastSpellKey key) async {
    try {
      await viewModel.edit(key);
      return true;
    } catch (error) {
      if (mounted) DialogUtil.instance.error('加载失败：$error');
      return false;
    }
  }

  Future<void> _destroy(PlayerCreateInfoCastSpellKey key) async {
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
