import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:foxy/widget/foxy_input_readonly.dart';
import 'package:foxy/widget/foxy_pagination.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Form field that queries the database by value to pick a record:
/// ShadInput + search button; clicking opens a paginated query dialog, and
/// double-clicking a row (or pressing confirm) backfills the selected id.
/// State is fully managed by the dialog's internal setState, no signals.
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

/// One column of the table. A null [width] means a flexible column
/// (sharing the remaining width with other flexible columns). Use [text]
/// for plain columns or [cell] for custom-styled ones (e.g. colored);
/// provide exactly one of the two.
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

/// Query/render config provided per entity. Pure data + closures, holding
/// no mutable state, so one instance can be shared by multiple
/// [FoxyEntityPicker]s.
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

/// A filter input (for the ID).
class FoxyEntityPickerFilter {
  final String placeholder;
  const FoxyEntityPickerFilter(this.placeholder);
}

class _EntityPickerDialog<T> extends StatefulWidget {
  final FoxyEntityPickerDelegate<T> delegate;
  final int initialValue;

  _EntityPickerDialog({required this.delegate, required this.initialValue})
    : assert(
        delegate.filters.length <= 3,
        'FoxyEntityPickerDelegate.filters 最多支持 3 个筛选条件',
      );

  @override
  State<_EntityPickerDialog<T>> createState() => _EntityPickerDialogState<T>();
}

class _EntityPickerDialogState<T> extends State<_EntityPickerDialog<T>> {
  late final List<TextEditingController> _filterControllers;
  int _page = 1;
  int _queryVersion = 0;
  List<T> _items = [];
  int _total = 0;
  int? _selectedId;
  String? _errorMessage;

  /// Whether the user actively clicked a row. Preselected values (an ID
  /// already in the input on open) are not highlighted, consistent with
  /// other tables; only user-clicked rows get the selected background.
  bool _userSelected = false;

  /// Request sequence: under concurrent searches only the latest result is
  /// accepted, so a slow request never overwrites a fast one.
  int _searchSeq = 0;

  List<String> get _filterValues =>
      _filterControllers.map((c) => c.text).toList();

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: Text(widget.delegate.title),
      scrollable: false,
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
      constraints: foxyDialogConstraints(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          FoxyInlineError(message: _errorMessage),
          _buildFilter(),
          Flexible(child: _buildTable()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (final c in _filterControllers) {
      c.dispose();
    }
    super.dispose();
  }

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

  Widget _buildFilter() {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 16,
        children: [
          for (int i = 0; i < _filterControllers.length; i++)
            Expanded(
              child: ShadInput(
                controller: _filterControllers[i],
                placeholder: Text(widget.delegate.filters[i].placeholder),
              ),
            ),
          Expanded(
            flex: 4 - _filterControllers.length,
            child: Row(
              spacing: 16,
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
    final columns = widget.delegate.columns;
    if (_items.isEmpty && widget.delegate.emptyText != null) {
      return Center(child: Text(widget.delegate.emptyText!));
    }

    return FoxyDataTable<T>(
      queryVersion: _queryVersion,
      pinnedRowCount: 1,
      rows: _items,
      keyOf: widget.delegate.idOf,
      selectedKey: _userSelected ? _selectedId : null,
      onRowTap: (item) {
        setState(() {
          _selectedId = widget.delegate.idOf(item);
          _userSelected = true;
        });
      },
      onRowDoubleTap: (item) =>
          Navigator.of(context).pop(widget.delegate.idOf(item)),
      columns: [
        for (final col in columns)
          if (col.width != null)
            FoxyTableColumn<T>.fixed(
              label: col.header,
              width: col.width!,
              cell: (context, item) => _columnCell(col, item, flex: false),
            )
          else
            FoxyTableColumn<T>.flex(
              label: col.header,
              cell: (context, item) => _columnCell(col, item, flex: true),
            ),
      ],
    );
  }

  Widget _columnCell(
    FoxyEntityPickerColumn<T> col,
    T item, {
    required bool flex,
  }) {
    if (col.cell != null) return col.cell!(item);
    final text = col.text!(item);
    return flex
        ? Text(text, maxLines: 1, overflow: TextOverflow.ellipsis)
        : Text(text);
  }

  void _doSearch() {
    _page = 1;
    _queryVersion++;
    _search();
  }

  void _paginate(int p) {
    _page = p;
    _queryVersion++;
    _search();
  }

  void _reset() {
    for (final c in _filterControllers) {
      c.clear();
    }
    _page = 1;
    _queryVersion++;
    _search();
  }

  Future<void> _search() async {
    final values = _filterValues;
    final seq = ++_searchSeq;
    try {
      final result = await widget.delegate.fetch(_page, values);
      final count = await widget.delegate.count(values);
      if (!mounted || seq != _searchSeq) return;
      setState(() {
        _items = result;
        _total = count;
        _errorMessage = null; // a successful search clears the previous error
      });
    } catch (e) {
      LoggerUtil.instance.e('${widget.delegate.errorLabel}: $e');
      if (!mounted || seq != _searchSeq) return;
      // The UI only shows user copy mapped by foxyErrorMessage; raw
      // exception strings go to the log.
      setState(
        () => _errorMessage =
            '${widget.delegate.errorLabel}: ${foxyErrorMessage(e)}',
      );
    }
  }
}

class _FoxyEntityPickerState<T> extends State<FoxyEntityPicker<T>> {
  @override
  Widget build(BuildContext context) {
    // Editable: the user may type an ID; read-only: pure display (no
    // search button).
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

  Future<void> _openDialog() async {
    if (widget.readOnly) return;
    // The input accepts free text; invalid text makes collect() throw
    // FormatException. Catch it and prompt the user instead of letting the
    // search button silently fail.
    final int currentId;
    try {
      currentId = widget.controller.collect();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error(foxyErrorMessage(error));
      return;
    }
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
}
