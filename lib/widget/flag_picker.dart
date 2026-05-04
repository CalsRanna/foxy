import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class FlagPicker extends StatefulWidget {
  final Signal<int> signal;
  final List<FlagItem> flags;
  final String title;
  final String? placeholder;

  const FlagPicker({
    super.key,
    required this.signal,
    required this.flags,
    required this.title,
    this.placeholder,
  });

  @override
  State<FlagPicker> createState() => _FlagPickerState();
}

class _FlagPickerState extends State<FlagPicker> {
  late final TextEditingController _displayController;
  bool _isInternal = false;

  @override
  void initState() {
    super.initState();
    _displayController = TextEditingController(text: _format(widget.signal.value));
    widget.signal.subscribe(_onSignalChanged);
  }

  @override
  void didUpdateWidget(FlagPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isInternal) return;
    if (widget.signal.value != oldWidget.signal.value) {
      _displayController.text = _format(widget.signal.value);
    }
  }

  @override
  void dispose() {
    _displayController.dispose();
    super.dispose();
  }

  void _onSignalChanged(int _) {
    if (_isInternal) return;
    _displayController.text = _format(widget.signal.value);
  }

  String _format(int value) {
    final hex = value.toRadixString(16).toUpperCase().padLeft(8, '0');
    return '$value (0x$hex)';
  }

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: _displayController,
      placeholder: Text(widget.placeholder ?? ''),
      readOnly: true,
      trailing: ShadButton.ghost(
        height: 20,
        width: 20,
        padding: EdgeInsets.zero,
        onPressed: _openDialog,
        child: Icon(LucideIcons.settings2, size: 12),
      ),
    );
  }

  Future<void> _openDialog() async {
    final result = await showShadDialog<int>(
      context: context,
      builder: (context) {
        return _FlagPickerDialog(
          title: widget.title,
          flags: widget.flags,
          initialValue: widget.signal.value,
        );
      },
    );
    if (result != null) {
      _isInternal = true;
      widget.signal.value = result;
      _isInternal = false;
    }
  }
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

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

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
    final screenHeight = MediaQuery.of(context).size.height;
    final tableMaxHeight = screenHeight * 0.6;
    final flags = widget.flags;

    return ShadDialog(
      constraints: BoxConstraints(maxWidth: 720),
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
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: tableMaxHeight),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            var width = maxWidth - 280;
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
                  2 => FixedTableSpanExtent(width),
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

  void _toggleFlag(int flag) {
    setState(() {
      if ((_currentValue & flag) != 0) {
        _currentValue &= ~flag;
      } else {
        _currentValue |= flag;
      }
    });
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
}
