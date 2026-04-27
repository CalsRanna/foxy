import 'package:flutter/material.dart';
import 'package:foxy/model/area_table.dart';
import 'package:foxy/model/area_table_filter_entity.dart';
import 'package:foxy/model/quest_sort.dart';
import 'package:foxy/model/quest_sort_filter_entity.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 区域或任务排序选择器，通过 [mode] 切换数据源
class AreaTableOrQuestSortSelector extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;
  final String mode;

  const AreaTableOrQuestSortSelector({
    super.key,
    required this.controller,
    this.placeholder,
    this.mode = 'AreaTable',
  });

  @override
  State<AreaTableOrQuestSortSelector> createState() =>
      _AreaTableOrQuestSortSelectorState();
}

class _AreaTableOrQuestSortSelectorState
    extends State<AreaTableOrQuestSortSelector> {
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
        mode: widget.mode,
      ),
    );
    if (result == null) return;
    widget.controller.text = result.toString();
  }
}

class _Dialog extends StatefulWidget {
  final int? initialValue;
  final String mode;

  const _Dialog({this.initialValue, required this.mode});

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();

  List<AreaTable> _areaItems = [];
  List<QuestSort> _questItems = [];
  int _total = 0;
  int _page = 1;
  int? _selectedId;
  bool _loading = false;
  late String _currentMode;

  @override
  Widget build(BuildContext context) {
    final title = _currentMode == 'AreaTable' ? '区域' : '任务排序';
    var cancelButton = ShadButton.outline(
      onPressed: () => Navigator.of(context).pop(),
      child: Text('取消'),
    );
    var confirmButton = ShadButton(
      onPressed: () => Navigator.of(context).pop(_selectedId),
      child: Text('确定'),
    );
    var children = [
      _buildModeSwitcher(),
      _buildFilter(),
      _buildPagination(),
      _buildTable(),
    ];
    return ShadDialog(
      title: Text(title),
      actions: [cancelButton, confirmButton],
      constraints: BoxConstraints(maxWidth: 720),
      child: Column(spacing: 8, children: children),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _currentMode = widget.mode;
    if (widget.initialValue != 0) {
      _idController.text = widget.initialValue?.toString() ?? '';
      _selectedId = widget.initialValue;
    }
    _search();
  }

  Widget _buildModeSwitcher() {
    return Row(spacing: 8, children: [
      ShadButton(
        onPressed: _currentMode == 'AreaTable' ? null : () {
          setState(() {
            _currentMode = 'AreaTable';
            _idController.clear();
            _nameController.clear();
            _selectedId = null;
            _page = 1;
          });
          _search();
        },
        size: ShadButtonSize.sm,
        child: Text('区域'),
      ),
      ShadButton(
        onPressed: _currentMode == 'QuestSort' ? null : () {
          setState(() {
            _currentMode = 'QuestSort';
            _idController.clear();
            _nameController.clear();
            _selectedId = null;
            _page = 1;
          });
          _search();
        },
        size: ShadButtonSize.sm,
        child: Text('任务排序'),
      ),
    ]);
  }

  Widget _buildFilter() {
    var idInput = _currentMode == 'AreaTable'
        ? ShadInput(controller: _idController, placeholder: Text('区域ID'))
        : ShadInput(controller: _idController, placeholder: Text('任务排序ID'));
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
      Expanded(child: idInput),
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
            rowCount:
                _currentMode == 'AreaTable'
                    ? _areaItems.length
                    : _questItems.length,
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
              if (_currentMode == 'AreaTable') {
                if (dataRow < 0 || dataRow >= _areaItems.length) return null;
                if (_areaItems[dataRow].id == _selectedId) {
                  return TableSpanDecoration(color: theme.colorScheme.accent);
                }
              } else {
                if (dataRow < 0 || dataRow >= _questItems.length) return null;
                if (_questItems[dataRow].id == _selectedId) {
                  return TableSpanDecoration(color: theme.colorScheme.accent);
                }
              }
              return null;
            },
            onRowTap: (row) {
              if (_currentMode == 'AreaTable') {
                if (row >= 0 && row < _areaItems.length) {
                  setState(() => _selectedId = _areaItems[row].id);
                }
              } else {
                if (row >= 0 && row < _questItems.length) {
                  setState(() => _selectedId = _questItems[row].id);
                }
              }
            },
            onRowDoubleTap: (row) {
              if (_currentMode == 'AreaTable') {
                if (row >= 0 && row < _areaItems.length) {
                  Navigator.of(context).pop(_areaItems[row].id);
                }
              } else {
                if (row >= 0 && row < _questItems.length) {
                  Navigator.of(context).pop(_questItems[row].id);
                }
              }
            },
            builder: (context, vicinity) {
              if (_currentMode == 'AreaTable') {
                if (vicinity.row < 0 || vicinity.row >= _areaItems.length) {
                  return ShadTableCell(child: SizedBox());
                }
                final item = _areaItems[vicinity.row];
                return switch (vicinity.column) {
                  0 => ShadTableCell(child: Text(item.id.toString())),
                  1 => ShadTableCell(
                    child: Text(
                      item.areaNameLangZhCn,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _ => ShadTableCell(child: SizedBox()),
                };
              } else {
                if (vicinity.row < 0 || vicinity.row >= _questItems.length) {
                  return ShadTableCell(child: SizedBox());
                }
                final item = _questItems[vicinity.row];
                return switch (vicinity.column) {
                  0 => ShadTableCell(child: Text(item.id.toString())),
                  1 => ShadTableCell(child: Text(item.sortNameLangZhCn)),
                  _ => ShadTableCell(child: SizedBox()),
                };
              }
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
    _nameController.clear();
    _page = 1;
    _search();
  }

  Future<void> _search() async {
    setState(() => _loading = true);
    try {
      if (_currentMode == 'AreaTable') {
        final repository = AreaTableRepository();
        final filter = AreaTableFilterEntity()
          ..id = _idController.text
          ..name = _nameController.text;
        final items = await repository.search(filter: filter, page: _page);
        final total = await repository.count(filter: filter);
        if (mounted) {
          setState(() {
            _areaItems = items;
            _questItems = [];
            _total = total;
          });
        }
      } else {
        final repository = QuestSortRepository();
        final filter = QuestSortFilterEntity()
          ..id = _idController.text
          ..name = _nameController.text;
        final items = await repository.search(filter: filter, page: _page);
        final total = await repository.count(filter: filter);
        if (mounted) {
          setState(() {
            _questItems = items;
            _areaItems = [];
            _total = total;
          });
        }
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
}
