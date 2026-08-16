import 'package:flutter/material.dart';
import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/npc_trainer_linked_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/foxy_form_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// Trainer tab
class NpcTrainerView extends StatefulWidget {
  final int creatureId;

  const NpcTrainerView({super.key, required this.creatureId});

  @override
  State<NpcTrainerView> createState() => _NpcTrainerViewState();
}

class _NpcTrainerViewState extends State<NpcTrainerView> {
  final viewModel = GetIt.instance.get<NpcTrainerLinkedListViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return _buildTable();
    });
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
  void initState() {
    super.initState();
    _setParent(widget.creatureId);
  }

  /// Dialog form (vertical layout)
  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.editingKey.value != null;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: DialogUtil.width),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '训练师ID',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.trainerIdController,
                    placeholder: 'TrainerId',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '技能',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.spell,
                    controller: viewModel.spellIdController,
                    placeholder: 'SpellId',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '金币花费',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.moneyCostController,
                    placeholder: 'MoneyCost',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: const Text('需求条件'),
          ),
          const SizedBox(height: 8),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '需要专业技能',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.skillLine,
                    controller: viewModel.reqSkillLineController,
                    placeholder: 'ReqSkillLine',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '需要技能等级',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.reqSkillRankController,
                    placeholder: 'ReqSkillRank',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '前置技能 1',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.spell,
                    controller: viewModel.reqAbility1Controller,
                    placeholder: 'ReqAbility1',
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
                  label: '前置技能 2',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.spell,
                    controller: viewModel.reqAbility2Controller,
                    placeholder: 'ReqAbility2',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '前置技能 3',
                  child: FoxyEntityPicker(
                    delegate: FoxyEntityPickerDelegates.spell,
                    controller: viewModel.reqAbility3Controller,
                    placeholder: 'ReqAbility3',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '需要等级',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.reqLevelController,
                    placeholder: 'ReqLevel',
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
                  label: '验证版本',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.verifiedBuildController,
                    placeholder: 'VerifiedBuild',
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              const Expanded(child: SizedBox()),
            ],
          ),
          SizedBox(height: 24),
          // Button row
          Row(
            spacing: 8,
            children: [
              ShadButton.outline(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text('取消'),
              ),
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
    );
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

    final table = FoxyDataTable<BriefNpcTrainerEntity>(
      shrinkWrap: true,
      rows: items,
      columns: [
        FoxyTableColumn.fixed(
          label: '技能ID',
          width: 120,
          cell: (_, trainer) => Text(trainer.spellId.toString()),
        ),
        FoxyTableColumn.flex(
          label: '技能名称',
          cell: (_, trainer) {
            final displayName = trainer.spellSubtext.isNotEmpty
                ? '${trainer.spellName} - ${trainer.spellSubtext}'
                : trainer.spellName;
            return Text(displayName);
          },
        ),
        FoxyTableColumn.fixed(
          label: '金币花费',
          width: 120,
          cell: (_, trainer) => Text(trainer.moneyCost.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '专业技能',
          width: 120,
          cell: (_, trainer) => Text(trainer.reqSkillLine.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '等级要求',
          width: 120,
          cell: (_, trainer) => Text(trainer.reqLevel.toString()),
        ),
      ],
      onRowDoubleTap: (trainer) async {
        viewModel.selectedKey.value = trainer.key;
        if (!await _load(trainer.key)) return;
        if (!mounted) return;
        _showEditDialog();
      },
      onRowSecondaryTapDownWithDetails: (trainer, details) {
        viewModel.selectedKey.value = trainer.key;
        ContextMenu.show(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: () async {
                if (!await _load(trainer.key)) return;
                if (!mounted) return;
                _showEditDialog();
              },
              child: Text('编辑'),
            ),
            ShadContextMenuItem(
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed: () => _destroy(trainer.key),
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

  Future<void> _destroy(NpcTrainerKey key) async {
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

  Future<bool> _load(NpcTrainerKey key) async {
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

  Future<void> _setParent(int creatureId) async {
    try {
      final trainerId = await viewModel.resolveParent(creatureId);
      if (!mounted) return;
      if (trainerId == null) {
        viewModel.clearLink();
        return;
      }
      await viewModel.setLinkKey(trainerId);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
    }
  }

  /// Shows the add dialog
  Future<void> _showCreateDialog() async {
    try {
      await viewModel.create();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('创建失败：${FoxyExceptions.message(error)}');
      return;
    }
    if (!mounted) return;
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => FoxyFormDialog(
        title: '新增训练师技能',
        description: '新增一条训练师技能记录',
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// Shows the edit dialog
  void _showEditDialog() {
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => FoxyFormDialog(
        title: '编辑训练师技能',
        description: '编辑选中的训练师技能记录',
        child: _buildDialogForm(dialogContext),
      ),
    );
  }
}
