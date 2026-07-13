import 'package:flutter/material.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_input_readonly.dart';
import 'package:foxy/widget/foxy_shad_table.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 一个筛选输入框（输入编号）。
class FoxyEntityPickerFilter {
  final String placeholder;
  const FoxyEntityPickerFilter(this.placeholder);
}

/// 表格的一列。[width] 为 null 表示弹性列（与其他弹性列均分剩余宽度）。
/// 普通列用 [text]；需要自定义样式（如带颜色）的列用 [cell]，二者提供其一。
class FoxyEntityPickerColumn<T> {
  final String header;
  final String Function(T)? text;
  final Widget Function(T)? cell;
  final double? width;
  const FoxyEntityPickerColumn({
    required this.header,
    this.text,
    this.cell,
    this.width,
  }) : assert(text != null || cell != null, 'text 或 cell 至少提供一个');
}

/// 每个实体提供的查询/渲染配置。纯数据 + 闭包，不持有可变状态，
/// 因此同一实例可被多个 [FoxyEntityPicker] 共享。
class FoxyEntityPickerDelegate<T> {
  final String title;
  final String errorLabel;
  final List<FoxyEntityPickerFilter> filters;
  final List<FoxyEntityPickerColumn<T>> columns;
  final int Function(T) idOf;
  final Future<List<T>> Function(int page, List<String> values) fetch;
  final Future<int> Function(List<String> values) count;
  final String? emptyText;

  const FoxyEntityPickerDelegate({
    required this.title,
    required this.errorLabel,
    required this.filters,
    required this.columns,
    required this.idOf,
    required this.fetch,
    required this.count,
    this.emptyText,
  });
}

/// 通过值查库挑记录的表单字段：ShadInput + 搜索按钮，点击打开分页查询弹窗，
/// 双击行或确定回填选中 id。状态完全由弹窗内部 setState 管理，无 signals。
class FoxyEntityPicker<T> extends StatefulWidget {
  final IntFieldController controller;
  final FoxyEntityPickerDelegate<T> delegate;
  final String? placeholder;
  final bool readOnly;

  const FoxyEntityPicker({
    super.key,
    required this.controller,
    required this.delegate,
    this.placeholder,
    this.readOnly = false,
  });

  @override
  State<FoxyEntityPicker<T>> createState() => _FoxyEntityPickerState<T>();
}

class _FoxyEntityPickerState<T> extends State<FoxyEntityPicker<T>> {
  Future<void> _openDialog() async {
    if (widget.readOnly) return;
    final currentId = widget.controller.collect();
    if (!mounted) return;
    final result = await showFoxyDialog<int>(
      context: context,
      builder: (context) => _EntityPickerDialog<T>(
        delegate: widget.delegate,
        initialValue: currentId,
      ),
    );
    if (result != null) {
      widget.controller.init(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 可编辑时用户可手改 ID；只读时为纯展示（无搜索按钮）。
    final readonly = FoxyReadonlyInput.resolve(
      context,
      readOnly: widget.readOnly,
    );
    return readonly.wrap(
      ShadInput(
        controller: widget.controller.controller,
        placeholder: Text(widget.placeholder ?? ''),
        readOnly: widget.readOnly,
        style: readonly.style,
        decoration: readonly.decoration,
        mouseCursor: readonly.mouseCursor,
        showCursor: readonly.showCursor,
        trailing: widget.readOnly
            ? null
            : ShadButton.ghost(
                height: 20,
                width: 20,
                padding: EdgeInsets.zero,
                onPressed: _openDialog,
                child: Icon(LucideIcons.search, size: 12),
              ),
      ),
    );
  }
}

class _EntityPickerDialog<T> extends StatefulWidget {
  final FoxyEntityPickerDelegate<T> delegate;
  final int initialValue;

  const _EntityPickerDialog({
    required this.delegate,
    required this.initialValue,
  });

  @override
  State<_EntityPickerDialog<T>> createState() => _EntityPickerDialogState<T>();
}

class _EntityPickerDialogState<T> extends State<_EntityPickerDialog<T>> {
  late final List<TextEditingController> _filterControllers;
  int _page = 1;
  List<T> _items = [];
  int _total = 0;
  int? _selectedId;

  @override
  void initState() {
    super.initState();
    _filterControllers = widget.delegate.filters
        .map((_) => TextEditingController())
        .toList();
    if (widget.initialValue != 0 && _filterControllers.isNotEmpty) {
      _filterControllers.first.text = widget.initialValue.toString();
      _selectedId = widget.initialValue;
    }
    _search();
  }

  @override
  void dispose() {
    for (final c in _filterControllers) {
      c.dispose();
    }
    super.dispose();
  }

  List<String> get _filterValues =>
      _filterControllers.map((c) => c.text).toList();

  Future<void> _search() async {
    final values = _filterValues;
    try {
      final result = await widget.delegate.fetch(_page, values);
      final count = await widget.delegate.count(values);
      if (!mounted) return;
      setState(() {
        _items = result;
        _total = count;
      });
    } catch (e) {
      LoggerUtil.instance.e('${widget.delegate.errorLabel}: $e');
      DialogUtil.instance.error('${widget.delegate.errorLabel}: $e');
    }
  }

  void _doSearch() {
    _page = 1;
    _search();
  }

  void _paginate(int p) {
    _page = p;
    _search();
  }

  void _reset() {
    for (final c in _filterControllers) {
      c.clear();
    }
    _page = 1;
    _search();
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: Text(widget.delegate.title),
      actions: [
        FoxyPagination(
          page: _page,
          pageSize: 50,
          total: _total,
          onChange: _paginate,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            ShadButton.outline(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('取消'),
            ),
            ShadButton(
              onPressed: () => Navigator.of(context).pop(_selectedId),
              child: Text('确定'),
            ),
          ],
        ),
      ],
      actionsMainAxisAlignment: MainAxisAlignment.spaceBetween,
      actionsMainAxisSize: MainAxisSize.max,
      constraints: const BoxConstraints(maxWidth: 720),
      child: Column(spacing: 8, children: [_buildFilter(), _buildTable()]),
    );
  }

