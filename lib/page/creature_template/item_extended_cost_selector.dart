import 'package:flutter/material.dart';
import 'package:foxy/model/item_extended_cost.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 扩展价格选择器
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
  Widget build(BuildContext context) {
    return ShadInput(
      controller: widget.controller,
      placeholder: Text(widget.placeholder ?? ''),
      trailing: ShadButton.ghost(
        height: 20,
        width: 20,
        padding: EdgeInsets.zero,
        onPressed: _openDialog,
        child: Icon(LucideIcons.search, size: 12),
      ),
    );
  }

  Future<void> _openDialog() async {
    final currentValue = int.tryParse(widget.controller.text);
    final result = await showShadDialog<int>(
      context: context,
      builder: (context) {
        return _ItemExtendedCostSelectorDialog(initialValue: currentValue);
      },
    );
    if (result != null) {
      widget.controller.text = result.toString();
    }
  }
}

class _ItemExtendedCostSelectorDialog extends StatefulWidget {
  final int? initialValue;

  const _ItemExtendedCostSelectorDialog({this.initialValue});

  @override
  State<_ItemExtendedCostSelectorDialog> createState() =>
      _ItemExtendedCostSelectorDialogState();
}

class _ItemExtendedCostSelectorDialogState
    extends State<_ItemExtendedCostSelectorDialog> {
  final _idController = TextEditingController();

  List<ItemExtendedCost> _items = [];
  int _total = 0;
  int _page = 1;
  int? _selectedId;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialValue;
    _search();
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    setState(() => _loading = true);
    try {
      final repository = ItemExtendedCostRepository();
      final id = _idController.text.isEmpty ? null : _idController.text;
      final items = await repository.search(id: id, page: _page);
      final total = await repository.count(id: id);
      if (mounted) {
        setState(() {
          _items = items;
          _total = total;
        });
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _reset() {
    _idController.clear();
    _page = 1;
    _search();
  }

  void _paginate(int page) {
    _page = page;
    _search();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final tableMaxHeight = screenHeight * 0.5;

    return ShadDialog(
      title: Text('选择扩展价格'),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('取消'),
        ),
        ShadButton(
          onPressed: _selectedId != null
              ? () => Navigator.of(context).pop(_selectedId)
              : null,
          child: Text('确定'),
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSearchForm(),
          SizedBox(height: 12),
          _buildToolbar(),
          SizedBox(height: 8),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 720,
              maxHeight: tableMaxHeight,
            ),
            child: _loading
                ? Center(child: CircularProgressIndicator())
                : _buildTable(),
          ),
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
                _page = 1;
                _search();
              },
              child: Text('查询'),
            ),
            SizedBox(width: 8),
            ShadButton.outline(
              size: ShadButtonSize.sm,
              onPressed: _reset,
              child: Text('重置'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToolbar() {
    return Row(
      children: [
        Text('共 $_total 条记录'),
        Spacer(),
        FoxyPagination(
          page: _page,
          pageSize: 50,
          total: _total,
          onChange: _paginate,
        ),
      ],
    );
  }

  Widget _buildTable() {
    if (_items.isEmpty) {
      return Center(child: Text('暂无数据'));
    }

    final theme = ShadTheme.of(context);

    return FoxyShadTable(
      columnCount: 4,
      rowCount: _items.length,
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
        if (dataRow < 0 || dataRow >= _items.length) return null;
        final item = _items[dataRow];
        if (item.id == _selectedId) {
          return TableSpanDecoration(color: theme.colorScheme.accent);
        }
        return null;
      },
      onRowTap: (row) {
        if (row >= 0 && row < _items.length) {
          setState(() {
            _selectedId = _items[row].id;
          });
        }
      },
      onRowDoubleTap: (row) {
        if (row >= 0 && row < _items.length) {
          Navigator.of(context).pop(_items[row].id);
        }
      },
      builder: (context, vicinity) {
        if (vicinity.row < 0 || vicinity.row >= _items.length) {
          return ShadTableCell(child: SizedBox());
        }
        final item = _items[vicinity.row];
        return switch (vicinity.column) {
          0 => ShadTableCell(child: Text(item.id.toString())),
          1 => ShadTableCell(child: Text(item.honorPoints.toString())),
          2 => ShadTableCell(child: Text(item.arenaPoints.toString())),
          3 => ShadTableCell(child: Text(item.arenaBracket.toString())),
          _ => ShadTableCell(child: SizedBox()),
        };
      },
    );
  }
}
