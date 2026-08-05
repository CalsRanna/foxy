import 'package:flutter/material.dart';
import 'package:foxy/constant/flag_item.dart';
import 'package:foxy/infrastructure/util/table_layout_util.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
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
      child: Flexible(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Flexible column-width scheme: fixed columns 120+160, the
            // remaining width goes to the name column.
            const fixedWidthSum = 120.0 + 160.0;
            final flexWidth = flexColumnWidth(
              constraints.maxWidth,
              fixedWidthSum,
            );
            return ShadTable(
              columnCount: 3,
              rowCount: flags.length,
              pinnedRowCount: 1,
              header: (context, column) {
                return switch (column) {
                  0 => ShadTableCell.header(child: SizedBox()),
                  1 => ShadTableCell.header(child: Text('标志值')),
                  2 => ShadTableCell.header(child: Text('名称')),
                  _ => ShadTableCell.header(child: SizedBox()),
                };
              },
              columnSpanExtent: (column) {
                return switch (column) {
                  0 => FixedTableSpanExtent(120),
                  1 => FixedTableSpanExtent(160),
                  2 => FixedTableSpanExtent(flexWidth),
                  _ => null,
                };
              },
              onRowTap: (row) {
                final dataRow = row - 1;
                if (dataRow >= 0 && dataRow < flags.length) {
                  _toggleFlag(flags[dataRow].value);
                }
              },
              builder: (context, vicinity) {
                if (vicinity.row < 0 || vicinity.row >= flags.length) {
                  return ShadTableCell(child: SizedBox());
                }
                final flag = flags[vicinity.row];
                final isSelected = (_currentValue & flag.value) != 0;
                final hexValue =
                    '0x${flag.value.toRadixString(16).toUpperCase().padLeft(8, '0')}';

                return switch (vicinity.column) {
                  0 => ShadTableCell(
                    child: ShadCheckbox(
                      value: isSelected,
                      onChanged: (_) => _toggleFlag(flag.value),
                    ),
                  ),
                  1 => ShadTableCell(child: Text(hexValue)),
                  2 => ShadTableCell(child: Text(flag.label)),
                  _ => ShadTableCell(child: SizedBox()),
                };
              },
            );
          },
        ),
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
