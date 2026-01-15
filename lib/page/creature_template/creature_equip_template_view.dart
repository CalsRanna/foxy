import 'package:flutter/material.dart';
import 'package:foxy/constant/item_quality.dart';
import 'package:foxy/page/creature_template/creature_equip_template_view_model.dart';
import 'package:foxy/page/creature_template/item_template_selector.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// 装备模板Tab
class CreatureEquipTemplateView extends StatefulWidget {
  final int creatureId;

  const CreatureEquipTemplateView({super.key, required this.creatureId});

  @override
  State<CreatureEquipTemplateView> createState() =>
      _CreatureEquipTemplateViewState();
}

class _CreatureEquipTemplateViewState extends State<CreatureEquipTemplateView> {
  final viewModel = GetIt.instance.get<CreatureEquipTemplateViewModel>();

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
    final headers = ['ID', '主手武器', '副手武器', '远程武器', '验证版本'];

    Widget layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        var maxWidth = constraints.maxWidth;
        var width = maxWidth - 240;
        return FoxyShadTable(
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= items.length) {
              return ShadTableCell(child: SizedBox());
            }
            final equip = items[vicinity.row];
            final qualityColor1 = getItemQualityColor(equip.quality1);
            final qualityColor2 = getItemQualityColor(equip.quality2);
            final qualityColor3 = getItemQualityColor(equip.quality3);

            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(equip.id.toString())),
              1 => ShadTableCell(
                child: Text(
                  equip.displayName1,
                  style: TextStyle(color: qualityColor1),
                ),
              ),
              2 => ShadTableCell(
                child: Text(
                  equip.displayName2,
                  style: TextStyle(color: qualityColor2),
                ),
              ),
              3 => ShadTableCell(
                child: Text(
                  equip.displayName3,
                  style: TextStyle(color: qualityColor3),
                ),
              ),
              4 => ShadTableCell(child: Text(equip.verifiedBuild.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
          },
          columnCount: headers.length,
          columnSpanExtent: (index) {
            return switch (index) {
              0 => FixedTableSpanExtent(120),
              1 => FixedTableSpanExtent(width / 3),
              2 => FixedTableSpanExtent(width / 3),
              3 => FixedTableSpanExtent(width / 3),
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
                  leading: Icon(LucideIcons.copy, size: 16),
                  onPressed: () {
                    viewModel.selectRow(row);
                    viewModel.copy(context);
                  },
                  child: Text('复制'),
                ),
                ShadContextMenuItem(
                  leading: Icon(LucideIcons.trash, size: 16),
                  onPressed: () {
                    viewModel.selectRow(row);
                    viewModel.delete(context);
                  },
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
        title: Text('新增装备模板'),
        description: Text('新增一条装备模板记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  /// 显示编辑对话框
  void _showEditDialog(BuildContext context) {
    showShadDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑装备模板'),
        description: Text('编辑选中的装备模板记录'),
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
          // 模板ID
          FormItem(
            controller: viewModel.idController,
            label: '模板ID',
            placeholder: 'ID',
          ),
          SizedBox(height: 16),
          // 主手武器
          FormItem(
            label: '主手武器',
            child: ItemTemplateSelector(
              controller: viewModel.itemID1Controller,
              placeholder: 'ItemID1',
            ),
          ),
          SizedBox(height: 16),
          // 副手武器
          FormItem(
            label: '副手武器',
            child: ItemTemplateSelector(
              controller: viewModel.itemID2Controller,
              placeholder: 'ItemID2',
            ),
          ),
          SizedBox(height: 16),
          // 远程武器
          FormItem(
            label: '远程武器',
            child: ItemTemplateSelector(
              controller: viewModel.itemID3Controller,
              placeholder: 'ItemID3',
            ),
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
