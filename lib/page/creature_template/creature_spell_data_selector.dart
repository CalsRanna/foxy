import 'package:flutter/material.dart';
import 'package:foxy/model/creature_spell_data.dart';
import 'package:foxy/repository/creature_spell_data_repository.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 宠物技能选择器
class CreatureSpellDataSelector extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;

  const CreatureSpellDataSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  State<CreatureSpellDataSelector> createState() =>
      _CreatureSpellDataSelectorState();
}

class _CreatureSpellDataSelectorState extends State<CreatureSpellDataSelector> {
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
        return _CreatureSpellDataSelectorDialog(initialValue: currentValue);
      },
    );
    if (result != null) {
      widget.controller.text = result.toString();
    }
  }
}

class _CreatureSpellDataSelectorDialog extends StatefulWidget {
  final int? initialValue;

  const _CreatureSpellDataSelectorDialog({this.initialValue});

  @override
  State<_CreatureSpellDataSelectorDialog> createState() =>
      _CreatureSpellDataSelectorDialogState();
}

class _CreatureSpellDataSelectorDialogState
    extends State<_CreatureSpellDataSelectorDialog> {
  final _idController = TextEditingController();

  List<CreatureSpellData> _items = [];
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
      final repository = CreatureSpellDataRepository();
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
      title: Text('选择宠物技能'),
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
          child: ShadInput(
            controller: _idController,
            placeholder: Text('技能数据ID'),
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
      columnCount: 5,
      rowCount: _items.length,
      pinnedRowCount: 1,
      header: (context, column) {
        return switch (column) {
          0 => ShadTableCell.header(child: Text('编号')),
          1 => ShadTableCell.header(child: Text('技能1')),
          2 => ShadTableCell.header(child: Text('技能2')),
          3 => ShadTableCell.header(child: Text('技能3')),
          4 => ShadTableCell.header(child: Text('技能4')),
          _ => ShadTableCell.header(child: SizedBox()),
        };
      },
      columnSpanExtent: (column) {
        return switch (column) {
          0 => FixedTableSpanExtent(80),
          1 => FixedTableSpanExtent(80),
          2 => FixedTableSpanExtent(80),
          3 => FixedTableSpanExtent(80),
          _ => null,
        };
      },
      rowSpanBackgroundDecoration: (row) {
        if (row < 0 || row >= _items.length) return null;
        final item = _items[row];
        if (item.id == _selectedId) {
          return TableSpanDecoration(
            color: theme.colorScheme.accent.withValues(alpha: 0.2),
          );
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
          1 => ShadTableCell(child: Text(item.spells1.toString())),
          2 => ShadTableCell(child: Text(item.spells2.toString())),
          3 => ShadTableCell(child: Text(item.spells3.toString())),
          4 => ShadTableCell(child: Text(item.spells4.toString())),
          _ => ShadTableCell(child: SizedBox()),
        };
      },
    );
  }
}
