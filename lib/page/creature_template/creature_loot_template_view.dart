import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/item_quality.dart';
import 'package:foxy/page/creature_template/creature_loot_template_view_model.dart';
import 'package:foxy/page/creature_template/item_template_selector.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// 击杀掉落Tab
class CreatureLootTemplateView extends StatefulWidget {
  final int creatureId;

  const CreatureLootTemplateView({super.key, required this.creatureId});

  @override
  State<CreatureLootTemplateView> createState() =>
      _CreatureLootTemplateViewState();
}

class _CreatureLootTemplateViewState extends State<CreatureLootTemplateView> {
  final viewModel = GetIt.instance.get<CreatureLootTemplateViewModel>();

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
    final headers = ['物品ID', '物品名称', '几率', '数量', '任务', '组'];

    // 表格（固定高度）
    Widget layoutBuilder = SizedBox(
      height: 500,
      child: LayoutBuilder(
        builder: (context, constraints) {
          var maxWidth = constraints.maxWidth;
          var width = maxWidth - 600;
          return FoxyShadTable(
            builder: (context, vicinity) {
              if (vicinity.row < 0 || vicinity.row >= items.length) {
                return ShadTableCell(child: SizedBox());
              }
              final loot = items[vicinity.row];
              final qualityColor =
                  kItemQualityColors[loot.itemQuality] ?? Colors.white;

              return switch (vicinity.column) {
                0 => ShadTableCell(
                  child: Text(
                    loot.reference != 0
                        ? '${loot.item} (R)'
                        : loot.item.toString(),
                  ),
                ),
                1 => ShadTableCell(
                  child: loot.reference != 0
                      ? Text('关联掉落', style: TextStyle(color: Colors.grey))
                      : Text(
                          loot.displayName,
                          style: TextStyle(color: qualityColor),
                        ),
                ),
                2 => ShadTableCell(child: Text('${loot.chance}%')),
                3 => ShadTableCell(
                  child: Text('${loot.minCount}-${loot.maxCount}'),
                ),
                4 => ShadTableCell(child: Text(loot.questRequired ? '是' : '否')),
                5 => ShadTableCell(child: Text(loot.groupId.toString())),
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
                5 => FixedTableSpanExtent(120),
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
        title: Text('新增掉落'),
        description: Text('新增一条掉落记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// 显示编辑对话框
  void _showEditDialog(BuildContext context) {
    showShadDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑掉落'),
        description: Text('编辑选中的掉落记录'),
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
          // 物品ID
          FormItem(
            label: '物品ID',
            child: ItemTemplateSelector(
              controller: viewModel.itemController,
              placeholder: 'Item',
            ),
          ),
          SizedBox(height: 16),
          // 关联ID
          FormItem(
            controller: viewModel.referenceController,
            label: '关联ID',
            placeholder: 'Reference (0=直接掉落)',
          ),
          SizedBox(height: 16),
          // 掉落几率
          FormItem(
            controller: viewModel.chanceController,
            label: '掉落几率',
            placeholder: 'Chance (%)',
          ),
          SizedBox(height: 16),
          // 需要任务
          FormItem(
            label: '需要任务',
            child: FoxyShadSelect<int>(
              controller: viewModel.questRequiredController,
              options: kBooleanOptions,
              placeholder: Text('QuestRequired'),
            ),
          ),
          SizedBox(height: 16),
          // 掉落模式
          FormItem(
            controller: viewModel.lootModeController,
            label: '掉落模式',
            placeholder: 'LootMode',
          ),
          SizedBox(height: 16),
          // 组ID
          FormItem(
            controller: viewModel.groupIdController,
            label: '组ID',
            placeholder: 'GroupId',
          ),
          SizedBox(height: 16),
          // 数量范围
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: FormItem(
                  controller: viewModel.minCountController,
                  label: '最小数量',
                  placeholder: 'MinCount',
                ),
              ),
              Expanded(
                child: FormItem(
                  controller: viewModel.maxCountController,
                  label: '最大数量',
                  placeholder: 'MaxCount',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // 备注
          FormItem(
            controller: viewModel.commentController,
            label: '备注',
            placeholder: 'Comment',
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
