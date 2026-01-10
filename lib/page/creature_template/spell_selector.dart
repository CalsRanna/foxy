import 'package:flutter/material.dart';
import 'package:foxy/model/spell.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 技能选择器
class SpellSelector extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;

  const SpellSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  State<SpellSelector> createState() => _SpellSelectorState();
}

class _SpellSelectorState extends State<SpellSelector> {
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
        return _SpellSelectorDialog(initialValue: currentValue);
      },
    );
    if (result != null) {
      widget.controller.text = result.toString();
    }
  }
}

class _SpellSelectorDialog extends StatefulWidget {
  final int? initialValue;

  const _SpellSelectorDialog({this.initialValue});

  @override
  State<_SpellSelectorDialog> createState() => _SpellSelectorDialogState();
}

class _SpellSelectorDialogState extends State<_SpellSelectorDialog> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();

  List<Spell> _items = [];
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
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    setState(() => _loading = true);
    try {
      final repository = SpellRepository();
      final id = _idController.text.isEmpty ? null : _idController.text;
      final name = _nameController.text.isEmpty ? null : _nameController.text;
      final items = await repository.search(id: id, name: name, page: _page);
      final total = await repository.count(id: id, name: name);
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
    _nameController.clear();
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
      title: Text('选择技能'),
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
              maxWidth: 800,
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
          child: ShadInput(
            controller: _idController,
            placeholder: Text('编号'),
          ),
        ),
        Expanded(
          flex: 2,
          child: ShadInput(
            controller: _nameController,
            placeholder: Text('名称'),
          ),
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
      columnCount: 3,
      rowCount: _items.length,
      pinnedRowCount: 1,
      header: (context, column) {
        final headers = ['编号', '名称', '子名称'];
        return ShadTableCell.header(child: Text(headers[column]));
      },
      columnBuilder: (column) {
        return switch (column) {
          0 => TableSpan(extent: FixedTableSpanExtent(80)),
          1 => TableSpan(extent: FixedTableSpanExtent(300)),
          2 => TableSpan(extent: FixedTableSpanExtent(200)),
          _ => TableSpan(extent: FixedTableSpanExtent(100)),
        };
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
          1 => ShadTableCell(child: Text(item.name)),
          2 => ShadTableCell(child: Text(item.subtext)),
          _ => ShadTableCell(child: SizedBox()),
        };
      },
    );
  }
}
