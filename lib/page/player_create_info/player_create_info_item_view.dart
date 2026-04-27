import 'package:flutter/material.dart';
import 'package:foxy/page/player_create_info/player_create_info_item_view_model.dart';
import 'package:foxy/widget/context_menu.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PlayerCreateInfoItemView extends StatefulWidget {
  final int? race;
  final int? playerClass;
  const PlayerCreateInfoItemView({super.key, this.race, this.playerClass});

  @override
  State<PlayerCreateInfoItemView> createState() => _PlayerCreateInfoItemViewState();
}

class _PlayerCreateInfoItemViewState extends State<PlayerCreateInfoItemView> {
  final viewModel = GetIt.instance.get<PlayerCreateInfoItemViewModel>();

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
      child: Column(spacing: 16, children: [
        Row(children: [
          ShadButton(onPressed: _showCreateDialog, child: Text('新增')),
        ]),
        Watch((_) => _buildTable()),
      ]),
    );
  }

  Widget _buildTable() {
    final items = viewModel.items.value;
    return FoxyShadTable(
      builder: (context, vicinity) {
        final item = items[vicinity.row];
        return switch (vicinity.column) {
          0 => ShadTableCell(child: Text(item.itemid.toString())),
          1 => ShadTableCell(child: Text(item.amount.toString())),
          2 => ShadTableCell(child: Text(item.note)),
          _ => ShadTableCell(child: SizedBox()),
        };
      },
      columnCount: 3,
      columnSpanExtent: (index) => switch (index) {
        0 => FixedTableSpanExtent(120),
        1 => FixedTableSpanExtent(120),
        _ => FixedTableSpanExtent(200),
      },
      header: (context, index) => ShadTableCell.header(
        child: Text(['物品ID', '数量', '备注'][index]),
      ),
      onRowSecondaryTapDownWithDetails: (row, details) {
        showFoxyContextMenu(
          context: context,
          position: details.globalPosition,
          items: [
            ShadContextMenuItem(
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed: () => viewModel.onDelete(context, items[row]),
              child: Text('删除'),
            ),
          ],
        );
      },
      rowCount: items.length,
      shrinkWrap: true,
    );
  }

  void _showCreateDialog() {
    viewModel.create();
    showShadDialog(context: context, builder: (c) => ShadDialog(
      title: Text('新增起始物品'),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: Column(mainAxisSize: MainAxisSize.min, spacing: 16, children: [
          FormItem(controller: viewModel.itemIdController, label: '物品ID', placeholder: 'itemid'),
          FormItem(controller: viewModel.amountController, label: '数量', placeholder: 'amount'),
          FormItem(controller: viewModel.noteController, label: '备注', placeholder: 'Note'),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            ShadButton.outline(onPressed: () => Navigator.of(c).pop(), child: Text('取消')),
            SizedBox(width: 8),
            ShadButton(onPressed: () async {
              await viewModel.save(c);
              if (!c.mounted) return;
              Navigator.of(c).pop();
            }, child: Text('保存')),
          ]),
        ]),
      ),
    ));
  }
}
