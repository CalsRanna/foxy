import 'package:flutter/material.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/repository/item_enchantment_template_repository.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 物品附魔模板选择器
class ItemEnchantmentTemplateSelector extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;

  const ItemEnchantmentTemplateSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  State<ItemEnchantmentTemplateSelector> createState() =>
      _ItemEnchantmentTemplateSelectorState();
}

class _ItemEnchantmentTemplateSelectorState
    extends State<ItemEnchantmentTemplateSelector> {
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

  List<BriefItemEnchantmentTemplateEntity> _items = [];
  int _total = 0;
  int _page = 1;
  int? _selectedId;

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
    var children = [_buildFilter(), _buildTable()];
    return ShadDialog(
      title: Text('附魔'),
      actions: [
        _buildPagination(),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [cancelButton, confirmButton],
        ),
      ],
      actionsMainAxisAlignment: MainAxisAlignment.spaceBetween,
      actionsMainAxisSize: MainAxisSize.max,
      constraints: BoxConstraints(maxWidth: 720),
      child: Column(spacing: 8, children: children),
    );
  }

  @override
  void dispose() {
    _entryController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.initialValue != 0) {
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
      Expanded(child: Row(spacing: 8, children: [searchButton, resetButton])),
    ];
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(spacing: 8, children: children),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
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
              var displayName = item.name.isNotEmpty ? item.name : '';
              return switch (vicinity.column) {
                0 => ShadTableCell(child: Text(item.entry.toString())),
                1 => ShadTableCell(
                  child: Text(
                    displayName,
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
    _entryController.clear();
    _nameController.clear();
    _page = 1;
    _search();
  }

  Future<void> _search() async {
    try {
      final repository = ItemEnchantmentTemplateRepository();
      final entry = _entryController.text.isEmpty
          ? null
          : _entryController.text;
      final items = await repository.getItemEnchantmentTemplates(
        entry: entry,
        page: _page,
      );
      final total = await repository.countItemEnchantmentTemplates(
        entry: entry,
      );
      if (mounted) {
        setState(() {
          _items = items;
          _total = total;
        });
      }
    } finally {}
  }
}
