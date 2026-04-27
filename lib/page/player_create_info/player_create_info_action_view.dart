import 'package:flutter/material.dart';
import 'package:foxy/page/player_create_info/player_create_info_action_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PlayerCreateInfoActionView extends StatefulWidget {
  final int? race;
  final int? playerClass;
  const PlayerCreateInfoActionView({super.key, this.race, this.playerClass});

  @override
  State<PlayerCreateInfoActionView> createState() => _PlayerCreateInfoActionViewState();
}

class _PlayerCreateInfoActionViewState extends State<PlayerCreateInfoActionView> {
  final viewModel = GetIt.instance.get<PlayerCreateInfoActionViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(race: widget.race, class_: widget.playerClass);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        spacing: 16,
        children: [
          Row(children: [
            ShadButton(onPressed: _showCreateDialog, child: Text('新增')),
          ]),
          Watch((_) => _buildTable()),
        ],
      ),
    );
  }

  Widget _buildTable() {
    final actions = viewModel.actions.value;
    final headers = ['按钮', '动作', '类型'];

    return FoxyShadTable(
      builder: (context, vicinity) {
        final item = actions[vicinity.row];
        return switch (vicinity.column) {
          0 => ShadTableCell(child: Text(item.button.toString())),
          1 => ShadTableCell(child: Text(item.action.toString())),
          2 => ShadTableCell(child: Text(item.type.toString())),
          _ => ShadTableCell(child: SizedBox()),
        };
      },
      columnCount: headers.length,
      columnSpanExtent: (_) => FixedTableSpanExtent(120),
      header: (context, index) => ShadTableCell.header(child: Text(headers[index])),
      onRowSecondaryTapDownWithDetails: (row, details) {
        showFoxyContextMenu(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed: () => _showEditDialog(row),
              child: Text('编辑'),
            ),
            ShadContextMenuItem(
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed: () => viewModel.onDelete(context, actions[row]),
              child: Text('删除'),
            ),
          ],
        );
      },
      rowCount: actions.length,
      shrinkWrap: true,
    );
  }

  void _showCreateDialog() {
    viewModel.create();
    showShadDialog(context: context, builder: (c) => _buildDialog(c, isEditing: false));
  }

  void _showEditDialog(int index) {
    viewModel.edit(index);
    showShadDialog(context: context, builder: (c) => _buildDialog(c, isEditing: true));
  }

  Widget _buildDialog(BuildContext dialogContext, {required bool isEditing}) {
    return ShadDialog(
      title: Text(isEditing ? '编辑动作' : '新增动作'),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: Column(mainAxisSize: MainAxisSize.min, spacing: 16, children: [
          FormItem(controller: viewModel.buttonController, label: '按钮', placeholder: 'button'),
          FormItem(controller: viewModel.actionController, label: '动作', placeholder: 'action'),
          FormItem(controller: viewModel.typeController, label: '类型', placeholder: 'type'),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            ShadButton.outline(onPressed: () => Navigator.of(dialogContext).pop(), child: Text('取消')),
            SizedBox(width: 8),
            ShadButton(onPressed: () async {
              if (isEditing) {
                await viewModel.update(dialogContext);
              } else {
                await viewModel.save(dialogContext);
              }
              if (!dialogContext.mounted) return;
              Navigator.of(dialogContext).pop();
            }, child: Text(isEditing ? '更新' : '保存')),
          ]),
        ]),
      ),
    );
  }
}
