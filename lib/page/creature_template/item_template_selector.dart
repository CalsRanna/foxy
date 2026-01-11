import 'package:flutter/material.dart';
import 'package:foxy/constant/item_quality.dart';
import 'package:foxy/model/item_template.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 物品模板选择器
class ItemTemplateSelector extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;

  const ItemTemplateSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  State<ItemTemplateSelector> createState() => _ItemTemplateSelectorState();
}

class _ItemTemplateSelectorState extends State<ItemTemplateSelector> {
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
  final _entryController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<ItemTemplate> _items = [];
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
      title: Text('物品'),
      actions: [cancelButton, confirmButton],
      constraints: BoxConstraints(maxWidth: 720),
      child: Column(spacing: 8, children: children),
    );
  }

  @override
  void dispose() {
    _entryController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != 0) {
      _entryController.text = widget.initialValue?.toString() ?? '';
      _selectedId = widget.initialValue;
    }
    _search();
  }

  Widget _buildFilter() {
    var entryInput = ShadInput(
      controller: _entryController,
      placeholder: Text('编号'),
    );
    var nameInput = ShadInput(
      controller: _nameController,
      placeholder: Text('名称'),
    );
    var descriptionInput = ShadInput(
      controller: _descriptionController,
      placeholder: Text('描述'),
    );
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
      Expanded(child: entryInput),
      Expanded(child: nameInput),
      Expanded(child: descriptionInput),
      Row(spacing: 8, children: [searchButton, resetButton]),
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
          var nameWidth = maxWidth - 360;
          return FoxyShadTable(
            columnCount: 4,
            rowCount: _items.length,
            pinnedRowCount: 1,
            header: (context, column) {
              return switch (column) {
                0 => ShadTableCell.header(child: Text('编号')),
                1 => ShadTableCell.header(child: Text('名称')),
                2 => ShadTableCell.header(child: Text('物品等级')),
                3 => ShadTableCell.header(child: Text('需求等级')),
                _ => ShadTableCell.header(child: SizedBox()),
              };
            },
            columnSpanExtent: (column) {
              return switch (column) {
                0 => FixedTableSpanExtent(120),
                1 => FixedTableSpanExtent(nameWidth),
                2 => FixedTableSpanExtent(120),
                3 => FixedTableSpanExtent(120),
                _ => null,
              };
            },
            rowSpanBackgroundDecoration: (row) {
              // row 包含 header，所以减 1
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
              final qualityColor =
                  kItemQualityColors[item.quality] ?? Colors.white;
              return switch (vicinity.column) {
                0 => ShadTableCell(child: Text(item.entry.toString())),
                1 => ShadTableCell(
                  child: Text(
                    item.displayName,
                    style: TextStyle(color: qualityColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                2 => ShadTableCell(child: Text(item.itemLevel.toString())),
                3 => ShadTableCell(child: Text(item.requiredLevel.toString())),
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
    _entryController.clear();
    _nameController.clear();
    _descriptionController.clear();
    _page = 1;
    _search();
  }

  Future<void> _search() async {
    setState(() => _loading = true);
    try {
      final repository = ItemTemplateRepository();
      final entry = _entryController.text.isEmpty
          ? null
          : _entryController.text;
      final name = _nameController.text.isEmpty ? null : _nameController.text;
      final description = _descriptionController.text.isEmpty
          ? null
          : _descriptionController.text;
      final items = await repository.search(
        entry: entry,
        name: name,
        description: description,
        page: _page,
      );
      final total = await repository.count(
        entry: entry,
        name: name,
        description: description,
      );
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
