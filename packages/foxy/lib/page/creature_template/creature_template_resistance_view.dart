import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/entity/creature_template_resistance_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/view_model/creature_template_resistance_linked_list_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// Resistance tab
class CreatureTemplateResistanceView extends StatefulWidget {
  final int creatureId;

  const CreatureTemplateResistanceView({super.key, required this.creatureId});

  @override
  State<CreatureTemplateResistanceView> createState() =>
      _CreatureTemplateResistanceViewState();
}

class _CreatureTemplateResistanceViewState
    extends State<CreatureTemplateResistanceView> {
  final viewModel = GetIt.instance
      .get<CreatureTemplateResistanceLinkedListViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return _buildTable();
    });
  }

  @override
  void didUpdateWidget(covariant CreatureTemplateResistanceView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.creatureId != widget.creatureId) {
      viewModel.setLinkKey(widget.creatureId);
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
    viewModel.initSignals(linkKey: widget.creatureId);
  }

  /// Dialog form (vertical layout)
  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.editingKey.value != null;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 720),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '生物ID',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.creatureIDController,
                    placeholder: 'CreatureID',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '抗性类型',
                  child: FoxyShadSelect<int>(
                    controller: viewModel.schoolController,
                    options: CreatureEnums.resistanceSchoolOptions,
                    placeholder: Text('School'),
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '抗性值',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.resistanceController,
                    placeholder: 'Resistance',
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
    );
  }

  Widget _buildTable() {
    // Add button
    var createButton = ShadButton(
      onPressed: _showCreateDialog,
      child: Text('新增'),
    );

    // Toolbar
    final toolbar = Row(
      children: [
        createButton,
        Spacer(),
        FoxyPagination(
          page: viewModel.page.value,
          pageSize: 50,
          total: viewModel.total.value,
          onChange: viewModel.paginate,
        ),
      ],
    );

    final items = viewModel.items.value;

    final table = FoxyDataTable<BriefCreatureTemplateResistanceEntity>(
      shrinkWrap: true,
      rows: items,
      columns: [
        FoxyTableColumn.flex(
          label: '抗性类型',
          cell: (_, resistance) => Text(
            CreatureEnums.resistanceSchoolOptions[resistance.school] ??
                '未知 (${resistance.school})',
          ),
        ),
        FoxyTableColumn.flex(
          label: '抗性值',
          cell: (_, resistance) => Text(resistance.resistance.toString()),
        ),
        FoxyTableColumn.fixed(
          label: '验证版本',
          width: 120,
          cell: (_, resistance) => Text(resistance.verifiedBuild.toString()),
        ),
      ],
      onRowDoubleTap: (resistance) async {
        viewModel.selectedKey.value = resistance.key;
        if (!await _load(viewModel.selectedKey.value!)) return;
        if (!mounted) return;
        _showEditDialog(context);
      },
      onRowSecondaryTapDownWithDetails: (resistance, details) {
        ContextMenu.show(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: () async {
                viewModel.selectedKey.value = resistance.key;
                if (!await _load(viewModel.selectedKey.value!)) return;
                if (!mounted) return;
                _showEditDialog(context);
              },
              child: Text('编辑'),
            ),
            ShadContextMenuItem(
              leading: Icon(LucideIcons.copy, size: 16),
              onPressed: () {
                viewModel.selectedKey.value = resistance.key;
                _copy(viewModel.selectedKey.value!);
              },
              child: Text('复制'),
            ),
            ShadContextMenuItem(
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed: () {
                viewModel.selectedKey.value = resistance.key;
                _destroy(viewModel.selectedKey.value!);
              },
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

  Future<void> _copy(CreatureTemplateResistanceKey key) async {
    try {
      await viewModel.copy(key);
      if (!mounted) return;
      DialogUtil.instance.success('复制成功');
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('复制失败：${FoxyError.message(error)}');
    }
  }

  Future<void> _destroy(CreatureTemplateResistanceKey key) async {
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

  Future<bool> _load(CreatureTemplateResistanceKey key) async {
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

  /// Shows the add dialog
  Future<void> _showCreateDialog() async {
    try {
      await viewModel.create();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('创建失败：${FoxyError.message(error)}');
      return;
    }
    if (!mounted) return;
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('新增抗性'),
        description: Text('新增一条抗性记录'),
        titlePinned: true,
        descriptionPinned: true,
        constraints: DialogUtil.constraints(dialogContext),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// Shows the edit dialog
  void _showEditDialog(BuildContext context) {
    DialogUtil.show(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑抗性'),
        description: Text('编辑选中的抗性记录'),
        titlePinned: true,
        descriptionPinned: true,
        constraints: DialogUtil.constraints(dialogContext),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }
}
