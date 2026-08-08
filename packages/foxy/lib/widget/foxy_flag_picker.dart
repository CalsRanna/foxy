import 'package:flutter/material.dart';
import 'package:foxy/constant/flag_item.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_data_table.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Flag picker: shows the formatted value; clicking the input or the
/// trailing button opens the edit dialog.
///
/// This is an interactive edit entry and does **not** use
/// [FoxyReadonlyInput]'s muted/disabled look. `ShadInput.readOnly` only
/// prevents hand-editing the `"123 (0x…)"` format string; all editing goes
/// through the dialog.
///
/// [controller] is initialized by the ViewModel
/// ([FlagFieldController.init]); after the dialog confirms, the formatted
/// text is written back. The VM reads it with
/// [FlagFieldController.collect] on save.
class FoxyFlagPicker extends StatefulWidget {
  final TextBackedFieldController<int> controller;
  final List<FlagItem> flags;
  final String title;
  final String? placeholder;

  const FoxyFlagPicker({
    super.key,
    required this.controller,
    required this.flags,
    required this.title,
    this.placeholder,
  });

  @override
  State<FoxyFlagPicker> createState() => _FoxyFlagPickerState();
}

class _FlagPickerDialog extends StatefulWidget {
  final String title;
  final List<FlagItem> flags;
  final int initialValue;

  const _FlagPickerDialog({
    required this.title,
    required this.flags,
    required this.initialValue,
  });

  @override
  State<_FlagPickerDialog> createState() => _FlagPickerDialogState();
}

class _FlagPickerDialogState extends State<_FlagPickerDialog> {
  late int _currentValue;

  String get _displayValue {
    final hex = _currentValue.toRadixString(16).toUpperCase().padLeft(8, '0');
    return '$_currentValue (0x$hex)';
  }

  int get _selectedCount {
    int count = 0;
    for (var flag in widget.flags) {
      if ((_currentValue & flag.value) != 0) count++;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final flags = widget.flags;

    return ShadDialog(
      scrollable: false,
      constraints: foxyDialogConstraints(context),
      title: Text(widget.title),
      description: Text('当前值: $_displayValue  |  已选: $_selectedCount 项'),
      actions: [
        ShadButton.outline(
          size: ShadButtonSize.sm,
          onPressed: _selectedCount == flags.length ? _selectNone : _selectAll,
          child: Text(_selectedCount == flags.length ? '清空' : '全选'),
        ),
        const Spacer(),
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('取消'),
        ),
        ShadButton(
          onPressed: () => Navigator.of(context).pop(_currentValue),
          child: Text('确定'),
        ),
      ],
      // ShadDialog already wraps its child in a BoxyColumn + Flexible
      // (shadcn_ui dialog.dart), so no extra Flexible here: a nested
      // Flutter Flexible would compete for the same FlexParentData.
      child: FoxyDataTable<FlagItem>(
        pinnedRowCount: 1,
        rows: flags,
        onRowTap: (flag) => _toggleFlag(flag.value),
        columns: [
          FoxyTableColumn.fixed(
            label: '',
            width: 120,
            cell: (_, flag) => ShadCheckbox(
              value: (_currentValue & flag.value) != 0,
              onChanged: (_) => _toggleFlag(flag.value),
            ),
          ),
          FoxyTableColumn.fixed(
            label: '标志值',
            width: 160,
            cell: (_, flag) => Text(
              '0x${flag.value.toRadixString(16).toUpperCase().padLeft(8, '0')}',
            ),
          ),
          FoxyTableColumn.flex(
            label: '名称',
            cell: (_, flag) => Text(flag.label),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  void _selectAll() {
    setState(() {
      for (var flag in widget.flags) {
        _currentValue |= flag.value;
      }
    });
  }

  void _selectNone() {
    setState(() {
      _currentValue = 0;
    });
  }

  void _toggleFlag(int flag) {
    setState(() {
      if ((_currentValue & flag) != 0) {
        _currentValue &= ~flag;
      } else {
        _currentValue |= flag;
      }
    });
  }
}

class _FoxyFlagPickerState extends State<FoxyFlagPicker> {
  int get _currentValue => widget.controller.collect();

  @override
  Widget build(BuildContext context) {
    // Look matches the editable input; the outer MouseRegion guarantees the
    // hand cursor (with readOnly, ShadInput's internal AbsorbPointer kills
    // mouseCursor).
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ShadInput(
        controller: widget.controller.controller,
        placeholder: Text(widget.placeholder ?? ''),
        readOnly: true,
        showCursor: false,
        onPressed: _openDialog,
        trailing: ShadButton.ghost(
          height: 20,
          width: 20,
          padding: EdgeInsets.zero,
          onPressed: _openDialog,
          child: Icon(LucideIcons.settings2, size: 12),
        ),
      ),
    );
  }

  Future<void> _openDialog() async {
    final result = await showFoxyDialog<int>(
      context: context,
      builder: (context) {
        return _FlagPickerDialog(
          title: widget.title,
          flags: widget.flags,
          initialValue: _currentValue,
        );
      },
    );
    if (result != null) {
      widget.controller.init(result);
    }
  }
}
