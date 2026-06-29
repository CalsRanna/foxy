import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/creature_model_info_selector_controller.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CreatureModelInfoSelector extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;

  const CreatureModelInfoSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  State<CreatureModelInfoSelector> createState() =>
      _CreatureModelInfoSelectorState();
}

class _CreatureModelInfoSelectorState extends State<CreatureModelInfoSelector> {


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
    final controller = CreatureModelInfoSelectorController();
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
  final CreatureModelInfoSelectorController controller;

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
      title: Text('生物模型信息'),
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
      constraints: BoxConstraints(maxWidth: 640),
      child: Column(spacing: 8, children: [
        _buildFilter(),
        _buildTable(),
      ]),
    );
  }

  Widget _buildFilter() {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 8, children: [
        Expanded(
          child: ShadInput(
            controller: _idController,
            placeholder: Text('显示ID'),
          ),
        ),
        Expanded(child: SizedBox()),
        Expanded(
          child: Row(spacing: 8, children: [
            ShadButton(
              onPressed: () {
                widget.controller.idFilter = _idController.text;
                widget.controller.page = 1;
                widget.controller.search();
              },
              size: ShadButtonSize.sm,
              child: Text('查询'),
            ),
            ShadButton.ghost(
              onPressed: () {
                _idController.clear();
                widget.controller.reset();
              },
              size: ShadButtonSize.sm,
              child: Text('重置'),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _buildTable() {
    final theme = ShadTheme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final tableMaxHeight = screenHeight * 0.5;

    return ListenableBuilder(listenable: widget.controller, builder: (_, _) {
      final items = widget.controller.items;
      final selectedId = widget.controller.selectedId;

      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: tableMaxHeight),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            var width = maxWidth - 360;
            return FoxyShadTable(
              columnCount: 4,
              rowCount: items.length,
              pinnedRowCount: 1,
              header: (context, column) {
                return switch (column) {
                  0 => ShadTableCell.header(child: Text('显示ID')),
                  1 => ShadTableCell.header(child: Text('性别')),
                  2 => ShadTableCell.header(child: Text('包围半径')),
                  3 => ShadTableCell.header(child: Text('战斗距离')),
                  _ => ShadTableCell.header(child: SizedBox()),
                };
              },
              columnSpanExtent: (column) {
                return switch (column) {
                  0 => FixedTableSpanExtent(120),
                  1 => FixedTableSpanExtent(120),
                  2 => FixedTableSpanExtent(120),
                  3 => FixedTableSpanExtent(width),
                  _ => null,
                };
              },
              rowSpanBackgroundDecoration: (row) {
                final dataRow = row - 1;
                if (dataRow < 0 || dataRow >= items.length) return null;
                if (items[dataRow].displayId == selectedId) {
                  return TableSpanDecoration(color: theme.colorScheme.accent);
                }
                return null;
              },
              onRowTap: (row) {
                if (row >= 0 && row < items.length) {
                  widget.controller.select(items[row].displayId);
                }
              },
              onRowDoubleTap: (row) {
                if (row >= 0 && row < items.length) {
                  Navigator.of(context).pop(items[row].displayId);
                }
              },
              builder: (context, vicinity) {
                if (vicinity.row < 0 || vicinity.row >= items.length) {
                  return ShadTableCell(child: SizedBox());
                }
                final item = items[vicinity.row];
                return switch (vicinity.column) {
                  0 => ShadTableCell(child: Text(item.displayId.toString())),
                  1 => ShadTableCell(child: Text(item.gender.toString())),
                  2 => ShadTableCell(
                    child: Text(item.boundingRadius.toStringAsFixed(2)),
                  ),
                  3 => ShadTableCell(
                    child: Text(item.combatReach.toStringAsFixed(2)),
                  ),
                  _ => ShadTableCell(child: SizedBox()),
                };
              },
            );
          },
        ),
      );
    });
  }
}
