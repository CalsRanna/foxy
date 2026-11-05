import 'package:flutter/material.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Selects one predefined value in a searchable dialog.
/// Only confirmation writes the dialog's selection back to [controller].
class FoxyEnumPicker<T> extends StatefulWidget {
  final EnumFieldController<T> controller;
  final Map<T, String> options;
  final String title;
  final String? placeholder;

  const FoxyEnumPicker({
    super.key,
    required this.controller,
    required this.options,
    required this.title,
    this.placeholder,
  });

  @override
  State<FoxyEnumPicker<T>> createState() => _FoxyEnumPickerState<T>();
}

class _FoxyEnumPickerState<T> extends State<FoxyEnumPicker<T>> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _dialogOpen = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_syncText);
    _syncText();
  }

  @override
  void didUpdateWidget(FoxyEnumPicker<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_syncText);
      widget.controller.addListener(_syncText);
    }
    _syncText();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_syncText);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _syncText() {
    final value = widget.controller.controller.value;
    _textController.text = value == null
        ? ''
        : widget.options[value] ?? value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ShadInput(
        controller: _textController,
        focusNode: _focusNode,
        placeholder: Text(widget.placeholder ?? ''),
        readOnly: true,
        showCursor: false,
        enableInteractiveSelection: false,
        onPressed: _openDialog,
        trailing: ShadButton.ghost(
          height: 20,
          width: 20,
          padding: EdgeInsets.zero,
          onPressed: _openDialog,
          child: const Icon(LucideIcons.list, size: 12),
        ),
      ),
    );
  }

  Future<void> _openDialog() async {
    if (_dialogOpen) return;
    _dialogOpen = true;
    final result = await DialogUtil.show<T>(
      context: context,
      builder: (context) => _EnumPickerDialog<T>(
        title: widget.title,
        options: widget.options,
        initialValue: widget.controller.controller.value,
      ),
    );
    if (!mounted) return;
    _dialogOpen = false;
    if (result != null) widget.controller.init(result);
    _focusNode.requestFocus();
  }
}

class _EnumPickerDialog<T> extends StatefulWidget {
  final String title;
  final Map<T, String> options;
  final T? initialValue;

  const _EnumPickerDialog({
    required this.title,
    required this.options,
    required this.initialValue,
  });

  @override
  State<_EnumPickerDialog<T>> createState() => _EnumPickerDialogState<T>();
}

class _EnumPickerDialogState<T> extends State<_EnumPickerDialog<T>> {
  final _selectionController = ShadRadioController<T>();
  late List<MapEntry<T, String>> _rows;
  int _queryVersion = 0;

  T? get _selectedValue => _selectionController.value;

  bool get _hasSelection => _rows.any((row) => row.key == _selectedValue);

  @override
  void initState() {
    super.initState();
    _rows = widget.options.entries.toList();
    if (widget.options.containsKey(widget.initialValue)) {
      _selectionController.value = widget.initialValue;
    }
    _selectionController.addListener(_onSelectionChanged);
  }

  @override
  void dispose() {
    _selectionController.dispose();
    super.dispose();
  }

  void _onSelectionChanged() => setState(() {});

  void _search(String query) {
    final q = query.trim().toLowerCase();
    setState(() {
      _rows = widget.options.entries
          .where(
            (entry) =>
                entry.key.toString().toLowerCase().contains(q) ||
                entry.value.toLowerCase().contains(q),
          )
          .toList();
      _queryVersion++;
    });
    if (!_hasSelection) _selectionController.value = null;
  }

  void _confirm() {
    if (_hasSelection) {
      Navigator.of(context).pop(_selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final initial = widget.initialValue;
    final currentText = initial == null
        ? '未选择'
        : widget.options.containsKey(initial)
        ? '${widget.options[initial]} ($initial)'
        : initial.toString();
    return ShadDialog(
      title: Text(widget.title),
      description: Text('当前值: $currentText'),
      scrollable: false,
      constraints: DialogUtil.constraints(context),
      actions: [
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          ShadInput(
            autofocus: true,
            placeholder: const Text('搜索名称或值'),
            onChanged: _search,
          ),
          Flexible(
            child: _rows.isEmpty
                ? const Center(child: Text('无匹配选项'))
                : FoxyDataTable<MapEntry<T, String>>(
                    rows: _rows,
                    pinnedRowCount: 1,
                    queryVersion: _queryVersion,
                    onRowTap: (row) => _selectionController.value = row.key,
                    onRowDoubleTap: (row) => Navigator.of(context).pop(row.key),
                    columns: [
                      FoxyTableColumn.fixed(
                        label: '',
                        width: 120,
                        cell: (_, row) => ShadRadioGroup<T>(
                          controller: _selectionController,
                          items: [ShadRadio<T>(value: row.key)],
                        ),
                      ),
                      FoxyTableColumn.fixed(
                        label: '值',
                        width: 120,
                        cell: (_, row) => Text(row.key.toString()),
                      ),
                      FoxyTableColumn.flex(
                        label: '名称',
                        cell: (_, row) => Tooltip(
                          message: row.value,
                          child: Text(
                            row.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
