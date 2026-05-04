import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/item_extended_cost_selector_view_model.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class ItemExtendedCostSelector extends StatefulWidget {
  final Signal<int> signal;
  final String? placeholder;

  const ItemExtendedCostSelector({
    super.key,
    required this.signal,
    this.placeholder,
  });

  @override
  State<ItemExtendedCostSelector> createState() =>
      _ItemExtendedCostSelectorState();
}

class _ItemExtendedCostSelectorState extends State<ItemExtendedCostSelector> {
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
    final vm = ItemExtendedCostSelectorViewModel();
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
  final ItemExtendedCostSelectorViewModel vm;

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
      title: Text('选择扩展价格'),
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
                widget.vm.idFilter.value = _idController.text;
                widget.vm.page.value = 1;
                widget.vm.search();
              },
              child: Text('查询'),
            ),
            SizedBox(width: 8),
            ShadButton.outline(
              size: ShadButtonSize.sm,
              onPressed: () {
                _idController.clear();
                widget.vm.reset();
              },
              child: Text('重置'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToolbar() {
    return Watch((_) {
      return Row(children: [Text('共 ${widget.vm.total.value} 条记录')]);
    });
  }

  Widget _buildTable() {
    final theme = ShadTheme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final tableMaxHeight = screenHeight * 0.5;

    return Watch((_) {
      final items = widget.vm.items.value;
      final selectedId = widget.vm.selectedId.value;

      if (items.isEmpty) {
        return Center(child: Text('暂无数据'));
      }

      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 720,
          maxHeight: tableMaxHeight,
        ),
        child: FoxyShadTable(
          columnCount: 4,
          rowCount: items.length,
          pinnedRowCount: 1,
          header: (context, column) {
            final headers = ['编号', '荣誉点数', '竞技场点数', '竞技场等级'];
            return ShadTableCell.header(child: Text(headers[column]));
          },
          columnBuilder: (column) {
            return TableSpan(extent: FixedTableSpanExtent(120));
          },
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
              widget.vm.select(items[row].id);
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
          },
        ),
      );
    });
  }
}
