import 'package:flutter/material.dart';
import 'package:foxy/page/game_object/game_object_quest_item_view_model.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class GameObjectQuestItemView extends StatefulWidget {
  final int gameObjectId;

  const GameObjectQuestItemView({super.key, required this.gameObjectId});

  @override
  State<GameObjectQuestItemView> createState() =>
      _GameObjectQuestItemViewState();
}

class _GameObjectQuestItemViewState extends State<GameObjectQuestItemView> {
  final viewModel = GetIt.instance.get<GameObjectQuestItemViewModel>();

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
    final headers = ['索引', '物品名称', '验证版本'];

    return Column(
      spacing: 16,
      children: [
        Row(
          spacing: 8,
          children: [
            ShadButton(
              leading: Icon(LucideIcons.plus, size: 16),
              onPressed: () => viewModel.create(context),
              size: ShadButtonSize.sm,
              child: Text('新增'),
            ),
            ShadButton.ghost(
              leading: Icon(LucideIcons.squarePen, size: 16),
              onPressed:
                  selectedIndex != null ? () => viewModel.edit(context) : null,
              size: ShadButtonSize.sm,
              child: Text('编辑'),
            ),
            ShadButton.ghost(
              leading: Icon(LucideIcons.copy, size: 16),
              onPressed:
                  selectedIndex != null
                      ? () => viewModel.copy(context)
                      : null,
              size: ShadButtonSize.sm,
              child: Text('复制'),
            ),
            const Spacer(),
            ShadButton.destructive(
              leading: Icon(LucideIcons.trash, size: 16),
              onPressed:
                  selectedIndex != null
                      ? () => viewModel.delete(context)
                      : null,
              size: ShadButtonSize.sm,
              child: Text('删除'),
            ),
          ],
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              var width = constraints.maxWidth - 240;
              return FoxyShadTable(
                builder: (context, vicinity) {
                  final item = items[vicinity.row];
                  final nameStyle = TextStyle(
                    color: _getQualityColor(item.itemQuality),
                  );
                  return switch (vicinity.column) {
                    0 => ShadTableCell(child: Text(item.idx.toString())),
                    1 => ShadTableCell(
                      child: Text(item.displayName, style: nameStyle),
                    ),
                    2 => ShadTableCell(
                      child: Text(item.verifiedBuild.toString()),
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
                onRowTap: (row) => viewModel.selectRow(row),
                onRowDoubleTap: (row) {
                  viewModel.selectRow(row);
                  viewModel.edit(context);
                },
                pinnedRowCount: 1,
                rowCount: items.length,
              );
            },
          ),
        ),
      ],
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
