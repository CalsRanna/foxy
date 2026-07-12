import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/page/game_object/game_object_loot_template_view_model.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class GameObjectLootTemplateView extends StatefulWidget {
  final int gameObjectId;

  const GameObjectLootTemplateView({super.key, required this.gameObjectId});

  @override
  State<GameObjectLootTemplateView> createState() =>
      _GameObjectLootTemplateViewState();
}

class _GameObjectLootTemplateViewState
    extends State<GameObjectLootTemplateView> {
  final viewModel = GetIt.instance.get<GameObjectLootTemplateViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(gameObjectId: widget.gameObjectId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) => _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    final items = viewModel.items.value;
    final selectedIndex = viewModel.selectedIndex.value;
    final headers = ['物品ID', '物品名称', '几率', '数量', '任务', '组'];

    return Column(
      spacing: 16,
      children: [
        Row(
          spacing: 8,
          children: [
            ShadButton(
              leading: Icon(LucideIcons.plus, size: 16),
              onPressed: _showCreateDialog,
              size: ShadButtonSize.sm,
              child: Text('新增'),
            ),
            ShadButton.ghost(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: selectedIndex != null ? _showEditDialog : null,
              size: ShadButtonSize.sm,
              child: Text('编辑'),
            ),
            ShadButton.ghost(
              leading: Icon(LucideIcons.copy, size: 16),
              onPressed: selectedIndex != null
                  ? () => viewModel.copy(context)
                  : null,
              size: ShadButtonSize.sm,
              child: Text('复制'),
            ),
            const Spacer(),
            ShadButton.destructive(
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed: selectedIndex != null
                  ? () => viewModel.delete(context)
                  : null,
              size: ShadButtonSize.sm,
              child: Text('删除'),
            ),
          ],
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            var width = constraints.maxWidth - 560;
            return FoxyShadTable(
              shrinkWrap: true,
              builder: (context, vicinity) {
                final item = items[vicinity.row];
                final nameStyle = TextStyle(
                  color: _getQualityColor(item.itemQuality),
                );
                return switch (vicinity.column) {
                  0 => ShadTableCell(child: Text(item.item.toString())),
                  1 => ShadTableCell(
                    child: Text(
                      item.reference != 0
                          ? '[${item.displayName}]'
                          : item.displayName,
                      style: nameStyle,
                    ),
                  ),
                  2 => ShadTableCell(child: Text(item.chance.toString())),
                  3 => ShadTableCell(
                    child: Text('${item.minCount}-${item.maxCount}'),
                  ),
                  4 => ShadTableCell(
                    child: Text(item.questRequired ? '是' : '否'),
                  ),
                  5 => ShadTableCell(child: Text(item.groupId.toString())),
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
                  4 => FixedTableSpanExtent(100),
                  5 => FixedTableSpanExtent(100),
                  _ => null,
                };
              },
              header: (context, index) {
                return ShadTableCell.header(child: Text(headers[index]));
              },
              onRowTap: (row) => viewModel.selectRow(row),
              onRowDoubleTap: (row) {
                viewModel.selectRow(row);
                _showEditDialog();
              },
              pinnedRowCount: 1,
              rowCount: items.length,
            );
          },
        ),
      ],
    );
  }

  Future<void> _showCreateDialog() async {
    await viewModel.create();
    if (!mounted) return;
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('新增掉落'),
        description: Text('新增一条掉落记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  void _showEditDialog() {
    viewModel.edit();
    showFoxyDialog(
      context: context,
      builder: (dialogContext) => ShadDialog(
        title: Text('编辑掉落'),
        description: Text('编辑选中的掉落记录'),
        child: _buildDialogForm(dialogContext),
      ),
    );
  }

  Widget _buildDialogForm(BuildContext dialogContext) {
    final isEditing = viewModel.editing.value;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FoxyFormItem(
            label: '游戏对象编号',
            child: FoxyNumberInput<int>(
              controller: viewModel.gameObjectIdController,
              placeholder: 'GameObjectID',
              readOnly: true,
            ),
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '物品ID',
            child: FoxyEntityPicker(
              delegate: FoxyEntityPickerDelegates.itemTemplate,
              controller: viewModel.itemController,
              placeholder: 'Item',
            ),
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '关联ID',
            child: FoxyNumberInput<int>(
              controller: viewModel.referenceController,
              placeholder: 'Reference (0=直接掉落)',
            ),
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '掉落几率',
            child: FoxyNumberInput<double>(
              controller: viewModel.chanceController,
              placeholder: 'Chance (%)',
            ),
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '需要任务',
            child: FoxyShadSelect<int>(
              controller: viewModel.questRequiredController,
              options: kBooleanOptions,
              placeholder: Text('QuestRequired'),
            ),
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '掉落模式',
            child: FoxyNumberInput<int>(
              controller: viewModel.lootModeController,
              placeholder: 'LootMode',
            ),
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '组ID',
            child: FoxyNumberInput<int>(
              controller: viewModel.groupIdController,
              placeholder: 'GroupId',
            ),
          ),
          SizedBox(height: 16),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: FoxyFormItem(
                  label: '最小数量',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.minCountController,
                    placeholder: 'MinCount',
                  ),
                ),
              ),
              Expanded(
                child: FoxyFormItem(
                  label: '最大数量',
                  child: FoxyNumberInput<int>(
                    controller: viewModel.maxCountController,
                    placeholder: 'MaxCount',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          FoxyFormItem(
            label: '备注',
            child: FoxyStringInput(
              controller: viewModel.commentController,
              placeholder: 'Comment',
            ),
          ),
          SizedBox(height: 24),
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

  Color _getQualityColor(int quality) {
    return switch (quality) {
      1 => const Color(0xFFFFFFFF),
      2 => const Color(0xFF1EFF00),
      3 => const Color(0xFF0070DD),
      4 => const Color(0xFFA335EE),
      5 => const Color(0xFFFF8000),
      _ => const Color(0xFF9D9D9D),
    };
  }
}
