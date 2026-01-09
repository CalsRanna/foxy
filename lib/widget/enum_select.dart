import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 通用枚举下拉选择组件
///
/// 用于将数字枚举值转换为下拉选择框，支持显示中英文名称。
/// 符合项目架构规范，使用 ShadSelect 作为基础组件。
class EnumSelect<T> extends StatelessWidget {
  /// 当前选中的值
  final T? value;

  /// 选项映射表 {枚举值: 显示名称}
  final Map<T, String> options;

  /// 值变化回调
  final void Function(T?)? onChanged;

  /// 占位提示文本
  final String? placeholder;

  /// 是否允许清空（选择 null）
  final bool nullable;

  /// 最小宽度
  final double minWidth;

  const EnumSelect({
    super.key,
    required this.value,
    required this.options,
    this.onChanged,
    this.placeholder,
    this.nullable = false,
    this.minWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth),
      child: ShadSelect<T>(
        placeholder: Text(placeholder ?? '请选择'),
        initialValue: value,
        options: options.entries
            .map((e) => ShadOption(value: e.key, child: Text(e.value)))
            .toList(),
        selectedOptionBuilder: (context, value) {
          return Text(options[value] ?? '');
        },
        onChanged: onChanged,
      ),
    );
  }
}
