import 'package:flutter/material.dart';
import 'package:foxy/model/item_enchantment_template.dart';
import 'package:foxy/repository/scaling_stat_distribution_repository.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 属性缩放分布选择器
class ScalingStatDistributionSelector extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;

  const ScalingStatDistributionSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  State<ScalingStatDistributionSelector> createState() =>
      _ScalingStatDistributionSelectorState();
}

class _ScalingStatDistributionSelectorState
    extends State<ScalingStatDistributionSelector> {
  @override
  Widget build(BuildContext context) {
    var shadButton = ShadButton.ghost(
      height: 20,
      padding: EdgeInsets.zero,
      onPressed: _openDialog,
      width: 20,
      child: Icon(LucideIcons.search, size: 12),
    );
    return ShadInput(
      controller: widget.controller,
      placeholder: Text(widget.placeholder ?? ''),
      trailing: shadButton,
    );
  }

  Future<void> _openDialog() async {
    final currentValue = int.tryParse(widget.controller.text);
    final result = await showShadDialog<int>(
      context: context,
      builder: (context) => _Dialog(initialValue: currentValue),
    );
    if (result == null) return;
    widget.controller.text = result.toString();
  }
}

class _Dialog extends StatefulWidget {
  final int? initialValue;

  const _Dialog({this.initialValue});

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  final _idController = TextEditingController();

  List<ItemEnchantmentTemplate> _items = [];
  int _total = 0;
  int _page = 1;
  int? _selectedId;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    var cancelButton = ShadButton.outline(
      onPressed: () => Navigator.of(context).pop(),
      child: Text('取消'),
    );
    var confirmButton = ShadButton(
      onPressed: () => Navigator.of(context).pop(_selectedId),
      child: Text('确定'),
    );
    var children = [_buildFilter(), _buildPagination(), _buildTable()];
    return ShadDialog(
      title: Text('属性缩放分布'),
      actions: [cancelButton, confirmButton],
      constraints: BoxConstraints(maxWidth: 720),
      child: Column(spacing: 8, children: children),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.initialValue != 0) {
      _idController.text = widget.initialValue?.toString() ?? '';
      _selectedId = widget.initialValue;
    }
    _search();
  }

  Widget _buildFilter() {
    var idInput = ShadInput(controller: _idController, placeholder: Text('编号'));
    var searchButton = ShadButton(
      onPressed: _doSearch,
      size: ShadButtonSize.sm,
      child: Text('查询'),
    );
    var resetButton = ShadButton.ghost(
      onPressed: _reset,
      size: ShadButtonSize.sm,
      child: Text('重置'),
    );
    var children = [
      Expanded(child: idInput),
      Expanded(child: SizedBox()),
      Expanded(child: Row(spacing: 8, children: [searchButton, resetButton])),
    ];
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 8, children: children),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (_loading)
          SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
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
    final theme = ShadTheme.of(context);

    final screenHeight = MediaQuery.of(context).size.height;
    final tableMaxHeight = screenHeight * 0.5;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: tableMaxHeight),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          var nameWidth = maxWidth - 120;
          return FoxyShadTable(
            columnCount: 2,
            rowCount: _items.length,
            pinnedRowCount: 1,
            header: (context, column) {
              return switch (column) {
                0 => ShadTableCell.header(child: Text('编号')),
                1 => ShadTableCell.header(child: Text('名称')),
                _ => ShadTableCell.header(child: SizedBox()),
              };
            },
            columnSpanExtent: (column) {
              return switch (column) {
                0 => FixedTableSpanExtent(120),
                1 => FixedTableSpanExtent(nameWidth),
                _ => null,
              };
            },
            rowSpanBackgroundDecoration: (row) {
              final dataRow = row - 1;
              if (dataRow < 0 || dataRow >= _items.length) return null;
              final item = _items[dataRow];
              if (item.entry == _selectedId) {
                return TableSpanDecoration(color: theme.colorScheme.accent);
              }
              return null;
            },
            onRowTap: (row) {
              if (row >= 0 && row < _items.length) {
                setState(() {
                  _selectedId = _items[row].entry;
                });
              }
            },
            onRowDoubleTap: (row) {
              if (row >= 0 && row < _items.length) {
                Navigator.of(context).pop(_items[row].entry);
              }
            },
            builder: (context, vicinity) {
              if (vicinity.row < 0 || vicinity.row >= _items.length) {
                return ShadTableCell(child: SizedBox());
              }
              final item = _items[vicinity.row];
              return switch (vicinity.column) {
                0 => ShadTableCell(child: Text(item.entry.toString())),
                1 => ShadTableCell(
                  child: Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _ => ShadTableCell(child: SizedBox()),
              };
            },
          );
        },
      ),
    );
  }

  void _doSearch() {
    _page = 1;
    _search();
  }

  void _paginate(int page) {
    _page = page;
    _search();
  }

  void _reset() {
    _idController.clear();
    _page = 1;
    _search();
  }

  Future<void> _search() async {
    setState(() => _loading = true);
    try {
      final repository = ScalingStatDistributionRepository();
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
}
