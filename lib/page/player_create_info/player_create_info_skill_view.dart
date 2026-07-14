import 'package:flutter/material.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/page/player_create_info/player_create_info_skill_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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
  final viewModel = GetIt.instance.get<PlayerCreateInfoSkillViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(race: widget.race, playerClass: widget.playerClass);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Column(
      spacing: 16,
      children: [
        Row(
          children: [
            ShadButton(
              onPressed: widget.race == null ? null : _showCreateDialog,
              child: const Text('新增'),
            ),
          ],
        ),
        Watch((_) => _buildTable()),
      ],
    ),
  );

  Widget _buildTable() {
    final rows = viewModel.skills.value;
    const headers = ['种族掩码', '职业掩码', '技能', '阶数', '备注'];
    return FoxyShadTable(
      builder: (context, vicinity) {
        final row = rows[vicinity.row];
        return ShadTableCell(
          child: Text(switch (vicinity.column) {
            0 => row.raceMask.toString(),
            1 => row.classMask.toString(),
            2 => row.skill.toString(),
            3 => row.rank.toString(),
            4 => row.comment,
            _ => '',
          }),
        );
      },
      columnCount: headers.length,
      columnSpanExtent: (index) => FixedTableSpanExtent(index == 4 ? 280 : 150),
      header: (context, index) =>
          ShadTableCell.header(child: Text(headers[index])),
      onRowSecondaryTapDownWithDetails: (row, details) {
        showFoxyContextMenu(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: const Icon(LucideIcons.squarePen, size: 16),
              onPressed: () => _showEditDialog(rows[row]),
              child: const Text('编辑'),
            ),
            ShadContextMenuItem(
              leading: const Icon(LucideIcons.trash, size: 16),
              onPressed: () => viewModel.delete(context, rows[row]),
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
    await viewModel.create();
    if (!mounted) return;
    _showDialog('新增技能');
  }

  void _showEditDialog(PlayerCreateInfoSkillEntity entity) {
    viewModel.edit(entity);
    _showDialog('编辑技能');
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
                    label: '技能',
                    child: FoxyEntityPicker(
                      controller: viewModel.skillController,
                      delegate: FoxyEntityPickerDelegates.skillLine,
                      placeholder: 'skill',
                    ),
                  ),
                ),
                Expanded(
                  child: FoxyFormItem(
                    label: '阶数',
                    child: FoxyNumberInput<int>(
                      controller: viewModel.rankController,
                      placeholder: 'rank (0..15)',
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
                      controller: viewModel.commentController,
                      placeholder: 'comment',
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                const Expanded(child: SizedBox()),
                const Expanded(child: SizedBox()),
              ],
            ),
            _dialogActions(dialogContext),
          ],
        ),
      ),
    );
  }

  Widget _dialogActions(BuildContext dialogContext) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ShadButton.outline(
        onPressed: () => Navigator.of(dialogContext).pop(),
        child: const Text('取消'),
      ),
      const SizedBox(width: 8),
      ShadButton(
        onPressed: () async {
          await viewModel.save(dialogContext);
          if (dialogContext.mounted) Navigator.of(dialogContext).pop();
        },
        child: const Text('保存'),
      ),
    ],
  );
}
