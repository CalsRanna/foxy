import 'package:flutter/material.dart';
import 'package:foxy/model/loot_template.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 掉落模板选择器
class LootTemplateSelector extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;
  final LootTableType tableType;
  final String title;

  const LootTemplateSelector({
    super.key,
    required this.controller,
    this.placeholder,
    required this.tableType,
    required this.title,
  });

  /// 击杀掉落选择器
  factory LootTemplateSelector.creature({
    Key? key,
    required TextEditingController controller,
    String? placeholder,
  }) {
    return LootTemplateSelector(
      key: key,
      controller: controller,
      placeholder: placeholder,
      tableType: LootTableType.creature,
      title: '击杀掉落',
    );
  }

  /// 偷窃掉落选择器
  factory LootTemplateSelector.pickpocket({
    Key? key,
    required TextEditingController controller,
    String? placeholder,
  }) {
    return LootTemplateSelector(
      key: key,
      controller: controller,
      placeholder: placeholder,
      tableType: LootTableType.pickpocket,
      title: '偷窃掉落',
    );
  }

  /// 剥皮掉落选择器
  factory LootTemplateSelector.skinning({
    Key? key,
    required TextEditingController controller,
    String? placeholder,
  }) {
    return LootTemplateSelector(
      key: key,
      controller: controller,
      placeholder: placeholder,
      tableType: LootTableType.skinning,
      title: '剥皮掉落',
    );
  }

  @override
  State<LootTemplateSelector> createState() => _LootTemplateSelectorState();
}

class _LootTemplateSelectorState extends State<LootTemplateSelector> {
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
      builder: (context) => _Dialog(
        initialValue: currentValue,
        tableType: widget.tableType,
        title: widget.title,
      ),
    );
    if (result == null) return;
    widget.controller.text = result.toString();
  }
}

class _Dialog extends StatefulWidget {
  final int? initialValue;
  final LootTableType tableType;
  final String title;

  const _Dialog({
    this.initialValue,
    required this.tableType,
    required this.title,
  });

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  final _entryController = TextEditingController();

  List<LootTemplate> _items = [];
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
      title: Text(widget.title),
      actions: [cancelButton, confirmButton],
      constraints: BoxConstraints(maxWidth: 720),
      child: Column(spacing: 8, children: children),
    );
  }

  @override
  void dispose() {
    _entryController.dispose();
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
      placeholder: Text('掉落编号'),
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
          var width = maxWidth - 240;
          return FoxyShadTable(
            columnCount: 2,
            rowCount: _items.length,
            pinnedRowCount: 1,
            header: (context, column) {
              return switch (column) {
                0 => ShadTableCell.header(child: Text('掉落编号')),
                1 => ShadTableCell.header(child: Text('物品数量')),
                _ => ShadTableCell.header(child: SizedBox()),
              };
            },
            columnSpanExtent: (column) {
              return switch (column) {
                0 => FixedTableSpanExtent(120),
                1 => FixedTableSpanExtent(width + 120),
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
              return switch (vicinity.column) {
                0 => ShadTableCell(child: Text(item.entry.toString())),
                1 => ShadTableCell(child: Text(item.itemCount.toString())),
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
    _page = 1;
    _search();
  }

  Future<void> _search() async {
    setState(() => _loading = true);
    try {
      final repository = LootTemplateRepository(widget.tableType);
      final entry = _entryController.text.isEmpty
          ? null
          : _entryController.text;
      final items = await repository.searchDistinctEntries(
        entry: entry,
        page: _page,
      );
      final total = await repository.count(entry: entry);
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
