import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/npc_trainer_view_model.dart';
import 'package:foxy/page/creature_template/spell_selector.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
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
              0 => ShadTableCell(child: Text(trainer.spellID.toString())),
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
          loading: viewModel.loading.value,
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
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () => viewModel.copy(context),
                  child: Text('复制'),
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
  void _showCreateDialog() {
    viewModel.create();
    showShadDialog(
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
    showShadDialog(
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
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 训练师ID（只读）
          FormItem(
            controller: TextEditingController(
              text: widget.creatureId.toString(),
            ),
            label: '训练师ID',
            placeholder: 'ID',
            readOnly: true,
          ),
          SizedBox(height: 16),
          // 技能
          FormItem(
            label: '技能',
            child: SpellSelector(
              controller: viewModel.spellIDController,
              placeholder: 'SpellID',
            ),
          ),
          SizedBox(height: 16),
          // 金币花费
          FormItem(
            controller: viewModel.moneyCostController,
            label: '金币花费',
            placeholder: 'MoneyCost',
          ),
          SizedBox(height: 16),
          // 需要技能线
          FormItem(
            controller: viewModel.reqSkillLineController,
            label: '需要技能线',
            placeholder: 'ReqSkillLine',
          ),
          SizedBox(height: 16),
          // 需要技能等级
          FormItem(
            controller: viewModel.reqSkillRankController,
            label: '需要技能等级',
            placeholder: 'ReqSkillRank',
          ),
          SizedBox(height: 16),
          // 需要等级
          FormItem(
            controller: viewModel.reqLevelController,
            label: '需要等级',
            placeholder: 'ReqLevel',
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
    );
  }
}
