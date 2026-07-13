import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 标志位选择器：显示已格式化的值，点击输入框或尾部按钮打开编辑弹窗。
///
/// 这是可交互的编辑入口，**不**使用 [FoxyReadonlyInput] 的 muted/禁用外观。
/// `ShadInput.readOnly` 仅用于禁止手改 `"123 (0x…)"` 格式串，编辑一律走弹窗。
///
/// [controller] 由 ViewModel 初始化（[FlagFieldController.init]）；
/// 弹窗确认后写回格式化文本。VM 在 save 时用 [FlagFieldController.collect] 读取。
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

class _FoxyFlagPickerState extends State<FoxyFlagPicker> {
  @override
  Widget build(BuildContext context) {
    // 外观与可编辑输入框一致；外侧 MouseRegion 保证手型光标
    // （readOnly 时 ShadInput 内部 AbsorbPointer 会使 mouseCursor 失效）。
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

  int get _currentValue => widget.controller.collect();

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
