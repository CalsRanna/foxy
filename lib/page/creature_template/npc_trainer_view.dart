import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/page/creature_template/npc_trainer_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// 训练师Tab
class NpcTrainerView extends StatefulWidget {
  final int creatureId;

  const NpcTrainerView({super.key, required this.creatureId});

  @override
  State<NpcTrainerView> createState() => _NpcTrainerViewState();
}

class _NpcTrainerViewState extends State<NpcTrainerView> {
  final viewModel = GetIt.instance.get<NpcTrainerViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(creatureId: widget.creatureId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return _buildTable();
    });
  }

  Widget _buildTable() {
    // 新增按钮
    var createButton = ShadButton(
      onPressed: _showCreateDialog,
      child: Text('新增'),
    );

    // 工具栏
    final toolbar = Row(children: [createButton, Spacer()]);

    final items = viewModel.items.value;
    final headers = ['技能ID', '技能名称', '金币花费', '技能线', '等级要求'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var maxWidth = constraints.maxWidth;
        var width = maxWidth - 480;
        return FoxyShadTable(
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= items.length) {
              return ShadTableCell(child: SizedBox());
            }
            final trainer = items[vicinity.row];
            final displayName = trainer.spellSubtext.isNotEmpty
                ? '${trainer.spellName} - ${trainer.spellSubtext}'
                : trainer.spellName;
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(trainer.spellId.toString())),
              1 => ShadTableCell(child: Text(displayName)),
              2 => ShadTableCell(child: Text(trainer.moneyCost.toString())),
              3 => ShadTableCell(child: Text(trainer.reqSkillLine.toString())),
              4 => ShadTableCell(child: Text(trainer.reqLevel.toString())),
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
              4 => FixedTableSpanExtent(120),
              _ => null,
            };
          },
          header: (context, index) {
            return ShadTableCell.header(child: Text(headers[index]));
          },
          onRowSecondaryTapDownWithDetails: (row, details) {
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () {
                    viewModel.selectRow(row);
                    viewModel.edit();
                    _showEditDialog(context);
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => viewModel.delete(context),
                  child: Text('删除'),
                ),
              ],
            );
          },
          rowCount: items.length,
          shrinkWrap: true,
        );
      },
    );

    var children = [toolbar, layoutBuilder];
    final column = Column(spacing: 16, children: children);
    return Padding(padding: const EdgeInsets.only(top: 16), child: column);
  }

  /// 显示新增对话框
  Future<void> _showCreateDialog() async {
    if (!await viewModel.create() || !mounted) return;
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('新增训练师技能'),
        description: Text('新增一条训练师技能记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// 显示编辑对话框
  void _showEditDialog(BuildContext context) {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑训练师技能'),
        description: Text('编辑选中的训练师技能记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// 对话框表单（垂直布局）
  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.editing.value;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500, maxHeight: 680),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FoxyFormItem(
              label: '生物ID',
              child: FoxyNumberInput<int>(
                controller: viewModel.creatureIdController,
                placeholder: 'CreatureId',
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            FoxyFormItem(
              label: '训练师ID',
              child: FoxyNumberInput<int>(
                controller: viewModel.trainerIdController,
                placeholder: 'TrainerId',
                readOnly: true,
              ),
            ),
            SizedBox(height: 16),
            // 技能
            FoxyFormItem(
              label: '技能',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.spell,
                controller: viewModel.spellIdController,
                placeholder: 'SpellId',
                readOnly: isEditing,
              ),
            ),
            SizedBox(height: 16),
            // 金币花费
            FoxyFormItem(
              label: '金币花费',
              child: FoxyNumberInput<int>(
                controller: viewModel.moneyCostController,
                placeholder: 'MoneyCost',
              ),
            ),
            SizedBox(height: 16),
            // 需要技能线
            FoxyFormItem(
              label: '需要技能线',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.skillLine,
                controller: viewModel.reqSkillLineController,
                placeholder: 'ReqSkillLine',
              ),
            ),
            SizedBox(height: 16),
            // 需要技能等级
            FoxyFormItem(
              label: '需要技能等级',
              child: FoxyNumberInput<int>(
                controller: viewModel.reqSkillRankController,
                placeholder: 'ReqSkillRank',
              ),
            ),
            SizedBox(height: 16),
            FoxyFormItem(
              label: '前置技能 1',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.spell,
                controller: viewModel.reqAbility1Controller,
                placeholder: 'ReqAbility1 (0=无)',
              ),
            ),
            SizedBox(height: 16),
            FoxyFormItem(
              label: '前置技能 2',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.spell,
                controller: viewModel.reqAbility2Controller,
                placeholder: 'ReqAbility2 (0=无)',
              ),
            ),
            SizedBox(height: 16),
            FoxyFormItem(
              label: '前置技能 3',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.spell,
                controller: viewModel.reqAbility3Controller,
                placeholder: 'ReqAbility3 (0=无)',
              ),
            ),
            SizedBox(height: 16),
            FoxyFormItem(
              label: '需要等级',
              child: FoxyNumberInput<int>(
                controller: viewModel.reqLevelController,
                placeholder: 'ReqLevel',
              ),
            ),
            SizedBox(height: 16),
            FoxyFormItem(
              label: 'VerifiedBuild',
              child: FoxyNumberInput<int>(
                controller: viewModel.verifiedBuildController,
                placeholder: 'VerifiedBuild',
              ),
            ),
            SizedBox(height: 24),
            // 按钮行
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShadButton.outline(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text('取消'),
                ),
                SizedBox(width: 8),
                ShadButton(
                  onPressed: () async {
                    if (isEditing) {
                      await viewModel.update(dialogContext);
                    } else {
                      await viewModel.save(dialogContext);
                    }
                    if (!dialogContext.mounted) return;
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(isEditing ? '更新' : '保存'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
