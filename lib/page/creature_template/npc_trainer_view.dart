import 'package:flutter/material.dart';
import 'package:foxy/entity/npc_trainer_key.dart';
import 'package:foxy/page/creature_template/npc_trainer_collection_editor_view_model.dart';
import 'package:foxy/use_case/creature_template/resolve_npc_trainer_parent_use_case.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:signals/signals_flutter.dart';

/// 训练师Tab
class NpcTrainerView extends StatefulWidget {
  final int creatureId;

  const NpcTrainerView({super.key, required this.creatureId});

  @override
  State<NpcTrainerView> createState() => _NpcTrainerViewState();
}

class _NpcTrainerViewState extends State<NpcTrainerView> {
  final viewModel = GetIt.instance.get<NpcTrainerCollectionEditorViewModel>();
  final _resolveParent = GetIt.instance.get<ResolveNpcTrainerParentUseCase>();

  @override
  void initState() {
    super.initState();
    _setParent(widget.creatureId);
  }

  @override
  void didUpdateWidget(covariant NpcTrainerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.creatureId != widget.creatureId) {
      _setParent(widget.creatureId);
    }
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
    final toolbar = Row(
      children: [
        ShadButton(onPressed: _showCreateDialog, child: const Text('新增')),
        const Spacer(),
        FoxyPagination(
          page: viewModel.page.value,
          pageSize: 50,
          total: viewModel.total.value,
          onChange: viewModel.paginate,
        ),
      ],
    );

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
            viewModel.selectedKey.value = items[row].key;
            showFoxyContextMenu(
              context: context,
              position: details.globalPosition,
              items: [
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.squarePen, size: 16),
                  onPressed: () async {
                    if (!await _load(items[row].key)) return;
                    if (!mounted) return;
                    _showEditDialog();
                  },
                  child: Text('编辑'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () => _destroy(items[row].key),
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
    try {
      await viewModel.create();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('创建失败：$error');
      return;
    }
    if (!mounted) return;
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
  void _showEditDialog() {
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
    final isEditing = viewModel.editingKey.value != null;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500, maxHeight: 680),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FoxyFormItem(
              label: '训练师ID',
              child: FoxyNumberInput<int>(
                controller: viewModel.trainerIdController,
                placeholder: 'TrainerId',
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

  Future<void> _setParent(int creatureId) async {
    try {
      final trainerId = await _resolveParent.execute(creatureId);
      if (!mounted) return;
      if (trainerId == null) {
        viewModel.clearParent();
        return;
      }
      await viewModel.setParentKey(trainerId);
    } catch (error) {
      if (!mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('$error')));
    }
  }

  Future<bool> _load(NpcTrainerKey key) async {
    try {
      await viewModel.edit(key);
      return true;
    } catch (error) {
      if (mounted) DialogUtil.instance.error('加载失败：$error');
      return false;
    }
  }

  Future<void> _destroy(NpcTrainerKey key) async {
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
