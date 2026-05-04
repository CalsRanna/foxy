import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/creature_model_info_selector_view_model.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class CreatureModelInfoSelector extends StatefulWidget {
  final Signal<int> signal;
  final String? placeholder;

  const CreatureModelInfoSelector({
    super.key,
    required this.signal,
    this.placeholder,
  });

  @override
  State<CreatureModelInfoSelector> createState() =>
      _CreatureModelInfoSelectorState();
}

class _CreatureModelInfoSelectorState extends State<CreatureModelInfoSelector> {
  final _displayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _syncDisplay();
  }

  void _syncDisplay() {
    final v = widget.signal.value;
    _displayController.text = v == 0 ? '' : v.toString();
  }

  @override
  void dispose() {
    _displayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: _displayController,
      placeholder: Text(widget.placeholder ?? ''),
      readOnly: true,
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
    final vm = CreatureModelInfoSelectorViewModel();
    if (widget.signal.value != 0) {
      vm.idFilter.value = widget.signal.value.toString();
      vm.selectedId.value = widget.signal.value;
      await vm.search();
    }

    final result = await showShadDialog<int>(
      context: context,
      builder: (context) => _Dialog(vm: vm),
    );
    vm.dispose();
    if (result != null) {
      widget.signal.value = result;
      _syncDisplay();
    }
  }
}

class _Dialog extends StatefulWidget {
  final CreatureModelInfoSelectorViewModel vm;

  const _Dialog({required this.vm});

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  final _idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _idController.text = widget.vm.idFilter.value;
  }

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
        Watch((_) {
          return FoxyPagination(
            page: widget.vm.page.value,
            pageSize: 50,
            total: widget.vm.total.value,
            onChange: (p) => widget.vm.paginate(p),
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
              onPressed: () => Navigator.of(context).pop(widget.vm.selectedId.value),
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
                widget.vm.idFilter.value = _idController.text;
                widget.vm.page.value = 1;
                widget.vm.search();
              },
              size: ShadButtonSize.sm,
              child: Text('查询'),
            ),
            ShadButton.ghost(
              onPressed: () {
                _idController.clear();
                widget.vm.reset();
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

    return Watch((_) {
      final items = widget.vm.items.value;
      final selectedId = widget.vm.selectedId.value;

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
                  widget.vm.select(items[row].displayId);
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
