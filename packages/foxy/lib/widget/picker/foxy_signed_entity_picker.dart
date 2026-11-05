import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/model/picker/signed_entity_source.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Signed-route picker: single input + search button; the dialog routes by
/// the sign of the input value to the matching data source.
///
/// Encoding convention: positive → [positiveSource] (e.g. creatures),
/// negative → [negativeSource] (e.g. game objects). The dialog is a
/// standard paginated table with no type switching. The input shows the
/// encoded value itself (sign included).
class FoxySignedEntityPicker extends StatefulWidget {
  final IntFieldController controller;
  final SignedEntitySource positiveSource;
  final SignedEntitySource negativeSource;
  final String? placeholder;

  const FoxySignedEntityPicker({
    super.key,
    required this.controller,
    required this.positiveSource,
    required this.negativeSource,
    this.placeholder,
  });

  @override
  State<FoxySignedEntityPicker> createState() => _FoxySignedEntityPickerState();
}

class _FoxySignedEntityPickerState extends State<FoxySignedEntityPicker> {
  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: widget.controller.controller,
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
    // The input accepts free text; invalid text makes collect() throw
    // FormatException. Catch it and prompt the user instead of letting the
    // search button silently fail.
    final int currentValue;
    try {
      currentValue = widget.controller.collect();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error(FoxyExceptions.message(error));
      return;
    }
    if (!mounted) return;
    final result = await DialogUtil.show<int>(
      context: context,
      builder: (context) => _SignedEntityDialog(
        positiveSource: widget.positiveSource,
        negativeSource: widget.negativeSource,
        initialValue: currentValue,
      ),
    );
    if (result != null) {
      widget.controller.init(result);
    }
  }
}

class _SignedEntityDialog extends StatefulWidget {
  final SignedEntitySource positiveSource;
  final SignedEntitySource negativeSource;
  final int initialValue;

  const _SignedEntityDialog({
    required this.positiveSource,
    required this.negativeSource,
    required this.initialValue,
  });

  @override
  State<_SignedEntityDialog> createState() => _SignedEntityDialogState();
}

class _SignedEntityDialogState extends State<_SignedEntityDialog> {
  late final TextEditingController _idController;
  late final TextEditingController _nameController;

  /// Current data source and its encoding direction; positive sources
  /// encode positive, negative sources negative.
  late SignedEntitySource _source;
  late bool _isPositive;
  int _page = 1;
  int _queryVersion = 0;
  List<SignedEntityBrief> _items = [];
  int _total = 0;
  int? _selectedId;

  /// Whether the user actively clicked a row. Preselected values (an ID
  /// already in the input on open) are not highlighted, consistent with
  /// FoxyEntityPicker and other tables; only user-clicked rows get the
  /// selected background.
  bool _userSelected = false;

  /// Request sequence: under concurrent searches only the latest result is
  /// accepted, so a slow request never overwrites a fast one.
  int _searchSeq = 0;
  String? _errorMessage;

  bool get _hasSelection => _items.any((item) => item.id == _selectedId);

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: Text(_source.title),
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
              child: const Text('取消'),
            ),
            ShadButton(
              enabled: _hasSelection,
              onPressed: _confirm,
              child: const Text('确定'),
            ),
          ],
        ),
      ],
      actionsMainAxisAlignment: MainAxisAlignment.spaceBetween,
      actionsMainAxisSize: MainAxisSize.max,
      constraints: DialogUtil.constraints(context),
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
    _idController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _nameController = TextEditingController();
    _isPositive = widget.initialValue >= 0;
    _source = _isPositive ? widget.positiveSource : widget.negativeSource;
    if (widget.initialValue != 0) {
      _idController.text = widget.initialValue.abs().toString();
      _selectedId = widget.initialValue.abs();
    }
    _search();
  }

  /// Encoded value on confirm: positive sources backfill a positive ID,
  /// negative sources a negative ID.
  void _confirm() {
    if (!_hasSelection) return;
    final id = _selectedId!;
    Navigator.of(context).pop(_isPositive ? id : -id);
  }

  Widget _buildFilter() {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 8,
        children: [
          Expanded(
            child: ShadInput(
              controller: _idController,
              placeholder: const Text('编号'),
            ),
          ),
          Expanded(
            child: ShadInput(
              controller: _nameController,
              placeholder: const Text('名称'),
            ),
          ),
          Expanded(
            child: Row(
              spacing: 8,
              children: [
                ShadButton(
                  onPressed: _doSearch,
                  size: ShadButtonSize.sm,
                  child: const Text('查询'),
                ),
                ShadButton.ghost(
                  onPressed: _reset,
                  size: ShadButtonSize.sm,
                  child: const Text('重置'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    final screenHeight = MediaQuery.of(context).size.height;
    final tableMaxHeight = screenHeight * 0.5;
    if (_items.isEmpty) {
      return Center(
        child: SizedBox(
          height: tableMaxHeight,
          child: const Center(child: Text('无匹配数据')),
        ),
      );
    }
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: tableMaxHeight),
      child: FoxyDataTable<SignedEntityBrief>(
        queryVersion: _queryVersion,
        pinnedRowCount: 1,
        rows: _items,
        keyOf: (row) => row.id,
        selectedKey: _userSelected ? _selectedId : null,
        onRowTap: (row) {
          setState(() {
            _selectedId = row.id;
            _userSelected = true;
          });
        },
        onRowDoubleTap: (row) {
          _selectedId = row.id;
          _confirm();
        },
        columns: [
          FoxyTableColumn.fixed(
            label: '编号',
            width: 120,
            cell: (_, row) => Text(row.id.toString()),
          ),
          FoxyTableColumn.flex(
            label: '名称',
            cell: (_, row) =>
                Text(row.name, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  void _doSearch() {
    _page = 1;
    _queryVersion++;
    _search();
  }

  void _paginate(int page) {
    _page = page;
    _queryVersion++;
    _search();
  }

  void _reset() {
    _idController.clear();
    _nameController.clear();
    _page = 1;
    _queryVersion++;
    _search();
  }

  Future<void> _search() async {
    final seq = ++_searchSeq;
    setState(() => _items = []);
    try {
      final result = await _source.fetch(
        _page,
        _idController.text,
        _nameController.text,
      );
      final count = await _source.count(
        _idController.text,
        _nameController.text,
      );
      if (!mounted || seq != _searchSeq) return;
      setState(() {
        _items = result;
        _total = count;
        _errorMessage = null;
        if (!_hasSelection) {
          _selectedId = null;
          _userSelected = false;
        }
      });
    } catch (e) {
      LoggerUtil.instance.e('${_source.errorLabel}: $e');
      if (!mounted || seq != _searchSeq) return;
      setState(() {
        _selectedId = null;
        _userSelected = false;
        _errorMessage = '${_source.errorLabel}: ${FoxyExceptions.message(e)}';
      });
    }
  }
}
