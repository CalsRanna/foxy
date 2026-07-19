import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/item_quality_color.dart';
import 'package:foxy/page/creature_template/creature_quest_item_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// 任务物品Tab
class CreatureQuestItemView extends StatefulWidget {
  final int creatureId;

  const CreatureQuestItemView({super.key, required this.creatureId});

  @override
  State<CreatureQuestItemView> createState() => _CreatureQuestItemViewState();
}

class _CreatureQuestItemViewState extends State<CreatureQuestItemView> {
  final viewModel = GetIt.instance.get<CreatureQuestItemViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(creatureId: widget.creatureId);
  }

  @override
  void didUpdateWidget(covariant CreatureQuestItemView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.creatureId != widget.creatureId) {
      viewModel.setParentCreatureEntry(widget.creatureId);
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
    // 新增按钮
    var createButton = ShadButton(
      onPressed: _showCreateDialog,
      child: Text('新增'),
    );

    // 工具栏
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
    final headers = ['索引', '物品名称', '验证版本'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var maxWidth = constraints.maxWidth;
        var width = maxWidth - 240;
        return FoxyShadTable(
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= items.length) {
              return ShadTableCell(child: SizedBox());
            }
            final questItem = items[vicinity.row];
            final qualityColor = getItemQualityColor(questItem.itemQuality);
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(questItem.idx.toString())),
              1 => ShadTableCell(
                child: Text(
                  questItem.displayName,
                  style: TextStyle(color: qualityColor),
                ),
              ),
              2 => ShadTableCell(
                child: Text(questItem.verifiedBuild.toString()),
              ),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              1 => FixedTableSpanExtent(width),
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
                  onPressed: () async {
                    viewModel.selectRow(row);
                    if (!await viewModel.edit() || !context.mounted) return;
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
          // pinnedRowCount: 1,
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
        title: Text('新增任务物品'),
        description: Text('新增一条任务物品记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// 显示编辑对话框
  void _showEditDialog(BuildContext context) {
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑任务物品'),
        description: Text('编辑选中的任务物品记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// 对话框表单（垂直布局）
  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.editingKey.value != null;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 生物ID
          FoxyFormItem(
            label: '生物ID',
            child: FoxyNumberInput<int>(
              controller: viewModel.creatureIdController,
              placeholder: 'CreatureEntry',
            ),
          ),
          SizedBox(height: 16),
          // 索引（主键序号）
          FoxyFormItem(
            label: '索引',
            child: FoxyNumberInput<int>(
              controller: viewModel.idxController,
              placeholder: 'Idx',
            ),
          ),
          SizedBox(height: 16),
          // 物品
          FoxyFormItem(
            label: '物品',
            child: FoxyEntityPicker(
              delegate: FoxyEntityPickerDelegates.itemTemplate,
              controller: viewModel.itemIdController,
              placeholder: 'ItemId',
            ),
          ),
          SizedBox(height: 16),
          // VerifiedBuild
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
                  final saved = await viewModel.save(dialogContext);
                  if (!saved || !dialogContext.mounted) return;
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
