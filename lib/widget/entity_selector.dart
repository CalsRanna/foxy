import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 实体选择器搜索字段配置
class SelectorSearchField {
  final String name;
  final String label;
  final String placeholder;

  const SelectorSearchField({
    required this.name,
    required this.label,
    required this.placeholder,
  });
}

/// 实体选择器列配置
class SelectorColumn {
  final String name;
  final String label;
  final double? width;

  const SelectorColumn({
    required this.name,
    required this.label,
    this.width,
  });
}

/// 实体选择器搜索结果
class SelectorSearchResult<T> {
  final List<T> items;
  final int total;

  const SelectorSearchResult({
    required this.items,
    required this.total,
  });
}

/// 通用实体选择器组件
class EntitySelector<T> extends StatefulWidget {
  /// 控制器，存储选中的 ID（字符串形式）
  final TextEditingController controller;

  /// 占位符
  final String? placeholder;

  /// 弹窗标题
  final String title;

  /// 搜索字段配置
  final List<SelectorSearchField> searchFields;

  /// 列配置
  final List<SelectorColumn> columns;

  /// 搜索回调，返回分页结果
  final Future<SelectorSearchResult<T>> Function(
    Map<String, String> params,
    int page,
  ) onSearch;

  /// 获取实体的 ID
  final int Function(T item) getId;

  /// 获取实体的单元格内容
  final String Function(T item, String columnName) getCellValue;

  const EntitySelector({
    super.key,
    required this.controller,
    this.placeholder,
    required this.title,
    required this.searchFields,
    required this.columns,
    required this.onSearch,
    required this.getId,
    required this.getCellValue,
  });

  @override
  State<EntitySelector<T>> createState() => _EntitySelectorState<T>();
}

class _EntitySelectorState<T> extends State<EntitySelector<T>> {
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
        return _EntitySelectorDialog<T>(
          title: widget.title,
          searchFields: widget.searchFields,
          columns: widget.columns,
          onSearch: widget.onSearch,
          getId: widget.getId,
          getCellValue: widget.getCellValue,
          initialValue: currentValue,
        );
      },
    );
    if (result != null) {
      widget.controller.text = result.toString();
    }
  }
}

/// 实体选择器弹窗
class _EntitySelectorDialog<T> extends StatefulWidget {
  final String title;
  final List<SelectorSearchField> searchFields;
  final List<SelectorColumn> columns;
  final Future<SelectorSearchResult<T>> Function(
    Map<String, String> params,
    int page,
  ) onSearch;
  final int Function(T item) getId;
  final String Function(T item, String columnName) getCellValue;
  final int? initialValue;

  const _EntitySelectorDialog({
    required this.title,
    required this.searchFields,
    required this.columns,
    required this.onSearch,
    required this.getId,
    required this.getCellValue,
    this.initialValue,
  });

  @override
  State<_EntitySelectorDialog<T>> createState() =>
      _EntitySelectorDialogState<T>();
}

class _EntitySelectorDialogState<T> extends State<_EntitySelectorDialog<T>> {
  final Map<String, TextEditingController> _searchControllers = {};
  List<T> _items = [];
  int _total = 0;
  int _page = 1;
  int? _selectedId;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialValue;
    // 初始化搜索控制器
    for (var field in widget.searchFields) {
      _searchControllers[field.name] = TextEditingController();
    }
    // 初始搜索
    _search();
  }

  @override
  void dispose() {
    for (var controller in _searchControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _search() async {
    setState(() => _loading = true);
    try {
      final params = <String, String>{};
      for (var entry in _searchControllers.entries) {
        if (entry.value.text.isNotEmpty) {
          params[entry.key] = entry.value.text;
        }
      }
      final result = await widget.onSearch(params, _page);
      if (mounted) {
        setState(() {
          _items = result.items;
          _total = result.total;
        });
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _reset() {
    for (var controller in _searchControllers.values) {
      controller.clear();
    }
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
    final maxHeight = screenHeight * 0.7;
    // 计算表格高度
    final tableHeight = maxHeight - 200;

    return ShadDialog(
      title: Text(widget.title),
      constraints: BoxConstraints(maxWidth: 700, maxHeight: maxHeight),
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
        children: [
          // 搜索表单
          _buildSearchForm(),
          SizedBox(height: 12),
          // 工具栏（分页）
          _buildToolbar(),
          SizedBox(height: 8),
          // 数据表格
          SizedBox(
            height: tableHeight,
            child: _loading
                ? Center(child: CircularProgressIndicator())
                : _buildTable(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchForm() {
    final fields = <Widget>[];
    for (var field in widget.searchFields) {
      fields.add(
        Expanded(
          child: ShadInput(
            controller: _searchControllers[field.name],
            placeholder: Text(field.placeholder),
          ),
        ),
      );
    }
    fields.add(
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
    );
    return Row(spacing: 12, children: fields);
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
    final headers = widget.columns.map((c) => c.label).toList();

    return FoxyShadTable(
      columnCount: headers.length,
      rowCount: _items.length,
      pinnedRowCount: 1,
      header: (context, column) {
        return ShadTableCell.header(child: Text(headers[column]));
      },
      columnSpanExtent: (column) {
        final col = widget.columns[column];
        if (col.width != null) {
          return FixedTableSpanExtent(col.width!);
        }
        return null;
      },
      rowSpanBackgroundDecoration: (row) {
        if (row < 0 || row >= _items.length) return null;
        final item = _items[row];
        final id = widget.getId(item);
        if (id == _selectedId) {
          return TableSpanDecoration(
            color: theme.colorScheme.accent.withValues(alpha: 0.2),
          );
        }
        return null;
      },
      onRowTap: (row) {
        if (row >= 0 && row < _items.length) {
          setState(() {
            _selectedId = widget.getId(_items[row]);
          });
        }
      },
      onRowDoubleTap: (row) {
        if (row >= 0 && row < _items.length) {
          Navigator.of(context).pop(widget.getId(_items[row]));
        }
      },
      builder: (context, vicinity) {
        if (vicinity.row < 0 || vicinity.row >= _items.length) {
          return ShadTableCell(child: SizedBox());
        }
        final item = _items[vicinity.row];
        final columnName = widget.columns[vicinity.column].name;
        final value = widget.getCellValue(item, columnName);
        return ShadTableCell(child: Text(value));
      },
    );
  }
}
