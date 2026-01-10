import 'package:flutter/material.dart';
import 'package:foxy/model/creature_template.dart';
import 'package:foxy/model/creature_template_filter_entity.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 生物模板选择器
class CreatureTemplateSelector extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;

  const CreatureTemplateSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  State<CreatureTemplateSelector> createState() =>
      _CreatureTemplateSelectorState();
}

class _CreatureTemplateSelectorState extends State<CreatureTemplateSelector> {
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
        return _CreatureTemplateSelectorDialog(initialValue: currentValue);
      },
    );
    if (result != null) {
      widget.controller.text = result.toString();
    }
  }
}

class _CreatureTemplateSelectorDialog extends StatefulWidget {
  final int? initialValue;

  const _CreatureTemplateSelectorDialog({this.initialValue});

  @override
  State<_CreatureTemplateSelectorDialog> createState() =>
      _CreatureTemplateSelectorDialogState();
}

class _CreatureTemplateSelectorDialogState
    extends State<_CreatureTemplateSelectorDialog> {
  final _entryController = TextEditingController();
  final _nameController = TextEditingController();

  List<BriefCreatureTemplate> _items = [];
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
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    setState(() => _loading = true);
    try {
      final repository = CreatureTemplateRepository();
      final filter = CreatureTemplateFilterEntity()
        ..entry = _entryController.text
        ..name = _nameController.text;
      final items = await repository.getBriefCreatureTemplates(
        page: _page,
        filter: filter,
      );
      final total = await repository.count(filter: filter);
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
      title: Text('选择生物模板'),
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
            controller: _entryController,
            placeholder: Text('entry'),
          ),
        ),
        Expanded(
          child: ShadInput(
            controller: _nameController,
            placeholder: Text('name'),
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
        return switch (column) {
          0 => ShadTableCell.header(child: Text('编号')),
          1 => ShadTableCell.header(child: Text('名称')),
          2 => ShadTableCell.header(child: Text('等级')),
          _ => ShadTableCell.header(child: SizedBox()),
        };
      },
      columnSpanExtent: (column) {
        return switch (column) {
          0 => FixedTableSpanExtent(100),
          2 => FixedTableSpanExtent(100),
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
          1 => ShadTableCell(child: Text(item.displayName)),
          2 => ShadTableCell(child: Text('${item.minLevel}-${item.maxLevel}')),
          _ => ShadTableCell(child: SizedBox()),
        };
      },
    );
  }
}
