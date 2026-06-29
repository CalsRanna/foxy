import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/item_extended_cost_selector_controller.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ItemExtendedCostSelector extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;

  const ItemExtendedCostSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  State<ItemExtendedCostSelector> createState() =>
      _ItemExtendedCostSelectorState();
}

class _ItemExtendedCostSelectorState extends State<ItemExtendedCostSelector> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: widget.controller,
      placeholder: Text(widget.placeholder ?? ''),
      trailing: ShadButton.ghost(
        height: 20,
        padding: EdgeInsets.zero,
        onPressed: _openDialog,
        width: 20,
        child: Icon(LucideIcons.search, size: 12),
      ),
    );
  }

  Future<void> _openDialog() async {
    final controller = ItemExtendedCostSelectorController();
    final currentId = int.tryParse(widget.controller.text) ?? 0;
    if (currentId != 0) {
      controller.idFilter = currentId.toString();
      controller.selectedId = currentId;
    }
    await controller.search();
    if (!mounted) return;

    final result = await showShadDialog<int>(
      context: context,
      builder: (context) => _Dialog(controller: controller),
    );
    controller.dispose();
    if (result != null) {
      widget.controller.text = result.toString();
    }
  }
}

class _Dialog extends StatefulWidget {
  final ItemExtendedCostSelectorController controller;

  const _Dialog({required this.controller});

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  final _idController = TextEditingController();


  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: Text('选择扩展价格'),
      actions: [
        ListenableBuilder(listenable: widget.controller, builder: (_, _) {
          return FoxyPagination(
            page: widget.controller.page,
            pageSize: 50,
            total: widget.controller.total,
            onChange: (p) => widget.controller.paginate(p),
          );
        }),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            ShadButton.outline(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('取消'),
            ),
            ShadButton(
              onPressed: () => Navigator.of(context).pop(widget.controller.selectedId),
              child: Text('确定'),
            ),
          ],
        ),
      ],
      actionsMainAxisAlignment: MainAxisAlignment.spaceBetween,
      actionsMainAxisSize: MainAxisSize.max,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSearchForm(),
          SizedBox(height: 12),
          _buildToolbar(),
          SizedBox(height: 8),
          _buildTable(),
        ],
      ),
    );
  }

  Widget _buildSearchForm() {
    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: ShadInput(controller: _idController, placeholder: Text('编号')),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadButton(
              size: ShadButtonSize.sm,
              onPressed: () {
                widget.controller.idFilter = _idController.text;
                widget.controller.page = 1;
                widget.controller.search();
              },
              child: Text('查询'),
            ),
            SizedBox(width: 8),
            ShadButton.outline(
              size: ShadButtonSize.sm,
              onPressed: () {
                _idController.clear();
                widget.controller.reset();
              },
              child: Text('重置'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToolbar() {
    return ListenableBuilder(listenable: widget.controller, builder: (_, _) {
      return Row(children: [Text('共 ${widget.controller.total} 条记录')]);
    });
  }

  Widget _buildTable() {
    final theme = ShadTheme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final tableMaxHeight = screenHeight * 0.5;

    return ListenableBuilder(listenable: widget.controller, builder: (_, _) {
      final items = widget.controller.items;
      final selectedId = widget.controller.selectedId;

      if (items.isEmpty) {
        return Center(child: Text('暂无数据'));
      }

      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 720,
          maxHeight: tableMaxHeight,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            var flexWidth = constraints.maxWidth - 360;
            return FoxyShadTable(
              columnCount: 4,
              rowCount: items.length,
              pinnedRowCount: 1,
              header: (context, column) {
                final headers = ['编号', '荣誉点数', '竞技场点数', '竞技场等级'];
                return ShadTableCell.header(child: Text(headers[column]));
              },
              columnBuilder: (column) => TableSpan(
                extent: column < 3
                    ? FixedTableSpanExtent(120)
                    : FixedTableSpanExtent(flexWidth > 120 ? flexWidth : 120),
              ),
          rowSpanBackgroundDecoration: (row) {
            final dataRow = row - 1;
            if (dataRow < 0 || dataRow >= items.length) return null;
            if (items[dataRow].id == selectedId) {
              return TableSpanDecoration(color: theme.colorScheme.accent);
            }
            return null;
          },
          onRowTap: (row) {
            if (row >= 0 && row < items.length) {
              widget.controller.select(items[row].id);
            }
          },
          onRowDoubleTap: (row) {
            if (row >= 0 && row < items.length) {
              Navigator.of(context).pop(items[row].id);
            }
          },
          builder: (context, vicinity) {
            if (vicinity.row < 0 || vicinity.row >= items.length) {
              return ShadTableCell(child: SizedBox());
            }
            final item = items[vicinity.row];
            return switch (vicinity.column) {
              0 => ShadTableCell(child: Text(item.id.toString())),
              1 => ShadTableCell(child: Text(item.honorPoints.toString())),
              2 => ShadTableCell(child: Text(item.arenaPoints.toString())),
              3 => ShadTableCell(child: Text(item.arenaBracket.toString())),
              _ => ShadTableCell(child: SizedBox()),
            };
            }
            );
          },
        ),
      );
    });
  }
}
