import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/page/creature_template/creature_template_resistance_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// 抗性Tab
class CreatureTemplateResistanceView extends StatefulWidget {
  final int creatureId;

  const CreatureTemplateResistanceView({super.key, required this.creatureId});

  @override
  State<CreatureTemplateResistanceView> createState() =>
      _CreatureTemplateResistanceViewState();
}

class _CreatureTemplateResistanceViewState
    extends State<CreatureTemplateResistanceView> {
  final viewModel = GetIt.instance.get<CreatureTemplateResistanceViewModel>();

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
      if (viewModel.loading.value) {
        return Center(child: CircularProgressIndicator());
      }

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
    final headers = ['抗性类型', '抗性值', '验证版本'];

    // 表格（固定高度）
    Widget layoutBuilder = SizedBox(
      height: 500,
      child: LayoutBuilder(
        builder: (context, constraints) {
          var maxWidth = constraints.maxWidth;
          var width = maxWidth - 120;
          return FoxyShadTable(
            builder: (context, vicinity) {
              if (vicinity.row < 0 || vicinity.row >= items.length) {
                return ShadTableCell(child: SizedBox());
              }
              final resistance = items[vicinity.row];
              return switch (vicinity.column) {
                0 => ShadTableCell(
                  child: Text(
                    kResistanceSchoolOptions[resistance.school] ??
                        '未知 (${resistance.school})',
                  ),
                ),
                1 => ShadTableCell(
                  child: Text(resistance.resistance.toString()),
                ),
                2 => ShadTableCell(
                  child: Text(resistance.verifiedBuild.toString()),
                ),
                _ => ShadTableCell(child: SizedBox()),
              };
            },
            columnCount: headers.length,
            columnSpanExtent: (index) {
              return switch (index) {
                0 => FixedTableSpanExtent(width / 2),
                1 => FixedTableSpanExtent(width / 2),
                2 => FixedTableSpanExtent(120),
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
            pinnedRowCount: 1,
            rowCount: items.length,
          );
        },
      ),
    );

    var children = [toolbar, layoutBuilder];
    final column = Column(spacing: 16, children: children);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ShadCard(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: column,
      ),
    );
  }

  /// 显示新增对话框
  void _showCreateDialog() {
    viewModel.create();
    showShadDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('新增抗性'),
        description: Text('新增一条抗性记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// 显示编辑对话框
  void _showEditDialog(BuildContext context) {
    showShadDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑抗性'),
        description: Text('编辑选中的抗性记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// 对话框表单（垂直布局）
  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.selectedIndex.value != null;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 生物ID（只读）
          FormItem(
            controller: TextEditingController(
              text: widget.creatureId.toString(),
            ),
            label: '生物ID',
            placeholder: 'CreatureID',
            readOnly: true,
          ),
          SizedBox(height: 16),
          // 抗性类型
          FormItem(
            label: '抗性类型',
            child: FoxyShadSelect<int>(
              controller: viewModel.schoolController,
              options: kResistanceSchoolOptions,
              placeholder: Text('School'),
            ),
          ),
          SizedBox(height: 16),
          // 抗性值
          FormItem(
            controller: viewModel.resistanceController,
            label: '抗性值',
            placeholder: 'Resistance',
          ),
          SizedBox(height: 16),
          // VerifiedBuild
          FormItem(
            controller: viewModel.verifiedBuildController,
            label: 'VerifiedBuild',
            placeholder: 'VerifiedBuild',
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
