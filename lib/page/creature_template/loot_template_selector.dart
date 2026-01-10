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
      title: '选择击杀掉落',
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
      title: '选择偷窃掉落',
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
      title: '选择剥皮掉落',
    );
  }

  @override
  State<LootTemplateSelector> createState() => _LootTemplateSelectorState();
}

class _LootTemplateSelectorState extends State<LootTemplateSelector> {
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
        return _LootTemplateSelectorDialog(
          initialValue: currentValue,
          tableType: widget.tableType,
          title: widget.title,
        );
      },
    );
    if (result != null) {
      widget.controller.text = result.toString();
    }
  }
}

class _LootTemplateSelectorDialog extends StatefulWidget {
  final int? initialValue;
  final LootTableType tableType;
  final String title;

  const _LootTemplateSelectorDialog({
    this.initialValue,
    required this.tableType,
    required this.title,
  });

  @override
  State<_LootTemplateSelectorDialog> createState() =>
      _LootTemplateSelectorDialogState();
}

class _LootTemplateSelectorDialogState
    extends State<_LootTemplateSelectorDialog> {
  final _entryController = TextEditingController();

  List<LootTemplate> _items = [];
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
    _entryController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    setState(() => _loading = true);
    try {
      final repository = LootTemplateRepository(widget.tableType);
      final entry =
          _entryController.text.isEmpty ? null : _entryController.text;
      final items =
          await repository.searchDistinctEntries(entry: entry, page: _page);
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

  void _reset() {
    _entryController.clear();
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
      title: Text(widget.title),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('取消'),
        ),
        ShadButton(
          onPressed:
              _selectedId != null
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
            constraints: BoxConstraints(maxWidth: 320, maxHeight: tableMaxHeight),
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
            controller: _entryController,
            placeholder: Text('Entry'),
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
          pageSize: 25,
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
      columnCount: 1,
      rowCount: _items.length,
      pinnedRowCount: 1,
      header: (context, column) {
        return ShadTableCell.header(child: Text('掉落编号'));
      },
      rowSpanBackgroundDecoration: (row) {
        if (row < 0 || row >= _items.length) return null;
        final item = _items[row];
        if (item.entry == _selectedId) {
          return TableSpanDecoration(
            color: theme.colorScheme.accent.withValues(alpha: 0.2),
          );
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
        return ShadTableCell(child: Text(item.entry.toString()));
      },
    );
  }
}
