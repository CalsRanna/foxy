import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 标志位选择器组件
class FlagPicker extends StatefulWidget {
  /// 控制器，存储整数值（字符串形式）
  final TextEditingController controller;

  /// 标志位选项列表
  final List<FlagItem> flags;

  /// 标题（用于弹窗标题）
  final String title;

  /// 占位符
  final String? placeholder;

  const FlagPicker({
    super.key,
    required this.controller,
    required this.flags,
    required this.title,
    this.placeholder,
  });

  @override
  State<FlagPicker> createState() => _FlagPickerState();
}

class _FlagPickerState extends State<FlagPicker> {
  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: widget.controller,
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
    final currentValue = int.tryParse(widget.controller.text) ?? 0;
    final result = await showShadDialog<int>(
      context: context,
      builder: (context) {
        return _FlagPickerDialog(
          title: widget.title,
          flags: widget.flags,
          initialValue: currentValue,
        );
      },
    );
    if (result != null) {
      widget.controller.text = result.toString();
    }
  }
}

/// 标志位选择弹窗
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
  final _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<FlagItem> get _filteredFlags {
    if (_searchText.isEmpty) return widget.flags;
    return widget.flags.where((flag) {
      return flag.label.toLowerCase().contains(_searchText) ||
          flag.value.toRadixString(16).contains(_searchText);
    }).toList();
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
    final theme = ShadTheme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final maxHeight = screenHeight * 0.7;
    // 计算表格区域的高度：总高度 - 标题区域(约80) - 搜索框(约60) - 底部按钮(约60) - padding
    final tableHeight = maxHeight - 200;
    final flags = _filteredFlags;

    return ShadDialog(
      title: Text(widget.title),
      description: Text('当前值: $_displayValue  |  已选: $_selectedCount 项'),
      constraints: BoxConstraints(maxWidth: 560, maxHeight: maxHeight),
      actions: [
        ShadButton.outline(
          size: ShadButtonSize.sm,
          onPressed: _selectAll,
          child: Text('全选'),
        ),
        ShadButton.outline(
          size: ShadButtonSize.sm,
          onPressed: _selectNone,
          child: Text('清空'),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 搜索框
          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: ShadInput(
              controller: _searchController,
              placeholder: Text('搜索标志位...'),
              leading: Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(LucideIcons.search, size: 16),
              ),
            ),
          ),
          // 标志位表格 - 使用 SizedBox 提供明确的高度约束
          SizedBox(
            height: tableHeight,
            child: ShadTable(
              columnCount: 3,
              rowCount: flags.length,
              pinnedRowCount: 1,
              header: (context, column) {
                return switch (column) {
                  0 => ShadTableCell.header(
                      child: SizedBox(width: 28),
                    ),
                  1 => ShadTableCell.header(child: Text('标志值')),
                  2 => ShadTableCell.header(child: Text('名称')),
                  _ => ShadTableCell.header(child: SizedBox()),
                };
              },
              columnSpanExtent: (column) {
                return switch (column) {
                  0 => FixedTableSpanExtent(56),
                  1 => FixedTableSpanExtent(120),
                  2 => RemainingTableSpanExtent(),
                  _ => null,
                };
              },
              rowSpanBackgroundDecoration: (row) {
                // 检查 row 是否在有效范围内
                if (row < 0 || row >= flags.length) return null;
                final flag = flags[row];
                final isSelected = (_currentValue & flag.value) != 0;
                if (isSelected) {
                  return TableSpanDecoration(
                    color: theme.colorScheme.accent.withValues(alpha: 0.1),
                  );
                }
                return null;
              },
              onRowTap: (row) {
                // row 包含 header，所以减 1
                final dataRow = row - 1;
                if (dataRow >= 0 && dataRow < flags.length) {
                  _toggleFlag(flags[dataRow].value);
                }
              },
              builder: (context, vicinity) {
                // 边界检查
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
                  1 => ShadTableCell(
                      child: Text(
                        hexValue,
                        style: TextStyle(
                          fontFamily: 'Consolas, monospace',
                          fontSize: 12,
                          color: theme.colorScheme.mutedForeground,
                        ),
                      ),
                    ),
                  2 => ShadTableCell(
                      child: Text(
                        flag.label,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.w500 : null,
                          color: isSelected ? theme.colorScheme.primary : null,
                        ),
                      ),
                    ),
                  _ => ShadTableCell(child: SizedBox()),
                };
              },
            ),
          ),
        ],
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