  Widget _buildFilter() {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 8,
        children: [
          for (int i = 0; i < _filterControllers.length; i++)
            Expanded(
              child: ShadInput(
                controller: _filterControllers[i],
                placeholder: Text(widget.delegate.filters[i].placeholder),
              ),
            ),
          Expanded(
            child: Row(
              spacing: 8,
              children: [
                ShadButton(
                  onPressed: _doSearch,
                  size: ShadButtonSize.sm,
                  child: Text('查询'),
                ),
                ShadButton.ghost(
                  onPressed: _reset,
                  size: ShadButtonSize.sm,
                  child: Text('重置'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    final theme = ShadTheme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final tableMaxHeight = screenHeight * 0.5;
    final columns = widget.delegate.columns;
    final flexCount = columns.where((c) => c.width == null).length;
    final fixedWidthSum = columns
        .where((c) => c.width != null)
        .fold<double>(0, (sum, c) => sum + c.width!);

    if (_items.isEmpty && widget.delegate.emptyText != null) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: tableMaxHeight),
        child: Center(child: Text(widget.delegate.emptyText!)),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: tableMaxHeight),
      child: LayoutBuilder(
        builder: (context, constraints) {
          var flexWidth = flexCount > 0
              ? (constraints.maxWidth - fixedWidthSum) / flexCount
              : 0.0;
          if (flexWidth < 0) flexWidth = 0;
          return FoxyShadTable(
            columnCount: columns.length,
            rowCount: _items.length,
            pinnedRowCount: 1,
            header: (context, column) =>
                ShadTableCell.header(child: Text(columns[column].header)),
            columnSpanExtent: (column) {
              final w = columns[column].width;
              return FixedTableSpanExtent(w ?? flexWidth);
            },
            rowSpanBackgroundDecoration: (row) {
              final dataRow = row - 1;
              if (dataRow < 0 || dataRow >= _items.length) return null;
              if (widget.delegate.idOf(_items[dataRow]) == _selectedId) {
                return TableSpanDecoration(color: theme.colorScheme.accent);
              }
              return null;
            },
            onRowTap: (row) {
              if (row >= 0 && row < _items.length) {
                setState(() => _selectedId = widget.delegate.idOf(_items[row]));
              }
            },
            onRowDoubleTap: (row) {
              if (row >= 0 && row < _items.length) {
                Navigator.of(context).pop(widget.delegate.idOf(_items[row]));
              }
            },
            builder: (context, vicinity) {
              if (vicinity.row < 0 || vicinity.row >= _items.length) {
                return ShadTableCell(child: SizedBox());
              }
              final item = _items[vicinity.row];
              final col = columns[vicinity.column];
              final isFlex = col.width == null;
              Widget cellWidget;
              if (col.cell != null) {
                cellWidget = col.cell!(item);
              } else if (isFlex) {
                cellWidget = Text(
                  col.text!(item),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                );
              } else {
                cellWidget = Text(col.text!(item));
              }
              return ShadTableCell(child: cellWidget);
            },
          );
        },
      ),
    );
  }
}
