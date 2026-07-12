import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 格式化标志位整数值为显示文本，如 "123 (0x0000007B)"。
String formatFlagValue(int value) {
  final hex = value.toRadixString(16).toUpperCase().padLeft(8, '0');
  return '$value (0x$hex)';
}

/// 将 [formatFlagValue] 产生的显示文本解析回 int。
///
/// [controller] 存储格式化文本（如 "123 (0x0000007B)"），VM 在 save 时
/// 用此函数读取原始值，与 [FoxyEntityPicker]/[FoxyNumberInput] 的
/// controller-only 契约一致。
int parseFlagValue(String text) {
  return int.tryParse(text.split(' ').first) ?? 0;
}

/// 标志位选择器：显示已格式化的值，点击输入框或尾部按钮打开编辑弹窗。
///
/// 这是可交互的编辑入口，**不**使用 [FoxyReadonlyInput] 的 muted/禁用外观。
/// `ShadInput.readOnly` 仅用于禁止手改 `"123 (0x…)"` 格式串，编辑一律走弹窗。
///
/// [controller] 的文本由调用方在初始化时设置（通过 [formatFlagValue]），
/// 弹窗确认后组件自动写回 [controller]（格式化文本）。VM 在 save 时
/// 用 [parseFlagValue] 从 controller 文本读取原始 int 值。
///
/// 与 [FoxyEntityPicker]/[FoxyNumberInput] 对齐：纯 controller 模式，
/// 无 onChanged 双向绑定。
class FoxyFlagPicker extends StatefulWidget {
  final TextEditingController controller;
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
        controller: widget.controller,
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

  int get _currentValue {
    final text = widget.controller.text;
    return int.tryParse(text.split(' ').first) ?? 0;
  }

  Future<void> _openDialog() async {
    final result = await showShadDialog<int>(
      opaque: false,
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
      widget.controller.text = formatFlagValue(result);
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
